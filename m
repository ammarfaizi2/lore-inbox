Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272542AbTGaOgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274803AbTGaOgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:36:51 -0400
Received: from angband.namesys.com ([212.16.7.85]:46270 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S272542AbTGaOgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:36:50 -0400
Date: Thu, 31 Jul 2003 18:36:49 +0400
From: Oleg Drokin <green@namesys.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5] reiserfs: fix savelinks on bigendian arches
Message-ID: <20030731143649.GN14081@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    This small patch fixes a savelinks problem on bigendian platforms, where
    savelinks were not working at all because of incorrect cpu->disk endianness conversion.
    Savelinks are used on reiserfs to remember "truncate" and "unlink" events
    so that if crash happens in the middle of truncate/unlink, we do not endup with
    lost or half truncated files.
    The patch is against 2.6.0-test2

===== fs/reiserfs/super.c 1.66 vs edited =====
--- 1.66/fs/reiserfs/super.c	Sat Jun 21 00:16:06 2003
+++ edited/fs/reiserfs/super.c	Thu Jul 31 18:05:37 2003
@@ -298,7 +298,7 @@
     }
 
     /* body of "save" link */
-    link = cpu_to_le32 (INODE_PKEY (inode)->k_dir_id);
+    link = INODE_PKEY (inode)->k_dir_id;
 
     /* put "save" link inot tree */
     retval = reiserfs_insert_item (th, &path, &key, &ih, (char *)&link);
