Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264741AbUEFBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbUEFBQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 21:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUEFBQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 21:16:31 -0400
Received: from tantale.fifi.org ([216.27.190.146]:60568 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S264741AbUEFBQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 21:16:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: errno
References: <1083634011.952.154.camel@cube>
	<Pine.LNX.4.58.0405032111450.1636@ppc970.osdl.org>
	<87r7u0g2cf.fsf@electrolyt.fifi.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 05 May 2004 18:16:15 -0700
In-Reply-To: <87r7u0g2cf.fsf@electrolyt.fifi.org>
Message-ID: <87smeejqxs.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin <phil@fifi.org> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Mon, 3 May 2004, Albert Cahalan wrote:
> > > 
> > > The obvious fix would be to stuff errno into the
> > > task_struct, hmmm?
> > 
> > No. "errno" is one of those fundamentally broken things that should not 
> > exist. It was wrogn in original UNIX, it's wrong now.
> > 
> > The kernel usage comes not from the kernel wanting to use it per se (the 
> > kernel has always used the "negative error" approach), but from some 
> > misguided kernel modules using the user-space interfaces.
> > 
> > The Linux way of returning negative error numbers is much nicer. It's
> > inherently thread-safe, and it has no performance downsides. Of course, it
> > does depend on having enough of a result domain that you can always
> > separate error returns from good returns, but that's true in practice for
> > all system calls.
> 
> Except of course for fcntl(fd, F_GETOWN) where the owner is a
> (negative) process group... If the owning process group has a "low
> enough" PGID, it collides with errors and glibc reports an error and
> sets errno to -PGID. One might argue that in this instance, that the
> BSD's overloading of the pid field with pgids is at fault, but the bug
> still remains :-)

This is a patch against 2.6.5 for what I am talking about. Of course,
glibc needs to be patched as well to transparently issue a
F_GETOWN_ARG when the user requests F_GETOWN...

Phil.

diff -rcN linux-2.6.5.orig/fs/fcntl.c linux-2.6.5/fs/fcntl.c
*** linux-2.6.5.orig/fs/fcntl.c	Sat Apr  3 19:37:36 2004
--- linux-2.6.5/fs/fcntl.c	Wed May  5 18:06:02 2004
***************
*** 323,328 ****
--- 323,339 ----
  			err = filp->f_owner.pid;
  			force_successful_syscall_return();
  			break;
+ 		case F_GETOWN_ARG:
+ 			/*
+ 			 * Works around F_GETOWN's return limitations.
+ 			 * Libc will transparently convert F_GETOWN to 
+ 			 * F_GETOWN_ARG.
+ 			 */
+ 			err = 0;
+ 			if (copy_to_user(&filp->f_owner.pid, (void*)arg, 
+ 					 sizeof(filp->f_owner.pid)))
+ 				err = -EFAULT;
+ 			break;
  		case F_SETOWN:
  			err = f_setown(filp, arg, 1);
  			break;
diff -rcN linux-2.6.5.orig/include/asm-alpha/fcntl.h linux-2.6.5/include/asm-alpha/fcntl.h
*** linux-2.6.5.orig/include/asm-alpha/fcntl.h	Sat Apr  3 19:37:24 2004
--- linux-2.6.5/include/asm-alpha/fcntl.h	Wed May  5 17:57:03 2004
***************
*** 36,41 ****
--- 36,43 ----
  #define F_SETSIG	10	/*  for sockets. */
  #define F_GETSIG	11	/*  for sockets. */
  
+ #define F_GETOWN_ARG	12	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-arm/fcntl.h linux-2.6.5/include/asm-arm/fcntl.h
*** linux-2.6.5.orig/include/asm-arm/fcntl.h	Sat Apr  3 19:36:27 2004
--- linux-2.6.5/include/asm-arm/fcntl.h	Wed May  5 17:56:51 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-arm26/fcntl.h linux-2.6.5/include/asm-arm26/fcntl.h
*** linux-2.6.5.orig/include/asm-arm26/fcntl.h	Sat Apr  3 19:37:40 2004
--- linux-2.6.5/include/asm-arm26/fcntl.h	Wed May  5 17:56:47 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-cris/fcntl.h linux-2.6.5/include/asm-cris/fcntl.h
*** linux-2.6.5.orig/include/asm-cris/fcntl.h	Sat Apr  3 19:36:25 2004
--- linux-2.6.5/include/asm-cris/fcntl.h	Wed May  5 17:56:41 2004
***************
*** 41,46 ****
--- 41,48 ----
  #define F_SETLK64      13
  #define F_SETLKW64     14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-h8300/fcntl.h linux-2.6.5/include/asm-h8300/fcntl.h
*** linux-2.6.5.orig/include/asm-h8300/fcntl.h	Sat Apr  3 19:37:43 2004
--- linux-2.6.5/include/asm-h8300/fcntl.h	Wed May  5 17:56:37 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-i386/fcntl.h linux-2.6.5/include/asm-i386/fcntl.h
*** linux-2.6.5.orig/include/asm-i386/fcntl.h	Sat Apr  3 19:37:23 2004
--- linux-2.6.5/include/asm-i386/fcntl.h	Wed May  5 17:56:21 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-ia64/fcntl.h linux-2.6.5/include/asm-ia64/fcntl.h
*** linux-2.6.5.orig/include/asm-ia64/fcntl.h	Sat Apr  3 19:37:23 2004
--- linux-2.6.5/include/asm-ia64/fcntl.h	Wed May  5 17:56:11 2004
***************
*** 43,48 ****
--- 43,50 ----
  #define F_SETSIG	10	/*  for sockets. */
  #define F_GETSIG	11	/*  for sockets. */
  
