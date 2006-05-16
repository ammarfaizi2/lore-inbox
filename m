Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWEPTTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWEPTTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWEPTTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:19:05 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20658 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751001AbWEPTTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:19:04 -0400
Date: Tue, 16 May 2006 21:19:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] openpromfs: remove unnecessary casts
Message-ID: <Pine.LNX.4.61.0605162118350.26647@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unnecessary casts in fs/openpromfs/inode.c

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17-rc4~/fs/openpromfs/inode.c linux-2.6.17-rc4+/fs/openpromfs/inode.c
--- linux-2.6.17-rc4~/fs/openpromfs/inode.c	2006-05-16 20:57:32.000000000 +0200
+++ linux-2.6.17-rc4+/fs/openpromfs/inode.c	2006-05-16 20:58:37.085807000 +0200
@@ -72,7 +72,7 @@ static ssize_t nodenum_read(struct file 
 	
 	if (count < 0 || !inode->u.generic_ip)
 		return -EINVAL;
-	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->u.generic_ip));
+	sprintf (buffer, "%8.8lx\n", (long)inode->u.generic_ip);
 	if (file->f_pos >= 9)
 		return 0;
 	if (count > 9 - file->f_pos)
@@ -123,7 +123,7 @@ static ssize_t property_read(struct file
 					      GFP_KERNEL);
 		if (!filp->private_data)
 			return -ENOMEM;
-		op = (openprom_property *)filp->private_data;
+		op = filp->private_data;
 		op->flag = 0;
 		op->alloclen = 2 * i;
 		strcpy (op->name, p);
@@ -163,7 +163,7 @@ static ssize_t property_read(struct file
 				op->len--;
 		}
 	} else
-		op = (openprom_property *)filp->private_data;
+		op = filp->private_data;
 	if (!count || !(op->len || (op->flag & OPP_ASCIIZ)))
 		return 0;
 	if (*ppos >= 0xffffff || count >= 0xffffff)
@@ -335,7 +335,7 @@ static ssize_t property_write(struct fil
 			return i;
 	}
 	k = *ppos;
-	op = (openprom_property *)filp->private_data;
+	op = filp->private_data;
 	if (!(op->flag & OPP_STRING)) {
 		u32 *first, *last;
 		int first_off, last_cnt;
@@ -388,13 +388,13 @@ static ssize_t property_write(struct fil
 			memcpy (b, filp->private_data,
 				sizeof (openprom_property)
 				+ strlen (op->name) + op->alloclen);
-			memset (((char *)b) + sizeof (openprom_property)
+			memset (b + sizeof (openprom_property)
 				+ strlen (op->name) + op->alloclen, 
 				0, 2 * i - op->alloclen);
-			op = (openprom_property *)b;
+			op = b;
 			op->alloclen = 2*i;
 			b = filp->private_data;
-			filp->private_data = (void *)op;
+			filp->private_data = op;
 			kfree (b);
 		}
 		first = ((u32 *)op->value) + (k / 9);
@@ -498,13 +498,13 @@ write_try_string:
 			memcpy (b, filp->private_data,
 				sizeof (openprom_property)
 				+ strlen (op->name) + op->alloclen);
-			memset (((char *)b) + sizeof (openprom_property)
+			memset (b + sizeof (openprom_property)
 				+ strlen (op->name) + op->alloclen, 
 				0, 2*(count - *ppos) - op->alloclen);
-			op = (openprom_property *)b;
+			op = b;
 			op->alloclen = 2*(count + *ppos);
 			b = filp->private_data;
-			filp->private_data = (void *)op;
+			filp->private_data = op;
 			kfree (b);
 		}
 		p = op->value + *ppos - ((op->flag & OPP_QUOTED) ? 1 : 0);
@@ -533,7 +533,7 @@ write_try_string:
 
 int property_release (struct inode *inode, struct file *filp)
 {
-	openprom_property *op = (openprom_property *)filp->private_data;
+	openprom_property *op = filp->private_data;
 	int error;
 	u32 node;
 	
@@ -932,7 +932,7 @@ static int __init check_space (u16 n)
 			return -1;
 
 		if (nodes) {
-			memcpy ((char *)pages, (char *)nodes,
+			memcpy ((char *)pages, nodes,
 				(1 << alloced) * PAGE_SIZE);
 			free_pages ((unsigned long)nodes, alloced);
 		}
#<<eof>>


Jan Engelhardt
-- 
