Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUEVGph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUEVGph (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 02:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUEVGpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 02:45:36 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:29446 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263626AbUEVGpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 02:45:00 -0400
Date: Sat, 22 May 2004 14:42:49 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, joe@perches.com
Subject: [PATCH] autofs4 - printk cleanup
Message-ID: <Pine.LNX.4.58.0405221410340.4426@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This is a patch contributed by Joe Perches to automatically  include the 
function name in the dprintk statements. It applies and compiles cleanly 
against the mm4 tree.

diff -urN a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
--- a/fs/autofs4/autofs_i.h	2004-05-16 11:50:45.000000000 -0700
+++ b/fs/autofs4/autofs_i.h	2004-05-16 17:25:05.000000000 -0700
@@ -33,9 +33,9 @@
 /* #define DEBUG */
 
 #ifdef DEBUG
-#define DPRINTK(D) do{ printk("pid %d: ", current->pid); printk D; } while(0)
+#define DPRINTK(fmt,args...) do { printk(KERN_DEBUG "pid %d: %s: " fmt "\n" , current->pid , __FUNCTION__ , ##args); } while(0)
 #else
-#define DPRINTK(D) do {} while(0)
+#define DPRINTK(fmt,args...) do {} while(0)
 #endif
 
 #define AUTOFS_SUPER_MAGIC 0x0187
diff -urN a/fs/autofs4/expire.c b/fs/autofs4/expire.c
--- a/fs/autofs4/expire.c	2004-05-16 11:50:45.000000000 -0700
+++ b/fs/autofs4/expire.c	2004-05-16 17:19:42.000000000 -0700
@@ -50,8 +50,8 @@
 {
 	int status = 0;
 
-	DPRINTK(("autofs4_check_mount: dentry %p %.*s\n",
-		 dentry, (int)dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("dentry %p %.*s",
+		dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
 	mntget(mnt);
 	dget(dentry);
@@ -70,7 +70,7 @@
 	if (may_umount_tree(mnt) == 0)
 		status = 1;
 done:
-	DPRINTK(("autofs4_check_mount: returning = %d\n", status));
+	DPRINTK("returning = %d", status);
 	mntput(mnt);
 	dput(dentry);
 	return status;
@@ -88,8 +88,8 @@
 	struct dentry *this_parent = top;
 	struct list_head *next;
 
-	DPRINTK(("autofs4_check_tree: parent %p %.*s\n",
-		 top, (int)top->d_name.len, top->d_name.name));
+	DPRINTK("parent %p %.*s",
+		top, (int)top->d_name.len, top->d_name.name);
 
 	/* Negative dentry - give up */
 	if (!simple_positive(top))
@@ -112,8 +112,8 @@
 			continue;
 		}
 
-		DPRINTK(("autofs4_check_tree: dentry %p %.*s\n",
-			 dentry, (int)dentry->d_name.len, dentry->d_name.name));
+		DPRINTK("dentry %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
 		if (!simple_empty_nolock(dentry)) {
 			this_parent = dentry;
@@ -154,8 +154,8 @@
 	struct dentry *this_parent = parent;
 	struct list_head *next;
 
-	DPRINTK(("autofs4_check_leaves: parent %p %.*s\n",
-		parent, (int)parent->d_name.len, parent->d_name.name));
+	DPRINTK("parent %p %.*s",
+		parent, (int)parent->d_name.len, parent->d_name.name);
 
 	spin_lock(&dcache_lock);
 repeat:
@@ -170,8 +170,8 @@
 			continue;
 		}
 
-		DPRINTK(("autofs4_check_leaves: dentry %p %.*s\n",
-			dentry, (int)dentry->d_name.len, dentry->d_name.name));
+		DPRINTK("dentry %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
 		if (!list_empty(&dentry->d_subdirs)) {
 			this_parent = dentry;
@@ -250,8 +250,8 @@
 
 		/* Case 1: indirect mount or top level direct mount */
 		if (d_mountpoint(dentry)) {
-			DPRINTK(("autofs4_expire: checking mountpoint %p %.*s\n",
-			 dentry, (int)dentry->d_name.len, dentry->d_name.name));
+			DPRINTK("checking mountpoint %p %.*s",
+				dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
 			/* Can we expire this guy */
 			if (!autofs4_can_expire(dentry, timeout, do_now))
@@ -289,8 +289,8 @@
 	}
 
 	if ( expired ) {
-		DPRINTK(("autofs4_expire: returning %p %.*s\n",
-			 expired, (int)expired->d_name.len, expired->d_name.name));
+		DPRINTK("returning %p %.*s",
+			expired, (int)expired->d_name.len, expired->d_name.name);
 		spin_lock(&dcache_lock);
 		list_del(&expired->d_parent->d_subdirs);
 		list_add(&expired->d_parent->d_subdirs, &expired->d_child);
diff -urN a/fs/autofs4/inode.c b/fs/autofs4/inode.c
--- a/fs/autofs4/inode.c	2004-05-16 11:50:45.000000000 -0700
+++ b/fs/autofs4/inode.c	2004-05-16 16:42:32.000000000 -0700
@@ -87,7 +87,7 @@
 
 	kfree(sbi);
 
-	DPRINTK(("autofs: shutting down\n"));
+	DPRINTK("shutting down");
 }
 
 static struct super_operations autofs4_sops = {
@@ -193,7 +193,7 @@
 	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
 		goto fail_unlock;
-	DPRINTK(("autofs: starting up, sbi = %p\n",sbi));
+	DPRINTK("starting up, sbi = %p",sbi);
 
 	memset(sbi, 0, sizeof(*sbi));
 
@@ -253,7 +253,7 @@
 	sbi->version = maxproto > AUTOFS_MAX_PROTO_VERSION ? AUTOFS_MAX_PROTO_VERSION : maxproto;
 	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
 
-	DPRINTK(("autofs: pipe fd = %d, pgrp = %u\n", pipefd, sbi->oz_pgrp));
+	DPRINTK("pipe fd = %d, pgrp = %u", pipefd, sbi->oz_pgrp);
 	pipe = fget(pipefd);
 	
 	if ( !pipe ) {
diff -urN a/fs/autofs4/root.c b/fs/autofs4/root.c
--- a/fs/autofs4/root.c	2004-05-16 11:50:45.000000000 -0700
+++ b/fs/autofs4/root.c	2004-05-16 16:22:35.000000000 -0700
@@ -69,8 +69,7 @@
 	struct autofs_sb_info *sbi = autofs4_sbi(file->f_dentry->d_sb);
 	int oz_mode = autofs4_oz_mode(sbi);
 
-	DPRINTK(("autofs4_root_readdir called, filp->f_pos = %lld\n",
-			file->f_pos));
+	DPRINTK("called, filp->f_pos = %lld", file->f_pos);
 
 	/*
 	 * Don't set reghost flag if:
@@ -81,8 +80,7 @@
 	if (oz_mode && file->f_pos == 0 && sbi->reghost_enabled)
 		sbi->needs_reghost = 1;
 
-	DPRINTK(("autofs4_root_readdir: needs_reghost = %d\n",
-			sbi->needs_reghost));
+	DPRINTK("needs_reghost = %d", sbi->needs_reghost);
 
 	return autofs4_dcache_readdir(file, dirent, filldir);
 }
@@ -173,14 +171,14 @@
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	int status;
 
-	DPRINTK(("autofs4_dir_open: file=%p dentry=%p %.*s\n",
-		file, dentry, dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("file=%p dentry=%p %.*s",
+		file, dentry, dentry->d_name.len, dentry->d_name.name);
 
 	if (autofs4_oz_mode(sbi))
 		goto out;
 
 	if (autofs4_ispending(dentry)) {
-		DPRINTK(("autofs4_dir_open: dentry busy\n"));
+		DPRINTK("dentry busy");
 		return -EBUSY;
 	}
 
@@ -227,14 +225,14 @@
 	struct dentry *dentry = file->f_dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 
-	DPRINTK(("autofs4_dir_close: file=%p dentry=%p %.*s\n",
-		file, dentry, dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("file=%p dentry=%p %.*s",
+		file, dentry, dentry->d_name.len, dentry->d_name.name);
 
 	if (autofs4_oz_mode(sbi))
 		goto out;
 
 	if (autofs4_ispending(dentry)) {
-		DPRINTK(("autofs4_dir_close: dentry busy\n"));
+		DPRINTK("dentry busy");
 		return -EBUSY;
 	}
 
@@ -257,14 +255,14 @@
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	int status;
 
-	DPRINTK(("autofs4_readdir: file=%p dentry=%p %.*s\n",
-		file, dentry, dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("file=%p dentry=%p %.*s",
+		file, dentry, dentry->d_name.len, dentry->d_name.name);
 
 	if (autofs4_oz_mode(sbi))
 		goto out;
 
 	if (autofs4_ispending(dentry)) {
-		DPRINTK(("autofs4_readdir: dentry busy\n"));
+		DPRINTK("dentry busy");
 		return -EBUSY;
 	}
 
@@ -298,27 +296,27 @@
            when expiration is done to trigger mount request with a new
            dentry */
 	if (de_info && (de_info->flags & AUTOFS_INF_EXPIRING)) {
-		DPRINTK(("try_to_fill_entry: waiting for expire %p name=%.*s\n",
-			 dentry, dentry->d_name.len, dentry->d_name.name));
+		DPRINTK("waiting for expire %p name=%.*s",
+			 dentry, dentry->d_name.len, dentry->d_name.name);
 
 		status = autofs4_wait(sbi, dentry, NFY_NONE);
 		
-		DPRINTK(("try_to_fill_entry: expire done status=%d\n", status));
+		DPRINTK("expire done status=%d", status);
 		
 		return 0;
 	}
 
-	DPRINTK(("try_to_fill_entry: dentry=%p %.*s ino=%p\n", 
-		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode));
+	DPRINTK("dentry=%p %.*s ino=%p", 
+		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
 
 	/* Wait for a pending mount, triggering one if there isn't one already */
 	if (dentry->d_inode == NULL) {
-		DPRINTK(("try_to_fill_entry: waiting for mount name=%.*s\n",
-			 dentry->d_name.len, dentry->d_name.name));
+		DPRINTK("waiting for mount name=%.*s",
+			 dentry->d_name.len, dentry->d_name.name);
 
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
 		 
-		DPRINTK(("try_to_fill_entry: mount done status=%d\n", status));
+		DPRINTK("mount done status=%d", status);
 
 		if (status && dentry->d_inode)
 			return 0; /* Try to get the kernel to invalidate this dentry */
@@ -337,15 +335,15 @@
 	/* Trigger mount for path component or follow link */
 	} else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
 			current->link_count) {
-		DPRINTK(("try_to_fill_entry: waiting for mount name=%.*s\n",
-			dentry->d_name.len, dentry->d_name.name));
+		DPRINTK("waiting for mount name=%.*s",
+			dentry->d_name.len, dentry->d_name.name);
 
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
 		spin_unlock(&dentry->d_lock);
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
 
-		DPRINTK(("try_to_fill_entry: mount done status=%d\n", status));
+		DPRINTK("mount done status=%d", status);
 
 		if (status) {
 			spin_lock(&dentry->d_lock);
@@ -396,8 +394,8 @@
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
 	    list_empty(&dentry->d_subdirs)) {
-		DPRINTK(("autofs4_root_revalidate: dentry=%p %.*s, emptydir\n",
-			 dentry, dentry->d_name.len, dentry->d_name.name));
+		DPRINTK("dentry=%p %.*s, emptydir",
+			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
 		if (!oz_mode)
 			status = try_to_fill_dentry(dentry, dir->i_sb, sbi, flags);
@@ -416,7 +414,7 @@
 {
 	struct autofs_info *inf;
 
-	DPRINTK(("autofs4_dentry_release: releasing %p\n", de));
+	DPRINTK("releasing %p", de);
 
 	inf = autofs4_dentry_ino(de);
 	de->d_fsdata = NULL;
@@ -446,9 +444,9 @@
 static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 #if 0
-	DPRINTK(("autofs4_dir_lookup: iignoring lookup of %.*s/%.*s\n",
+	DPRINTK("ignoring lookup of %.*s/%.*s",
 		 dentry->d_parent->d_name.len, dentry->d_parent->d_name.name,
-		 dentry->d_name.len, dentry->d_name.name));
+		 dentry->d_name.len, dentry->d_name.name);
 #endif
 
 	dentry->d_fsdata = NULL;
@@ -462,8 +460,8 @@
 	struct autofs_sb_info *sbi;
 	int oz_mode;
 
-	DPRINTK(("autofs4_root_lookup: name = %.*s\n",
-		 dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("name = %.*s",
+		dentry->d_name.len, dentry->d_name.name);
 
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);/* File name too long to exist */
@@ -471,8 +469,8 @@
 	sbi = autofs4_sbi(dir->i_sb);
 
 	oz_mode = autofs4_oz_mode(sbi);
-	DPRINTK(("autofs4_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, process_group(current), sbi->catatonic, oz_mode));
+	DPRINTK("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d",
+		 current->pid, process_group(current), sbi->catatonic, oz_mode);
 
 	/*
 	 * Mark the dentry incomplete, but add it. This is needed so
@@ -537,8 +535,8 @@
 	struct inode *inode;
 	char *cp;
 
-	DPRINTK(("autofs4_dir_symlink: %s <- %.*s\n", symname,
-		 dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("%s <- %.*s", symname,
+		dentry->d_name.len, dentry->d_name.name);
 
 	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
@@ -646,8 +644,8 @@
 	if ( !autofs4_oz_mode(sbi) )
 		return -EACCES;
 
-	DPRINTK(("autofs4_dir_mkdir: dentry %p, creating %.*s\n",
-		 dentry, dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("dentry %p, creating %.*s",
+		dentry, dentry->d_name.len, dentry->d_name.name);
 
 	ino = autofs4_init_ino(ino, sbi, S_IFDIR | 0555);
 	if (ino == NULL)
@@ -709,7 +707,7 @@
 {
 	int status;
 
-	DPRINTK(("autofs_ask_reghost: returning %d\n", sbi->needs_reghost));
+	DPRINTK("returning %d", sbi->needs_reghost);
 
 	status = put_user(sbi->needs_reghost, p);
 	if ( status )
@@ -729,7 +727,7 @@
 
 	status = get_user(val, p);
 
-	DPRINTK(("autofs4_toggle_reghost: reghost = %d\n", val));
+	DPRINTK("reghost = %d", val);
 
 	if (status)
 		return status;
@@ -749,7 +747,7 @@
 	if (may_umount(mnt) == 0)
 		status = 1;
 
-	DPRINTK(("autofs_ask_umount: returning %d\n", status));
+	DPRINTK("returning %d", status);
 
 	status = put_user(status, p);
 
@@ -777,8 +775,8 @@
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
 
-	DPRINTK(("autofs4_root_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
-		 cmd,arg,sbi,process_group(current)));
+	DPRINTK("cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u",
+		cmd,arg,sbi,process_group(current));
 
 	if ( _IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT )
diff -urN a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
--- a/fs/autofs4/waitq.c	2004-05-16 11:50:45.000000000 -0700
+++ b/fs/autofs4/waitq.c	2004-05-16 14:04:08.000000000 -0700
@@ -28,7 +28,7 @@
 {
 	struct autofs_wait_queue *wq, *nwq;
 
-	DPRINTK(("autofs: entering catatonic mode\n"));
+	DPRINTK("entering catatonic mode");
 
 	sbi->catatonic = 1;
 	wq = sbi->queues;
@@ -91,8 +91,8 @@
 	union autofs_packet_union pkt;
 	size_t pktsz;
 
-	DPRINTK(("autofs4_notify_daemon: wait id = 0x%08lx, name = %.*s, type=%d\n",
-		 wq->wait_queue_token, wq->len, wq->name, type));
+	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
+		wq->wait_queue_token, wq->len, wq->name, type);
 
 	memset(&pkt,0,sizeof pkt); /* For security reasons */
 
@@ -212,8 +212,8 @@
 		atomic_set(&wq->wait_ctr, 2);
 		up(&sbi->wq_sem);
 
-		DPRINTK(("autofs4_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
+		DPRINTK("new wait id = 0x%08lx, name = %.*s, nfy=%d",
+			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 		/* autofs4_notify_daemon() may block */
 		if (notify != NFY_NONE) {
 			autofs4_notify_daemon(sbi,wq, 
@@ -224,8 +224,8 @@
 	} else {
 		atomic_inc(&wq->wait_ctr);
 		up(&sbi->wq_sem);
-		DPRINTK(("autofs4_wait: existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
+		DPRINTK("existing wait id = 0x%08lx, name = %.*s, nfy=%d",
+			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 	}
 
 	/* wq->name is NULL if and only if the lock is already released */
@@ -257,7 +257,7 @@
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 	} else {
-		DPRINTK(("autofs4_wait: skipped sleeping\n"));
+		DPRINTK("skipped sleeping");
 	}
 
 	status = wq->status;


