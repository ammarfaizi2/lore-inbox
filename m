Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUF1UUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUF1UUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUF1UUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:20:53 -0400
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:1476 "EHLO
	mangrove.bmc.com") by vger.kernel.org with ESMTP id S265170AbUF1UUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:20:00 -0400
Message-ID: <F12B6443B4A38748AFA644D1F8EF3532147335@bos-ex-01.adprod.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Andries Brouwer'" <aebr@win.tue.nl>
Subject: [PATCH] [RFC] Expose {shm,sem,msg}info in /proc/sysvipc
Date: Mon, 28 Jun 2004 15:19:27 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exposes global IPC variables in /proc/sysvipc/{shm,sem,msg}info,
alongside the entry listings in /proc/sysvipc{shm,sem,msg}.

For example:

# cat /proc/sysvipc/shminfo
shmmax 33554432
shmmin 1
shmmni 4096
shmseg 4096
shmall 2097152
used_ids 2
shm_tot 2
shm_rss 0
shm_swp 0


Some of them (e.g., shmmax) are sysctl parameters, and so are already
available in /proc/sys/kernel, but others (e.g., shm_rss) can only be
retrieved via undocumented {IPC,SHM,SEM,MSG}_INFO {shm,sem,msg}ctl calls.

sys_shmctl() has long had a comment about a /proc interface, but until now,
it has only been done for per-entry values.

One advantage of this interface is that it allows a 32-bit application
to read the correct values from a 64-bit kernel without recompiling.


# Signed-off-by: Lev Makhlis <mlev@despammed.com>
#
diff -ruN linux-2.6.7-orig/ipc/msg.c linux-2.6.7/ipc/msg.c
--- linux-2.6.7-orig/ipc/msg.c	2004-06-16 01:18:38.000000000 -0400
+++ linux-2.6.7/ipc/msg.c	2004-06-28 15:16:27.816863592 -0400
@@ -73,6 +73,7 @@
 static int newque (key_t key, int msgflg);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_read_proc(char *buffer, char **start, off_t offset,
int length, int *eof, void *data);
+static int sysvipc_msginfo_read_proc(char *buffer, char **start, off_t
offset, int length, int *eof, void *data);
 #endif
 
 void __init msg_init (void)
@@ -81,6 +82,7 @@
 
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/msg", 0, 0, sysvipc_msg_read_proc,
NULL);
+	create_proc_read_entry("sysvipc/msginfo", 0, 0,
sysvipc_msginfo_read_proc, NULL);
 #endif
 }
 
@@ -827,4 +829,28 @@
 		len = 0;
 	return len;
 }
+static int sysvipc_msginfo_read_proc(char *buffer, char **start, off_t
offset, int length, int *eof, void *data)
+{
+	int len = 0;
+	int ids, hdrs, bytes;
+
+	len += sprintf(buffer + len, "msgpool %d\n", MSGPOOL);
+	len += sprintf(buffer + len, "msgmap %d\n", MSGMAP);
+	len += sprintf(buffer + len, "msgmax %d\n", msg_ctlmax);
+	len += sprintf(buffer + len, "msgmnb %d\n", msg_ctlmnb);
+	len += sprintf(buffer + len, "msgmni %d\n", msg_ctlmni);
+	len += sprintf(buffer + len, "msgssz %d\n", MSGSSZ);
+	len += sprintf(buffer + len, "msgtql %d\n", MSGTQL);
+	len += sprintf(buffer + len, "msgseg %d\n", MSGSEG);
+	down(&msg_ids.sem);
+	ids = msg_ids.in_use;
+	hdrs = atomic_read(&msg_hdrs);
+	bytes = atomic_read(&msg_bytes);
+	up(&msg_ids.sem);
+	len += sprintf(buffer + len, "used_ids %d\n", ids);
+	len += sprintf(buffer + len, "msg_hdrs %d\n", hdrs);
+	len += sprintf(buffer + len, "msg_bytes %d\n", bytes);
+
+	return len;
+}
 #endif
diff -ruN linux-2.6.7-orig/ipc/sem.c linux-2.6.7/ipc/sem.c
--- linux-2.6.7-orig/ipc/sem.c	2004-06-16 01:19:13.000000000 -0400
+++ linux-2.6.7/ipc/sem.c	2004-06-28 15:16:27.812864200 -0400
@@ -88,6 +88,7 @@
 static void freeary (struct sem_array *sma, int id);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset,
