Return-Path: <linux-kernel-owner+w=401wt.eu-S1030411AbWLPAuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWLPAuH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWLPAuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 19:50:07 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51720 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030411AbWLPAuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 19:50:03 -0500
X-Sasl-enc: nDLyBT123ZKtKZ07DX1uLQAVJ9hbzKt8O4Ym7iCe+duY 1166230198
Message-ID: <45834391.2050100@imap.cc>
Date: Sat, 16 Dec 2006 01:53:37 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH][RFC] consolidate line discipline number definitions
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF1FC061C2E28156DFCC18B92"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1FC061C2E28156DFCC18B92
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The line discipline code numbers N_* are currently defined
separately for each architecture in include/asm-${arch}/termios.h
which is in turn included by include/linux/termios.h via the
symlink include/asm. I don't see any reason why these definitions
need to be architecture specific. They are identical for all
architectures, with a single exception: include/asm-cris/termios.h
doesn't define N_HCI, but instead defines N_BT with the same value
(15). This however appears to be a mistake rather than deliberate,
as N_BT isn't used anyhere in the 2.6.19 source tree.

Therefore I propose to consolidate these definitions by moving
them into the architecture independent part as by the patch below.
This would significantly reduce the effort for adding new line
disciplines and the danger of unnecessary divergence between
architectures as well as errors like the one cited above.

A few source files include <asm/termios.h> directly instead of
<linux/termios.h> and would therefore miss the moved definitions.
These are:
  arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h
  arch/parisc/hpux/ioctl.c
  arch/sparc64/solaris/ioctl.c
  arch/sparc64/solaris/socksys.c
  arch/sparc64/solaris/timod.c
  drivers/char/n_hdlc.c
  drivers/serial/crisv10.h
Of these, only drivers/char/n_hdlc.c actually references a line
discipline number and is therefore also patched below to include
<linux/termios.h> instead. For the others, I would like opinions
on whether to change them to <linux/termios.h> too.

I would also like comments from someone versed in UML on whether
include/asm-um/termios.h, which includes "asm/arch/termios.h",
will need modification.

Thanks
Tilman

From: Tilman Schmidt <tilman@imap.cc>

Consolidate line discipline number definitions from
architecture-specific termios.h files into architecture
independent termios.h file.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/char/n_hdlc.c         |    2 +-
 include/asm-alpha/termios.h   |   18 ------------------
 include/asm-arm/termios.h     |   18 ------------------
 include/asm-arm26/termios.h   |   18 ------------------
 include/asm-avr32/termios.h   |   18 ------------------
 include/asm-cris/termios.h    |   18 ------------------
 include/asm-frv/termios.h     |   18 ------------------
 include/asm-h8300/termios.h   |   18 ------------------
 include/asm-i386/termios.h    |   18 ------------------
 include/asm-ia64/termios.h    |   18 ------------------
 include/asm-m32r/termios.h    |   18 ------------------
 include/asm-m68k/termios.h    |   18 ------------------
 include/asm-mips/termios.h    |   18 ------------------
 include/asm-parisc/termios.h  |   18 ------------------
 include/asm-powerpc/termios.h |   18 ------------------
 include/asm-s390/termios.h    |   18 ------------------
 include/asm-sh/termios.h      |   18 ------------------
 include/asm-sh64/termios.h    |   18 ------------------
 include/asm-sparc/termios.h   |   18 ------------------
 include/asm-sparc64/termios.h |   18 ------------------
 include/asm-v850/termios.h    |   18 ------------------
 include/asm-x86_64/termios.h  |   18 ------------------
 include/asm-xtensa/termios.h  |   19 -------------------
 include/linux/termios.h       |   19 +++++++++++++++++++
 24 files changed, 20 insertions(+), 398 deletions(-)

