Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWCMUaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWCMUaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWCMUaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:30:05 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:44816 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932440AbWCMUaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:30:03 -0500
Date: Mon, 13 Mar 2006 21:29:59 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 2/8] saa7111: Prevent array overrun
Message-Id: <20060313212959.db88d296.khali@linux-fr.org>
In-Reply-To: <20060313210933.88a42375.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitely state the number of registers the SAA7111 has, and use
that defined value where relevant. This should prevent any future
array overrun like the one I just fixed in the saa7110 driver.

This patch also saves 8 bytes of memory as a side effect, as the
register cache was larger than needed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/saa7111.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/media/video/saa7111.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/saa7111.c	2006-03-01 21:10:07.000000000 +0100
@@ -69,8 +69,10 @@
 
 /* ----------------------------------------------------------------------- */
 
+#define SAA7111_NR_REG		0x18
+
 struct saa7111 {
-	unsigned char reg[32];
+	unsigned char reg[SAA7111_NR_REG];
 
 	int norm;
 	int input;
@@ -226,11 +228,11 @@
 	{
 		int i;
 
-		for (i = 0; i < 32; i += 16) {
+		for (i = 0; i < SAA7111_NR_REG; i += 16) {
 			int j;
 
 			printk(KERN_DEBUG "%s: %03x", I2C_NAME(client), i);
-			for (j = 0; j < 16; ++j) {
+			for (j = 0; j < 16 && i + j < SAA7111_NR_REG; ++j) {
 				printk(" %02x",
 				       saa7111_read(client, i + j));
 			}

-- 
Jean Delvare
