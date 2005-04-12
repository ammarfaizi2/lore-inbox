Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVDLUgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVDLUgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbVDLUfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:35:45 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:46310 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S262554AbVDLS5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:57:14 -0400
Subject: [PATCH] SELinux:  cleanup ipc_has_perm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 12 Apr 2005 14:48:39 -0400
Message-Id: <1113331719.25217.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the sclass argument from ipc_has_perm in the
SELinux module, as it can be obtained from the ipc security structure.
The use of a separate argument was a legacy of the older precondition
function handling in SELinux and is obsolete.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

---

 security/selinux/hooks.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

===== security/selinux/hooks.c 1.95 vs edited =====
--- 1.95/security/selinux/hooks.c	2005-04-01 16:30:16 -05:00
+++ edited/security/selinux/hooks.c	2005-04-08 10:37:42 -04:00
@@ -3666,7 +3666,7 @@ static void msg_msg_free_security(struct
 }
 
 static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
-			u16 sclass, u32 perms)
+			u32 perms)
 {
 	struct task_security_struct *tsec;
 	struct ipc_security_struct *isec;
@@ -3678,7 +3678,7 @@ static int ipc_has_perm(struct kern_ipc_
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(tsec->sid, isec->sid, sclass, perms, &ad);
+	return avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -3763,7 +3763,7 @@ static int selinux_msg_queue_msgctl(stru
 		return 0;
 	}
 
-	err = ipc_has_perm(&msq->q_perm, SECCLASS_MSGQ, perms);
+	err = ipc_has_perm(&msq->q_perm, perms);
 	return err;
 }
 
@@ -3915,7 +3915,7 @@ static int selinux_shm_shmctl(struct shm
 		return 0;
 	}
 
-	err = ipc_has_perm(&shp->shm_perm, SECCLASS_SHM, perms);
+	err = ipc_has_perm(&shp->shm_perm, perms);
 	return err;
 }
 
@@ -3934,7 +3934,7 @@ static int selinux_shm_shmat(struct shmi
 	else
 		perms = SHM__READ | SHM__WRITE;
 
-	return ipc_has_perm(&shp->shm_perm, SECCLASS_SHM, perms);
+	return ipc_has_perm(&shp->shm_perm, perms);
 }
 
 /* Semaphore security operations */
@@ -4023,7 +4023,7 @@ static int selinux_sem_semctl(struct sem
 		return 0;
 	}
 
-	err = ipc_has_perm(&sma->sem_perm, SECCLASS_SEM, perms);
+	err = ipc_has_perm(&sma->sem_perm, perms);
 	return err;
 }
 
@@ -4037,18 +4037,13 @@ static int selinux_sem_semop(struct sem_
 	else
 		perms = SEM__READ;
 
-	return ipc_has_perm(&sma->sem_perm, SECCLASS_SEM, perms);
+	return ipc_has_perm(&sma->sem_perm, perms);
 }
 
 static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
-	struct ipc_security_struct *isec = ipcp->security;
-	u16 sclass = SECCLASS_IPC;
 	u32 av = 0;
 
-	if (isec && isec->magic == SELINUX_MAGIC)
-		sclass = isec->sclass;
-
 	av = 0;
 	if (flag & S_IRUGO)
 		av |= IPC__UNIX_READ;
@@ -4058,7 +4053,7 @@ static int selinux_ipc_permission(struct
 	if (av == 0)
 		return 0;
 
-	return ipc_has_perm(ipcp, sclass, av);
+	return ipc_has_perm(ipcp, av);
 }
 
 /* module stacking operations */

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

