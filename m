Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKAUpk>; Wed, 1 Nov 2000 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130547AbQKAUpb>; Wed, 1 Nov 2000 15:45:31 -0500
Received: from core.federated.com ([199.217.175.51]:30225 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S129112AbQKAUpQ>; Wed, 1 Nov 2000 15:45:16 -0500
From: Jim Studt <jim@federated.com>
Message-Id: <200011012045.OAA08574@core.federated.com>
Subject: [PATCH] tulip oops for some eeproms in 2.4.0-test10
To: linux-kernel@vger.kernel.org
Date: Wed, 1 Nov 2000 14:45:06 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me, I follow the list on a web page)

The printk()s which enumerate media types during boot will oops
for some eeproms.  They use the media type as an index into an
array of strings without doing any bounds checking.

This patch fixes it.  The leaf->type is the killer for my card, I 
have a descriptor where that is 128, the block_name table only has 6 
entries.  (The card is a Lite-On Communications Inc LNE100TX, based
on a Kingston card.  Freebie from SWBell on DSL install.)

The "leaf->media & 0x0f" range check is sufficient, but not as nice
as the explicit size check on leaf->type.  There are 16 entires in
medianame, but that is not known to this file during compilation.
(leaf->media could be as high as 0x3f, so some sort of check is called for.
If anyone named linus asks me to make a patch that uses the real size
of medianame I will. :-)

--- linux/drivers/net/tulip/eeprom.c.orig	Wed Nov  1 14:32:18 2000
+++ linux/drivers/net/tulip/eeprom.c	Wed Nov  1 14:14:02 2000
@@ -236,8 +236,9 @@
 			}
 			printk(KERN_INFO "%s:  Index #%d - Media %s (#%d) described "
 				   "by a %s (%d) block.\n",
-				   dev->name, i, medianame[leaf->media], leaf->media,
-				   block_name[leaf->type], leaf->type);
+				   dev->name, i, medianame[leaf->media & 0x0f], leaf->media,
+				   ((leaf->type < sizeof(block_name)/sizeof(block_name[0])) ? block_name[leaf->type] : "unknown"), 
+				   leaf->type);
 		}
 		if (new_advertise)
 			tp->to_advertise = new_advertise;

-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
