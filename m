Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbULIQ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbULIQ7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULIQ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:59:38 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:63712 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S261555AbULIQ4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:56:51 -0500
Date: Thu, 9 Dec 2004 17:48:33 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [Patch] fix ext2/ext3 memory leak
Message-ID: <20041209164833.GA5547@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the patch below fixes an ext2/ext3 memory leak: the *_fill_super
functions allocate percpu data structures but don't free them in
*_put_super.

Thanks,
Heiko

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_ext3.diff"

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 fs/ext2/super.c |    3 +++
 fs/ext3/super.c |    3 +++
 2 files changed, 6 insertions(+)

diff -urN linux-2.6/fs/ext2/super.c linux-2.6-patched/fs/ext2/super.c
--- linux-2.6/fs/ext2/super.c	2004-12-09 17:41:49.000000000 +0100
+++ linux-2.6-patched/fs/ext2/super.c	2004-12-09 17:42:01.000000000 +0100
@@ -122,6 +122,9 @@
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
+	percpu_counter_destroy(&sbi->s_freeblocks_counter);
+	percpu_counter_destroy(&sbi->s_freeinodes_counter);
+	percpu_counter_destroy(&sbi->s_dirs_counter);
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
diff -urN linux-2.6/fs/ext3/super.c linux-2.6-patched/fs/ext3/super.c
--- linux-2.6/fs/ext3/super.c	2004-12-09 17:41:49.000000000 +0100
+++ linux-2.6-patched/fs/ext3/super.c	2004-12-09 17:42:01.000000000 +0100
@@ -400,6 +400,9 @@
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
+	percpu_counter_destroy(&sbi->s_freeblocks_counter);
+	percpu_counter_destroy(&sbi->s_freeinodes_counter);
+	percpu_counter_destroy(&sbi->s_dirs_counter);
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++) {

--HlL+5n6rz5pIUxbD--
