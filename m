Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316402AbSEWIf3>; Thu, 23 May 2002 04:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316403AbSEWIf2>; Thu, 23 May 2002 04:35:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16392 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316402AbSEWIfY>; Thu, 23 May 2002 04:35:24 -0400
Message-ID: <3CEC9AF2.2010107@evision-ventures.com>
Date: Thu, 23 May 2002 09:32:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.17 sysvipc (AKA: spoiling oil in to the flames)
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060507010009050009020604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060507010009050009020604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kill /proc/sysvipc and friends. This is a pure case of interface duplication,
since we have the ipcs command and nice fine /proc/sys/kernel entries for the
relevant stuff... Fortunately apparently nothing is using it.

Fix improper extern inline usage in ipc/utils.h as well as add
some static attributes to local functions found there.

If some "embedded" system user starts to holler about
memory issues. Well:

[root@domek linux]# size /usr/bin/ipcs
    text    data     bss     dec     hex filename
   13433     324      32   13789    35dd /usr/bin/ipcs

And now count the pages used to implement /proc/sysvipc entires +
the few kilbytes of actual code removed from the kernel.

As an added bonus the functions implementing /proc/sysvipc
where accessible by everyone and getting the msg_ide.sem and similar
semaphores for quite a significant amount of time...

Perhaps it is time as well to look at the two different
IPC structures carried around there ("64 bit" and 32 bit)
and the double liked list usage there?

--------------060507010009050009020604
Content-Type: text/plain;
 name="kill-sysvipc-2.5.17.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kill-sysvipc-2.5.17.patch"

diff -urN linux-2.5.17/fs/proc/root.c linux/fs/proc/root.c
--- linux-2.5.17/fs/proc/root.c	2002-05-21 07:07:42.000000000 +0200
+++ linux/fs/proc/root.c	2002-05-23 07:07:38.000000000 +0200
@@ -53,9 +53,6 @@
 	}
 	proc_misc_init();
 	proc_net = proc_mkdir("net", 0);
-#ifdef CONFIG_SYSVIPC
-	proc_mkdir("sysvipc", 0);
-#endif
 #ifdef CONFIG_SYSCTL
 	proc_sys_root = proc_mkdir("sys", 0);
 #endif
Binary files linux-2.5.17/fs/proc/.root.c.swp and linux/fs/proc/.root.c.swp differ
diff -urN linux-2.5.17/ipc/msg.c linux/ipc/msg.c
--- linux-2.5.17/ipc/msg.c	2002-05-21 07:07:29.000000000 +0200
+++ linux/ipc/msg.c	2002-05-22 22:37:32.000000000 +0200
@@ -8,8 +8,6 @@
  * Fixed up the unchecked user space derefs
  * Copyright (C) 1998 Alan Cox & Andi Kleen
  *
- * /proc/sysvipc/msg support (c) 1999 Dragos Acostachioaie <dragos@iname.com>
- *
  * mostly rewritten, threaded and wake-one semantics added
  * MSGMAX limit removed, sysctl's added
  * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
@@ -20,9 +18,12 @@
 #include <linux/msg.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
-#include <linux/proc_fs.h>
 #include <linux/list.h>
+#include <linux/stat.h>
+#include <linux/err.h>
+
 #include <asm/uaccess.h>
+
 #include "util.h"
 
 /* sysctl: */
@@ -54,8 +55,8 @@
 };
 /* one msg_msg structure for each message */
 struct msg_msg {
-	struct list_head m_list; 
-	long  m_type;          
+	struct list_head m_list;
+	long  m_type;
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
 	/* the actual message follows immediately */
@@ -101,17 +102,10 @@
 
 static void freeque (int id);
 static int newque (key_t key, int msgflg);
-#ifdef CONFIG_PROC_FS
-static int sysvipc_msg_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
-#endif
 
 void __init msg_init (void)
 {
 	ipc_init_ids(&msg_ids,msg_ctlmni);
-
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("sysvipc/msg", 0, 0, sysvipc_msg_read_proc, NULL);
-#endif
 }
 
 static int newque (key_t key, int msgflg)
@@ -847,57 +841,3 @@
 		msg_unlock(msqid);
 	return err;
 }
