Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWANOgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWANOgn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWANOgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:36:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28322 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751456AbWANOgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:36:42 -0500
Date: Sat, 14 Jan 2006 15:36:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       raven@themaw.net
Subject: [patch 2.6.15-mm4] sem2mutex: autofs4 wq_sem
Message-ID: <20060114143650.GA18567@elte.hu>
References: <20060114143042.GA17675@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114143042.GA17675@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/autofs4/autofs_i.h |    3 ++-
 fs/autofs4/inode.c    |    2 +-
 fs/autofs4/waitq.c    |   16 ++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

Index: linux/fs/autofs4/autofs_i.h
===================================================================
--- linux.orig/fs/autofs4/autofs_i.h
+++ linux/fs/autofs4/autofs_i.h
@@ -13,6 +13,7 @@
 /* Internal header file for autofs */
 
 #include <linux/auto_fs4.h>
+#include <linux/mutex.h>
 #include <linux/list.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
@@ -102,7 +103,7 @@ struct autofs_sb_info {
 	int reghost_enabled;
 	int needs_reghost;
 	struct super_block *sb;
-	struct semaphore wq_sem;
+	struct mutex wq_mutex;
 	spinlock_t fs_lock;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
 };
Index: linux/fs/autofs4/inode.c
===================================================================
--- linux.orig/fs/autofs4/inode.c
+++ linux/fs/autofs4/inode.c
@@ -269,7 +269,7 @@ int autofs4_fill_super(struct super_bloc
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
-	init_MUTEX(&sbi->wq_sem);
+	mutex_init(&sbi->wq_mutex);
 	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
 	s->s_blocksize = 1024;
Index: linux/fs/autofs4/waitq.c
===================================================================
--- linux.orig/fs/autofs4/waitq.c
+++ linux/fs/autofs4/waitq.c
@@ -178,7 +178,7 @@ int autofs4_wait(struct autofs_sb_info *
 		return -ENOENT;
 	}
 
-	if (down_interruptible(&sbi->wq_sem)) {
+	if (mutex_lock_interruptible(&sbi->wq_mutex)) {
 		kfree(name);
 		return -EINTR;
 	}
@@ -194,7 +194,7 @@ int autofs4_wait(struct autofs_sb_info *
 		/* Can't wait for an expire if there's no mount */
 		if (notify == NFY_NONE && !d_mountpoint(dentry)) {
 			kfree(name);
-			up(&sbi->wq_sem);
+			mutex_unlock(&sbi->wq_mutex);
 			return -ENOENT;
 		}
 
@@ -202,7 +202,7 @@ int autofs4_wait(struct autofs_sb_info *
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
 		if ( !wq ) {
 			kfree(name);
-			up(&sbi->wq_sem);
+			mutex_unlock(&sbi->wq_mutex);
 			return -ENOMEM;
 		}
 
@@ -218,10 +218,10 @@ int autofs4_wait(struct autofs_sb_info *
 		wq->status = -EINTR; /* Status return if interrupted */
 		atomic_set(&wq->wait_ctr, 2);
 		atomic_set(&wq->notified, 1);
-		up(&sbi->wq_sem);
+		mutex_unlock(&sbi->wq_mutex);
 	} else {
 		atomic_inc(&wq->wait_ctr);
-		up(&sbi->wq_sem);
+		mutex_unlock(&sbi->wq_mutex);
 		kfree(name);
 		DPRINTK("existing wait id = 0x%08lx, name = %.*s, nfy=%d",
 			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
@@ -282,19 +282,19 @@ int autofs4_wait_release(struct autofs_s
 {
 	struct autofs_wait_queue *wq, **wql;
 
-	down(&sbi->wq_sem);
+	mutex_lock(&sbi->wq_mutex);
 	for ( wql = &sbi->queues ; (wq = *wql) != 0 ; wql = &wq->next ) {
 		if ( wq->wait_queue_token == wait_queue_token )
 			break;
 	}
 
 	if ( !wq ) {
-		up(&sbi->wq_sem);
+		mutex_unlock(&sbi->wq_mutex);
 		return -EINVAL;
 	}
 
 	*wql = wq->next;	/* Unlink from chain */
-	up(&sbi->wq_sem);
+	mutex_unlock(&sbi->wq_mutex);
 	kfree(wq->name);
 	wq->name = NULL;	/* Do not wait on this queue */
 