int length, int *eof, void *data);
+static int sysvipc_seminfo_read_proc(char *buffer, char **start, off_t
offset, int length, int *eof, void *data);
 #endif
 
 #define SEMMSL_FAST	256 /* 512 bytes on stack */
@@ -117,6 +118,7 @@
 
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/sem", 0, 0, sysvipc_sem_read_proc,
NULL);
+	create_proc_read_entry("sysvipc/seminfo", 0, 0,
sysvipc_seminfo_read_proc, NULL);
 #endif
 }
 
@@ -1330,4 +1332,29 @@
 		len = 0;
 	return len;
 }
+
+static int sysvipc_seminfo_read_proc(char *buffer, char **start, off_t
offset, int length, int *eof, void *data)
+{
+	int len = 0;
+	int ids, sems;
+
+	len += sprintf(buffer + len, "semmap %d\n", SEMMAP);
+	len += sprintf(buffer + len, "semmni %d\n", sc_semmni);
+	len += sprintf(buffer + len, "semmns %d\n", sc_semmns);
+	len += sprintf(buffer + len, "semmnu %d\n", SEMMNU);
+	len += sprintf(buffer + len, "semmsl %d\n", sc_semmsl);
+	len += sprintf(buffer + len, "semopm %d\n", sc_semopm);
+	len += sprintf(buffer + len, "semume %d\n", SEMUME);
+	len += sprintf(buffer + len, "semusz %d\n", SEMUSZ);
+	len += sprintf(buffer + len, "semvmx %d\n", SEMVMX);
+	len += sprintf(buffer + len, "semaem %d\n", SEMAEM);
+	down(&sem_ids.sem);
+	ids = sem_ids.in_use;
+	sems = used_sems;
+	up(&sem_ids.sem);
+	len += sprintf(buffer + len, "used_ids %d\n", ids);
+	len += sprintf(buffer + len, "used_sems %d\n", sems);
+
+	return len;
+}
 #endif
diff -ruN linux-2.6.7-orig/ipc/shm.c linux-2.6.7/ipc/shm.c
--- linux-2.6.7-orig/ipc/shm.c	2004-06-16 01:19:23.000000000 -0400
+++ linux-2.6.7/ipc/shm.c	2004-06-28 15:21:32.768503896 -0400
@@ -48,6 +48,7 @@
 static void shm_close (struct vm_area_struct *shmd);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset,
int length, int *eof, void *data);
+static int sysvipc_shminfo_read_proc(char *buffer, char **start, off_t
offset, int length, int *eof, void *data);
 #endif
 
 size_t	shm_ctlmax = SHMMAX;
@@ -61,6 +62,7 @@
 	ipc_init_ids(&shm_ids, 1);
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc,
NULL);
+	create_proc_read_entry("sysvipc/shminfo", 0, 0,
sysvipc_shminfo_read_proc, NULL);
 #endif
 }
 
@@ -893,4 +895,28 @@
 		len = 0;
 	return len;
 }
+
+static int sysvipc_shminfo_read_proc(char *buffer, char **start, off_t
offset, int length, int *eof, void *data)
+{
+	int len = 0;
+	int ids;
+	unsigned long tot, rss, swp;
+
+	len += sprintf(buffer + len, "shmmax %lu\n", (unsigned
long)shm_ctlmax);
+	len += sprintf(buffer + len, "shmmin %lu\n", (unsigned long)SHMMIN);
+	len += sprintf(buffer + len, "shmmni %lu\n", (unsigned
long)shm_ctlmni);
+	len += sprintf(buffer + len, "shmseg %lu\n", (unsigned
long)shm_ctlmni);
+	len += sprintf(buffer + len, "shmall %lu\n", (unsigned
long)shm_ctlall);
+	down(&shm_ids.sem);
+	ids = shm_ids.in_use;
+	tot = shm_tot;
+	shm_get_stat(&rss, &swp);
+	up(&shm_ids.sem);
+	len += sprintf(buffer + len, "used_ids %d\n", ids);
+	len += sprintf(buffer + len, "shm_tot %lu\n", tot);
+	len += sprintf(buffer + len, "shm_rss %lu\n", rss);
+	len += sprintf(buffer + len, "shm_swp %lu\n", swp);
+
+	return len;
+}
 #endif