-
-#ifdef CONFIG_PROC_FS
-static int sysvipc_msg_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
-{
-	off_t pos = 0;
-	off_t begin = 0;
-	int i, len = 0;
-
-	down(&msg_ids.sem);
-	len += sprintf(buffer, "       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n");
-
-	for(i = 0; i <= msg_ids.max_id; i++) {
-		struct msg_queue * msq;
-		msq = msg_lock(i);
-		if(msq != NULL) {
-			len += sprintf(buffer + len, "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
-				msq->q_perm.key,
-				msg_buildid(i,msq->q_perm.seq),
-				msq->q_perm.mode,
-				msq->q_cbytes,
-				msq->q_qnum,
-				msq->q_lspid,
-				msq->q_lrpid,
-				msq->q_perm.uid,
-				msq->q_perm.gid,
-				msq->q_perm.cuid,
-				msq->q_perm.cgid,
-				msq->q_stime,
-				msq->q_rtime,
-				msq->q_ctime);
-			msg_unlock(i);
-
-			pos += len;
-			if(pos < offset) {
-				len = 0;
-				begin = pos;
-			}
-			if(pos > offset + length)
-				goto done;
-		}
-
-	}
-	*eof = 1;
-done:
-	up(&msg_ids.sem);
-	*start = buffer + (offset - begin);
-	len -= (offset - begin);
-	if(len > length)
-		len = length;
-	if(len < 0)
-		len = 0;
-	return len;
-}
-#endif
diff -urN linux-2.5.17/ipc/sem.c linux/ipc/sem.c
--- linux-2.5.17/ipc/sem.c	2002-05-21 07:07:37.000000000 +0200
+++ linux/ipc/sem.c	2002-05-22 23:01:02.000000000 +0200
@@ -49,8 +49,6 @@
  *      increase. If there are decrement operations in the operations
  *      array we do the same as before.
  *
- * /proc/sysvipc/sem support (c) 1999 Dragos Acostachioaie <dragos@iname.com>
- *
  * SMP-threaded, sysctl's added
  * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
  * Enforced range limit on SEM_UNDO
@@ -61,9 +59,12 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
-#include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/stat.h>
+#include <linux/err.h>
+
 #include <asm/uaccess.h>
+
 #include "util.h"
 
 
@@ -78,9 +79,6 @@
 
 static int newary (key_t, int, int);
 static void freeary (int id);
-#ifdef CONFIG_PROC_FS
-static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
-#endif
 
 #define SEMMSL_FAST	256 /* 512 bytes on stack */
 #define SEMOPM_FAST	64  /* ~ 372 bytes on stack */
@@ -91,7 +89,7 @@
  *	sem_array.sem_pending{,last},
  *	sem_array.sem_undo: sem_lock() for read/write
  *	sem_undo.proc_next: only "current" is allowed to read/write that field.
- *	
+ *
  */
 
 int sem_ctls[4] = {SEMMSL, SEMMNS, SEMOPM, SEMMNI};
@@ -106,10 +104,6 @@
 {
 	used_sems = 0;
 	ipc_init_ids(&sem_ids,sc_semmni);
-
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("sysvipc/sem", 0, 0, sysvipc_sem_read_proc, NULL);
-#endif
 }
 
 static int newary (key_t key, int nsems, int semflg)
@@ -158,7 +152,7 @@
 	if (nsems < 0 || nsems > sc_semmsl)
 		return -EINVAL;
 	down(&sem_ids.sem);
