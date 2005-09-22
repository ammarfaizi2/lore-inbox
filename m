Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVIVHoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVIVHoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVIVHoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:44:44 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:24790 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750988AbVIVHon convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:44:43 -0400
Subject: Re: AIO Support and related package information??
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       bcrl@kvack.org
In-Reply-To: <20050922030844.14682.qmail@web8406.mail.in.yahoo.com>
References: <20050922030844.14682.qmail@web8406.mail.in.yahoo.com>
Date: Thu, 22 Sep 2005 09:46:30 +0200
Message-Id: <1127375190.2051.53.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 22/09/2005 09:57:48,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 22/09/2005 09:57:50,
	Serialize complete at 22/09/2005 09:57:50
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Vikas,


On Thu, 2005-09-22 at 04:08 +0100, vikas gupta wrote:
> hello ALL ,
> 
> I am very curious about the AIO support in kernel. I
> have downloaded the
> recent kernel 2.6.13 and applied suparna's patches on
> that but now i got stuck as
> now there are two different packages are available.

  You should try Ben LaHaise's patchset which includes
Suparna's patches. It's available as a single patch at:

http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1-all.diff 

and broken down at:
http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1/

> 
> 1) libaio rpm
> 

  libaio is meant as a way for using the kernel AIO support but 
does not provide a POSIX compliant interface.

> There are many rpm available such as
> libaio-0.3.xxx-02.src rpm and many
> more but at http://lse.sourceforge.net/io/aio.html
> ,Somebody has said to use
> libaio-0.3.99 package ..

  I've been using libaio-0.3.92 with success.

> 
> So can you please give me some guidelines on after
> applying the patch how
> to proceed further???
> 
> Is these packages are part of linux kernel
> installation ????
> 
> Is this package implementation is really necessary and
> if yes then what
> are the packages we need to install.
> 
> And if any other resource is required then from where
> i can get that
> resource.
> 
> 2) libposix API library of 
> http://www.bullopensource.org/posix.
> 
>         How to use it???
>         Is it any other way of implementing the AIO
> Support or it is to
> provide posix conformance to the kernel.


  Just like libaio, libposix-aio uses the kernel AIO support but 
provides a POSIX compliant interface.

  There are no man pages yet, but you can look a the SuSV3 
specification (links are on http://www.bullopensource.org/posix/).

  For completeness, I should add that there is a POSIX AIO
implementation in glibc librt but it uses helper threads to achieve
asynchrony and does not use kernel support.

> 
> 3) What is the relation between libposixaio pacakage
> supported by bullsource.net and libaio pacakage
> supported by redhat ....

  None, libposix-aio used to rely on libaio for the syscalls but that's
no longer the case.

> 
> 4) I am able to built that libposix package without
> libaio ??????

  Normal.

> 
> 5) are these pacakages are supported for othewr
> platforms such as arm and ppc ,I am not able to build
> libposix for arm platform.Do Cross compiling is
> supported ???
> 

  Right now support is provided for:

	i386	- tested
	ia64	- not tested
	x86_64	- not tested

  If you're willing to add support for other platforms there is
only one file to add for implementing the architecture dependant
syscalls, such as syscall_arm.h or syscall_ppc.h. Look at the sources.

> 
> 
> 6) How to use these api in test program
> 
>   Can i use it as mentioned below ????
> 
>   Test1.c
> 
>   #include <aio.h>
>   #include <errno.h>
>   #include <stdio.h>
>   #include <string.h>
>   #include <unistd.h>
> 
>   #define BYTES 8
> 
>   int main( int argc, char *argv[] )
>   {
>       int i, r;
>       int fildes;
>       struct aiocb cb;
>       char buff[BYTES];
> 
>       if ((fildes = open( "/etc/resolv.conf", O_RDONLY
> )) < 0) {
>           perror( "opening file" ); return 1;
>       }
> 
>       cb.aio_fildes = fildes;
>       cb.aio_offset = 0;
>       cb.aio_buf = buff;
>       cb.aio_nbytes = BYTES;
>       cb.aio_reqprio = 0;
>       cb.aio_sigevent.sigev_notify = SIGEV_NONE;
> 
>       errno = 0;
>       r = aio_read( &cb );
>       printf( "aio_read() ret: %i\terrno: %i\n", r,
> errno );
> 
>       while (aio_error( &cb ) == EINPROGRESS) {
> usleep( 10 ); }
> 
>       for (i = 0; i < BYTES; i++) { printf( "%c ",
> buff[i] ); } printf(
> "\n" );
> 
>       errno = 0;
>       r = aio_return( &cb );
>       printf( "aio_return() ret: %i\tBYTES: %i\terrno:
> %i\n", r, BYTES,
> errno );
> 
>       return 0;
> }

  That should be OK. Look at the examples in libposix-aio, in
the check and testbed subdirectories.


> 
> 
> 
> Any other information, if u can provide then it will
> be of great use ...
> 
> 
> Thanks in advance ...
> 
> Vikas

  Hope this helps,

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

