Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUFXMyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUFXMyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUFXMwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:52:55 -0400
Received: from mail.donpac.ru ([80.254.111.2]:26287 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264432AbUFXMw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:52:28 -0400
Subject: [PATCH 2/4] 2.6.7-mm2, Use it in IRDA drivers
In-Reply-To: <10880815421449@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 24 Jun 2004 16:52:25 +0400
Message-Id: <10880815453111@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes IRDA subsystem use common crc16 code.


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 include/net/irda/crc.h |   10 ++-----
 net/irda/Kconfig       |    1 
 net/irda/Makefile      |    2 -
 net/irda/crc.c         |   68 -------------------------------------------------
 4 files changed, 5 insertions(+), 76 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/include/net/irda/crc.h linux-2.6.7-rc1-mm1/include/net/irda/crc.h
--- linux-2.6.7-rc1-mm1.vanilla/include/net/irda/crc.h	Wed Apr 28 22:56:46 2004
+++ linux-2.6.7-rc1-mm1/include/net/irda/crc.h	Sat May  8 13:59:27 2004
@@ -15,19 +15,15 @@
 #define IRDA_CRC_H
 
 #include <linux/types.h>
+#include <linux/crc16.h>
 
 #define INIT_FCS  0xffff   /* Initial FCS value */
 #define GOOD_FCS  0xf0b8   /* Good final FCS value */
 
-extern __u16 const irda_crc16_table[];
-
 /* Recompute the FCS with one more character appended. */
-static inline __u16 irda_fcs(__u16 fcs, __u8 c)
-{
-	return (((fcs) >> 8) ^ irda_crc16_table[((fcs) ^ (c)) & 0xff]);
-}
+#define irda_fcs(fcs, c) crc16_byte(fcs, c)
 
 /* Recompute the FCS with len bytes appended. */
-__u16 irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len);
+#define irda_calc_crc16(fcs, buf, len) crc16(fcs, buf, len)
 
 #endif
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/net/irda/Kconfig linux-2.6.7-rc1-mm1/net/irda/Kconfig
--- linux-2.6.7-rc1-mm1.vanilla/net/irda/Kconfig	Wed Apr 28 22:57:09 2004
+++ linux-2.6.7-rc1-mm1/net/irda/Kconfig	Sat May  8 14:13:30 2004
@@ -5,6 +5,7 @@
 menuconfig IRDA
 	depends on NET
 	tristate "IrDA (infrared) subsystem support"
+	select CRC16
 	---help---
 	  Say Y here if you want to build support for the IrDA (TM) protocols.
 	  The Infrared Data Associations (tm) specifies standards for wireless
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/net/irda/Makefile linux-2.6.7-rc1-mm1/net/irda/Makefile
--- linux-2.6.7-rc1-mm1.vanilla/net/irda/Makefile	Wed Apr 28 22:57:09 2004
+++ linux-2.6.7-rc1-mm1/net/irda/Makefile	Sat May  8 13:57:16 2004
@@ -9,7 +9,7 @@ obj-$(CONFIG_IRCOMM) += ircomm/
 
 irda-y := iriap.o iriap_event.o irlmp.o irlmp_event.o irlmp_frame.o \
           irlap.o irlap_event.o irlap_frame.o timer.o qos.o irqueue.o \
-          irttp.o irda_device.o irias_object.o crc.o wrapper.o af_irda.o \
+          irttp.o irda_device.o irias_object.o wrapper.o af_irda.o \
 	  discovery.o parameters.o irmod.o
 irda-$(CONFIG_PROC_FS) += irproc.o
 irda-$(CONFIG_SYSCTL) += irsysctl.o
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/net/irda/crc.c linux-2.6.7-rc1-mm1/net/irda/crc.c
--- linux-2.6.7-rc1-mm1.vanilla/net/irda/crc.c	Wed Apr 28 22:57:09 2004
+++ linux-2.6.7-rc1-mm1/net/irda/crc.c	Thu Jan  1 03:00:00 1970
@@ -1,68 +0,0 @@
-/*********************************************************************
- *                
- * Filename:      crc.c
- * Version:       0.1
- * Description:   CRC calculation routines
- * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
- * Created at:    Mon Aug  4 20:40:53 1997
- * Modified at:   Sun May  2 20:28:08 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * Sources:       ppp.c by Michael Callahan <callahan@maths.ox.ac.uk>
- *                Al Longyear <longyear@netcom.com>
- *
- ********************************************************************/
-
-#include <net/irda/crc.h>
-#include <linux/module.h>
-
-/*
- * This mysterious table is just the CRC of each possible byte.  It can be
- * computed using the standard bit-at-a-time methods.  The polynomial can
- * be seen in entry 128, 0x8408.  This corresponds to x^0 + x^5 + x^12.
- * Add the implicit x^16, and you have the standard CRC-CCITT.
- */
-__u16 const irda_crc16_table[256] =
-{
-	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
-	0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
-	0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
-	0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
-	0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
-	0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
-	0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
-	0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
-	0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
-	0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
-	0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
-	0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
-	0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
-	0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
-	0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
-	0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
-	0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
-	0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
-	0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
-	0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
-	0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
-	0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
-	0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
-	0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
-	0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
-	0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
-	0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
-	0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
-	0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
-	0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
-	0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
-	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
-};
-EXPORT_SYMBOL(irda_crc16_table);
-
-__u16 irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len) 
-{
-	while (len--)
-                fcs = irda_fcs(fcs, *buf++);
-	return fcs;
-}
-EXPORT_SYMBOL(irda_calc_crc16);

