Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUEOT23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUEOT23 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUEOT23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:28:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35747 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264677AbUEOT2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:28:25 -0400
Date: Sat, 15 May 2004 21:28:24 +0200
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       Eugene Crosser <crosser@average.org>, torvalds@osdl.org
Subject: [PATCH] Quota fix 2
Message-ID: <20040515192824.GB21471@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  another fix for quota code - it fixes the problem with recursion into
filesystem when inode of quota file needs a page + some other allocation
problems. I hope I got the GFP mask setting right.. The patch is against
2.6.6 with the patch you sent to Linus & my previous quota patch. Please
apply.

								Honza


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.6-3-slabfix.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.6.6-2-releasefix/fs/dquot.c linux-2.6.6-3-slabfix/fs/dquot.c
--- linux-2.6.6-2-releasefix/fs/dquot.c	2004-05-13 21:05:02.000000000 +0200
+++ linux-2.6.6-3-slabfix/fs/dquot.c	2004-05-14 15:19:38.000000000 +0200
@@ -75,6 +75,7 @@
 #include <linux/proc_fs.h>
 #include <linux/security.h>
 #include <linux/kmod.h>
+#include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
 
@@ -547,7 +548,7 @@
 {
 	struct dquot *dquot;
 
-	dquot = kmem_cache_alloc(dquot_cachep, SLAB_KERNEL);
+	dquot = kmem_cache_alloc(dquot_cachep, SLAB_NOFS);
 	if(!dquot)
 		return NODQUOT;
 
@@ -1366,9 +1367,12 @@
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_file_init;
-	/* We don't want quota and atime on quota files (deadlocks possible) */
+	/* We don't want quota and atime on quota files (deadlocks possible)
+	 * We also need to set GFP mask differently because we cannot recurse
+	 * into filesystem when allocating page for quota inode */
 	down_write(&dqopt->dqptr_sem);
 	inode->i_flags |= S_NOQUOTA | S_NOATIME;
+	clear_bit(ffs(__GFP_FS), &inode->i_mapping->flags);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		to_drop[cnt] = inode->i_dquot[cnt];
 		inode->i_dquot[cnt] = NODQUOT;
diff -ruX /home/jack/.kerndiffexclude linux-2.6.6-2-releasefix/fs/quota_v2.c linux-2.6.6-3-slabfix/fs/quota_v2.c
--- linux-2.6.6-2-releasefix/fs/quota_v2.c	2004-05-13 21:00:27.000000000 +0200
+++ linux-2.6.6-3-slabfix/fs/quota_v2.c	2004-05-14 15:14:28.000000000 +0200
@@ -135,7 +135,7 @@
 
 static dqbuf_t getdqbuf(void)
 {
-	dqbuf_t buf = kmalloc(V2_DQBLKSIZE, GFP_KERNEL);
+	dqbuf_t buf = kmalloc(V2_DQBLKSIZE, GFP_NOFS);
 	if (!buf)
 		printk(KERN_WARNING "VFS: Not enough memory for quota buffers.\n");
 	return buf;

--T4sUOijqQbZv57TR--
