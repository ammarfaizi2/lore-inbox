Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUEKJQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUEKJQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUEKJQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:16:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:63371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263162AbUEKJDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:03:04 -0400
Date: Tue, 11 May 2004 02:02:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 10/11] enforce rlimits for POSIX mqueue allocation
Message-ID: <20040511020252.I21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net> <20040511015015.C21045@build.pdx.osdl.net> <20040511015219.D21045@build.pdx.osdl.net> <20040511015357.E21045@build.pdx.osdl.net> <20040511015658.F21045@build.pdx.osdl.net> <20040511015833.G21045@build.pdx.osdl.net> <20040511020002.H21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511020002.H21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 02:00:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a user_struct to the mq_inode_info structure.  Charge the maximum
number of bytes that could be allocated to a mqueue to the user who
creates the mqueue.  This is checked against the per user rlimit.

--- 2.6-rlimit/ipc/mqueue.c~mqueue_rlimit	2004-05-10 22:28:43.137833864 -0700
+++ 2.6-rlimit/ipc/mqueue.c	2004-05-10 22:30:44.530379392 -0700
@@ -67,6 +66,7 @@
 
 	struct sigevent notify;
 	pid_t notify_owner;
+ 	struct user_struct *user;	/* user who created, for accouting */
 	struct sock *notify_sock;
 	struct sk_buff *notify_cookie;
 
@@ -114,6 +114,9 @@
 
 		if (S_ISREG(mode)) {
 			struct mqueue_inode_info *info;
+			struct task_struct *p = current;
+			struct user_struct *u = p->user;
+			unsigned long mq_bytes, mq_msg_tblsz;
 
 			inode->i_fop = &mqueue_file_operations;
 			inode->i_size = FILENT_SIZE;
@@ -123,8 +126,10 @@
 			init_waitqueue_head(&info->wait_q);
 			INIT_LIST_HEAD(&info->e_wait_q[0].list);
 			INIT_LIST_HEAD(&info->e_wait_q[1].list);
+			info->messages = NULL;
 			info->notify_owner = 0;
 			info->qsize = 0;
+			info->user = NULL;	/* set when all is ok */
 			memset(&info->attr, 0, sizeof(info->attr));
 			info->attr.mq_maxmsg = DFLT_MSGMAX;
 			info->attr.mq_msgsize = DFLT_MSGSIZEMAX;
@@ -132,12 +137,29 @@
 				info->attr.mq_maxmsg = attr->mq_maxmsg;
 				info->attr.mq_msgsize = attr->mq_msgsize;
 			}
-			info->messages = kmalloc(info->attr.mq_maxmsg * sizeof(struct msg_msg *), GFP_KERNEL);
+			mq_msg_tblsz = info->attr.mq_maxmsg * sizeof(struct msg_msg *);
+			mq_bytes = (mq_msg_tblsz +
+				(info->attr.mq_maxmsg * info->attr.mq_msgsize));
+
+			spin_lock(&mq_lock);
+			if (u->mq_bytes + mq_bytes < u->mq_bytes ||
+		 	    u->mq_bytes + mq_bytes >
+			    p->rlim[RLIMIT_MSGQUEUE].rlim_cur) {
+				spin_unlock(&mq_lock);
+				goto out_inode;
+			}
+			u->mq_bytes += mq_bytes;
+			spin_unlock(&mq_lock);
+
+			info->messages = kmalloc(mq_msg_tblsz, GFP_KERNEL);
 			if (!info->messages) {
-				make_bad_inode(inode);
-				iput(inode);
-				inode = NULL;
+				spin_lock(&mq_lock);
+				u->mq_bytes -= mq_bytes;
+				spin_unlock(&mq_lock);
+				goto out_inode;
 			}
+			/* all is ok */
+			info->user = get_uid(u);
 		} else if (S_ISDIR(mode)) {
 			inode->i_nlink++;
 			/* Some things misbehave if size == 0 on a directory */
@@ -147,6 +169,10 @@
 		}
 	}
 	return inode;
+out_inode:
+	make_bad_inode(inode);
+	iput(inode);
+	return NULL;
 }
 
 static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
@@ -205,6 +231,8 @@
 static void mqueue_delete_inode(struct inode *inode)
 {
 	struct mqueue_inode_info *info;
+	struct user_struct *user;
+	unsigned long mq_bytes;
 	int i;
 
 	if (S_ISDIR(inode->i_mode)) {
@@ -220,10 +248,15 @@
 
 	clear_inode(inode);
 
-	if (info->messages) {
+	mq_bytes = (info->attr.mq_maxmsg * sizeof(struct msg_msg *) +
+		   (info->attr.mq_maxmsg * info->attr.mq_msgsize));
+	user = info->user;
+	if (user) {
 		spin_lock(&mq_lock);
+		user->mq_bytes -= mq_bytes;
 		queues_count--;
 		spin_unlock(&mq_lock);
+		free_uid(user);
 	}
 }
 
