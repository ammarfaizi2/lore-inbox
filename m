Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWASBTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWASBTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWASBTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:19:33 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:62474 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1030405AbWASBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:19:31 -0500
Date: Thu, 19 Jan 2006 09:18:31 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: Re: [PATCH 9/13] updated for rc1-mm1: autofs4 - add a show mount
 options for proc filesystem
In-Reply-To: <200601180723.k0I7Nruv006185@eagle.themaw.net>
Message-ID: <Pine.LNX.4.64.0601190917150.3261@eagle.themaw.net>
References: <200601180723.k0I7Nruv006185@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Ian Kent wrote:

> This patch adds show_options method to display autofs4 mount options
> in the proc filesystem.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> 

--- linux-2.6.16-rc1-mm1/fs/autofs4/inode.c.add-show_options	2006-01-18 22:08:08.000000000 +0800
+++ linux-2.6.16-rc1-mm1/fs/autofs4/inode.c	2006-01-18 22:08:28.000000000 +0800
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/seq_file.h>
 #include <linux/pagemap.h>
 #include <linux/parser.h>
 #include <linux/bitops.h>
@@ -163,9 +164,26 @@ static void autofs4_put_super(struct sup
 	DPRINTK("shutting down");
 }
 
+static int autofs4_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(mnt->mnt_sb);
+
+	if (!sbi)
+		return 0;
+
+	seq_printf(m, ",fd=%d", sbi->pipefd);
+	seq_printf(m, ",pgrp=%d", sbi->oz_pgrp);
+	seq_printf(m, ",timeout=%lu", sbi->exp_timeout/HZ);
+	seq_printf(m, ",minproto=%d", sbi->min_proto);
+	seq_printf(m, ",maxproto=%d", sbi->max_proto);
+
+	return 0;
+}
+
 static struct super_operations autofs4_sops = {
 	.put_super	= autofs4_put_super,
 	.statfs		= simple_statfs,
+	.show_options	= autofs4_show_options,
 };
 
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto};
@@ -261,7 +279,6 @@ int autofs4_fill_super(struct super_bloc
 	int pipefd;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
-	int minproto, maxproto;
 
 	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
@@ -273,12 +290,15 @@ int autofs4_fill_super(struct super_bloc
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->root = NULL;
+	sbi->pipefd = -1;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
+	sbi->min_proto = 0;
+	sbi->max_proto = 0;
 	mutex_init(&sbi->wq_mutex);
 	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
@@ -311,22 +331,26 @@ int autofs4_fill_super(struct super_bloc
 	if (parse_options(data, &pipefd,
 			  &root_inode->i_uid, &root_inode->i_gid,
 			  &sbi->oz_pgrp,
-			  &minproto, &maxproto)) {
+			  &sbi->min_proto, &sbi->max_proto)) {
 		printk("autofs: called with bogus options\n");
 		goto fail_dput;
 	}
 
 	/* Couldn't this be tested earlier? */
-	if (maxproto < AUTOFS_MIN_PROTO_VERSION ||
-	    minproto > AUTOFS_MAX_PROTO_VERSION) {
+	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
+	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
 		printk("autofs: kernel does not match daemon version "
 		       "daemon (%d, %d) kernel (%d, %d)\n",
-			minproto, maxproto,
+			sbi->min_proto, sbi->max_proto,
 			AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
 		goto fail_dput;
 	}
 
-	sbi->version = maxproto > AUTOFS_MAX_PROTO_VERSION ? AUTOFS_MAX_PROTO_VERSION : maxproto;
+	/* Establish highest kernel protocol version */
+	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
+		sbi->version = AUTOFS_MAX_PROTO_VERSION;
+	else
+		sbi->version = sbi->max_proto;
 	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
 
 	DPRINTK("pipe fd = %d, pgrp = %u", pipefd, sbi->oz_pgrp);
@@ -339,6 +363,7 @@ int autofs4_fill_super(struct super_bloc
 	if ( !pipe->f_op || !pipe->f_op->write )
 		goto fail_fput;
 	sbi->pipe = pipe;
+	sbi->pipefd = pipefd;
 
 	/*
 	 * Take a reference to the root dentry so we get a chance to
--- linux-2.6.16-rc1-mm1/fs/autofs4/autofs_i.h.add-show_options	2006-01-18 22:08:08.000000000 +0800
+++ linux-2.6.16-rc1-mm1/fs/autofs4/autofs_i.h	2006-01-18 22:08:28.000000000 +0800
@@ -87,11 +87,14 @@ struct autofs_wait_queue {
 struct autofs_sb_info {
 	u32 magic;
 	struct dentry *root;
+	int pipefd;
 	struct file *pipe;
 	pid_t oz_pgrp;
 	int catatonic;
 	int version;
 	int sub_version;
+	int min_proto;
+	int max_proto;
 	unsigned long exp_timeout;
 	int reghost_enabled;
 	int needs_reghost;