-	
+
 	if (key == IPC_PRIVATE) {
 		err = newary(key, nsems, semflg);
 	} else if ((id = ipc_findkey(&sem_ids, key)) == -1) {  /* key not used */
@@ -321,7 +315,7 @@
 	struct sem_queue * q;
 
 	for (q = sma->sem_pending; q; q = q->next) {
-			
+
 		if (q->status == 1)
 			continue;	/* this one was woken up before */
 
@@ -370,6 +364,7 @@
 	}
 	return semncnt;
 }
+
 static int count_semzcnt (struct sem_array * sma, ushort semnum)
 {
 	int semzcnt;
@@ -441,7 +436,7 @@
 	}
 }
 
-int semctl_nolock(int semid, int semnum, int cmd, int version, union semun arg)
+static int semctl_nolock(int semid, int semnum, int cmd, int version, union semun arg)
 {
 	int err = -EINVAL;
 
@@ -1115,7 +1110,7 @@
 			spin_lock_init(&undo_list->lock);
 		atomic_inc(&undo_list->refcnt);
 		tsk->sysvsem.undo_list = undo_list;
-	} else 
+	} else
 		tsk->sysvsem.undo_list = NULL;
 
 	return 0;
@@ -1226,52 +1221,3 @@
 
 	unlock_kernel();
 }
-
-#ifdef CONFIG_PROC_FS
-static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
-{
-	off_t pos = 0;
-	off_t begin = 0;
-	int i, len = 0;
-
-	len += sprintf(buffer, "       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n");
-	down(&sem_ids.sem);
-
-	for(i = 0; i <= sem_ids.max_id; i++) {
-		struct sem_array *sma;
-		sma = sem_lock(i);
-		if(sma) {
-			len += sprintf(buffer + len, "%10d %10d  %4o %10lu %5u %5u %5u %5u %10lu %10lu\n",
-				sma->sem_perm.key,
-				sem_buildid(i,sma->sem_perm.seq),
-				sma->sem_perm.mode,
-				sma->sem_nsems,
-				sma->sem_perm.uid,
-				sma->sem_perm.gid,
-				sma->sem_perm.cuid,
-				sma->sem_perm.cgid,
-				sma->sem_otime,
-				sma->sem_ctime);
-			sem_unlock(i);
-
-			pos += len;
-			if(pos < offset) {
-				len = 0;
-	    			begin = pos;
-			}
-			if(pos > offset + length)
-				goto done;
-		}
-	}
-	*eof = 1;
-done:
-	up(&sem_ids.sem);
-	*start = buffer + (offset - begin);
-	len -= (offset - begin);
-	if(len > length)
-		len = length;
-	if(len < 0)
-		len = 0;
-	return len;
-}
-#endif
diff -urN linux-2.5.17/ipc/shm.c linux/ipc/shm.c
--- linux-2.5.17/ipc/shm.c	2002-05-21 07:07:39.000000000 +0200
+++ linux/ipc/shm.c	2002-05-22 22:44:16.000000000 +0200
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/mman.h>
-#include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
 #include <asm/uaccess.h>
 
@@ -60,9 +59,6 @@
 static int newseg (key_t key, int shmflg, size_t size);
 static void shm_open (struct vm_area_struct *shmd);
 static void shm_close (struct vm_area_struct *shmd);
-#ifdef CONFIG_PROC_FS
-static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
-#endif
 
 size_t	shm_ctlmax = SHMMAX;
 size_t 	shm_ctlall = SHMALL;
@@ -73,9 +69,6 @@
 void __init shm_init (void)
 {
 	ipc_init_ids(&shm_ids, 1);
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, NULL);
-#endif
 }
 
 static inline int shm_checkid(struct shmid_kernel *s, int id)
@@ -688,65 +681,3 @@
 	up_write(&mm->mmap_sem);
 	return retval;
 }
