Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUD2B0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUD2B0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUD2BZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:25:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:14464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262503AbUD2BZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:25:04 -0400
Date: Wed, 28 Apr 2004 18:24:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: busterbcook@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040428182443.6747e34b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	<20040427230203.1e4693ac.akpm@osdl.org>
	<Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	<20040428124809.418e005d.akpm@osdl.org>
	<Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Cook <busterbcook@yahoo.com> wrote:
>
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
>      7 root      25   0     0    0     0 RW   99.4  0.0 415:26   0 pdflush

This getting very irritating.  Cannot reproduce it with a 2.4 server, gcc
3.4.0, 2.6.6-rc3 client.  grrr.

Could you please apply the below two patches, then wait for pdflush to go
nuts, then do:

	echo 1 > /proc/sys/debug/0
	echo 0 > /proc/sys/debug/0
	dmesg -s 1000000 > foo

then mail me foo?  It probably won't tell me much, but one has to start
somewhere.

Thanks.


 25-akpm/include/linux/kernel.h |    2 ++
 25-akpm/kernel/sysctl.c        |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff -puN include/linux/kernel.h~proc-sys-debug include/linux/kernel.h
--- 25/include/linux/kernel.h~proc-sys-debug	Tue Apr 27 17:11:39 2004
+++ 25-akpm/include/linux/kernel.h	Tue Apr 27 17:11:39 2004
@@ -220,6 +220,8 @@ extern void dump_stack(void);
 	1; \
 })
 
+extern int proc_sys_debug[8];
+
 #endif /* __KERNEL__ */
 
 #define SI_LOAD_SHIFT	16
diff -puN kernel/sysctl.c~proc-sys-debug kernel/sysctl.c
--- 25/kernel/sysctl.c~proc-sys-debug	Tue Apr 27 17:11:39 2004
+++ 25-akpm/kernel/sysctl.c	Tue Apr 27 17:11:39 2004
@@ -888,7 +888,26 @@ static ctl_table fs_table[] = {
 	{ .ctl_name = 0 }
 };
 
+int proc_sys_debug[8];
+EXPORT_SYMBOL(proc_sys_debug);
+
 static ctl_table debug_table[] = {
+	{1, "0", &proc_sys_debug[0], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+	{2, "1", &proc_sys_debug[1], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+	{3, "2", &proc_sys_debug[2], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+	{4, "3", &proc_sys_debug[3], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+	{5, "4", &proc_sys_debug[4], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+	{6, "5", &proc_sys_debug[5], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+	{7, "6", &proc_sys_debug[6], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+	{8, "7", &proc_sys_debug[7], sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
 	{ .ctl_name = 0 }
 };
 

_





---

 25-akpm/fs/fs-writeback.c |   22 ++++++++++++++++++++++
 25-akpm/fs/mpage.c        |    6 ++++++
 2 files changed, 28 insertions(+)

diff -puN fs/fs-writeback.c~pdflush-debug fs/fs-writeback.c
--- 25/fs/fs-writeback.c~pdflush-debug	Tue Apr 27 17:12:11 2004
+++ 25-akpm/fs/fs-writeback.c	Tue Apr 27 17:19:21 2004
@@ -152,7 +152,23 @@ __sync_single_inode(struct inode *inode,
 
 	spin_unlock(&inode_lock);
 
+	if (proc_sys_debug[0]) {
+		printk("%s: writepages in nr_pages:%lu nr_to_write:%ld"
+				" pages_skipped:%ld en:%d\n",
+			__FUNCTION__,
+			mapping->nrpages, wbc->nr_to_write,
+			wbc->pages_skipped,
+			wbc->encountered_congestion);
+	}
 	ret = do_writepages(mapping, wbc);
+	if (proc_sys_debug[0]) {
+		printk("%s: writepages in nr_pages:%lu nr_to_write:%ld"
+				" pages_skipped:%ld en:%d\n",
+			__FUNCTION__,
+			mapping->nrpages, wbc->nr_to_write,
+			wbc->pages_skipped,
+			wbc->encountered_congestion);
+	}
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
@@ -328,6 +344,9 @@ sync_sb_inodes(struct super_block *sb, s
 		if (current_is_pdflush() && !writeback_acquire(bdi))
 			break;
 
+		if (proc_sys_debug[0]) {
+			printk("%s: write inode %p\n", __FUNCTION__, inode);
+		}
 		BUG_ON(inode->i_state & I_FREEING);
 		__iget(inode);
 		pages_skipped = wbc->pages_skipped;
@@ -384,6 +403,9 @@ writeback_inodes(struct writeback_contro
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
 		if (!list_empty(&sb->s_dirty) || !list_empty(&sb->s_io)) {
 			spin_unlock(&sb_lock);
+			if (proc_sys_debug[0]) {
+				printk("%s: sync sb %p\n", __FUNCTION__, sb);
+			}
 			sync_sb_inodes(sb, wbc);
 			spin_lock(&sb_lock);
 		}
diff -puN fs/mpage.c~pdflush-debug fs/mpage.c
--- 25/fs/mpage.c~pdflush-debug	Tue Apr 27 17:19:41 2004
+++ 25-akpm/fs/mpage.c	Tue Apr 27 17:20:57 2004
@@ -658,6 +658,12 @@ retry:
 			if (writepage) {
 				ret = (*writepage)(page, wbc);
 				if (ret) {
+					if (proc_sys_debug[0]) {
+						printk("%s: writepage "
+							"returned %d\n",
+							__FUNCTION__,
+							ret);
+					}
 					if (ret == -ENOSPC)
 						set_bit(AS_ENOSPC,
 							&mapping->flags);

_

