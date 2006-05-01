Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWEANus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWEANus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWEANur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:50:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:11738 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932104AbWEANup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:50:45 -0400
Date: Mon, 1 May 2006 15:50:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 4/4] MultiAdmin module
In-Reply-To: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0605011549460.31804@yvahk01.tjqt.qr>
References: <20060417162345.GA9609@infradead.org>
 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1511487256-1146491421=:31804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1511487256-1146491421=:31804
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


[PATCH 4/4] MultiAdmin module

    -   Add the MultiAdmin to the mainline tree.
        I hope the rest is self-explanatory.

Please do not mention CodingStyle for multiadm.c. I already know it. :)
And I will get to it should it really be merged.


Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/security/Kconfig linux-2.6.17-rc3+/security/Kconfig
--- linux-2.6.17-rc3~/security/Kconfig	2006-05-01 12:47:01.382832000 +0200
+++ linux-2.6.17-rc3+/security/Kconfig	2006-05-01 15:04:08.482832000 +0200
@@ -99,6 +99,22 @@ config SECURITY_SECLVL
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_MULTIADM
+    tristate "MultiAdmin secuirty module"
+    depends on SECURITY
+    ---help---
+        The MultiAdmin security kernel module provides means to have multiple
+        "root" users with unique UIDs. This fixes collation order problems
+        which for example appear with NSCD, allows to have files with
+        determinable owner and allows to track the quota usage for every
+        user, since they now have a unique uid.
+        
+        It also implements a "sub-admin", a partially restricted root user
+        (or enhanced normal user, depending on the way you see it), who has
+        full read-only access to most subsystems, and additional write rights
+        only to a limited subset, e.g. writing to files or killing processes
+        only of certain users.
+
 source security/selinux/Kconfig
 
 endmenu
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/security/Makefile linux-2.6.17-rc3+/security/Makefile
--- linux-2.6.17-rc3~/security/Makefile	2006-05-01 12:47:01.382832000 +0200
+++ linux-2.6.17-rc3+/security/Makefile	2006-05-01 15:04:08.482832000 +0200
@@ -17,3 +17,4 @@ obj-$(CONFIG_SECURITY_SELINUX)		+= selin
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
 obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