diff -pur linux-2.6.19-orig/drivers/char/n_hdlc.c linux-2.6.19/drivers/ch=
ar/n_hdlc.c
--- linux-2.6.19-orig/drivers/char/n_hdlc.c	2006-11-29 22:57:37.000000000=
 +0100
+++ linux-2.6.19/drivers/char/n_hdlc.c	2006-12-15 19:12:39.000000000 +010=
0
@@ -103,9 +103,9 @@
 #include <linux/signal.h>	/* used in new tty drivers */
 #include <linux/if.h>
 #include <linux/bitops.h>
+#include <linux/termios.h>

 #include <asm/system.h>
-#include <asm/termios.h>
 #include <asm/uaccess.h>

 /*
diff -pur linux-2.6.19-orig/include/asm-alpha/termios.h linux-2.6.19/incl=
ude/asm-alpha/termios.h
--- linux-2.6.19-orig/include/asm-alpha/termios.h	2006-11-29 22:57:37.000=
000000 +0100
+++ linux-2.6.19/include/asm-alpha/termios.h	2006-12-15 18:55:12.00000000=
0 +0100
@@ -66,24 +66,6 @@ struct termio {
 #define _VEOL2	6
 #define _VSWTC	7

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 /*	eof=3D^D		eol=3D\0		eol2=3D\0		erase=3Ddel
 	werase=3D^W	kill=3D^U		reprint=3D^R	sxtc=3D\0
diff -pur linux-2.6.19-orig/include/asm-arm/termios.h linux-2.6.19/includ=
e/asm-arm/termios.h
--- linux-2.6.19-orig/include/asm-arm/termios.h	2006-11-29 22:57:37.00000=
0000 +0100
+++ linux-2.6.19/include/asm-arm/termios.h	2006-12-15 18:58:57.000000000 =
+0100
@@ -49,24 +49,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*
diff -pur linux-2.6.19-orig/include/asm-arm26/termios.h linux-2.6.19/incl=
ude/asm-arm26/termios.h
--- linux-2.6.19-orig/include/asm-arm26/termios.h	2006-11-29 22:57:37.000=
000000 +0100
+++ linux-2.6.19/include/asm-arm26/termios.h	2006-12-15 18:58:03.00000000=
0 +0100
@@ -49,24 +49,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*
diff -pur linux-2.6.19-orig/include/asm-avr32/termios.h linux-2.6.19/incl=
ude/asm-avr32/termios.h
--- linux-2.6.19-orig/include/asm-avr32/termios.h	2006-11-29 22:57:37.000=
000000 +0100
+++ linux-2.6.19/include/asm-avr32/termios.h	2006-12-15 19:00:52.00000000=
0 +0100
@@ -46,24 +46,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
 	eof=3D^D		vtime=3D\0	vmin=3D\1		sxtc=3D\0
diff -pur linux-2.6.19-orig/include/asm-cris/termios.h linux-2.6.19/inclu=
de/asm-cris/termios.h
--- linux-2.6.19-orig/include/asm-cris/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-cris/termios.h	2006-12-15 19:01:21.000000000=
 +0100
@@ -40,24 +40,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_BT		15	/* bluetooth */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-frv/termios.h linux-2.6.19/includ=
e/asm-frv/termios.h
--- linux-2.6.19-orig/include/asm-frv/termios.h	2006-11-29 22:57:37.00000=
0000 +0100
+++ linux-2.6.19/include/asm-frv/termios.h	2006-12-15 19:01:37.000000000 =
+0100
@@ -51,24 +51,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #include <asm-generic/termios.h>

 #endif /* _ASM_TERMIOS_H */
diff -pur linux-2.6.19-orig/include/asm-h8300/termios.h linux-2.6.19/incl=
ude/asm-h8300/termios.h
--- linux-2.6.19-orig/include/asm-h8300/termios.h	2006-11-29 22:57:37.000=
000000 +0100
+++ linux-2.6.19/include/asm-h8300/termios.h	2006-12-15 19:04:15.00000000=
0 +0100
@@ -49,24 +49,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*
diff -pur linux-2.6.19-orig/include/asm-i386/termios.h linux-2.6.19/inclu=
de/asm-i386/termios.h
--- linux-2.6.19-orig/include/asm-i386/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-i386/termios.h	2006-12-15 19:04:43.000000000=
 +0100