+ #define F_GETOWN_ARG	12	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-m68k/fcntl.h linux-2.6.5/include/asm-m68k/fcntl.h
*** linux-2.6.5.orig/include/asm-m68k/fcntl.h	Sat Apr  3 19:36:53 2004
--- linux-2.6.5/include/asm-m68k/fcntl.h	Wed May  5 17:55:57 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-mips/fcntl.h linux-2.6.5/include/asm-mips/fcntl.h
*** linux-2.6.5.orig/include/asm-mips/fcntl.h	Sat Apr  3 19:37:43 2004
--- linux-2.6.5/include/asm-mips/fcntl.h	Wed May  5 17:55:36 2004
***************
*** 42,47 ****
--- 42,48 ----
  #define F_GETOWN	23	/*  for sockets. */
  #define F_SETSIG	10	/*  for sockets. */
  #define F_GETSIG	11	/*  for sockets. */
+ #define F_GETOWN_ARG	25	/*  same as F_GETOWN, but uses arg */
  
  #ifndef __mips64
  #define F_GETLK64	33	/*  using 'struct flock64' */
diff -rcN linux-2.6.5.orig/include/asm-parisc/fcntl.h linux-2.6.5/include/asm-parisc/fcntl.h
*** linux-2.6.5.orig/include/asm-parisc/fcntl.h	Sat Apr  3 19:37:07 2004
--- linux-2.6.5/include/asm-parisc/fcntl.h	Wed May  5 17:55:10 2004
***************
*** 42,47 ****
--- 42,48 ----
  #define F_SETOWN	12	/*  for sockets. */
  #define F_SETSIG	13	/*  for sockets. */
  #define F_GETSIG	14	/*  for sockets. */
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
  
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
diff -rcN linux-2.6.5.orig/include/asm-ppc/fcntl.h linux-2.6.5/include/asm-ppc/fcntl.h
*** linux-2.6.5.orig/include/asm-ppc/fcntl.h	Sat Apr  3 19:37:07 2004
--- linux-2.6.5/include/asm-ppc/fcntl.h	Wed May  5 17:54:59 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-ppc64/fcntl.h linux-2.6.5/include/asm-ppc64/fcntl.h
*** linux-2.6.5.orig/include/asm-ppc64/fcntl.h	Sat Apr  3 19:36:15 2004
--- linux-2.6.5/include/asm-ppc64/fcntl.h	Wed May  5 17:54:51 2004
***************
*** 42,47 ****
--- 42,49 ----
  #define F_SETSIG	10	/*  for sockets. */
  #define F_GETSIG	11	/*  for sockets. */
  
+ #define F_GETOWN_ARG	12	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-s390/fcntl.h linux-2.6.5/include/asm-s390/fcntl.h
*** linux-2.6.5.orig/include/asm-s390/fcntl.h	Sat Apr  3 19:36:12 2004
--- linux-2.6.5/include/asm-s390/fcntl.h	Wed May  5 17:54:43 2004
***************
*** 48,53 ****
--- 48,55 ----
  #define F_SETLKW64	14
  #endif /* ! __s390x__ */
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-sh/fcntl.h linux-2.6.5/include/asm-sh/fcntl.h
*** linux-2.6.5.orig/include/asm-sh/fcntl.h	Sat Apr  3 19:37:42 2004
--- linux-2.6.5/include/asm-sh/fcntl.h	Wed May  5 17:54:29 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-sparc/fcntl.h linux-2.6.5/include/asm-sparc/fcntl.h
*** linux-2.6.5.orig/include/asm-sparc/fcntl.h	Sat Apr  3 19:38:20 2004
--- linux-2.6.5/include/asm-sparc/fcntl.h	Wed May  5 17:54:23 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-sparc64/fcntl.h linux-2.6.5/include/asm-sparc64/fcntl.h
*** linux-2.6.5.orig/include/asm-sparc64/fcntl.h	Sat Apr  3 19:38:20 2004
--- linux-2.6.5/include/asm-sparc64/fcntl.h	Wed May  5 17:54:18 2004
***************
*** 35,40 ****
--- 35,41 ----
  #define F_SETLKW	9
  #define F_SETSIG	10	/*  for sockets. */
  #define F_GETSIG	11	/*  for sockets. */
+ #define F_GETOWN_ARG	12	/*  same as F_GETOWN, but uses arg */
  
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
diff -rcN linux-2.6.5.orig/include/asm-v850/fcntl.h linux-2.6.5/include/asm-v850/fcntl.h
*** linux-2.6.5.orig/include/asm-v850/fcntl.h	Sat Apr  3 19:36:53 2004
--- linux-2.6.5/include/asm-v850/fcntl.h	Wed May  5 17:53:58 2004
***************
*** 39,44 ****
--- 39,46 ----
  #define F_SETLK64	13
  #define F_SETLKW64	14
  
+ #define F_GETOWN_ARG	15	/*  same as F_GETOWN, but uses arg */
+ 
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
  
diff -rcN linux-2.6.5.orig/include/asm-x86_64/fcntl.h linux-2.6.5/include/asm-x86_64/fcntl.h
*** linux-2.6.5.orig/include/asm-x86_64/fcntl.h	Sat Apr  3 19:36:26 2004
--- linux-2.6.5/include/asm-x86_64/fcntl.h	Wed May  5 17:53:48 2004
***************
*** 34,39 ****
--- 34,40 ----
  #define F_GETOWN	9	/*  for sockets. */
  #define F_SETSIG	10	/*  for sockets. */
  #define F_GETSIG	11	/*  for sockets. */
+ #define F_GETOWN_ARG	12	/*  same as F_GETOWN, but uses arg */
  
  /* for F_[GET|SET]FL */
  #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
