Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317711AbSGPADY>; Mon, 15 Jul 2002 20:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSGPADX>; Mon, 15 Jul 2002 20:03:23 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:15887 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317711AbSGPADT>;
	Mon, 15 Jul 2002 20:03:19 -0400
Date: Mon, 15 Jul 2002 17:05:24 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM setup changes for 2.5.25
Message-ID: <20020716000523.GE32262@kroah.com>
References: <20020715093021.B26472@figure1.int.wirex.com> <20020716000311.GC32262@kroah.com> <20020716000502.GD32262@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716000502.GD32262@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 17 Jun 2002 22:50:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.640   -> 1.641  
#	           ipc/sem.c	1.9     -> 1.10   
#	           ipc/shm.c	1.11    -> 1.12   
#	 include/linux/shm.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/15	greg@kroah.com	1.641
# LSM: move struct shmid_kernel out of ipc/shm.c to include/linux/shm.h
# 
# Also move where we set sma->sem_perm.mode and .key to before ipc_addid() gets called.
# --------------------------------------------
#
diff -Nru a/include/linux/shm.h b/include/linux/shm.h
--- a/include/linux/shm.h	Mon Jul 15 16:50:02 2002
+++ b/include/linux/shm.h	Mon Jul 15 16:50:02 2002
@@ -71,6 +71,19 @@
 };
 
 #ifdef __KERNEL__
+struct shmid_kernel /* private to the kernel */
+{	
+	struct kern_ipc_perm	shm_perm;
+	struct file *		shm_file;
+	int			id;
+	unsigned long		shm_nattch;
+	unsigned long		shm_segsz;
+	time_t			shm_atim;
+	time_t			shm_dtim;
+	time_t			shm_ctim;
+	pid_t			shm_cprid;
+	pid_t			shm_lprid;
+};
 
 /* shm_mode upper byte flags */
 #define	SHM_DEST	01000	/* segment will be destroyed on last detach */
diff -Nru a/ipc/sem.c b/ipc/sem.c
--- a/ipc/sem.c	Mon Jul 15 16:50:02 2002
+++ b/ipc/sem.c	Mon Jul 15 16:50:02 2002
@@ -129,15 +129,16 @@
 		return -ENOMEM;
 	}
 	memset (sma, 0, size);
+
+	sma->sem_perm.mode = (semflg & S_IRWXUGO);
+	sma->sem_perm.key = key;
+
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
 		ipc_free(sma, size);
 		return -ENOSPC;
 	}
 	used_sems += nsems;
-
-	sma->sem_perm.mode = (semflg & S_IRWXUGO);
-	sma->sem_perm.key = key;
 
 	sma->sem_base = (struct sem *) &sma[1];
 	/* sma->sem_pending = NULL; */
diff -Nru a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	Mon Jul 15 16:50:02 2002
+++ b/ipc/shm.c	Mon Jul 15 16:50:02 2002
@@ -28,20 +28,6 @@
 
 #include "util.h"
 
-struct shmid_kernel /* private to the kernel */
-{	
-	struct kern_ipc_perm	shm_perm;
-	struct file *		shm_file;
-	int			id;
-	unsigned long		shm_nattch;
-	unsigned long		shm_segsz;
-	time_t			shm_atim;
-	time_t			shm_dtim;
-	time_t			shm_ctim;
-	pid_t			shm_cprid;
-	pid_t			shm_lprid;
-};
-
 #define shm_flags	shm_perm.mode
 
 static struct file_operations shm_file_operations;
@@ -193,6 +179,10 @@
 	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp), GFP_USER);
 	if (!shp)
 		return -ENOMEM;
+
+	shp->shm_perm.key = key;
+	shp->shm_flags = (shmflg & S_IRWXUGO);
+
 	sprintf (name, "SYSV%08x", key);
 	file = shmem_file_setup(name, size);
 	error = PTR_ERR(file);
@@ -203,8 +193,7 @@
 	id = shm_addid(shp);
 	if(id == -1) 
 		goto no_id;
-	shp->shm_perm.key = key;
-	shp->shm_flags = (shmflg & S_IRWXUGO);
+
 	shp->shm_cprid = current->pid;
 	shp->shm_lprid = 0;
 	shp->shm_atim = shp->shm_dtim = 0;
