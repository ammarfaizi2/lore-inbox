Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312226AbSCRH5G>; Mon, 18 Mar 2002 02:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312228AbSCRH4s>; Mon, 18 Mar 2002 02:56:48 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32273 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312225AbSCRH4l>; Mon, 18 Mar 2002 02:56:41 -0500
Message-ID: <3C959D55.14768770@zip.com.au>
Date: Sun, 17 Mar 2002 23:55:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <3C959716.6040308@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> * fadvise(2) usefulness extends past open(2).  It may be useful to call
> it at various points during runtime.
> 
> * I think putting hints in open(2) is the wrong direction to go.  Hints
> have a potential to be very flexible.  open(2) O_xxx bits are not to be
> squandered lightly, while I see a lot more value in being a little more
> loose and free with the bit assignment for an "fadvise mask" (just a
> list of hint bits).  IMO it should be easier to introduce and retire
> hints, far easier than O_xxx flags.
> 

Yup.

posix_fadvise() looks to be a fine interface:

int posix_fadvise(int fd, off_t offset, size_t len, int advice);

 DESCRIPTION

     The posix_fadvise() function shall advise the implementation on
     the expected behavior of the application with respect to the data in
     the file associated with the open file descriptor, fd, starting at offset
     and continuing for len bytes. The specified range need not currently
     exist in the file. If len is zero, all data following offset is specified.
     The implementation may use this information to optimize handling
     of the specified data. The posix_fadvise() function shall have no
     effect on the semantics of other operations on the specified data,
     although it may affect the performance of other operations.

     The advice to be applied to the data is specified by the advice
     parameter and may be one of the following values:

     POSIX_FADV_NORMAL 

          Specifies that the application has no advice to give on its
          behavior with respect to the specified data. It is the default
          characteristic if no advice is given for an open file. 
     POSIX_FADV_SEQUENTIAL 

          Specifies that the application expects to access the specified
          data sequentially from lower offsets to higher offsets. 
     POSIX_FADV_RANDOM 

          Specifies that the application expects to access the specified
          data in a random order. 
     POSIX_FADV_WILLNEED 

          Specifies that the application expects to access the specified
          data in the near future. 
     POSIX_FADV_DONTNEED 

          Specifies that the application expects that it will not access
          the specified data in the near future. 
     POSIX_FADV_NOREUSE 

          Specifies that the application expects to access the specified
          data once and then not reuse it thereafter. 

We can usefully implement all of these.  FADV_WILLNEED obsoletes
sys_readahead().

We'll need to cheat a bit on the offset/len thing for NORMAL and
SEQUENTIAL - just apply it to the whole file - we don't want to have to
attach an arbitrary number of silly range objects to each file for this.
(We already cheat a bit this way with msync).

Note that it applies to a file descriptor.  If posix_fadvise(FADV_DONTNEED) is
called against a file descriptor, and someone else has an fd open
against the same file, that other user gets their foot shot off.  That's
OK.

Given this, I don't see a persuasive need to implement a non-standard
interface.  It takes an off_t, so posix_fadvise64() is also needed.

The presence of this interface doesn't imply that we don't need
good dropbehind heuristics for streaming reads and writes.  We
do need those.

I wouldn't suggest that anyone rush out and implement this stuff for 2.5.
There's some decrudding needed in filemap.c first, and many of these
hints need to interact with the 2.6 VM.  Whatever that will be.

A 2.4 implementation could be done any time.  If anyone decides to
do this, please let me know...

-
