Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318856AbSHETsI>; Mon, 5 Aug 2002 15:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318857AbSHETsI>; Mon, 5 Aug 2002 15:48:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12980 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318856AbSHETsG>; Mon, 5 Aug 2002 15:48:06 -0400
Message-ID: <3D4ED69E.ABA2C737@us.ibm.com>
Date: Mon, 05 Aug 2002 12:48:46 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
CC: cmm@us.ibm.com
Subject: [PATCH] Breaking down the global IPC locks
Content-Type: multipart/mixed;
 boundary="------------A575D5A2DFB6C66A5ED4DFEE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A575D5A2DFB6C66A5ED4DFEE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Linus and All,

This patch breaks down the three global IPC locks into one lock per IPC
ID. 

In current implementation, the operations on any IPC semaphores are
synchronized by one single IPC semaphore lock.  Changing the IPC locks
from one lock per IPC resource type into one lock per IPC ID makes sense
to me.  By doing so could reduce the possible lock contention in some
applications where the IPC resources are heavily used.

Test results from the LMbench Pipe and IPC latency test shows this patch 
improves the performance of those functions from 1% to 9%.  

Patch applies to 2.5.30 kernel. Please consider it.

--
Mingming Cao
--------------A575D5A2DFB6C66A5ED4DFEE
Content-Type: text/plain; charset=us-ascii;
 name="ipclock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipclock.patch"

diff -urN -X ../dontdiff ../base/linux-2.5.30/ipc/util.c 2.5.30-ipc/ipc/util.c
--- ../base/linux-2.5.30/ipc/util.c	Thu Aug  1 14:16:21 2002
+++ 2.5.30-ipc/ipc/util.c	Fri Aug  2 16:06:19 2002
@@ -74,9 +74,11 @@
 		printk(KERN_ERR "ipc_init_ids() failed, ipc service disabled.\n");
 		ids->size = 0;
 	}
-	ids->ary = SPIN_LOCK_UNLOCKED;
-	for(i=0;i<ids->size;i++)
+	ids->ary_lock =RW_LOCK_UNLOCKED;
+	for(i=0;i<ids->size;i++) {
 		ids->entries[i].p = NULL;
+		ids->entries[i].lock = SPIN_LOCK_UNLOCKED;
+	}
 }
 
 /**
@@ -119,14 +121,15 @@
 	memcpy(new, ids->entries, sizeof(struct ipc_id)*ids->size);
 	for(i=ids->size;i<newsize;i++) {
 		new[i].p = NULL;
+		new[i].lock = SPIN_LOCK_UNLOCKED;
 	}
-	spin_lock(&ids->ary);
+	write_lock(&ids->ary_lock);
 
 	old = ids->entries;
 	ids->entries = new;
 	i = ids->size;
 	ids->size = newsize;
-	spin_unlock(&ids->ary);
+	write_unlock(&ids->ary_lock);
 	ipc_free(old, sizeof(struct ipc_id)*i);
 	return ids->size;
 }
@@ -165,7 +168,8 @@
 	if(ids->seq > ids->seq_max)
 		ids->seq = 0;
 
-	spin_lock(&ids->ary);
+	read_lock(&ids->ary_lock);
+	spin_lock(&ids->entries[id].lock);
 	ids->entries[id].p = new;
 	return id;
 }
diff -urN -X ../dontdiff ../base/linux-2.5.30/ipc/util.h 2.5.30-ipc/ipc/util.h
--- ../base/linux-2.5.30/ipc/util.h	Thu Aug  1 14:16:28 2002
+++ 2.5.30-ipc/ipc/util.h	Fri Aug  2 16:06:19 2002
@@ -20,11 +20,13 @@
 	unsigned short seq_max;
 	struct semaphore sem;	
 	spinlock_t ary;
+	rwlock_t ary_lock;
 	struct ipc_id* entries;
 };
 
 struct ipc_id {
 	struct kern_ipc_perm* p;
+	spinlock_t	lock;
 };
 
 
@@ -72,16 +74,25 @@
 	if(lid >= ids->size)
 		return NULL;
 
-	spin_lock(&ids->ary);
+	/*spin_lock(&ids->ary);*/
+	read_lock(&ids->ary_lock);
+	spin_lock(&ids->entries[lid].lock);
 	out = ids->entries[lid].p;
-	if(out==NULL)
-		spin_unlock(&ids->ary);
+	if(out==NULL) {
+		spin_unlock(&ids->entries[lid].lock);
+		read_unlock(&ids->ary_lock);
+	}
 	return out;
 }
 
 extern inline void ipc_unlock(struct ipc_ids* ids, int id)
 {
-	spin_unlock(&ids->ary);
+	int lid = id % SEQ_MULTIPLIER;
+        if(lid >= ids->size)
+                return;
+
+	spin_unlock(&ids->entries[lid].lock);
+	read_unlock(&ids->ary_lock);
 }
 
 extern inline int ipc_buildid(struct ipc_ids* ids, int id, int seq)

--------------A575D5A2DFB6C66A5ED4DFEE--

