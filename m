Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130109AbQLPB3i>; Fri, 15 Dec 2000 20:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130453AbQLPB32>; Fri, 15 Dec 2000 20:29:28 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23309 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130109AbQLPB3R>;
	Fri, 15 Dec 2000 20:29:17 -0500
Date: Sat, 16 Dec 2000 01:55:37 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: miquels@cistron.nl, Linux kernel list <linux-kernel@vger.kernel.org>
Subject: TIOCGDEV ioctl
Message-ID: <20001216015537.G21372@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, miquels@cistron.nl,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus, Alan,

some applications do need to know where the console (/dev/console)
actually maps to. For processes with a controlling terminal, you may see 
it in /proc/$$/stat. However, daemons are supposed to run detached (they
don't want to get killed by ^C) and some processes like init or bootlogd 
do still need to be able to find out.

The kernel provides this information -- sort of:
It contains the TIOCTTYGSTRUCT syscall which returns a struct. Of course,
it changes between different kernel archs and revisions, so using it is
an ugly hack. Grab for TIOCTTYGSTRUCT_HACK in the bootlogd.c file of the
sysvinit sources. Shudder!

Having a new ioctl, just returning the device no is a much cleaner solution,
IMHO. So, I created the TIOCGDEV, which Miquel suggests in his sysvinit
sources. It makes querying the actual console device as easy as 
int tty; ioctl (0, TIOCGDEV, &tty);

Patches against 2.2.18 and 2.4.0-testX are attached.
Please apply.
-- 
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="TIOCGDEV-240t11.diff"

diff -uNr linux-2.4.0_test10.SuSE/drivers/char/tty_io.c linux-2.4.0_test10.TIOCGDEV/drivers/char/tty_io.c
--- linux-2.4.0_test10.SuSE/drivers/char/tty_io.c	Mon Oct 16 21:58:51 2000
+++ linux-2.4.0_test10.TIOCGDEV/drivers/char/tty_io.c	Fri Dec 15 19:35:23 2000
@@ -1766,7 +1766,8 @@
 #endif
 		case TIOCTTYGSTRUCT:
 			return tiocttygstruct(tty, (struct tty_struct *) arg);
-
+		case TIOCGDEV:
+			return put_user (kdev_to_nr (real_tty->device, (unsigned int*) arg);
 		/*
 		 * Break handling
 		 */
diff -uNr linux-2.4.0_test10.SuSE/include/asm/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm/ioctls.h	Fri Jul 24 20:10:16 1998
+++ linux-2.4.0_test10.TIOCGDEV/include/asm/ioctls.h	Fri Dec 15 19:39:17 2000
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.4.0_test10.SuSE/include/asm-alpha/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-alpha/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-alpha/ioctls.h	Fri Jan 28 01:40:09 2000
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-alpha/ioctls.h	Fri Dec 15 19:41:45 2000
@@ -91,6 +91,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -uNr linux-2.4.0_test10.SuSE/include/asm-arm/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-arm/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-arm/ioctls.h	Fri Feb 13 01:25:04 1998
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-arm/ioctls.h	Fri Dec 15 19:42:39 2000
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.4.0_test10.SuSE/include/asm-i386/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-i386/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-i386/ioctls.h	Fri Jul 24 20:10:16 1998
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-i386/ioctls.h	Fri Dec 15 19:39:17 2000
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.4.0_test10.SuSE/include/asm-ia64/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-ia64/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-ia64/ioctls.h	Mon Feb  7 03:42:40 2000
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-ia64/ioctls.h	Fri Dec 15 19:41:31 2000
@@ -54,6 +54,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.4.0_test10.SuSE/include/asm-m68k/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-m68k/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-m68k/ioctls.h	Fri Feb 13 01:25:04 1998
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-m68k/ioctls.h	Fri Dec 15 19:40:58 2000
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.4.0_test10.SuSE/include/asm-mips/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-mips/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-mips/ioctls.h	Sat May 13 17:31:25 2000
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-mips/ioctls.h	Fri Dec 15 19:42:54 2000
@@ -100,6 +100,7 @@
 #define TIOCGSID	0x7416  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5488
 #define TIOCSERGWILD	0x5489
diff -uNr linux-2.4.0_test10.SuSE/include/asm-mips64/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-mips64/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-mips64/ioctls.h	Sat May 13 17:31:25 2000
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-mips64/ioctls.h	Fri Dec 15 19:37:24 2000
@@ -100,6 +100,7 @@
 #define TIOCGSID	0x7416  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5488
 #define TIOCSERGWILD	0x5489
diff -uNr linux-2.4.0_test10.SuSE/include/asm-ppc/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-ppc/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-ppc/ioctls.h	Sun Nov 28 00:42:33 1999
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-ppc/ioctls.h	Fri Dec 15 19:42:28 2000
@@ -88,6 +88,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -uNr linux-2.4.0_test10.SuSE/include/asm-s390/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-s390/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-s390/ioctls.h	Fri May 12 20:41:44 2000
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-s390/ioctls.h	Fri Dec 15 19:44:04 2000
@@ -57,6 +57,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.4.0_test10.SuSE/include/asm-sh/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-sh/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-sh/ioctls.h	Sat Nov  6 19:40:31 1999
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-sh/ioctls.h	Fri Dec 15 19:41:20 2000
@@ -80,6 +80,7 @@
 #define TIOCGSID	_IOR('T', 41, pid_t) /* 0x5429 */ /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	_IO('T', 83) /* 0x5453 */
 #define TIOCSERGWILD	_IOR('T', 84,  int) /* 0x5454 */
diff -uNr linux-2.4.0_test10.SuSE/include/asm-sparc/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-sparc/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-sparc/ioctls.h	Sun Oct  4 19:22:44 1998
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-sparc/ioctls.h	Fri Dec 15 19:39:50 2000
@@ -99,6 +99,7 @@
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
 #define TIOCTTYGSTRUCT	0x5426
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -uNr linux-2.4.0_test10.SuSE/include/asm-sparc64/ioctls.h linux-2.4.0_test10.TIOCGDEV/include/asm-sparc64/ioctls.h
--- linux-2.4.0_test10.SuSE/include/asm-sparc64/ioctls.h	Wed Apr 15 02:44:24 1998
+++ linux-2.4.0_test10.TIOCGDEV/include/asm-sparc64/ioctls.h	Fri Dec 15 19:40:18 2000
@@ -100,6 +100,7 @@
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
 #define TIOCTTYGSTRUCT	0x5426
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455

--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="TIOCGDEV-2218.diff"

diff -uNr linux-2.2.18.SuSE/drivers/char/tty_io.c linux-2.2.18.TIOCGDEV/drivers/char/tty_io.c
--- linux-2.2.18.SuSE/drivers/char/tty_io.c	Thu Dec 14 22:38:30 2000
+++ linux-2.2.18.TIOCGDEV/drivers/char/tty_io.c	Fri Dec 15 17:39:05 2000
@@ -1768,6 +1768,9 @@
 		case TIOCTTYGSTRUCT:
 			return tiocttygstruct(tty, (struct tty_struct *) arg);
 
+		case TIOCGDEV:
+			return put_user (kdev_t_to_nr (real_tty->device), (unsigned int *) arg);
+		
 		/*
 		 * Break handling
 		 */
diff -uNr linux-2.2.18.SuSE/include/asm-alpha/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-alpha/ioctls.h
--- linux-2.2.18.SuSE/include/asm-alpha/ioctls.h	Fri Feb 13 01:25:04 1998
+++ linux-2.2.18.TIOCGDEV/include/asm-alpha/ioctls.h	Fri Dec 15 19:51:59 2000
@@ -88,6 +88,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -uNr linux-2.2.18.SuSE/include/asm-arm/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-arm/ioctls.h
--- linux-2.2.18.SuSE/include/asm-arm/ioctls.h	Fri Feb 13 01:25:04 1998
+++ linux-2.2.18.TIOCGDEV/include/asm-arm/ioctls.h	Fri Dec 15 19:53:09 2000
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.2.18.SuSE/include/asm-i386/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-i386/ioctls.h
--- linux-2.2.18.SuSE/include/asm-i386/ioctls.h	Fri Jul 24 20:10:16 1998
+++ linux-2.2.18.TIOCGDEV/include/asm-i386/ioctls.h	Fri Dec 15 19:50:35 2000
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.2.18.SuSE/include/asm-m68k/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-m68k/ioctls.h
--- linux-2.2.18.SuSE/include/asm-m68k/ioctls.h	Fri Feb 13 01:25:04 1998
+++ linux-2.2.18.TIOCGDEV/include/asm-m68k/ioctls.h	Fri Dec 15 19:51:48 2000
@@ -49,6 +49,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.2.18.SuSE/include/asm-mips/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-mips/ioctls.h
--- linux-2.2.18.SuSE/include/asm-mips/ioctls.h	Mon Aug  9 21:04:41 1999
+++ linux-2.2.18.TIOCGDEV/include/asm-mips/ioctls.h	Fri Dec 15 19:53:23 2000
@@ -100,6 +100,7 @@
 #define TIOCGSID	0x7416  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5488
 #define TIOCSERGWILD	0x5489
diff -uNr linux-2.2.18.SuSE/include/asm-ppc/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-ppc/ioctls.h
--- linux-2.2.18.SuSE/include/asm-ppc/ioctls.h	Fri Feb 13 01:25:04 1998
+++ linux-2.2.18.TIOCGDEV/include/asm-ppc/ioctls.h	Fri Dec 15 19:52:49 2000
@@ -88,6 +88,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -uNr linux-2.2.18.SuSE/include/asm-s390/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-s390/ioctls.h
--- linux-2.2.18.SuSE/include/asm-s390/ioctls.h	Tue Jan  4 19:12:24 2000
+++ linux-2.2.18.TIOCGDEV/include/asm-s390/ioctls.h	Fri Dec 15 19:53:34 2000
@@ -57,6 +57,7 @@
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff -uNr linux-2.2.18.SuSE/include/asm-sparc/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-sparc/ioctls.h
--- linux-2.2.18.SuSE/include/asm-sparc/ioctls.h	Sun Oct  4 19:22:44 1998
+++ linux-2.2.18.TIOCGDEV/include/asm-sparc/ioctls.h	Fri Dec 15 19:51:00 2000
@@ -99,6 +99,7 @@
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
 #define TIOCTTYGSTRUCT	0x5426
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -uNr linux-2.2.18.SuSE/include/asm-sparc64/ioctls.h linux-2.2.18.TIOCGDEV/include/asm-sparc64/ioctls.h
--- linux-2.2.18.SuSE/include/asm-sparc64/ioctls.h	Wed Apr 15 02:44:24 1998
+++ linux-2.2.18.TIOCGDEV/include/asm-sparc64/ioctls.h	Fri Dec 15 19:53:43 2000
@@ -100,6 +100,7 @@
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
 #define TIOCTTYGSTRUCT	0x5426
+#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455

--nOM8ykUjac0mNN89--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
