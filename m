Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSJEE3h>; Sat, 5 Oct 2002 00:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262029AbSJEE3h>; Sat, 5 Oct 2002 00:29:37 -0400
Received: from ns.suse.de ([213.95.15.193]:65286 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262023AbSJEE3e>;
	Sat, 5 Oct 2002 00:29:34 -0400
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Oct 2002 06:35:07 +0200
In-Reply-To: Adrian Bunk's message of "4 Oct 2002 17:34:26 +0200"
Message-ID: <p73adltqz9g.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:
> 
> TIOCGDEV is (as the comment above indicates) in neither 2.4.20-pre9 nor in
> 2.5.40 and I'm wondering why the x86_64 kernel supports a SuSE-specific
> i386 ioctl?

Why not? 

I resubmitted the TIOCGDEV patch to Marcelo now, which implements it 
for the console device.

-Andi

Here is it for your reference (applies to 2.4.20pre):

diff -urN linux-2.4.18.tmp/arch/sparc64/kernel/ioctl32.c linux-2.4.18.SuSE/arch/sparc64/kernel/ioctl32.c
--- linux-2.4.18.tmp/arch/sparc64/kernel/ioctl32.c	Sat May  4 11:37:20 2002
+++ linux-2.4.18.SuSE/arch/sparc64/kernel/ioctl32.c	Sat May  4 11:38:42 2002
@@ -3911,6 +3911,7 @@
 COMPATIBLE_IOCTL(TIOCLINUX)
 COMPATIBLE_IOCTL(TIOCSTART)
 COMPATIBLE_IOCTL(TIOCSTOP)
+COMPATIBLE_IOCTL(TIOCGDEV)
 /* Little t */
 COMPATIBLE_IOCTL(TIOCGETD)
 COMPATIBLE_IOCTL(TIOCSETD)
diff -urN linux-2.4.18.tmp/drivers/char/tty_io.c linux-2.4.18.SuSE/drivers/char/tty_io.c
--- linux-2.4.18.tmp/drivers/char/tty_io.c	Sat May  4 11:37:25 2002
+++ linux-2.4.18.SuSE/drivers/char/tty_io.c	Sat May  4 11:37:56 2002
@@ -1775,7 +1775,8 @@
 #endif
 		case TIOCTTYGSTRUCT:
 			return tiocttygstruct(tty, (struct tty_struct *) arg);
-
+		case TIOCGDEV:
+			return put_user (kdev_t_to_nr (real_tty->device), (unsigned int*) arg);
 		/*
 		 * Break handling
 		 */
diff -urN linux-2.4.18.tmp/include/asm-alpha/ioctls.h linux-2.4.18.SuSE/include/asm-alpha/ioctls.h
--- linux-2.4.18.tmp/include/asm-alpha/ioctls.h	Sat May  4 11:37:28 2002
+++ linux-2.4.18.SuSE/include/asm-alpha/ioctls.h	Sat May  4 11:37:56 2002
@@ -92,6 +92,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -urN linux-2.4.18.tmp/include/asm-arm/ioctls.h linux-2.4.18.SuSE/include/asm-arm/ioctls.h
--- linux-2.4.18.tmp/include/asm-arm/ioctls.h	Fri Feb  9 01:32:44 2001
+++ linux-2.4.18.SuSE/include/asm-arm/ioctls.h	Sat May  4 11:37:56 2002
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -urN linux-2.4.18.tmp/include/asm-i386/ioctls.h linux-2.4.18.SuSE/include/asm-i386/ioctls.h
--- linux-2.4.18.tmp/include/asm-i386/ioctls.h	Sat May  4 11:37:28 2002
+++ linux-2.4.18.SuSE/include/asm-i386/ioctls.h	Sat May  4 11:37:56 2002
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -urN linux-2.4.18.tmp/include/asm-ia64/ioctls.h linux-2.4.18.SuSE/include/asm-ia64/ioctls.h
--- linux-2.4.18.tmp/include/asm-ia64/ioctls.h	Sat May  4 11:37:28 2002
+++ linux-2.4.18.SuSE/include/asm-ia64/ioctls.h	Sat May  4 11:37:56 2002
@@ -54,6 +54,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -urN linux-2.4.18.tmp/include/asm-m68k/ioctls.h linux-2.4.18.SuSE/include/asm-m68k/ioctls.h
--- linux-2.4.18.tmp/include/asm-m68k/ioctls.h	Sat May  4 11:37:28 2002
+++ linux-2.4.18.SuSE/include/asm-m68k/ioctls.h	Sat May  4 11:37:56 2002
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -urN linux-2.4.18.tmp/include/asm-mips/ioctls.h linux-2.4.18.SuSE/include/asm-mips/ioctls.h
--- linux-2.4.18.tmp/include/asm-mips/ioctls.h	Sun Sep  9 19:43:01 2001
+++ linux-2.4.18.SuSE/include/asm-mips/ioctls.h	Sat May  4 11:37:56 2002
@@ -89,6 +89,7 @@
 #define TIOCGSID	0x7416  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5488
 #define TIOCSERGWILD	0x5489
diff -urN linux-2.4.18.tmp/include/asm-mips64/ioctls.h linux-2.4.18.SuSE/include/asm-mips64/ioctls.h
--- linux-2.4.18.tmp/include/asm-mips64/ioctls.h	Sun Sep  9 19:43:02 2001
+++ linux-2.4.18.SuSE/include/asm-mips64/ioctls.h	Sat May  4 11:37:56 2002
@@ -89,6 +89,7 @@
 #define TIOCGSID	0x7416  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5488
 #define TIOCSERGWILD	0x5489
diff -urN linux-2.4.18.tmp/include/asm-ppc/ioctls.h linux-2.4.18.SuSE/include/asm-ppc/ioctls.h
--- linux-2.4.18.tmp/include/asm-ppc/ioctls.h	Tue May 22 00:02:06 2001
+++ linux-2.4.18.SuSE/include/asm-ppc/ioctls.h	Sat May  4 11:37:56 2002
@@ -92,6 +92,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -urN linux-2.4.18.tmp/include/asm-s390/ioctls.h linux-2.4.18.SuSE/include/asm-s390/ioctls.h
--- linux-2.4.18.tmp/include/asm-s390/ioctls.h	Tue Feb 13 23:13:44 2001
+++ linux-2.4.18.SuSE/include/asm-s390/ioctls.h	Sat May  4 11:37:56 2002
@@ -57,6 +57,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -urN linux-2.4.18.tmp/include/asm-s390x/ioctls.h linux-2.4.18.SuSE/include/asm-s390x/ioctls.h
--- linux-2.4.18.tmp/include/asm-s390x/ioctls.h	Tue Feb 13 23:13:44 2001
+++ linux-2.4.18.SuSE/include/asm-s390x/ioctls.h	Sat May  4 11:37:56 2002
@@ -57,6 +57,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -urN linux-2.4.18.tmp/include/asm-sh/ioctls.h linux-2.4.18.SuSE/include/asm-sh/ioctls.h
--- linux-2.4.18.tmp/include/asm-sh/ioctls.h	Sat May  4 11:37:28 2002
+++ linux-2.4.18.SuSE/include/asm-sh/ioctls.h	Sat May  4 11:37:56 2002
@@ -81,6 +81,7 @@
 #define TIOCGSID	_IOR('T', 41, pid_t) /* 0x5429 */ /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	_IO('T', 83) /* 0x5453 */
 #define TIOCSERGWILD	_IOR('T', 84,  int) /* 0x5454 */
diff -urN linux-2.4.18.tmp/include/asm-sparc/ioctls.h linux-2.4.18.SuSE/include/asm-sparc/ioctls.h
--- linux-2.4.18.tmp/include/asm-sparc/ioctls.h	Sat May  4 11:37:28 2002
+++ linux-2.4.18.SuSE/include/asm-sparc/ioctls.h	Sat May  4 11:37:56 2002
@@ -100,6 +100,7 @@
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
 #define TIOCTTYGSTRUCT	0x5426
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -urN linux-2.4.18.tmp/include/asm-sparc64/ioctls.h linux-2.4.18.SuSE/include/asm-sparc64/ioctls.h
--- linux-2.4.18.tmp/include/asm-sparc64/ioctls.h	Sat May  4 11:37:28 2002
+++ linux-2.4.18.SuSE/include/asm-sparc64/ioctls.h	Sat May  4 11:37:56 2002
@@ -101,6 +101,7 @@
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
 #define TIOCTTYGSTRUCT	0x5426
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -urN linux-2.4.19-pre8.orig/include/asm-ppc64/ioctls.h linux-2.4.19-pre8/include/asm-ppc64/ioctls.h
--- linux-2.4.19-pre8.orig/include/asm-ppc64/ioctls.h	Sat Mar 30 01:48:50 2002
+++ linux-2.4.19-pre8/include/asm-ppc64/ioctls.h	Fri May  3 16:33:18 2002
@@ -96,6 +96,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
--- linux-2.4.19-pre9/arch/ppc64/kernel/ioctl32.c~	2002-06-03 12:01:56.000000000 +0000
+++ linux-2.4.19-pre9/arch/ppc64/kernel/ioctl32.c	2002-06-03 12:02:52.000000000 +0000
@@ -3728,6 +3728,7 @@
 COMPATIBLE_IOCTL(TCSETSF),
 COMPATIBLE_IOCTL(TIOCLINUX),
 COMPATIBLE_IOCTL(TIOCSTART),
+COMPATIBLE_IOCTL(TIOCGDEV),
 /* Little t */
 COMPATIBLE_IOCTL(TIOCGETD),
 COMPATIBLE_IOCTL(TIOCSETD),
