Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129911AbQK3Ev6>; Wed, 29 Nov 2000 23:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129760AbQK3Evs>; Wed, 29 Nov 2000 23:51:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129911AbQK3Ev3>;
        Wed, 29 Nov 2000 23:51:29 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14885.51636.553524.593379@wire.cadcamlab.org>
Date: Wed, 29 Nov 2000 21:29:56 -0600 (CST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [uPATCH] small __initdata fixes
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc has a minor bug[1]: __attribute__(("section")) is ignored for the
'.rodata' section.  This means that string constants cannot be
__initdata -- we have to use arrays instead.  The other workaround is
to use -fwritable-strings, which would be much worse.

[1] OK so it's arguable whether or not this is a bug, but IMO it is,
    because the contents of static string constants are handled
    differently from static arrays and structs.

A quick grep finds the following violators....

Peter


diff -urk~ 2.4.0test12pre2/arch/i386/kernel/setup.c~ 2.4.0test12pre2/arch/i386/kernel/setup.c
--- 2.4.0test12pre2/arch/i386/kernel/setup.c~	Tue Nov 28 21:54:43 2000
+++ 2.4.0test12pre2/arch/i386/kernel/setup.c	Wed Nov 29 21:10:28 2000
@@ -2060,7 +2060,7 @@
 
 
 /* These need to match <asm/processor.h> */
-static char *cpu_vendor_names[] __initdata = {
+static char cpu_vendor_names[][10] __initdata = {
 	"Intel", "Cyrix", "AMD", "UMC", "NexGen", "Centaur", "Rise", "Transmeta" };
 
 
diff -urk~ 2.4.0test12pre2/drivers/char/serial.c~ 2.4.0test12pre2/drivers/char/serial.c
--- 2.4.0test12pre2/drivers/char/serial.c~	Tue Nov 28 21:54:49 2000
+++ 2.4.0test12pre2/drivers/char/serial.c	Wed Nov 29 21:12:20 2000
@@ -4972,7 +4972,7 @@
 			irq->map = map;
 }
 
-static char *modem_names[] __initdata = {
+static char modem_names[][8] __initdata = {
        "MODEM", "Modem", "modem", "FAX", "Fax", "fax",
        "56K", "56k", "K56", "33.6", "28.8", "14.4",
        "33,600", "28,800", "14,400", "33.600", "28.800", "14.400",
diff -urk~ 2.4.0test12pre2/drivers/isdn/hisax/hscx.c~ 2.4.0test12pre2/drivers/isdn/hisax/hscx.c
--- 2.4.0test12pre2/drivers/isdn/hisax/hscx.c~	Tue Nov 28 21:53:44 2000
+++ 2.4.0test12pre2/drivers/isdn/hisax/hscx.c	Wed Nov 29 21:11:46 2000
@@ -16,7 +16,7 @@
 #include "isdnl1.h"
 #include <linux/interrupt.h>
 
-static char *HSCXVer[] __initdata =
+static char HSCXVer[][6] __initdata =
 {"A1", "?1", "A2", "?3", "A3", "V2.1", "?6", "?7",
  "?8", "?9", "?10", "?11", "?12", "?13", "?14", "???"};
 
diff -urk~ 2.4.0test12pre2/drivers/isdn/hisax/icc.c~ 2.4.0test12pre2/drivers/isdn/hisax/icc.c
--- 2.4.0test12pre2/drivers/isdn/hisax/icc.c~	Tue Nov 28 21:53:45 2000
+++ 2.4.0test12pre2/drivers/isdn/hisax/icc.c	Wed Nov 29 21:10:53 2000
@@ -25,7 +25,7 @@
 #define DBUSY_TIMER_VALUE 80
 #define ARCOFI_USE 0
 
-static char *ICCVer[] __initdata =
+static char ICCVer[][12] __initdata =
 {"2070 A1/A3", "2070 B1", "2070 B2/B3", "2070 V2.4"};
 
 void
diff -urk~ 2.4.0test12pre2/drivers/isdn/hisax/w6692.c~ 2.4.0test12pre2/drivers/isdn/hisax/w6692.c
--- 2.4.0test12pre2/drivers/isdn/hisax/w6692.c~	Tue Nov 28 21:53:50 2000
+++ 2.4.0test12pre2/drivers/isdn/hisax/w6692.c	Wed Nov 29 21:11:13 2000
@@ -51,7 +51,7 @@
 
 #define DBUSY_TIMER_VALUE 80
 
-static char *W6692Ver[] __initdata =
+static char W6692Ver[][10] __initdata =
 {"W6692 V00", "W6692 V01", "W6692 V10",
  "W6692 V11"};
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
