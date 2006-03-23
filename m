Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWCWIMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWCWIMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWCWIMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:12:40 -0500
Received: from dsl017-055-116.sfo1.dsl.speakeasy.net ([69.17.55.116]:40648
	"EHLO mail.murgatroid.com") by vger.kernel.org with ESMTP
	id S1030203AbWCWIMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:12:39 -0500
To: khali@linux-fr.org, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       akpm@osdl.org, ch@murgatroid.com
Subject: [PATCH] Clean up magic numbers in i2c_parport.h
Message-Id: <20060323081231.D794B1EC019@garage.murgatroid.com>
Date: Thu, 23 Mar 2006 00:12:31 -0800 (PST)
From: ch@garage.murgatroid.com (Christopher Hoover)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This small patch gets rid of some magic numbers in the i2c parport
drivers, specifically wrt the control and status handling, using the
symbols already defined in parport.h

The patch produces the same binary objects for i2c-parport.c and
i2c-parport-simple.c as before.

Please apply.

Cheers,
Christopher.

ch@murgatroid.com
ch@hpl.hp.com



Only in linux-2.6.16: .config
diff --exclude=scripts --exclude='*~' -aurp linux-2.6.16/drivers/i2c/busses/i2c-parport.h linux-2.6.16.i2c/drivers/i2c/busses/i2c-parport.h
--- linux-2.6.16/drivers/i2c/busses/i2c-parport.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16.i2c/drivers/i2c/busses/i2c-parport.h	2006-03-22 23:51:08.000000000 -0800
@@ -18,6 +18,8 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * ------------------------------------------------------------------------ */
 
+#include <linux/parport.h>
+
 #ifdef DATA
 #undef DATA
 #endif
@@ -40,53 +42,62 @@ struct adapter_parm {
 	struct lineop init;
 };
 
+#define LINEOP_DATA(val_, inverted_) \
+   { .val=(val_), .port = DATA, .inverted=(inverted_) }
+
+#define LINEOP_STATUS(val_, inverted_) \
+   { .val=(val_), .port = STAT, .inverted=(inverted_) }
+
+#define LINEOP_CONTROL(val_, inverted_) \
+   { .val=(val_), .port = CTRL, .inverted=(inverted_) }
+
 static struct adapter_parm adapter_parm[] = {
 	/* type 0: Philips adapter */
 	{
-		.setsda	= { 0x80, DATA, 1 },
-		.setscl	= { 0x08, CTRL, 0 },
-		.getsda	= { 0x80, STAT, 0 },
-		.getscl	= { 0x08, STAT, 0 },
+		.setsda	= LINEOP_DATA(0x80, 1),
+		.setscl	= LINEOP_CONTROL(PARPORT_CONTROL_SELECT, 0),
+		.getsda	= LINEOP_STATUS(PARPORT_STATUS_BUSY, 0),
+		.getscl	= LINEOP_STATUS(PARPORT_STATUS_ERROR, 0)
 	},
 	/* type 1: home brew teletext adapter */
 	{
-		.setsda	= { 0x02, DATA, 0 },
-		.setscl	= { 0x01, DATA, 0 },
-		.getsda	= { 0x80, STAT, 1 },
+		.setsda	= LINEOP_DATA(0x02, 0),
+		.setscl	= LINEOP_DATA(0x01, 0),
+		.getsda	= LINEOP_STATUS(PARPORT_STATUS_BUSY, 1)
 	},
 	/* type 2: Velleman K8000 adapter */
 	{
-		.setsda	= { 0x02, CTRL, 1 },
-		.setscl	= { 0x08, CTRL, 1 },
-		.getsda	= { 0x10, STAT, 0 },
+		.setsda	= LINEOP_CONTROL(PARPORT_CONTROL_AUTOFD, 1),
+		.setscl	= LINEOP_CONTROL(PARPORT_CONTROL_SELECT, 1),
+		.getsda	= LINEOP_STATUS(PARPORT_STATUS_SELECT, 0)
 	},
 	/* type 3: ELV adapter */
 	{
-		.setsda	= { 0x02, DATA, 1 },
-		.setscl	= { 0x01, DATA, 1 },
-		.getsda	= { 0x40, STAT, 1 },
-		.getscl	= { 0x08, STAT, 1 },
+		.setsda	= LINEOP_DATA(0x02, 1),
+		.setscl	= LINEOP_DATA(0x01, 1),
+		.getsda	= LINEOP_STATUS(PARPORT_STATUS_ACK, 1),
+		.getscl	= LINEOP_STATUS(PARPORT_STATUS_ERROR, 1)
 	},
 	/* type 4: ADM1032 evaluation board */
 	{
-		.setsda	= { 0x02, DATA, 1 },
-		.setscl	= { 0x01, DATA, 1 },
-		.getsda	= { 0x10, STAT, 1 },
-		.init	= { 0xf0, DATA, 0 },
+		.setsda	= LINEOP_DATA(0x02, 1),
+		.setscl	= LINEOP_DATA(0x01, 1),
+		.getsda	= LINEOP_STATUS(PARPORT_STATUS_SELECT, 1),
+		.init	= LINEOP_DATA(0xf0,0)
 	},
 	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
-		.setsda	= { 0x02, DATA, 1 },
-		.setscl	= { 0x01, DATA, 1 },
-		.getsda	= { 0x10, STAT, 1 },
+		.setsda	= LINEOP_DATA(0x02, 1),
+		.setscl	= LINEOP_DATA(0x01, 1),
+		.getsda	= LINEOP_STATUS(PARPORT_STATUS_SELECT, 1)
 	},
 	/* type 6: Barco LPT->DVI (K5800236) adapter */
 	{
-		.setsda	= { 0x02, DATA, 1 },
-		.setscl	= { 0x01, DATA, 1 },
-		.getsda	= { 0x20, STAT, 0 },
-		.getscl	= { 0x40, STAT, 0 },
-		.init	= { 0xfc, DATA, 0 },
+		.setsda	= LINEOP_DATA(0x02, 1),
+		.setscl	= LINEOP_DATA(0x01, 1),
+		.getsda	= LINEOP_STATUS(PARPORT_STATUS_PAPEROUT, 0),
+		.getscl	= LINEOP_STATUS(PARPORT_STATUS_ACK, 0),
+		.init	= LINEOP_DATA(0xfc, 0)
 	},
 };
 
