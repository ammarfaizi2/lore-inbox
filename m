Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277100AbRJDDr4>; Wed, 3 Oct 2001 23:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277102AbRJDDrr>; Wed, 3 Oct 2001 23:47:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28973 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277100AbRJDDrc>; Wed, 3 Oct 2001 23:47:32 -0400
To: landley@trommello.org
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <200110031249.HAA50103@tomcat.admin.navo.hpc.mil>
	<m1r8sk1tuq.fsf@frodo.biederman.org>
	<01100319203903.00728@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Oct 2001 21:38:16 -0600
In-Reply-To: <01100319203903.00728@localhost.localdomain>
Message-ID: <m1itdw13dj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

> On Wednesday 03 October 2001 14:06, Eric W. Biederman wrote:
> 
> > > But not modify a busy executable.
> >
> > Have ld-linux.so set the MAP_DENYWRITE bit when it is mapping
> > the library.
> 
> And of course since the FSF wrote it, it's not quite that simple...
> 
> >/* The right way to map in the shared library files is MAP_COPY, which
> >   makes a virtual copy of the data at the time of the mmap call; this
> >   guarantees the mapped pages will be consistent even if the file is
> >   overwritten.  Some losing VM systems like Linux's lack MAP_COPY.  All we
> >   get is MAP_PRIVATE, which copies each page when it is modified; this
> >   means if the file is overwritten, we may at some point get some pages
> >   from the new version after starting with pages from the old version.  */
> 
> I.E. it seems like they go out of their way to ALLOW writing to the libaries. 
>  (I assume they KNOW the difference between MAP_DENYWRITE, MAP_COPY, and 
> MAP_PRIVATE...?)
> 
> This look right to anybody else?  Or am I about to wander into weird 
> side-effect land?  (Is there a reason they DON'T want a read-only mapping?  
> Are they writing data into those pages, perhaps doing the linking fixup 
> stuff?  What?)

You definentily need to do some writing to do the fixups.
The deny write solves the problem of somone potentially writing to the
file at a later date.
Probably what is needed is:

#ifndef MAP_COPY
# ifdef MAP_DENYWRITE
#  define MAP_COPY (MAP_PRIVATE | MAP_DENYWRITE)
# else
#  define MAP_COPY MAP_PRIVATE
# endif
#endif

> 
> --- elf/dl-load.bak Wed Oct  3 18:53:37 2001
> +++ elf/dl-load.c   Wed Oct  3 18:55:57 2001
> @@ -48,7 +48,7 @@
>     means if the file is overwritten, we may at some point get some pages
>     from the new version after starting with pages from the old version.  */
>  #ifndef MAP_COPY
> -# define MAP_COPY      MAP_PRIVATE
> +# define MAP_COPY      MAP_DENYWRITE
>  #endif
>  
>  /* Some systems link their relocatable objects for another base address
> 
> I should just try this and see what it does.  On a machine I don't mind 
> reinstalling from scratch.  Which means I need to dig up a spare keyboard for 
> my junk machine...  (And figure out how to get glibc's ./configure script to 
> realise that linuxthreads is, in fact, there in the source directory.  It's 
> right there.  Use it.  Don't yell at me it's not there.  I didn't make this 
> SRPM, I changed one line...  Sigh...)
> 
> In the morning...

For testing you can do ./ld-linux.so program to run a program under to
see if it actually works. 

Eric

