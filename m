Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWCMUfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWCMUfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWCMUfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:35:30 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:23825 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964776AbWCMUf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:35:29 -0500
Date: Mon, 13 Mar 2006 21:35:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 7/8] bt856: Spare memory
Message-Id: <20060313213530.626ac539.khali@linux-fr.org>
In-Reply-To: <20060313210933.88a42375.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bt856 driver has a register cache much larger than needed. We
really only write to 3 registers, so a 32-byte cache is a bit too
much. We can be just as efficient with a 6-byte cache. We could even
do with a 3-byte cache, but at the cost of additional arithmetics
arguably not worth the spared 3 bytes.

Also, 4 of the 6 other members of the bt856 data structure were not
used anywhere, so we can as well drop them for an additional 16 bytes
of memory spared.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/bt856.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/media/video/bt856.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/bt856.c	2006-03-01 21:10:19.000000000 +0100
@@ -70,17 +70,14 @@
 
 /* ----------------------------------------------------------------------- */
 
-#define REG_OFFSET  0xCE
+#define REG_OFFSET	0xDA
+#define BT856_NR_REG	6
 
 struct bt856 {
-	unsigned char reg[32];
+	unsigned char reg[BT856_NR_REG];
 
 	int norm;
 	int enable;
-	int bright;
-	int contrast;
-	int hue;
-	int sat;
 };
 
 #define   I2C_BT856        0x88
@@ -119,8 +116,8 @@
 	struct bt856 *encoder = i2c_get_clientdata(client);
 
 	printk(KERN_INFO "%s: register dump:", I2C_NAME(client));
-	for (i = 0xd6; i <= 0xde; i += 2)
-		printk(" %02x", encoder->reg[i - REG_OFFSET]);
+	for (i = 0; i < BT856_NR_REG; i += 2)
+		printk(" %02x", encoder->reg[i]);
 	printk("\n");
 }
 

-- 
Jean Delvare