-
-#ifdef CONFIG_PROC_FS
-static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
-{
-	off_t pos = 0;
-	off_t begin = 0;
-	int i, len = 0;
-
-	down(&shm_ids.sem);
-	len += sprintf(buffer, "       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n");
-
-	for(i = 0; i <= shm_ids.max_id; i++) {
-		struct shmid_kernel* shp;
-
-		shp = shm_lock(i);
-		if(shp!=NULL) {
-#define SMALL_STRING "%10d %10d  %4o %10u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu\n"
-#define BIG_STRING   "%10d %10d  %4o %21u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu\n"
-			char *format;
-
-			if (sizeof(size_t) <= sizeof(int))
-				format = SMALL_STRING;
-			else
-				format = BIG_STRING;
-			len += sprintf(buffer + len, format,
-				shp->shm_perm.key,
-				shm_buildid(i, shp->shm_perm.seq),
-				shp->shm_flags,
-				shp->shm_segsz,
-				shp->shm_cprid,
-				shp->shm_lprid,
-				shp->shm_nattch,
-				shp->shm_perm.uid,
-				shp->shm_perm.gid,
-				shp->shm_perm.cuid,
-				shp->shm_perm.cgid,
-				shp->shm_atim,
-				shp->shm_dtim,
-				shp->shm_ctim);
-			shm_unlock(i);
-
-			pos += len;
-			if(pos < offset) {
-				len = 0;
-				begin = pos;
-			}
-			if(pos > offset + length)
-				goto done;
-		}
-	}
-	*eof = 1;
-done:
-	up(&shm_ids.sem);
-	*start = buffer + (offset - begin);
-	len -= (offset - begin);
-	if(len > length)
-		len = length;
-	if(len < 0)
-		len = 0;
-	return len;
-}
-#endif
diff -urN linux-2.5.17/ipc/util.h linux/ipc/util.h
--- linux-2.5.17/ipc/util.h	2002-05-21 07:07:40.000000000 +0200
+++ linux/ipc/util.h	2002-05-22 22:55:08.000000000 +0200
@@ -42,15 +42,15 @@
 /* for rare, potentially huge allocations.
  * both function can sleep
  */
-void* ipc_alloc(int size);
-void ipc_free(void* ptr, int size);
+extern void* ipc_alloc(int size);
+extern void ipc_free(void* ptr, int size);
 
-extern inline void ipc_lockall(struct ipc_ids* ids)
+static inline void ipc_lockall(struct ipc_ids* ids)
 {
 	spin_lock(&ids->ary);
 }
 
-extern inline struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
+static inline struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
@@ -61,11 +61,12 @@
 	return out;
 }
 
-extern inline void ipc_unlockall(struct ipc_ids* ids)
+static inline void ipc_unlockall(struct ipc_ids* ids)
 {
 	spin_unlock(&ids->ary);
 }
-extern inline struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
+
+static inline struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
@@ -79,28 +80,28 @@
 	return out;
 }
 
-extern inline void ipc_unlock(struct ipc_ids* ids, int id)
+static inline void ipc_unlock(struct ipc_ids* ids, int id)
 {
 	spin_unlock(&ids->ary);
 }
 
-extern inline int ipc_buildid(struct ipc_ids* ids, int id, int seq)
+static inline int ipc_buildid(struct ipc_ids* ids, int id, int seq)
 {
 	return SEQ_MULTIPLIER*seq + id;
 }
 
-extern inline int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid)
+static inline int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid)
 {
 	if(uid/SEQ_MULTIPLIER != ipcp->seq)
 		return 1;
 	return 0;
 }
 
-void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
-void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out);
+extern void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
+extern void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out);
 
 #ifdef __ia64__
-  /* On IA-64, we always use the "64-bit version" of the IPC structures.  */ 
+  /* On IA-64, we always use the "64-bit version" of the IPC structures.  */
 # define ipc_parse_version(cmd)	IPC_64
 #else
 int ipc_parse_version (int *cmd);

--------------060507010009050009020604--

