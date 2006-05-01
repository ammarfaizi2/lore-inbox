Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWEAK55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWEAK55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWEAK54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:57:56 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:21513 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751338AbWEAK5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:57:55 -0400
Date: Mon, 1 May 2006 18:56:50 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] autofs4 - NFY_NONE wait race fix
Message-ID: <Pine.LNX.4.64.0605011822250.5588@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-5.196,
	required 5, autolearn=not spam, ALL_TRUSTED -3.30, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This patch fixes two problems.

First, the comparison of entries in the waitq.c was incorrect.

Second, the NFY_NONE check was incorrect. The test of whether the dentry 
is mounted if ineffective, for example, if an expire fails then we could 
wait forever on a non existant expire. The bug was identified by Jeff 
Moyer.

The patch changes autofs4 to wait on expires only as this is all that's 
needed. If there is no existing wait when autofs4_wait is call with 
a type of NFY_NONE it delays until either a wait appears or the the expire 
flag is cleared.

Signed-off-by: Ian Kent <raven@themaw.net>

--

--- linux-2.6.17-rc1-mm3/fs/autofs4/autofs_i.h.nfy_none-wait-race-fix	2006-04-26 15:19:41.000000000 +0800
+++ linux-2.6.17-rc1-mm3/fs/autofs4/autofs_i.h	2006-04-26 15:20:25.000000000 +0800
@@ -74,8 +74,8 @@
 	struct autofs_wait_queue *next;
 	autofs_wqt_t wait_queue_token;
 	/* We use the following to see what we are waiting for */
-	int hash;
-	int len;
+	unsigned int hash;
+	unsigned int len;
 	char *name;
 	u32 dev;
 	u64 ino;
@@ -85,7 +85,6 @@
 	pid_t tgid;
 	/* This is for status reporting upon return */
 	int status;
-	atomic_t notify;
 	atomic_t wait_ctr;
 };
 
--- linux-2.6.17-rc1-mm3/fs/autofs4/waitq.c.nfy_none-wait-race-fix	2006-04-26 15:19:41.000000000 +0800
+++ linux-2.6.17-rc1-mm3/fs/autofs4/waitq.c	2006-04-26 15:32:00.000000000 +0800
@@ -189,14 +189,30 @@
 	return len;
 }
 
+static struct autofs_wait_queue *
+autofs4_find_wait(struct autofs_sb_info *sbi,
+		  char *name, unsigned int hash, unsigned int len)
+{
+	struct autofs_wait_queue *wq = NULL;
+
+	for (wq = sbi->queues ; wq ; wq = wq->next) {
+		if (wq->hash == hash &&
+		    wq->len == len &&
+		    wq->name && !memcmp(wq->name, name, len))
+			break;
+	}
+	return wq;
+}
+
 int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 		enum autofs_notify notify)
 {
+	struct autofs_info *ino;
 	struct autofs_wait_queue *wq;
 	char *name;
 	unsigned int len = 0;
 	unsigned int hash = 0;
-	int status;
+	int status, type;
 
 	/* In catatonic mode, we don't wait for nobody */
 	if (sbi->catatonic)
@@ -223,21 +239,42 @@
 		return -EINTR;
 	}
 
-	for (wq = sbi->queues ; wq ; wq = wq->next) {
-		if (wq->hash == dentry->d_name.hash &&
-		    wq->len == len &&
-		    wq->name && !memcmp(wq->name, name, len))
-			break;
-	}
+	wq = autofs4_find_wait(sbi, name, hash, len);
+	ino = autofs4_dentry_ino(dentry);
+	if (!wq && ino && notify == NFY_NONE) {
+		/*
+		 * Either we've betean the pending expire to post it's
+		 * wait or it finished while we waited on the mutex.
+		 * So we need to wait till either, the wait appears
+		 * or the expire finishes.
+		 */
 
-	if (!wq) {
-		/* Can't wait for an expire if there's no mount */
-		if (notify == NFY_NONE && !d_mountpoint(dentry)) {
+		while (ino->flags & AUTOFS_INF_EXPIRING) {
+			mutex_unlock(&sbi->wq_mutex);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ/10);
+			if (mutex_lock_interruptible(&sbi->wq_mutex)) {
+				kfree(name);
+				return -EINTR;
+			}
+			wq = autofs4_find_wait(sbi, name, hash, len);
+			if (wq)
+				break;
+		}
+
+		/*
+		 * Not ideal but the status has already gone. Of the two
+		 * cases where we wait on NFY_NONE neither depend on the
+		 * return status of the wait.
+		 */
+		if (!wq) {
 			kfree(name);
 			mutex_unlock(&sbi->wq_mutex);
-			return -ENOENT;
+			return 0;
 		}
+	}
 
+	if (!wq) {
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
 		if (!wq) {
@@ -263,20 +300,7 @@
 		wq->tgid = current->tgid;
 		wq->status = -EINTR; /* Status return if interrupted */
 		atomic_set(&wq->wait_ctr, 2);
-		atomic_set(&wq->notify, 1);
 		mutex_unlock(&sbi->wq_mutex);
-	} else {
-		atomic_inc(&wq->wait_ctr);
-		mutex_unlock(&sbi->wq_mutex);
-		kfree(name);
-		DPRINTK("existing wait id = 0x%08lx, name = %.*s, nfy=%d",
-			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
-	}
-
-	if (notify != NFY_NONE && atomic_read(&wq->notify)) {
-		int type;
-
-		atomic_dec(&wq->notify);
 
 		if (sbi->version < 5) {
 			if (notify == NFY_MOUNT)
@@ -299,6 +323,12 @@
 
 		/* autofs4_notify_daemon() may block */
 		autofs4_notify_daemon(sbi, wq, type);
+	} else {
+		atomic_inc(&wq->wait_ctr);
+		mutex_unlock(&sbi->wq_mutex);
+		kfree(name);
+		DPRINTK("existing wait id = 0x%08lx, name = %.*s, nfy=%d",
+			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 	}
 
 	/* wq->name is NULL if and only if the lock is already released */
--- linux-2.6.17-rc1-mm3/fs/autofs4/root.c.nfy_none-wait-race-fix	2006-04-26 15:19:41.000000000 +0800
+++ linux-2.6.17-rc1-mm3/fs/autofs4/root.c	2006-04-26 15:22:07.000000000 +0800
@@ -327,6 +327,7 @@
 static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int oz_mode = autofs4_oz_mode(sbi);
 	unsigned int lookup_type;
 	int status;
@@ -340,13 +341,8 @@
 	if (oz_mode || !lookup_type)
 		goto done;
 
-	/*
-	 * If a request is pending wait for it.
-	 * If it's a mount then it won't be expired till at least
-	 * a liitle later and if it's an expire then we might need
-	 * to mount it again.
-	 */
-	if (autofs4_ispending(dentry)) {
+	/* If an expire request is pending wait for it. */
+	if (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
 		DPRINTK("waiting for active request %p name=%.*s",
 			dentry, dentry->d_name.len, dentry->d_name.name);
 
