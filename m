Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVC1Rre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVC1Rre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVC1RrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:47:14 -0500
Received: from fep18.inet.fi ([194.251.242.243]:27269 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S261976AbVC1RmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:42:13 -0500
Subject: [PATCH 7/9] isofs: extract zisofs parsing to function
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p57.ci8bth.die9b1q2orkmf9yc1r3uljtl1.refire@cs.helsinki.fi>
In-Reply-To: <ie2p50.yci66q.aqv0asoicoaoehr579419heqb.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:42:12 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extracts ZISOFS entry parsing to a separate function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |   77 +++++++++++++++++++++++++++++------------------------------------
 1 files changed, 35 insertions(+), 42 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 18:26:34.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 18:47:40.000000000 +0300
@@ -177,6 +177,40 @@
 	return 0;
 }
 
+#ifdef CONFIG_ZISOFS
+static void rock_parse_zisofs_entry(struct rock_ridge *rr, struct inode *inode)
+{
+	int algo;
+
+	if (ISOFS_SB(inode->i_sb)->s_nocompress)
+		return;
+
+	algo = isonum_721(rr->u.ZF.algorithm);
+	if (algo == SIG('p', 'z')) {
+		int block_shift = isonum_711(&rr->u.ZF.parms[1]);
+		if (block_shift < PAGE_CACHE_SHIFT || block_shift > 17) {
+			printk(KERN_WARNING
+			       "isofs: Can't handle ZF block size of 2^%d\n",
+			       block_shift);
+		} else {
+			/* Note: we don't change i_blocks here */
+			ISOFS_I(inode)->i_file_format = isofs_file_compressed;
+			/* Parameters to compression algorithm (header size, block size) */
+			ISOFS_I(inode)->i_format_parm[0] =
+				isonum_711(&rr->u.ZF.parms[0]);
+			ISOFS_I(inode)->i_format_parm[1] =
+				isonum_711(&rr->u.ZF.parms[1]);
+			inode->i_size = isonum_733(rr->u.ZF.real_size);
+		}
+	} else {
+		printk(KERN_WARNING
+		       "isofs: Unknown ZF compression algorithm: %c%c\n",
+		       rr->u.ZF.algorithm[0],
+		       rr->u.ZF.algorithm[1]);
+	}
+}
+#endif
+
 static int
 parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 				struct inode *inode, int regard_xa)
@@ -384,48 +418,7 @@
 				break;
 #ifdef CONFIG_ZISOFS
 			case SIG('Z', 'F'):
-				if (!ISOFS_SB(inode->i_sb)->s_nocompress) {
-					int algo;
-					algo = isonum_721(rr->u.ZF.algorithm);
-					if (algo == SIG('p', 'z')) {
-						int block_shift =
-						    isonum_711(&rr->u.ZF.
-							       parms[1]);
-						if (block_shift <
-						    PAGE_CACHE_SHIFT
-						    || block_shift > 17) {
-							printk(KERN_WARNING
-							       "isofs: Can't handle ZF block size of 2^%d\n",
-							       block_shift);
-						} else {
-							/* Note: we don't change i_blocks here */
-							ISOFS_I(inode)->
-							    i_file_format =
-							    isofs_file_compressed;
-							/* Parameters to compression algorithm (header size, block size) */
-							ISOFS_I(inode)->
-							    i_format_parm[0] =
-							    isonum_711(&rr->u.
-								       ZF.
-								       parms
-								       [0]);
-							ISOFS_I(inode)->
-							    i_format_parm[1] =
-							    isonum_711(&rr->u.
-								       ZF.
-								       parms
-								       [1]);
-							inode->i_size =
-							    isonum_733(rr->u.ZF.
-								       real_size);
-						}
-					} else {
-						printk(KERN_WARNING
-						       "isofs: Unknown ZF compression algorithm: %c%c\n",
-						       rr->u.ZF.algorithm[0],
-						       rr->u.ZF.algorithm[1]);
-					}
-				}
+				rock_parse_zisofs_entry(rr, inode);
 				break;
 #endif
 			default:
