Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVJYRk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVJYRk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVJYRk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:40:56 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:45788 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S932247AbVJYRkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:40:55 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: <dwmw2@infradead.org>
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH]: 2.6.14-rc3 drives/mtd/redboot.c: recognise a foreign byte sex partition table
Date: Tue, 25 Oct 2005 10:40:03 -0700
Message-ID: <001701c5d98b$2284feb0$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RedBoot boot loader writes flash partition tables containing native byte
sex 32 bit values.  When booting an opposite byte sex kernel (e.g. an LE
kernel from BE RedBoot) the current MTD driver fails to handle the partition
table and therefore is unable to generate the correct partition map for the
flash.

So far as I am aware this problem is ARM specific, because only ARM supports
software change of the CPU (memory system) byte sex, however the partition
table parsing is in generic MTD code.  The patch below has been tested on
NSLU2 (an IXP4XX based system) with a patch, 10-ixp4xx-copy-from.patch
(submitted to linux-arm-kernel - it's ARM specific) required to make the
maps/ixp4xx.c driver work with an LE kernel.

Builds of the patched system are in the 'unstable' release of OpenSlug and
UcSlugC available from  www.nslu2-linux.org.  These builds are BE, the
archives at www.nslu2-linux.org and www.handhelds.org (see
monotone.vanille.de) can be built LE (currently DISTRO targets nslu-ltu.conf
for LE thumb uclibc (32 bit kernel) and nslu2-lau.conf, nslu2-lag.conf for
LE arm uclibc/glibc) and this patch has been tested extensively will both BE
and LE systems on the NSLU2 (including swapping between BE and LE by
reflashing from both RedBoot and Linux).

The patch recognises that the FIS directory (the partition table) is
byte-reversed by examining the partition table size, which is known to be
one erase block (this is an assumption made elsewhere in redboot.c).  If the
size matches the erase block after byte swapping the value then
byte-reversal is assumed, if not no further action is taken.  The patched
code is fail safe; should redboot.c be changed to support a partition table
with a modified size field the test will fail and the partition table will
be assumed to have the host byte sex.

If byte-reversal is detected the patch byte swaps the remainder of the 32
bit fields in the copy of the table; this copy is then used to set up the
MTD partition map.

Signed-off-by: John Bowler <jbowler@acm.org>

---
linux-2.6.13/.pc/10-mtdpart-redboot-fis-byteswap.patch/drivers/mtd/redboot.c
2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/drivers/mtd/redboot.c	2005-10-23 21:44:59.999694674 -0700
@@ -89,8 +89,34 @@
 			i = numslots;
 			break;
 		}
-		if (!memcmp(buf[i].name, "FIS directory", 14))
+		if (!memcmp(buf[i].name, "FIS directory", 14)) {
+			/* This is apparently the FIS directory entry for the
+			 * FIS directory itself.  The FIS directory size is
+			 * one erase block, if the buf[i].size field is
+			 * swab32(erasesize) then we know we are looking at
+			 * a byte swapped FIS directory - swap all the entries!
+			 * (NOTE: this is 'size' not 'data_length', size is
+			 * the full size of the entry.)
+			 */
+			if (swab32(buf[i].size) == master->erasesize) {
+				int j;
+				for (j = 0; j < numslots && buf[j].name[0] != 0xff; ++j) {
+					/* The unsigned long fields were written with the
+					 * wrong byte sex, name and pad have no byte sex.
+					 */
+#					define do_swab32(x) (x) = swab32(x)
+					do_swab32(buf[j].flash_base);
+					do_swab32(buf[j].mem_base);
+					do_swab32(buf[j].size);
+					do_swab32(buf[j].entry_point);
+					do_swab32(buf[j].data_length);
+					do_swab32(buf[j].desc_cksum);
+					do_swab32(buf[j].file_cksum);
+#					undef do_swab32
+				}
+			}
 			break;
+		}
 	}
 	if (i == numslots) {
 		/* Didn't find it */

