Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVHCWB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVHCWB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVHCWB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:01:29 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:39120 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261585AbVHCWAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:00:45 -0400
Date: Wed, 3 Aug 2005 15:00:43 -0700
From: Mike Waychison <mikew@google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Convert /proc/sysvipc/* to generic seq_file interface
Message-ID: <20050803220042.GB3353@google.com>
References: <20050803215559.GA3303@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803215559.GA3303@google.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the /proc/sysvipc/shm|sem|msg files to use the generic seq_file implementation for struct ipc_ids.

Signed-off-by: Mike Waychison <mikew@google.com>

 include/linux/msg.h |    1 
 include/linux/sem.h |    1 
 ipc/msg.c           |   80 +++++++++++++++---------------------------------
 ipc/sem.c           |   71 +++++++++++++-----------------------------
 ipc/shm.c           |   86 ++++++++++++++++------------------------------------
 5 files changed, 78 insertions(+), 161 deletions(-)

Index: linux-2.6.12.3/ipc/shm.c
===================================================================
--- linux-2.6.12.3.orig/ipc/shm.c	2005-08-03 14:31:28.000000000 -0700
+++ linux-2.6.12.3/ipc/shm.c	2005-08-03 14:35:29.000000000 -0700
@@ -23,12 +23,12 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/mman.h>
-#include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
 #include <linux/ptrace.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 
@@ -51,7 +51,7 @@ static int newseg (key_t key, int shmflg
 static void shm_open (struct vm_area_struct *shmd);
 static void shm_close (struct vm_area_struct *shmd);
 #ifdef CONFIG_PROC_FS
-static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
+static int sysvipc_shm_proc_show(struct seq_file *s, void *it);
 #endif
 
 size_t	shm_ctlmax = SHMMAX;
@@ -63,9 +63,10 @@ static int shm_tot; /* total number of s
 void __init shm_init (void)
 {
 	ipc_init_ids(&shm_ids, 1);
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("sysvipc/shm", 0, NULL, sysvipc_shm_read_proc, NULL);
-#endif
+	ipc_init_proc_interface("sysvipc/shm",
+				"       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n",
+				&shm_ids,
+				sysvipc_shm_proc_show);
 }
 
 static inline int shm_checkid(struct shmid_kernel *s, int id)
@@ -869,63 +870,32 @@ asmlinkage long sys_shmdt(char __user *s
 }
 
 #ifdef CONFIG_PROC_FS
-static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
+static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 {
-	off_t pos = 0;
-	off_t begin = 0;
-	int i, len = 0;
-
-	down(&shm_ids.sem);
-	len += sprintf(buffer, "       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n");
+	struct shmid_kernel *shp = it;
+	char *format;
 
-	for(i = 0; i <= shm_ids.max_id; i++) {
-		struct shmid_kernel* shp;
-
-		shp = shm_lock(i);
-		if(shp!=NULL) {
 #define SMALL_STRING "%10d %10d  %4o %10u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu\n"
 #define BIG_STRING   "%10d %10d  %4o %21u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu\n"
-			char *format;
 
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
-				is_file_hugepages(shp->shm_file) ? (file_count(shp->shm_file) - 1) : shp->shm_nattch,
-				shp->shm_perm.uid,
-				shp->shm_perm.gid,
-				shp->shm_perm.cuid,
-				shp->shm_perm.cgid,
-				shp->shm_atim,
-				shp->shm_dtim,
-				shp->shm_ctim);
-			shm_unlock(shp);
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
+	if (sizeof(size_t) <= sizeof(int))
+		format = SMALL_STRING;
+	else
+		format = BIG_STRING;
+	return seq_printf(s, format,
+			  shp->shm_perm.key,
+			  shp->id,
+			  shp->shm_flags,
+			  shp->shm_segsz,
+			  shp->shm_cprid,
+			  shp->shm_lprid,
+			  is_file_hugepages(shp->shm_file) ? (file_count(shp->shm_file) - 1) : shp->shm_nattch,
+			  shp->shm_perm.uid,
+			  shp->shm_perm.gid,
+			  shp->shm_perm.cuid,
+			  shp->shm_perm.cgid,
+			  shp->shm_atim,
+			  shp->shm_dtim,
+			  shp->shm_ctim);
 }
 #endif
Index: linux-2.6.12.3/include/linux/sem.h
===================================================================
--- linux-2.6.12.3.orig/include/linux/sem.h	2005-08-03 14:31:28.000000000 -0700
+++ linux-2.6.12.3/include/linux/sem.h	2005-08-03 14:35:29.000000000 -0700
@@ -88,6 +88,7 @@ struct sem {
 /* One sem_array data structure for each set of semaphores in the system. */
 struct sem_array {
 	struct kern_ipc_perm	sem_perm;	/* permissions .. see ipc.h */
+	int			sem_id;
 	time_t			sem_otime;	/* last semop time */
 	time_t			sem_ctime;	/* last change time */
 	struct sem		*sem_base;	/* ptr to first semaphore in array */
Index: linux-2.6.12.3/ipc/sem.c
===================================================================
--- linux-2.6.12.3.orig/ipc/sem.c	2005-08-03 14:31:28.000000000 -0700
+++ linux-2.6.12.3/ipc/sem.c	2005-08-03 14:35:29.000000000 -0700
@@ -73,6 +73,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
+#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -89,7 +90,7 @@ static struct ipc_ids sem_ids;
 static int newary (key_t, int, int);
 static void freeary (struct sem_array *sma, int id);
 #ifdef CONFIG_PROC_FS
-static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
+static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
 #endif
 
 #define SEMMSL_FAST	256 /* 512 bytes on stack */
@@ -116,10 +117,10 @@ void __init sem_init (void)
 {
 	used_sems = 0;
 	ipc_init_ids(&sem_ids,sc_semmni);
-
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("sysvipc/sem", 0, NULL, sysvipc_sem_read_proc, NULL);
-#endif
+	ipc_init_proc_interface("sysvipc/sem",
+				"       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n",
+				&sem_ids,
+				sysvipc_sem_proc_show);
 }
 
 /*
@@ -193,6 +194,7 @@ static int newary (key_t key, int nsems,
 	}
 	used_sems += nsems;
 
+	sma->sem_id = sem_buildid(id, sma->sem_perm.seq);
 	sma->sem_base = (struct sem *) &sma[1];
 	/* sma->sem_pending = NULL; */
 	sma->sem_pending_last = &sma->sem_pending;
@@ -201,7 +203,7 @@ static int newary (key_t key, int nsems,
 	sma->sem_ctime = get_seconds();
 	sem_unlock(sma);
 
-	return sem_buildid(id, sma->sem_perm.seq);
+	return sma->sem_id;
 }
 
 asmlinkage long sys_semget (key_t key, int nsems, int semflg)
@@ -1332,50 +1334,21 @@ next_entry:
 }
 
 #ifdef CONFIG_PROC_FS
