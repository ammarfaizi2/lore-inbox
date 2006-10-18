Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWJRRhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWJRRhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJRRhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:37:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23974 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751497AbWJRRhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:37:03 -0400
Subject: [PATCH] tty: preparatory structures for termios revamp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 18:39:34 +0100
Message-Id: <1161193175.9363.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to sort out our struct termios and add proper speed control we
need to separate the kernel and user termios structures. Glibc is fine
but the other libraries rely on the kernel exported struct termios and
we need to extend this without breaking the ABI/API

To do so we add a struct ktermios which is the kernel view of a termios
structure and overlaps the struct termios with extra fields on the end
for now. (That limitation will go away in later patches). Some platforms
(eg alpha) planned ahead and thus use the same struct for both, others
did not.


This just adds the structures but does not use them, it seems a sensible
splitting point for bisect if there are compile failures (not that I
expect them)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-alpha/termbits.h linux-2.6.19-rc2-mm1/include/asm-alpha/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-alpha/termbits.h	2006-10-13 15:07:03.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-alpha/termbits.h	2006-10-18 14:27:43.000000000 +0100
@@ -25,6 +25,19 @@
 	speed_t c_ospeed;		/* output speed */
 };
 
+/* Alpha has matching termios and ktermios */
+
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_cc[NCCS];		/* control characters */
+	cc_t c_line;			/* line discipline (== c_cc[19]) */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VEOF 0
 #define VEOL 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-arm/termbits.h linux-2.6.19-rc2-mm1/include/asm-arm/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-arm/termbits.h	2006-10-13 15:07:04.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-arm/termbits.h	2006-10-18 14:28:52.000000000 +0100
@@ -15,6 +15,18 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-arm26/termbits.h linux-2.6.19-rc2-mm1/include/asm-arm26/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-arm26/termbits.h	2006-10-13 15:07:04.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-arm26/termbits.h	2006-10-18 14:29:23.000000000 +0100
@@ -15,6 +15,18 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-avr32/termbits.h linux-2.6.19-rc2-mm1/include/asm-avr32/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-avr32/termbits.h	2006-10-18 13:50:25.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-avr32/termbits.h	2006-10-18 14:29:47.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-cris/termbits.h linux-2.6.19-rc2-mm1/include/asm-cris/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-cris/termbits.h	2006-10-13 15:07:04.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-cris/termbits.h	2006-10-18 14:30:08.000000000 +0100
@@ -19,6 +19,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-frv/termbits.h linux-2.6.19-rc2-mm1/include/asm-frv/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-frv/termbits.h	2006-10-13 15:07:04.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-frv/termbits.h	2006-10-18 14:30:33.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-h8300/termbits.h linux-2.6.19-rc2-mm1/include/asm-h8300/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-h8300/termbits.h	2006-10-13 15:07:04.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-h8300/termbits.h	2006-10-18 14:31:14.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-i386/termbits.h linux-2.6.19-rc2-mm1/include/asm-i386/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-i386/termbits.h	2006-10-13 15:07:05.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-i386/termbits.h	2006-10-18 14:31:44.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-ia64/termbits.h linux-2.6.19-rc2-mm1/include/asm-ia64/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-ia64/termbits.h	2006-10-13 15:07:05.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-ia64/termbits.h	2006-10-18 14:32:11.000000000 +0100
@@ -26,6 +26,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-m32r/termbits.h linux-2.6.19-rc2-mm1/include/asm-m32r/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-m32r/termbits.h	2006-10-13 15:07:05.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-m32r/termbits.h	2006-10-18 14:32:51.000000000 +0100
@@ -19,6 +19,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-m68k/termbits.h linux-2.6.19-rc2-mm1/include/asm-m68k/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-m68k/termbits.h	2006-10-13 15:07:05.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-m68k/termbits.h	2006-10-18 14:33:07.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-mips/termbits.h linux-2.6.19-rc2-mm1/include/asm-mips/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-mips/termbits.h	2006-10-18 13:50:25.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-mips/termbits.h	2006-10-18 14:34:08.000000000 +0100
@@ -30,6 +30,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR		 0		/* Interrupt character [ISIG].  */
 #define VQUIT		 1		/* Quit character [ISIG].  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-parisc/termbits.h linux-2.6.19-rc2-mm1/include/asm-parisc/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-parisc/termbits.h	2006-10-13 15:07:08.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-parisc/termbits.h	2006-10-18 14:34:43.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-powerpc/termbits.h linux-2.6.19-rc2-mm1/include/asm-powerpc/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-powerpc/termbits.h	2006-10-13 15:07:08.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-powerpc/termbits.h	2006-10-18 14:35:14.000000000 +0100
@@ -30,6 +30,19 @@
 	speed_t c_ospeed;		/* output speed */
 };
 
+/* For PowerPC the termios and ktermios are the same */
+
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 	         0
 #define VQUIT 	         1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-s390/termbits.h linux-2.6.19-rc2-mm1/include/asm-s390/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-s390/termbits.h	2006-10-13 15:07:08.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-s390/termbits.h	2006-10-18 14:35:50.000000000 +0100
@@ -25,6 +25,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-sh/termbits.h linux-2.6.19-rc2-mm1/include/asm-sh/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-sh/termbits.h	2006-10-13 15:07:09.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-sh/termbits.h	2006-10-18 14:36:15.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-sparc/termbits.h linux-2.6.19-rc2-mm1/include/asm-sparc/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-sparc/termbits.h	2006-10-13 15:07:09.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-sparc/termbits.h	2006-10-18 14:48:38.000000000 +0100
@@ -31,6 +31,18 @@
 #endif
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR    0
 #define VQUIT    1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-sparc64/termbits.h linux-2.6.19-rc2-mm1/include/asm-sparc64/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-sparc64/termbits.h	2006-10-13 15:07:09.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-sparc64/termbits.h	2006-10-18 14:48:58.000000000 +0100
@@ -33,6 +33,18 @@
 #endif
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR    0
 #define VQUIT    1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-v850/termbits.h linux-2.6.19-rc2-mm1/include/asm-v850/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-v850/termbits.h	2006-10-13 15:07:09.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-v850/termbits.h	2006-10-18 14:38:03.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/asm-x86_64/termbits.h linux-2.6.19-rc2-mm1/include/asm-x86_64/termbits.h
--- linux.vanilla-2.6.19-rc2-mm1/include/asm-x86_64/termbits.h	2006-10-13 15:07:09.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/asm-x86_64/termbits.h	2006-10-18 14:11:14.000000000 +0100
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct ktermios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1

