Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWFNOSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWFNOSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWFNOSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:18:43 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:22359 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S964908AbWFNOSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:18:42 -0400
Date: Wed, 14 Jun 2006 16:18:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/8] lock validator: s390 rwsem/semaphore changes
Message-ID: <20060614141827.GD1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

s390 rwsem/semaphore changes for lock validator.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/rwsem.h     |   31 +++++++++++++++++++++++++++++--
 include/asm-s390/semaphore.h |    3 ++-
 2 files changed, 31 insertions(+), 3 deletions(-)

diff -purN a/include/asm-s390/rwsem.h b/include/asm-s390/rwsem.h
--- a/include/asm-s390/rwsem.h	2006-06-06 02:57:02.000000000 +0200
+++ b/include/asm-s390/rwsem.h	2006-06-14 12:56:07.000000000 +0200
@@ -61,6 +61,9 @@ struct rw_semaphore {
 	signed long		count;
 	spinlock_t		wait_lock;
 	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
+	struct lockdep_map	dep_map;
+#endif
 };
 
 #ifndef __s390x__
@@ -80,8 +83,16 @@ struct rw_semaphore {
 /*
  * initialisation
  */
+
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
+# define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
+  __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
@@ -93,6 +104,17 @@ static inline void init_rwsem(struct rw_
 	INIT_LIST_HEAD(&sem->wait_list);
 }
 
+extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
+			 struct lockdep_type_key *key);
+
+#define init_rwsem(sem)				\
+do {						\
+	static struct lockdep_type_key __key;	\
+						\
+	__init_rwsem((sem), #sem, &__key);	\
+} while (0)
+
+
 /*
  * lock for reading
  */
@@ -155,7 +177,7 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write_nested(struct rw_semaphore *sem, int subtype)
 {
 	signed long old, new, tmp;
 
@@ -181,6 +203,11 @@ static inline void __down_write(struct r
 		rwsem_down_write_failed(sem);
 }
 
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	__down_write_nested(sem, 0);
+}
+
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
diff -purN a/include/asm-s390/semaphore.h b/include/asm-s390/semaphore.h
--- a/include/asm-s390/semaphore.h	2006-06-06 02:57:02.000000000 +0200
+++ b/include/asm-s390/semaphore.h	2006-06-14 12:56:07.000000000 +0200
@@ -37,7 +37,8 @@ struct semaphore {
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER((*sem),val);
+	atomic_set(&sem->count, val);
+	init_waitqueue_head(&sem->wait);
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
