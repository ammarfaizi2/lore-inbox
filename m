Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752054AbWCJVzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbWCJVzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbWCJVzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:55:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:27521 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752054AbWCJVzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:55:01 -0500
Subject: [PATCH] ext3 "nobh" writeback support for filesystems blocksize <
	pagesize
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 13:56:34 -0800
Message-Id: <1142027794.21442.49.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reading through the code, I don't see a reason why we can't
support "nobh" option for filesystems with blocksize < pagesize.
Base infrastructure already handles it and kicks it back to
creating buffer_heads if it can't handle. 

Of course, there may be performance reasons why we don't want
to do this.

Anyway, following patch at least enables "nobh" option for 
blocksize < pagesize cases.

Thanks,
Badari

There is no valid reason why we can't support "nobh" option
for filesystems with blocksize != PAGESIZE. 

This patch lets them use "nobh" option for writeback mode
for blocksize < pagesize.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc5/fs/ext3/super.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/ext3/super.c	2006-03-10 10:38:39.000000000 -0800
+++ linux-2.6.16-rc5/fs/ext3/super.c	2006-03-10 13:58:07.000000000 -0800
@@ -1677,12 +1677,6 @@ static int ext3_fill_super (struct super
 	}
 
 	if (test_opt(sb, NOBH)) {
-		if (sb->s_blocksize_bits != PAGE_CACHE_SHIFT) {
-			printk(KERN_WARNING "EXT3-fs: Ignoring nobh option "
-				"since filesystem blocksize doesn't match "
-				"pagesize\n");
-			clear_opt(sbi->s_mount_opt, NOBH);
-		}
 		if (!(test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)) {
 			printk(KERN_WARNING "EXT3-fs: Ignoring nobh option - "
 				"its supported only with writeback mode\n");