-static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
+static int sysvipc_sem_proc_show(struct seq_file *s, void *it)
 {
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
-			sem_unlock(sma);
+	struct sem_array *sma = it;
 
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
+	return seq_printf(s,
+			  "%10d %10d  %4o %10lu %5u %5u %5u %5u %10lu %10lu\n",
+			  sma->sem_perm.key,
+			  sma->sem_id,
+			  sma->sem_perm.mode,
+			  sma->sem_nsems,
+			  sma->sem_perm.uid,
+			  sma->sem_perm.gid,
+			  sma->sem_perm.cuid,
+			  sma->sem_perm.cgid,
+			  sma->sem_otime,
+			  sma->sem_ctime);
 }
 #endif
Index: linux-2.6.12.3/include/linux/msg.h
===================================================================
--- linux-2.6.12.3.orig/include/linux/msg.h	2005-08-03 14:31:28.000000000 -0700
+++ linux-2.6.12.3/include/linux/msg.h	2005-08-03 14:35:29.000000000 -0700
@@ -77,6 +77,7 @@ struct msg_msg {
 /* one msq_queue structure for each present queue on the system */
 struct msg_queue {
 	struct kern_ipc_perm q_perm;
+	int q_id;
 	time_t q_stime;			/* last msgsnd time */
 	time_t q_rtime;			/* last msgrcv time */
 	time_t q_ctime;			/* last change time */
Index: linux-2.6.12.3/ipc/msg.c
===================================================================
--- linux-2.6.12.3.orig/ipc/msg.c	2005-08-03 14:31:28.000000000 -0700
+++ linux-2.6.12.3/ipc/msg.c	2005-08-03 14:35:29.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
+#include <linux/seq_file.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 #include "util.h"
@@ -74,16 +75,16 @@ static struct ipc_ids msg_ids;
 static void freeque (struct msg_queue *msq, int id);
 static int newque (key_t key, int msgflg);
 #ifdef CONFIG_PROC_FS
-static int sysvipc_msg_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
+static int sysvipc_msg_proc_show(struct seq_file *s, void *it);
 #endif
 
 void __init msg_init (void)
 {
 	ipc_init_ids(&msg_ids,msg_ctlmni);
-
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("sysvipc/msg", 0, NULL, sysvipc_msg_read_proc, NULL);
-#endif
+	ipc_init_proc_interface("sysvipc/msg",
+				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
+				&msg_ids,
+				sysvipc_msg_proc_show);
 }
 
 static int newque (key_t key, int msgflg)
@@ -113,6 +114,7 @@ static int newque (key_t key, int msgflg
 		return -ENOSPC;
 	}
 
+	msq->q_id = msg_buildid(id,msq->q_perm.seq);
 	msq->q_stime = msq->q_rtime = 0;
 	msq->q_ctime = get_seconds();
 	msq->q_cbytes = msq->q_qnum = 0;
@@ -123,7 +125,7 @@ static int newque (key_t key, int msgflg
 	INIT_LIST_HEAD(&msq->q_senders);
 	msg_unlock(msq);
 
-	return msg_buildid(id,msq->q_perm.seq);
+	return msq->q_id;
 }
 
 static inline void ss_add(struct msg_queue* msq, struct msg_sender* mss)
@@ -808,55 +810,25 @@ out_unlock:
 }
 
 #ifdef CONFIG_PROC_FS
-static int sysvipc_msg_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
+static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 {
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
-			msg_unlock(msq);
-
-			pos += len;
-			if(pos < offset) {
-				len = 0;
-				begin = pos;
-			}
-			if(pos > offset + length)
-				goto done;
-		}
+	struct msg_queue *msq = it;
 
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
+	return seq_printf(s,
+			  "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
+			  msq->q_perm.key,
+			  msq->q_id,
+			  msq->q_perm.mode,
+			  msq->q_cbytes,
+			  msq->q_qnum,
+			  msq->q_lspid,
+			  msq->q_lrpid,
+			  msq->q_perm.uid,
+			  msq->q_perm.gid,
+			  msq->q_perm.cuid,
+			  msq->q_perm.cgid,
+			  msq->q_stime,
+			  msq->q_rtime,
+			  msq->q_ctime);
 }
 #endif
