Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319115AbSHTA0H>; Mon, 19 Aug 2002 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319116AbSHTA0H>; Mon, 19 Aug 2002 20:26:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5117 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319115AbSHTA0F>;
	Mon, 19 Aug 2002 20:26:05 -0400
Message-ID: <3D618D98.A9163EB1@us.ibm.com>
Date: Mon, 19 Aug 2002 17:30:16 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, cmm@us.ibm.com
Subject: Re: [PATCH] Breaking down the global IPC locks - 2.5.31
References: <Pine.LNX.4.44.0208061556160.1545-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------92CD5CD4F47BF99769C9454B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------92CD5CD4F47BF99769C9454B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch breaks the three global IPC locks into one lock per IPC ID.
By doing so it could reduce possible lock contention in workloads which
make heavy use of IPC semaphores, message queues and Shared
memories...etc.

Changes from last version:
- move the IPC ID lock from the ipc_ids structure to kern_ipc_perm
structure to avoid cacheline bouncing
- make the ipc_lockall() and ipc_unlockal() use the global read-write
locks.  Remove the old global spin locks.

Patch is against 2.5.31 kernel. Please comment.

Mingming
--------------92CD5CD4F47BF99769C9454B
Content-Type: text/plain; charset=us-ascii;
 name="ipclock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipclock.patch"

diff -urN -X ../dontdiff ../base/linux-2.5.31/include/linux/ipc.h 2.5.31-ipc/include/linux/ipc.h
--- ../base/linux-2.5.31/include/linux/ipc.h	Sat Aug 10 18:41:16 2002
+++ 2.5.31-ipc/include/linux/ipc.h	Tue Aug 13 10:23:59 2002
@@ -56,6 +56,7 @@
 /* used by in-kernel data structures */
 struct kern_ipc_perm
 {
+	spinlock_t	lock;
 	key_t		key;
 	uid_t		uid;
 	gid_t		gid;
diff -urN -X ../dontdiff ../base/linux-2.5.31/ipc/util.c 2.5.31-ipc/ipc/util.c
--- ../base/linux-2.5.31/ipc/util.c	Sat Aug 10 18:41:27 2002
+++ 2.5.31-ipc/ipc/util.c	Wed Aug 14 15:59:19 2002
@@ -74,7 +74,7 @@
 		printk(KERN_ERR "ipc_init_ids() failed, ipc service disabled.\n");
 		ids->size = 0;
 	}
-	ids->ary = SPIN_LOCK_UNLOCKED;
+	ids->ary =RW_LOCK_UNLOCKED;
 	for(i=0;i<ids->size;i++)
 		ids->entries[i].p = NULL;
 }
@@ -120,13 +120,13 @@
 	for(i=ids->size;i<newsize;i++) {
 		new[i].p = NULL;
 	}
-	spin_lock(&ids->ary);
+	write_lock(&ids->ary);
 
 	old = ids->entries;
 	ids->entries = new;
 	i = ids->size;
 	ids->size = newsize;
-	spin_unlock(&ids->ary);
+	write_unlock(&ids->ary);
 	ipc_free(old, sizeof(struct ipc_id)*i);
 	return ids->size;
 }
@@ -165,7 +165,9 @@
 	if(ids->seq > ids->seq_max)
 		ids->seq = 0;
 
-	spin_lock(&ids->ary);
+	new->lock = SPIN_LOCK_UNLOCKED;
+	read_lock(&ids->ary);
+	spin_lock(&new->lock);
 	ids->entries[id].p = new;
 	return id;
 }
diff -urN -X ../dontdiff ../base/linux-2.5.31/ipc/util.h 2.5.31-ipc/ipc/util.h
--- ../base/linux-2.5.31/ipc/util.h	Sat Aug 10 18:41:40 2002
+++ 2.5.31-ipc/ipc/util.h	Wed Aug 14 17:05:22 2002
@@ -19,7 +19,7 @@
 	unsigned short seq;
 	unsigned short seq_max;
 	struct semaphore sem;	
-	spinlock_t ary;
+	rwlock_t ary;
 	struct ipc_id* entries;
 };
 
@@ -47,7 +47,7 @@
 
 extern inline void ipc_lockall(struct ipc_ids* ids)
 {
-	spin_lock(&ids->ary);
+	write_lock(&ids->ary);
 }
 
 extern inline struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
@@ -63,7 +63,7 @@
 
 extern inline void ipc_unlockall(struct ipc_ids* ids)
 {
-	spin_unlock(&ids->ary);
+	write_unlock(&ids->ary);
 }
 extern inline struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 {
@@ -72,16 +72,29 @@
 	if(lid >= ids->size)
 		return NULL;
 
-	spin_lock(&ids->ary);
+	read_lock(&ids->ary);
 	out = ids->entries[lid].p;
-	if(out==NULL)
-		spin_unlock(&ids->ary);
+	if(out==NULL) {
+		read_unlock(&ids->ary);
+		return NULL;
+	}
+	spin_lock($out->lock);
 	return out;
 }
 
 extern inline void ipc_unlock(struct ipc_ids* ids, int id)
 {
-	spin_unlock(&ids->ary);
+	int lid = id % SEQ_MULTIPLIER;
+	struct kern_ipc_perm* out;
+
+        if(lid >= ids->size)
+		return;
+	out = ids->entries[lid].p;
+	if (out == NULL)
+		return;
+
+	spin_unlock(&out->lock);
+	read_unlock(&ids->ary);
 }
 
 extern inline int ipc_buildid(struct ipc_ids* ids, int id, int seq)

--------------92CD5CD4F47BF99769C9454B--

