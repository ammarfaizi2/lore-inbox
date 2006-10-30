Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWJ3MLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWJ3MLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWJ3MLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:11:50 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:12898 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751233AbWJ3MLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:11:49 -0500
Message-ID: <4545EAF9.6090507@openvz.org>
Date: Mon, 30 Oct 2006 15:07:21 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kirill Korotaev <dev@openvz.org>, devel@openvz.org
Subject: [PATCH] Fix ipc entries removal
Content-Type: multipart/mixed;
 boundary="------------000106080703060202000101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000106080703060202000101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch fixes two issuses related to ipc_ids->entries freeing.

1. When freeing ipc namespace we need to free entries allocated
   with ipc_init_ids().

2. When removing old entries in grow_ary() ipc_rcu_putref()
   may be called on entries set to &ids->nullentry earlier in
   ipc_init_ids().
   This is almost impossible without namespaces, but with
   them this situation becomes possible.

Found during OpenVZ testing after obvious leaks in beancounters.

Signed-off-by: Pavel Emelianov <xemul@openvz.org>

--------------000106080703060202000101
Content-Type: text/plain;
 name="diff-ipc-entries-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ipc-entries-fix"

--- ./ipc/msg.c.ipcfx	2006-10-30 14:53:07.000000000 +0300
+++ ./ipc/msg.c	2006-10-30 15:00:08.000000000 +0300
@@ -124,6 +124,7 @@ void msg_exit_ns(struct ipc_namespace *n
 	}
 	mutex_unlock(&msg_ids(ns).mutex);
 
+	ipc_fini_ids(ns->ids[IPC_MSG_IDS]);
 	kfree(ns->ids[IPC_MSG_IDS]);
 	ns->ids[IPC_MSG_IDS] = NULL;
 }
--- ./ipc/sem.c.ipcfx	2006-10-30 14:53:07.000000000 +0300
+++ ./ipc/sem.c	2006-10-30 14:59:44.000000000 +0300
@@ -161,6 +161,7 @@ void sem_exit_ns(struct ipc_namespace *n
 	}
 	mutex_unlock(&sem_ids(ns).mutex);
 
+	ipc_fini_ids(ns->ids[IPC_SEM_IDS]);
 	kfree(ns->ids[IPC_SEM_IDS]);
 	ns->ids[IPC_SEM_IDS] = NULL;
 }
--- ./ipc/shm.c.ipcfx	2006-10-30 14:53:07.000000000 +0300
+++ ./ipc/shm.c	2006-10-30 14:59:57.000000000 +0300
@@ -116,6 +116,7 @@ void shm_exit_ns(struct ipc_namespace *n
 	}
 	mutex_unlock(&shm_ids(ns).mutex);
 
+	ipc_fini_ids(ns->ids[IPC_SHM_IDS]);
 	kfree(ns->ids[IPC_SHM_IDS]);
 	ns->ids[IPC_SHM_IDS] = NULL;
 }
--- ./ipc/util.c.ipcfx	2006-10-26 17:51:58.000000000 +0400
+++ ./ipc/util.c	2006-10-30 14:59:23.000000000 +0300
@@ -301,7 +301,7 @@ static int grow_ary(struct ipc_ids* ids,
 	 */
 	rcu_assign_pointer(ids->entries, new);
 
-	ipc_rcu_putref(old);
+	__ipc_fini_ids(ids, old);
 	return newsize;
 }
 
--- ./ipc/util.h.ipcfx	2006-10-26 17:51:58.000000000 +0400
+++ ./ipc/util.h	2006-10-30 14:59:09.000000000 +0300
@@ -83,6 +83,18 @@ void* ipc_rcu_alloc(int size);
 void ipc_rcu_getref(void *ptr);
 void ipc_rcu_putref(void *ptr);
 
+static inline void __ipc_fini_ids(struct ipc_ids *ids,
+		struct ipc_id_ary *entries)
+{
+	if (entries != &ids->nullentry)
+		ipc_rcu_putref(entries);
+}
+
+static inline void ipc_fini_ids(struct ipc_ids *ids)
+{
+	__ipc_fini_ids(ids, ids->entries);
+}
+
 struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id);
 struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id);
 void ipc_lock_by_ptr(struct kern_ipc_perm *ipcp);

--------------000106080703060202000101--