+obj-$(CONFIG_SECURITY_MULTIADM)		+= commoncap.o multiadm.o
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/security/loadme linux-2.6.17-rc3+/security/loadme
--- linux-2.6.17-rc3~/security/loadme	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc3+/security/loadme	2006-05-01 15:16:27.662832000 +0200
@@ -0,0 +1,6 @@
+#!/bin/bash
+
+rmmod multiadm;
+modprobe commoncap;
+insmod ./multiadm.ko Supergid=0 Subuid_start=4000 \
+	Subuid_end=4000 Wrtuid_start=4003 Wrtuid_end=4004;
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/security/multiadm.c linux-2.6.17-rc3+/security/multiadm.c
--- linux-2.6.17-rc3~/security/multiadm.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc3+/security/multiadm.c	2006-05-01 15:39:13.042832000 +0200
@@ -0,0 +1,618 @@
+/*=============================================================================
+| MultiAdmin Security Module                                                  |
+| Copyright © Jan Engelhardt <jengelh [at] gmx de>, 2005 - 2006               |
+| v1.0.5, May 2006                                                            |
+| http://alphagate.hopto.org/                                                 |
+`-----------------------------------------------------------------------------'
+
+    This program is free software; you can redistribute it and/or
+    modify it under the terms of the GNU General Public License
+    version 2 as published by the Free Software Foundation.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+    General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program kit; if not, write to:
+    Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
+    Boston, MA  02110-1301  USA
+=============================================================================*/
+#include <asm/siginfo.h>
+#include <linux/binfmts.h>
+#include <linux/capability.h>
+#include <linux/config.h>
+#include <linux/dcache.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/ipc.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/namei.h>
+#include <linux/sched.h>
+#include <linux/securebits.h>
+#include <linux/security.h>
+#include <linux/sem.h>
+#include <linux/types.h>
+
+#if !defined(CONFIG_SECURITY_CAPABILITIES) && \
+    !defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
+#        error You need to have CONFIG_SECURITY_CAPABILITIES=y or =m \
+               for MultiAdmin to compile successfully.
+#endif
+
+#define BASENAME "multiadm"
+#define PREFIX BASENAME ": "
+
+/*
+This typedef is used to mark functions a littile without interfering
+with the ABI:
+    bool for  0=failure, !0=success
+    int  for  0=success, <0=failure, >0=failure or some val
+    int  for  0=eof,     <0=failure, >0=value
+*/
+typedef int bool;
+
+static int mt_bprm_set_security(struct linux_binprm *);
+static int mt_cap_extra(int);
+static int mt_inode_permission(struct inode *, int, struct nameidata *);
+static int mt_inode_setattr(struct dentry *, struct iattr *);
+static int mt_ipc_permission(struct kern_ipc_perm *, short);
+static int mt_msq_msgctl(struct msg_queue *, int);
+static int mt_ptrace(task_t *, task_t *);
+static int mt_quotactl(int, int, int, struct super_block *);
+static int mt_sem_semctl(struct sem_array *, int);
+static int mt_shm_shmctl(struct shmid_kernel *, int);
+static int mt_task_kill(task_t *, struct siginfo *, int);
+static int mt_task_post_setuid(uid_t, uid_t, uid_t, int);
+static int mt_task_post_setgid(gid_t, gid_t, gid_t, int);
+static int mt_task_setnice(task_t *, int);
+static int mt_task_setscheduler(task_t *, int, struct sched_param *);
+static int mt_task_setuid(uid_t, uid_t, uid_t, int);
+
+static inline void chg2_superadm(kernel_cap_t *);
+static inline void chg2_subadm(kernel_cap_t *);
+static inline void chg2_netadm(kernel_cap_t *);
+static inline bool is_any_superadm(uid_t, gid_t);
+static inline bool is_uid_superadm(uid_t);
+static inline bool is_gid_superadm(gid_t);
+static inline bool is_any_subadm(uid_t, gid_t);
+static inline bool is_uid_subadm(uid_t);
+static inline bool is_gid_subadm(gid_t);
+static inline bool is_uid_netadm(uid_t);
+static inline bool is_uid_user(uid_t);
+static inline bool is_task1_user(const task_t *);
+static inline bool is_task_user(const task_t *);
+static inline bool range_intersect(uid_t, uid_t, uid_t, uid_t);
+static inline bool range_intersect_wrt(uid_t, uid_t, uid_t, uid_t);
+
+static struct security_operations mt_secops = {
+    .bprm_apply_creds      = cap_bprm_apply_creds,
+    .bprm_set_security     = mt_bprm_set_security,
+    .cap_extra             = mt_cap_extra,
+    .capable               = cap_capable,
+    .capget                = cap_capget,
+    .capset_check          = cap_capset_check,
+    .capset_set            = cap_capset_set,
+    .inode_permission      = mt_inode_permission,
+    .inode_setattr         = mt_inode_setattr,
+    .ipc_permission        = mt_ipc_permission,
+    .msg_queue_msgctl      = mt_msq_msgctl,
+    .ptrace                = mt_ptrace,
+    .quotactl              = mt_quotactl,
+    .sem_semctl            = mt_sem_semctl,
+    .shm_shmctl            = mt_shm_shmctl,
+    .task_kill             = mt_task_kill,
+    .task_post_setuid      = mt_task_post_setuid,
+    .task_post_setgid      = mt_task_post_setgid,
+    .task_setnice          = mt_task_setnice,
+    .task_setscheduler     = mt_task_setscheduler,
+    .task_setuid           = mt_task_setuid,
+};
+static gid_t Supergid = -1, Subgid = -1;
+static uid_t Superuid_start = 0,  Superuid_end = 0,
+             Subuid_start   = -1, Subuid_end   = -1,
+             Netuid         = -1,
+             Wrtuid_start   = -1, Wrtuid_end   = -1;
+static int Secondary = 0;
+
+MODULE_DESCRIPTION("MultiAdmin Security Module; http://alphagate.hopto.org/");
+MODULE_AUTHOR("Jan Engelhardt <jengelh [at] gmx de>");
+MODULE_LICENSE("GPL");
+module_param(Supergid,       int, S_IRUSR | S_IWUSR);
+module_param(Superuid_start, int, S_IRUSR | S_IWUSR);
+module_param(Superuid_end,   int, S_IRUSR | S_IWUSR);
+module_param(Subuid_start,   int, S_IRUSR | S_IWUSR);
+module_param(Subuid_end,     int, S_IRUSR | S_IWUSR);
+module_param(Subgid,         int, S_IRUSR | S_IWUSR);
+module_param(Netuid,         int, S_IRUSR | S_IWUSR);
+module_param(Wrtuid_start,   int, S_IRUGO | S_IWUSR);
+module_param(Wrtuid_end,     int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(Wrtuid_start,   "First UID of the write-enabled user range");
+MODULE_PARM_DESC(Wrtuid_end,     "Last UID of the write-enabled user range");
+MODULE_PARM_DESC(Superuid_start, "First UIDs of the superadmin range");
+MODULE_PARM_DESC(Superuid_end,   "Last UID of the superadmin range");
+MODULE_PARM_DESC(Supergid,       "Superadmin GID");
+MODULE_PARM_DESC(Subuid_start,   "First UIDs of the subadmin range");
+MODULE_PARM_DESC(Subuid_end,     "Last UID of the subadmin range");
+MODULE_PARM_DESC(Subgid,         "Subadmin GID");
+MODULE_PARM_DESC(Netuid,         "Netadmin UID");
+
+//-----------------------------------------------------------------------------
+__init static int multiadm_init(void) {
+    int eax = 0, ebx = 0;
+    if((eax = register_security(&mt_secops)) != 0) {
+        if((ebx = mod_reg_security(BASENAME, &mt_secops)) != 0) {
+            printk(KERN_WARNING PREFIX
+            "Could not register with kernel: %d, %d\n", eax, ebx);
+            return ebx;
+        }
+        Secondary = 1;
+    }
+
+    if(range_intersect(Superuid_start, Superuid_end, Subuid_start, Subuid_end))
+        printk(KERN_WARNING PREFIX
+          "Superadmin and Subadmin ranges intersect! Unpredictable behavior"
+          " may result: some operations may classify you as a superadmin,"
+          " others as a subadmin. Security leak: subadmin could possibly"
+          " change into superadmin!\n"
+        );
+    if(range_intersect(Superuid_start, Superuid_end, Netuid, Netuid))
+        printk(KERN_WARNING PREFIX "Netuid within superadmin range! -Has more "
+               "powers than intended!\n");
+    if(range_intersect(Superuid_start, Superuid_end, Wrtuid_start, Wrtuid_end))
+        printk(KERN_WARNING PREFIX "Superadmin and write-enabled user range "
+               "intersect! A subadmin could setuid() into a superadmin!\n");
+    if(range_intersect(Subuid_start, Subuid_end, Netuid, Netuid))
+        printk(KERN_WARNING PREFIX "Netuid within subadmin range! -Has more "
+               "powers than intended!\n");
+    if(range_intersect_wrt(Subuid_start, Subuid_end, Wrtuid_start, Wrtuid_end))
+        printk(KERN_WARNING PREFIX "Subadmin and write-enabled user range "
+               "intersect! Subadmins are able to poke on other subadmins!\n");
+    if(range_intersect_wrt(Netuid, Netuid, Wrtuid_start, Wrtuid_end))
+        printk(KERN_WARNING PREFIX "Netuid within write-enabled user range! "
+               "Subadmin may gain CAP_NET_ADMIN!\n");
+    printk(KERN_INFO "MultiAdmin loaded\n");
+    return 0;
+}
+
+__exit static void multiadm_exit(void) {
+    int ret = 0;
+
+    if(Secondary)
+        ret = mod_unreg_security(BASENAME, &mt_secops);
+    else
+        ret = unregister_security(&mt_secops);
+
+    if(ret != 0)
+        printk(KERN_WARNING PREFIX
+               "Could not unregister with kernel: %d\n", ret);
+
+    return;
+}
+
+module_init(multiadm_init);
+module_exit(multiadm_exit);
+
+//-----------------------------------------------------------------------------
+static int mt_bprm_set_security(struct linux_binprm *bp) {
+    /* In the function chain of exec(), we eventually get here, which is the
+    place to set up new privileges. */
+    cap_bprm_set_security(bp);
+
+    /* All of the following is nicely inlined. The capability raising is
+    resolved to only one instruction for each set. */
+    if(is_any_superadm(bp->e_uid, bp->e_gid)) {
+        chg2_superadm(&bp->cap_permitted);
+        chg2_superadm(&bp->cap_effective);
+    } else if(is_any_superadm(current->uid, current->gid)) {
+        chg2_superadm(&bp->cap_permitted);
+    } else if(is_any_subadm(bp->e_uid, bp->e_gid)) {
+        chg2_subadm(&bp->cap_permitted);
+        chg2_subadm(&bp->cap_effective);
+    } else if(is_any_subadm(current->uid, current->gid)) {
+        chg2_subadm(&bp->cap_permitted);
+    } else if(is_uid_netadm(bp->e_uid)) {
+        chg2_netadm(&bp->cap_permitted);
+        chg2_netadm(&bp->cap_effective);
+    } else if(is_uid_netadm(current->uid)) {
+        chg2_netadm(&bp->cap_permitted);
+    }
+    return 0;
+}
+
+static int mt_cap_extra(int capability) {
+    if(capability == CAP_SYS_ADMIN)
+        /* Subadmin also has CAP_SYS_ADMIN, but if we get here, we did so
+        by capable() -- not capable_light(). */
+        return is_any_superadm(current->euid, current->egid);
+    else
+        /* Subadmin/Netadmin also has other capabilities, but they
+        are -- I hope -- ok. */
+        return 1;
+}
+
+static int mt_inode_permission(struct inode *inode, int mask,
+ struct nameidata *nd)
+{
+    /* Check for superadmin is not done, since the only users that can get
+    here is either superadmin or subadmin. By omitting the check for
+    superadmin, only two comparisons need to be done for the subadmin case.
+    This method is done almost throughout the entire module. */
+
+    if(is_any_subadm(current->euid, current->egid) && (mask & MAY_WRITE)) {
+        int ret;
+        if(inode->i_uid == current->fsuid || is_uid_user(inode->i_uid))
+            return 0;
+
+        /* Since we practically jumped over the checks to get here (because of
+        CAP_DAC_OVERRIDE), we need to do it again. Without CAP_DAC_OVERRIDE
+        this time. Temporarily drop it. */
+        cap_lower(current->cap_effective, CAP_DAC_OVERRIDE);
+
+        // Copied from fs/namei.c
+        if(inode->i_op != NULL && inode->i_op->permission != NULL)
+            ret = inode->i_op->permission(inode, mask & ~MAY_APPEND, nd);
+        else
+            ret = generic_permission(inode, mask & ~MAY_APPEND, NULL);
+
+        cap_raise(current->cap_effective, CAP_DAC_OVERRIDE);
+        return ret;
+    }
+    return 0;
+}
+
+static int mt_inode_setattr(struct dentry *dentry, struct iattr *attr) {
+    if(is_any_subadm(current->euid, current->egid)) {
+        /* Change is only allowed if either the inode belongs to us, or does
+        belond, _and_ will belong in case of ATTR_UID, to a WRT user. */
+        const struct inode *inode = dentry->d_inode;
+        if(inode->i_uid != current->fsuid && !is_uid_user(inode->i_uid))
+            return -EPERM;
+
+        if((attr->ia_valid & ATTR_UID) && attr->ia_uid != current->fsuid &&
+         !is_uid_user(attr->ia_uid))
+                return -EPERM;
+    }
+    return 0;
+}
+
+static int mt_ipc_permission(struct kern_ipc_perm *perm, short flag) {
+    if(is_any_subadm(current->euid, current->egid)) {
+        int req, grant;
+
+        if(perm->uid == current->euid || perm->cuid == current->euid ||
+         is_uid_user(perm->uid) || is_uid_user(perm->cuid))
+                return 0;
+
+        /* Copied and modified from ipc/util.c. Subadmin always has read
+        permission so add S_IRUGO to granted. Checking the owner permission
+        part is not done anymore, because it is done above. */
+        req   = (flag >> 6) | (flag >> 3) | flag;
+        grant = (perm->mode | S_IRUGO) >> 3;
+        if(in_group_p(perm->gid) || in_group_p(perm->cgid))
+            grant >>= 3;
+        if(req & ~grant & 0007)
+            return -EPERM;
+    }
+    return 0;
+}
+
+static int mt_msq_msgctl(struct msg_queue *msq, int cmd) {
+    if(is_any_subadm(current->euid, current->egid)) {
+        if(cmd == MSG_INFO || cmd == MSG_STAT || cmd == IPC_INFO ||
+         cmd == IPC_STAT)
+                return 0;
+
+        // UID or CUID (creator UID) must fit
+        if(msq != NULL && msq->q_perm.uid != current->euid &&
+         msq->q_perm.cuid != current->euid && !is_uid_user(msq->q_perm.uid) &&
+         !is_uid_user(msq->q_perm.cuid))
+                return -EPERM;
+    }
+    return 0;
+}
+
+static int mt_ptrace(task_t *tracer, task_t *task) {
+    if(is_any_subadm(tracer->euid, tracer->egid)) {
+        /* Ownership check according to kernel/ptrace.c:
+        all of [RES][UG]ID must match the tracer's R[UG]ID. */
+        if(task->euid == tracer->uid && task->uid == tracer->uid &&
+         task->suid == tracer->uid && task->egid == tracer->gid &&
+         task->gid == tracer->gid && task->sgid == tracer->gid)
+                return 0;
+
+        // ...or all [RES]UIDs must match a WRT user
+        if(!is_task_user(task))
+            return -EPERM;
+    }
+    return 0;
+}
+
+static int mt_quotactl(int cmd, int type, int id, struct super_block *sb) {
+    if(is_any_subadm(current->euid, current->egid))
+        switch(cmd) {
+            case Q_SYNC:
+            case Q_GETFMT:
+            case Q_GETINFO:
+            case Q_GETQUOTA:
+            case Q_XGETQUOTA:
+            case Q_XGETQSTAT:
+            case Q_XQUOTASYNC:
+                return 0;
+            default:
+                return -EPERM;
+        }
+    return 0;
+}
+
+static int mt_sem_semctl(struct sem_array *sem, int cmd) {
+    if(is_any_subadm(current->euid, current->euid)) {
+        if(cmd == SEM_INFO || cmd == IPC_INFO || cmd == SEM_STAT)
+            return 0;
+        if(sem != NULL) {
+            const struct kern_ipc_perm *perm = &sem->sem_perm;
+            if(perm->uid != current->euid && perm->cuid != current->euid &&
+             !is_uid_user(perm->uid) && !is_uid_user(perm->cuid))
+                    return -EPERM;
+        }
+    }
+    return 0;
+}
+
+static int mt_shm_shmctl(struct shmid_kernel *shp, int cmd) {
+    if(is_any_subadm(current->euid, current->egid)) {
+        if(cmd == SHM_INFO || cmd == SHM_STAT ||
+         cmd == IPC_INFO || cmd == IPC_STAT)
+                return 0;
+        if(shp != NULL) {
+            const struct kern_ipc_perm *perm = &shp->shm_perm;
+            if(perm->uid != current->euid && perm->cuid != current->euid &&
+             !is_uid_user(perm->uid) && !is_uid_user(perm->cuid))
+                    return -EPERM;
+        }
+    }
+    return 0;
+}
+
+static int mt_task_kill(task_t *task, struct siginfo *si, int sig) {
+    if(is_any_subadm(current->euid, current->egid)) {
+        // As tricky as the ptrace() permission net.
+        if(is_uid_user(task->uid) || is_uid_user(task->suid))
+            return 0;
+
+        // Subadmin's own process
+        if(task->uid == current->euid || task->suid == current->euid ||
+         task->uid == current->uid || task->suid == current->uid)
+            return 0;
+
+        // SIG_IGN or a kernel-generated signal
+        if(si != NULL && ((long)si == 1 || (long)si == 2 || !SI_FROMUSER(si)))
+            return 0;
+
+        // For the case of a privileged subshell, but with the same tty
+        if(sig == SIGCONT && task->signal->session == current->signal->session)
+            return 0;
+
+        return -EPERM;
+    }
+    return 0;
+}
+
+static int mt_task_post_setuid(uid_t old_ruid, uid_t old_euid,
+ uid_t old_suid, int flags)
+{
+    int ret = cap_task_post_setuid(old_ruid, old_euid, old_suid, flags);
+    if(ret != 0)
+        return ret;
+
+    switch(flags) {
+        case LSM_SETID_ID:
+        case LSM_SETID_RE:
+        case LSM_SETID_RES:
+            // Unlike bprm_set_security(), effective must be set independently.
+            if(is_uid_superadm(current->uid))
+                chg2_superadm(&current->cap_permitted);
+            else if(is_uid_subadm(current->uid))
+                chg2_subadm(&current->cap_permitted);
+            else if(is_uid_netadm(current->uid))
+                chg2_netadm(&current->cap_permitted);
+
+            if(is_uid_superadm(current->euid))
+                chg2_superadm(&current->cap_effective);
+            else if(is_uid_subadm(current->euid))
+                chg2_subadm(&current->cap_effective);
+            else if(is_uid_netadm(current->euid))
+                chg2_netadm(&current->cap_effective);
+            break;
+    }
+    return 0;
+}
+
+static int mt_task_post_setgid(gid_t old_rgid, gid_t old_egid,
+ gid_t old_sgid, int flags)
+{
+    switch(flags) {
+        case LSM_SETID_ID:
+        case LSM_SETID_RE:
+        case LSM_SETID_RES:
+            if(is_gid_superadm(current->gid))
+                chg2_superadm(&current->cap_permitted);
+            else if(is_gid_subadm(current->gid))
+                chg2_subadm(&current->cap_permitted);
+
+            if(is_gid_superadm(current->egid))
+                chg2_superadm(&current->cap_effective);
+            else if(is_gid_subadm(current->egid))
+                chg2_subadm(&current->cap_effective);
+            break;
+    }
+    return 0;
+}
+
+static int mt_task_setuid(uid_t ruid, uid_t euid, uid_t suid, int flags) {
+    if(is_any_superadm(current->euid, current->egid))
+        return 0;
+
+    if(is_any_subadm(current->euid, current->egid))
+        if((ruid == -1 || is_uid_user(ruid)) && (euid == -1 ||
+         is_uid_user(euid)) && (suid == -1 || is_uid_user(suid)))
+                return 0;
+
+    switch(flags) {
+        case LSM_SETID_ID:
+            if(current->uid == ruid || current->suid == ruid)
+                return 0;
+            break;
+        case LSM_SETID_RE:
+            if(current->euid == ruid || current->euid == euid ||
+             current->uid == ruid || current->uid == euid ||
+             current->suid == euid)
+                    return 0;
+            break;
+        case LSM_SETID_RES:
+            if(current->euid == ruid || current->euid == euid ||
+             current->euid == suid || current->uid == ruid ||
+             current->uid == euid || current->uid == suid ||
+             current->suid == ruid || current->suid == euid ||
+             current->suid == suid)
+                    return 0;
+            break;
+        case LSM_SETID_FS:
+            if(current->euid == ruid)
+                return 0;
+            break;
+        default:
+            printk(KERN_WARNING PREFIX "Unsupported case %d in %s\n",
+                   flags, __FUNCTION__);
+            break;
+    }
+    return -EIO;
+}
+
+static int mt_task_setnice(task_t *task, int nice) {
+    if(is_any_subadm(current->euid, current->egid)) {
+        if(task->euid != current->euid && task->uid != current->euid &&
+         !is_task1_user(task))
+                return -EPERM;
+        if(nice < 0)
+                return -EACCES;
+    }
+    return 0;
+}
+
+static int mt_task_setscheduler(task_t *task, int policy,
+ struct sched_param *param)
+{
+    /* Return 0 for superuser and normal users. The latters' checks are
+    performed in sched.c. */
+    if(is_any_subadm(current->euid, current->egid)) {
+        // Copied from kernel/sched.c:sched_setscheduler()
+        if(task->policy != policy)
+            return -EPERM;
+
+        if(policy != SCHED_NORMAL && param->sched_priority > task->rt_priority &&
+         param->sched_priority > task->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
+                return -EPERM;
+
+        if(task->uid != current->euid && task->suid != current->euid &&
+         !is_task1_user(task))
+                return -EPERM;
+    }
+    return 0;
+}
+
+//-----------------------------------------------------------------------------
+static inline void chg2_superadm(kernel_cap_t *c) {
+    cap_set_full(*c);
+    cap_lower(*c, CAP_SETPCAP);
+    cap_lower(*c, 31); // currently unused
+    return;
+}
+
+static inline void chg2_subadm(kernel_cap_t *c) {
+    cap_clear(*c);
+    cap_raise(*c, CAP_CHOWN);
+    cap_raise(*c, CAP_DAC_OVERRIDE);
+    cap_raise(*c, CAP_DAC_READ_SEARCH);
+    cap_raise(*c, CAP_FOWNER);
+    cap_raise(*c, CAP_KILL);
+    cap_raise(*c, CAP_SETUID);
+    cap_raise(*c, CAP_IPC_OWNER);
+    cap_raise(*c, CAP_SYS_PTRACE);
+    cap_raise(*c, CAP_SYS_ADMIN);
+    cap_raise(*c, CAP_SYS_NICE);
+    return;
+}
+
+static inline void chg2_netadm(kernel_cap_t *c) {
+    cap_clear(*c);
+    cap_raise(*c, CAP_NET_ADMIN);
+    return;
+}
+
+static inline bool is_any_superadm(uid_t u, gid_t g) {
+    return is_uid_superadm(u) || is_gid_superadm(g);
+}
+
+static inline bool is_uid_superadm(uid_t u) {
+    return
+      (!issecure(SECURE_NOROOT) && u == 0) ||
+      (Superuid_start != -1 && Superuid_end != -1 &&
+      u >= Superuid_start && u <= Superuid_end);
+}
+
+static inline bool is_gid_superadm(gid_t g) {
+    return Supergid != -1 && g == Supergid;
+}
+
+static inline bool is_any_subadm(uid_t u, gid_t g) {
+    return is_uid_subadm(u) || is_gid_subadm(g);
+}
+
+static inline bool is_uid_subadm(uid_t u) {
+    return Subuid_start != -1 && Subuid_end != -1 &&
+           u >= Subuid_start && u <= Subuid_end;
+}
+
+static inline bool is_gid_subadm(gid_t g) {
+    return Subgid != -1 && g == Subgid;
+}
+
+static inline bool is_uid_netadm(uid_t u) {
+    return Netuid != -1 && u == Netuid;
+}
+
+static inline bool is_uid_user(uid_t u) {
+    /* Special case Wrtuid_end == (unsigned) -1 means what it means: everything
+    until the end. This is why there is no Wrtuid_end != -1 check. */
+    return Wrtuid_start != -1 && u >= Wrtuid_start && u <= Wrtuid_end;
+}
+
+static inline bool is_task1_user(const task_t *task) {
+    return is_uid_user(task->uid) || is_uid_user(task->suid);
+}
+
+static inline bool is_task_user(const task_t *task) {
+    return is_uid_user(task->euid) && is_uid_user(task->uid) &&
+           is_uid_user(task->suid);
+}
+
+static inline bool range_intersect(uid_t as, uid_t ae, uid_t bs, uid_t be) {
+    if(as == -1 || ae == -1 || bs == -1 || be == -1)
+        return 0;
+    return (long)ae >= (long)bs && (long)as <= (long)be;
+}
+
+static inline bool range_intersect_wrt(uid_t as, uid_t ae,
+ uid_t bs, uid_t be)
+{
+    if(as == -1 || ae == -1 || bs == -1)
+        return 0;
+    return (long)ae >= (long)bs && (long)as <= (long)be;
+}
+
+//=============================================================================
#<<eof>>


Jan Engelhardt
-- 
--1283855629-1511487256-1146491421=:31804--
