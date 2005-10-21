Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVJUShd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVJUShd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVJUShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:37:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14018 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965074AbVJUShc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:37:32 -0400
Date: Fri, 21 Oct 2005 19:37:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alex Lyashkov <shadow@psoft.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] remove use global lock list from lockd
Message-ID: <20051021183727.GA23445@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alex Lyashkov <shadow@psoft.net>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <1126004739.3377.8.camel@berloga.shadowland>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126004739.3377.8.camel@berloga.shadowland>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 02:05:39PM +0300, Alex Lyashkov wrote:
> Hello All
> 
> What anyone think about this patch? 
> this patch remove play with global lock list and use interlnal list
> nlm_blocked.

This patch looks cool to me, but doesn't seem to apply to current kernels where
nlm_blocked is a list_head.  (urgg, we also seem to have another local variable
called nlm_blocked in svclock.c that's a nlm_block * ...)

Could you redo the patch for a current kernel?

Index: clntlock.c
===================================================================
RCS file: /home/cvs/kernel_26/fs/lockd/clntlock.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 clntlock.c
--- clntlock.c	23 Feb 2005 11:07:55 -0000	1.1.1.1
+++ clntlock.c	6 Sep 2005 10:44:34 -0000
@@ -137,24 +137,17 @@
 
 /*
  * Mark the locks for reclaiming.
- * FIXME: In 2.5 we don't want to iterate through any global file_lock_list.
- *        Maintain NLM lock reclaiming lists in the nlm_host instead.
  */
 static
 void nlmclnt_mark_reclaim(struct nlm_host *host)
 {
+	struct nlm_wait *head;
 	struct file_lock *fl;
-	struct inode *inode;
-	struct list_head *tmp;
 
-	list_for_each(tmp, &file_lock_list) {
-		fl = list_entry(tmp, struct file_lock, fl_link);
-
-		inode = fl->fl_file->f_dentry->d_inode;
-		if (inode->i_sb->s_magic != NFS_SUPER_MAGIC)
-			continue;
-		if (fl->fl_u.nfs_fl.owner->host != host)
+	for (head = nlm_blocked; head; head = head->b_next) {
+		if (head->b_host != host)
 			continue;
+		fl = head->b_lock;
 		if (!(fl->fl_u.nfs_fl.flags & NFS_LCK_GRANTED))
 			continue;
 		fl->fl_u.nfs_fl.flags |= NFS_LCK_RECLAIM;
@@ -202,9 +195,8 @@
 {
 	struct nlm_host	  *host = (struct nlm_host *) ptr;
 	struct nlm_wait	  *block;
-	struct list_head *tmp;
 	struct file_lock *fl;
-	struct inode *inode;
+	struct nlm_wait *head;	
 
 	daemonize("%s-reclaim", host->h_name);
 	allow_signal(SIGKILL);
@@ -216,14 +208,10 @@
 
 	/* First, reclaim all locks that have been marked. */
 restart:
-	list_for_each(tmp, &file_lock_list) {
-		fl = list_entry(tmp, struct file_lock, fl_link);
-
-		inode = fl->fl_file->f_dentry->d_inode;
-		if (inode->i_sb->s_magic != NFS_SUPER_MAGIC)
-			continue;
-		if (fl->fl_u.nfs_fl.owner->host != host)
+	for (head = nlm_blocked; head; head = head->b_next) {
+		if (head->b_host != host)
 			continue;
+		fl = head->b_lock;
 		if (!(fl->fl_u.nfs_fl.flags & NFS_LCK_RECLAIM))
 			continue;
 