@@ -39,24 +39,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>

diff -pur linux-2.6.19-orig/include/asm-ia64/termios.h linux-2.6.19/inclu=
de/asm-ia64/termios.h
--- linux-2.6.19-orig/include/asm-ia64/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-ia64/termios.h	2006-12-15 19:05:33.000000000=
 +0100
@@ -46,24 +46,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS msgs */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 # ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-m32r/termios.h linux-2.6.19/inclu=
de/asm-m32r/termios.h
--- linux-2.6.19-orig/include/asm-m32r/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-m32r/termios.h	2006-12-15 19:05:47.000000000=
 +0100
@@ -41,24 +41,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>

diff -pur linux-2.6.19-orig/include/asm-m68k/termios.h linux-2.6.19/inclu=
de/asm-m68k/termios.h
--- linux-2.6.19-orig/include/asm-m68k/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-m68k/termios.h	2006-12-15 19:06:02.000000000=
 +0100
@@ -49,24 +49,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*
diff -pur linux-2.6.19-orig/include/asm-mips/termios.h linux-2.6.19/inclu=
de/asm-mips/termios.h
--- linux-2.6.19-orig/include/asm-mips/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-mips/termios.h	2006-12-15 19:06:13.000000000=
 +0100
@@ -87,24 +87,6 @@ struct termio {
 #define TIOCM_OUT2	0x4000
 #define TIOCM_LOOP	0x8000

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6		/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved fo Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15	/* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 #include <linux/string.h>
diff -pur linux-2.6.19-orig/include/asm-parisc/termios.h linux-2.6.19/inc=
lude/asm-parisc/termios.h
--- linux-2.6.19-orig/include/asm-parisc/termios.h	2006-11-29 22:57:37.00=
0000000 +0100
+++ linux-2.6.19/include/asm-parisc/termios.h	2006-12-15 19:06:25.0000000=
00 +0100
@@ -39,24 +39,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-powerpc/termios.h linux-2.6.19/in=
clude/asm-powerpc/termios.h
--- linux-2.6.19-orig/include/asm-powerpc/termios.h	2006-11-29 22:57:37.0=
00000000 +0100
+++ linux-2.6.19/include/asm-powerpc/termios.h	2006-12-15 19:07:32.000000=
000 +0100
@@ -71,24 +71,6 @@ struct termio {
 #define _VEOL2	8
 #define _VSWTC	9

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://www.cs.uit.no/~dagb/irda/irda.=
html */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 /*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z =
 ^Q  ^S  ^V  ^U  */
 #define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\=
021\023\026\025"
diff -pur linux-2.6.19-orig/include/asm-s390/termios.h linux-2.6.19/inclu=
de/asm-s390/termios.h
--- linux-2.6.19-orig/include/asm-s390/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-s390/termios.h	2006-12-15 19:07:49.000000000=
 +0100
@@ -47,24 +47,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-sh/termios.h linux-2.6.19/include=
/asm-sh/termios.h
--- linux-2.6.19-orig/include/asm-sh/termios.h	2006-11-29 22:57:37.000000=
000 +0100
+++ linux-2.6.19/include/asm-sh/termios.h	2006-12-15 19:08:21.000000000 +=
0100
@@ -39,24 +39,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-sh64/termios.h linux-2.6.19/inclu=
de/asm-sh64/termios.h
--- linux-2.6.19-orig/include/asm-sh64/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-sh64/termios.h	2006-12-15 19:08:08.000000000=
 +0100
@@ -50,24 +50,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://www.cs.uit.no/~dagb/irda/irda.ht=
ml */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15	/* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-sparc/termios.h linux-2.6.19/incl=
ude/asm-sparc/termios.h
--- linux-2.6.19-orig/include/asm-sparc/termios.h	2006-11-29 22:57:37.000=
000000 +0100
+++ linux-2.6.19/include/asm-sparc/termios.h	2006-12-15 19:09:32.00000000=
0 +0100
@@ -45,24 +45,6 @@ struct winsize {
 	unsigned short ws_ypixel;
 };

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>

diff -pur linux-2.6.19-orig/include/asm-sparc64/termios.h linux-2.6.19/in=
clude/asm-sparc64/termios.h
--- linux-2.6.19-orig/include/asm-sparc64/termios.h	2006-11-29 22:57:37.0=
00000000 +0100
+++ linux-2.6.19/include/asm-sparc64/termios.h	2006-12-15 19:08:38.000000=
000 +0100
@@ -45,24 +45,6 @@ struct winsize {
 	unsigned short ws_ypixel;
 };

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>

diff -pur linux-2.6.19-orig/include/asm-v850/termios.h linux-2.6.19/inclu=
de/asm-v850/termios.h
--- linux-2.6.19-orig/include/asm-v850/termios.h	2006-11-29 22:57:37.0000=
00000 +0100
+++ linux-2.6.19/include/asm-v850/termios.h	2006-12-15 19:09:51.000000000=
 +0100
@@ -39,24 +39,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-x86_64/termios.h linux-2.6.19/inc=
lude/asm-x86_64/termios.h
--- linux-2.6.19-orig/include/asm-x86_64/termios.h	2006-11-29 22:57:37.00=
0000000 +0100
+++ linux-2.6.19/include/asm-x86_64/termios.h	2006-12-15 19:10:05.0000000=
00 +0100
@@ -39,24 +39,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/asm-xtensa/termios.h linux-2.6.19/inc=
lude/asm-xtensa/termios.h
--- linux-2.6.19-orig/include/asm-xtensa/termios.h	2006-11-29 22:57:37.00=
0000000 +0100
+++ linux-2.6.19/include/asm-xtensa/termios.h	2006-12-15 19:10:25.0000000=
00 +0100
@@ -52,25 +52,6 @@ struct termio {

 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

-/* Line disciplines */
-
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards =
about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15      /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__

 /*	intr=3D^C		quit=3D^\		erase=3Ddel	kill=3D^U
diff -pur linux-2.6.19-orig/include/linux/termios.h linux-2.6.19/include/=
linux/termios.h
--- linux-2.6.19-orig/include/linux/termios.h	2006-11-29 22:57:37.0000000=
00 +0100
+++ linux-2.6.19/include/linux/termios.h	2006-12-15 18:59:29.000000000 +0=
100
@@ -4,4 +4,23 @@
 #include <linux/types.h>
 #include <asm/termios.h>

+/* line disciplines */
+#define N_TTY		0
+#define N_SLIP		1
+#define N_MOUSE		2
+#define N_PPP		3
+#define N_STRIP		4
+#define N_AX25		5
+#define N_X25		6	/* X.25 async */
+#define N_6PACK		7
+#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
+#define N_R3964		9	/* Reserved for Simatic R3964 module */
+#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
+#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
+#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data */
+				/* cards about SMS messages */
+#define N_HDLC		13	/* synchronous HDLC */
+#define N_SYNC_PPP	14	/* synchronous PPP */
+#define N_HCI		15	/* Bluetooth HCI UART */
+
 #endif


--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigF1FC061C2E28156DFCC18B92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFg0OaMdB4Whm86/kRAqI6AJ9S3b8Kln21P6qBFHfD/E7BnO50YQCfV8k6
Q4TdDAReOLLaCllsANPAICI=
=yFja
-----END PGP SIGNATURE-----

--------------enigF1FC061C2E28156DFCC18B92--
