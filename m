Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWDGSvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWDGSvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWDGSsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:41 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:2192
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964874AbWDGSsg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 2/7] implementation of LSM hooks
Date: Fri, 7 Apr 2006 21:38:34 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
In-Reply-To: <200604072124.24000.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604072138.35201.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of the LSM hooks. It is based on hooks.c from SELinux. 
I replaced the avc with calls to functions from autolabel.c

Also, one important difference:
- when open files are checked during an execve, they are NOT closed when a 
domain transition occurs to a different sid. A group SID is created, and both 
the old sid, and new sids can be retrieved later.

How could I write an SELinux policy that does this?


---
 hooks.c      |  669 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 structures.h |   76 ++++++
 2 files changed, 745 insertions(+)

diff -uprN null/hooks.c fireflier_lsm/hooks.c
--- null/hooks.c	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/hooks.c	2006-04-07 17:43:37.000000000 +0300
@@ -0,0 +1,669 @@
+
+/*
+ *  Fireflier security labeling module
+ *
+ *
+ *  This file contains the Fireflier hook function implementations.
+ *
+ *  Based on the SELinux hooks.c
+ *
+ *  The Fireflier security module won't deny any operations
+ *  Its sole purpose is to label processes, and files, so that the sk_filter 
context match
+ *  will be able to do context matching without selinux being active
+ *
+ *  You shouldn't use SELinux and Fireflier LSM at the same time 
+ *  You can either have:
+ *   - Having SELinux compiled in your kernel, and disabled at boot, and 
fireflier enabled at boot /loaded as a module  
+ *   - Having SELinux compiled in your kernel, and enabled at boot, and 
fireflier disabled on boot/not loaded.
+ *	
+ *  Currently you have to turn off the capability module 
(capability.disable=1 on boot). See README for details
+ *
+ *  Copyright (C) 2006 Török Edwin <edwin@gurde.com>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2,
+ *      as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/security.h>
+
+#include <linux/mount.h>
+#include <linux/xattr.h>
+#include <net/sock.h>
+#include "fireflier_debug.h"
+#include "constants.h"
+#include "structures.h"
+#include "autolabel.h"
+
+//TODO: document all these functions here
+
+/* Original (dummy) security module. */
+static struct security_operations *original_ops = NULL;
+static struct security_operations *secondary_ops = NULL;
+static struct security_operations dummy_security_ops;
+
+
+#define XATTR_FIREFLIER_SUFFIX "fireflier"
+#define XATTR_NAME_FIREFLIER XATTR_SECURITY_PREFIX XATTR_FIREFLIER_SUFFIX
+
+
+/* module stacking operations */
+/**
+ * fireflier_register_security - register a stacked security module
+ * @name: the name of the secondary security module to register
+ * @ops:  the stacked module's security_operations 
+ */
+static int fireflier_register_security (const char *name, struct 
security_operations *ops)
+{
+        if (secondary_ops != original_ops)
+        {
+                printk(KERN_INFO "%s:  There is already a secondary 
security "
+                       "module registered.\n", __FUNCTION__);
+                return -EINVAL;
+        }
+	
+        secondary_ops = ops;
+	
+        printk(KERN_INFO "%s:  Registering secondary module %s\n",
+               __FUNCTION__,
+               name);
+
+        return 0;
+}
+
+/**
+ * fireflier_unregister_security - unregister a stacked security 
+ * @name: the name of the secondary security module to unregister
+ * @ops:  the security_operations of the stacked module
+ */
+static int fireflier_unregister_security (const char *name, struct 
security_operations *ops)
+{
+        if (ops != secondary_ops)
+        {
+                printk (KERN_INFO "%s:  trying to unregister a security 
module "
+                        "that is not registered.\n", __FUNCTION__);
+                return -EINVAL;
+        }
+
+        secondary_ops = original_ops;
+
+        return 0;
+}
+
+
+/**
+ * task_alloc_security - allocate the security structure for a task
+ * @task: the task to allocate the security structure for
+ * Allocates and initializes the security structure of a task.
+ * Returns -ENOMEM in case of an allocation failure.
+ * This function might sleep.
+ */
+static int task_alloc_security(struct task_struct *task)
+{
+	struct fireflier_task_security_struct *tsec;
+	
+	tsec = kzalloc(sizeof(*tsec), GFP_ATOMIC);
+	if (!tsec)
+		return -ENOMEM;
+	
+	tsec->magic = FIREFLIER_MAGIC;
+	tsec->task = task;
+	tsec->osid = tsec->sid = tsec->ptrace_sid = FIREFLIER_SID_UNLABELED;
+	task->security = tsec;
+	
+	return 0;
+}
+
+/**
+ * task_free_security - free the security structure of a task
+ */
+static void task_free_security(struct task_struct *task)
+{
+	struct fireflier_task_security_struct *tsec = task->security;
+	
+	if (!tsec || tsec->magic != FIREFLIER_MAGIC)
+		return;
+	
+	task->security = NULL;
+	kfree(tsec);
+}
+
+/**
+ * fireflier_task_alloc_security - allocate & initialize the security 
structure of tsk from current
+ * @tsk: the task who's security context needs to be initialized
+ * In case of allocation failure returns -ENOMEM
+ * otherwise calls secondary security module.
+ * Might sleep.
+ */
+static int fireflier_task_alloc_security(struct task_struct *tsk)
+{
+	struct fireflier_task_security_struct *tsec_current, *tsec_tsk;
+
+
+	int rc;
+	rc = task_alloc_security(tsk);
+	if (rc)
+		return rc;
+	tsec_current = current->security;
+	if(tsec_current) {
+		tsec_tsk = tsk->security;
+
+		tsec_tsk->sid = tsec_current->sid;
+		tsec_tsk->osid = tsec_current->osid;
+		/* Retain ptracer SID across fork, if any.
+		   This will be reset by the ptrace hook upon any
+		   subsequent ptrace_attach operations. */
+		tsec_tsk->ptrace_sid = tsec_current->ptrace_sid;
+	}
+	//else printk(KERN_DEBUG "current has no security info\n");
+	return secondary_ops->task_alloc_security(tsk);
+}
+
+
+/**
+ * fireflier_bprm_alloc_security - allocate & initialize a linux_bprm 
structure
+ * @bprm: the linux_bprm structure to initialize
+ * Returns -ENOMEM on allocation failure, otherwise calls stacked security 
module.
+ * Might sleep.
+ */
+static int fireflier_bprm_alloc_security(struct linux_binprm *bprm)
+{
+	struct fireflier_bprm_security_struct *bsec;
+
+	bsec = kzalloc(sizeof(*bsec), GFP_KERNEL);
+	if (!bsec)
+		return -ENOMEM;
+
+	bsec->magic = FIREFLIER_MAGIC;
+	bsec->bprm = bprm;
+	bsec->sid = FIREFLIER_SID_UNLABELED;
+	bsec->set = 0;
+
+	bprm->security = bsec;
+	
+	return secondary_ops->bprm_alloc_security(bprm);
+}
+
+/**
+ * fireflier_bprm_set_security - Sets the SID of bprm
+ * @bprm: linux_bprm structure, its SID will be calculated here
+ * This is where the (autolabeling) sid generation function is called, i.e.
+ * this function is responsible for computing the SID of the process that is 
going to be executed
+ * Calls secondary security module.
+ * Can this sleep?
+ */
+static int fireflier_bprm_set_security(struct linux_binprm *bprm)
+{
+	struct fireflier_bprm_security_struct *bsec;
+
+	bsec = bprm->security;
+	if(unlikely(!bsec)) {
+		printk(KERN_DEBUG "Fireflier: bprm->security not set\n");
+		return  secondary_ops->bprm_set_security(bprm);
+	}
+		
+	if (bsec->set)
+		return  secondary_ops->bprm_set_security(bprm);
+
+
+	bsec->sid = get_or_generate_sid(bprm->file,0);
+        printk(KERN_DEBUG "sid:%d\n",bsec->sid);
+	bsec->set = 1;
+	return  secondary_ops->bprm_set_security(bprm);
+}
+
+/**
+ * fireflier_bprm_free_security - free the binbprm's security structure
+ * @bprm: linux_binprm structure, who's security structure is to be freed
+ */
+static void fireflier_bprm_free_security(struct linux_binprm *bprm)
+{
+	BUG_ON(!bprm->security);
+	kfree(bprm->security);
+	bprm->security = NULL;
+	return secondary_ops->bprm_free_security(bprm);
+}
+
+/**
+ * fireflier_bprm_apply_creds - compute the sid of the current task based on 
bprm
+ * @bprm: linux_binprm structure
+ * @unsafe: reasons why the transition might be unsafe
+ * Compute the sid of a process being transformed by an execve operation
+ */
+static void fireflier_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
+{
+	struct fireflier_task_security_struct *tsec;
+	struct fireflier_bprm_security_struct *bsec;
+	u32 sid;
+
+
+	secondary_ops->bprm_apply_creds(bprm, unsafe);
+
+	tsec = current->security;
+	bsec = bprm->security;
+	if(unlikely(!bsec)) {
+		printk(KERN_DEBUG "No bprm security structure allocated\n");
+		dump_stack();
+		return;
+	}
+	sid = bsec->sid;
+
+
+	bsec->unsafe = 0;
+	if(unlikely(!tsec)) {
+		printk(KERN_DEBUG "No security structure allocated\n");
+		dump_stack();
+		return;
+	}
+	if (tsec->sid != sid) {
+		/* hmmm unsafe&ptrace stuff.... need to think over this a bit*/
+		if(unsafe & (LSM_UNSAFE_SHARE | LSM_UNSAFE_PTRACE|LSM_UNSAFE_PTRACE_CAP)) 
+		{	   
+		
+			printk(KERN_DEBUG "marking SID as unsafe\n");
+			bsec->unsafe=unsafe;
+		}
+	   
+		tsec->sid = sid;
+	}	
+}
+
+
+/**
+ * inode_update_perm - update the group SID of this inode
+ * @tsk - the task that has accesses the inode
+ * @inode - the inode who's SID has to be updated
+ * A task has accessed this file, add the task's SID to the group SID of 
tasks
+ * accessing the file
+ * based on inode_has_perm 
+ */
+static void inode_update_perm(struct task_struct *tsk,struct inode *inode)
+{
+	struct fireflier_task_security_struct *tsec;
+	struct fireflier_inode_security_struct *isec;
+
+     	tsec = tsk->security;
+   	isec = inode->i_security;
+   	if(!isec) 
+     		return;
+   
+     	if(unlikely(!tsec))
+       		isec->sid = compute_inode_sid(isec->sid,FIREFLIER_SID_UNLABELED);
+   	else
+     		isec->sid = compute_inode_sid(isec->sid,tsec->sid);
+   	printk(KERN_DEBUG "computed inode 
sid: %ld->%d\n",inode->i_ino,isec->sid);   
+}
+
+
+
+/** 
+ * file_update_perm - update the group SID of this file
+ * @tsk - the task that has accessed the file
+ * @file - the file that has been accessed
+ * A task has accessed this file, add the task's SID to the group SID of 
tasks
+ * accessing the file
+ * Based on file_has_perm 
+ */
+static  inline void file_update_perm(struct task_struct *tsk, struct file 
*file)    
+{
+   
+	struct fireflier_task_security_struct *tsec = tsk->security;
+	struct fireflier_file_security_struct *fsec = file->f_security;
+	struct dentry *dentry = file->f_dentry;
+	struct inode *inode = dentry->d_inode;
+   
+	inode_update_perm(tsk, inode);
+   
+	if(!fsec)
+		return;
+	if(unlikely(!tsec))
+		fsec->sid=compute_inode_sid(fsec->sid,FIREFLIER_SID_UNLABELED);
+	else
+		fsec->sid=compute_inode_sid(fsec->sid,tsec->sid);
+}
+
+
+  
+ 
+/** 
+ * update_files_auth - update the group SID of the files
+ * @files - a files_struct containing all files of the forked process
+ * Derived from fs/exec.c:flush_old_files. 
+ *  Should deal only with sockets 
+ */
+static inline void update_files_auth(struct files_struct * files)  
+{
+   
+   
+	struct file *file;
+	struct fdtable *fdt;
+	long j = -1;
+  
+	/* Revalidate access to inherited open files. */
+	spin_lock(&files->file_lock);
+	for (;;) 
+	{
+		unsigned long set, i;
+	
+		j++;
+		i = j * __NFDBITS;
+		fdt = files_fdtable(files);
+		if (i >= fdt->max_fds || i >= fdt->max_fdset)
+			break;
+		set = fdt->open_fds->fds_bits[j];
+		if (!set)
+			continue;
+		spin_unlock(&files->file_lock);
+		for ( ; set ; i++,set >>= 1) 
+		{
+			if (set & 1) 
+			{
+				file = fget(i);
+				if (!file)
+					continue;
+				file_update_perm(current,file);
+				fput(file);
+			}
+		}
+		spin_lock(&files->file_lock);
+	}
+	spin_unlock(&files->file_lock);
+}
+
+	 
+/**
+ * fireflier_bprm_post_apply_creds - updates files' SID
+ * @bprm - a linux_bprm structure
+ * update the security field of bprm
+ */
+static void fireflier_bprm_post_apply_creds(struct linux_binprm *bprm)
+{
+	struct fireflier_task_security_struct *tsec = current->security;
+	struct fireflier_bprm_security_struct *bsec  = bprm->security;
+	secondary_ops->bprm_post_apply_creds(bprm);
+	
+	if(bsec->unsafe) 
+	{
+	
+		printk(KERN_DEBUG "computing unsafe SID\n");
+		tsec->sid = get_or_generate_unsafe_sid(tsec->sid,bsec->unsafe);
+	
+	}
+   
+	ff_debug_map_pidsid(tsec->sid);
+	if (tsec->osid == tsec->sid)
+		return;
+   	//SID changed, so update the files's SIDs, i.e. turn them into group SIDs
+	update_files_auth(current->files);
+}
+
+/**
+ * fireflier_inode_alloc_security - allocate the security structure of an 
inode
+ * @inode - inode
+ * allocate the security field of inode
+ */
+static int inode_alloc_security(struct inode *inode)
+{
+	struct fireflier_task_security_struct *tsec = current->security;
+	struct fireflier_inode_security_struct *isec;
+	     
+	isec = kzalloc(sizeof(struct fireflier_inode_security_struct), GFP_KERNEL);
+	if (!isec)
+		return -ENOMEM;
+	     
+	INIT_LIST_HEAD(&isec->list);
+	isec->magic = FIREFLIER_MAGIC;
+	isec->inode = inode;
+	//isec->sclass = SECCLASS_FILE;
+	if (tsec && tsec->magic == FIREFLIER_MAGIC)
+		isec->sid = tsec->sid;
+	else
+		isec->sid = FIREFLIER_SID_UNLABELED;
+	inode->i_security = isec;
+	return 0;
+}
+	
+/**
+ * fireflier_inode_free_security - free the security structure of the inode
+ * @inode - inode
+ * free the security field of inode
+ */
+static void fireflier_inode_free_security(struct inode *inode)
+{
+	struct fireflier_inode_security_struct *isec = inode->i_security;
+//	struct fireflier_superblock_security_struct *sbsec = 
inode->i_sb->s_security;
+	     
+	secondary_ops->inode_free_security(inode);
+	if (!isec || isec->magic != FIREFLIER_MAGIC)// || !sbsec)
+		return;
+	     
+//	spin_lock(&sbsec->isec_lock);
+	if (!list_empty(&isec->list))
+		list_del_init(&isec->list);
+//	spin_unlock(&sbsec->isec_lock);
+	     
+	inode->i_security = NULL;
+	kfree(isec);
+}
+
+static int fireflier_socket_accept(struct socket *sock, struct socket 
*newsock)
+{
+	struct fireflier_inode_security_struct *isec = SOCK_INODE(sock)->i_security;        
+        struct inode* newinode = SOCK_INODE(newsock);
+	struct fireflier_inode_security_struct *newisec;
+   
+        inode_alloc_security(newinode);
+   
+        newisec = newinode->i_security;    
+        newisec->sid = isec->sid;
+   
+	return secondary_ops->socket_accept(sock,newsock);
+}
+	
+/** fireflier_file_receive - file received (via SysV IPC?)
+ * update group SID of file
+ */
+
+static int fireflier_file_receive(struct file* file)
+{
+	file_update_perm(current,file);
+	return secondary_ops->file_receive(file);
+}
+
+/*
+ * Copy the in-core inode security context value to the user.  If the
+ * getxattr() prior to this succeeded, check to see if we need to
+ * canonicalize the value to be finally returned to the user.
+ *
+ * Permission check is handled by selinux_inode_getxattr hook.
+ */
+static int fireflier_inode_getsecurity(struct inode *inode, const char *name, 
void *buffer, size_t size, int err)
+{
+	struct fireflier_inode_security_struct *isec = inode->i_security;
+	char *context=NULL;/* required!*/
+	unsigned len;
+	int rc;
+
+	if (strcmp(name, XATTR_FIREFLIER_SUFFIX) || !isec) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+     
+	rc = fireflier_sid_to_context(isec->sid, &context, &len);
+	if (rc)
+		goto out;
+
+	/* Probe for required buffer size */
+	if (!buffer || !size) {
+		rc = len;
+		goto out_free;
+	}
+
+	if (size < len) {
+		rc = -ERANGE;
+		goto out_free;
+	}
+
+	if (err > 0) {
+		if ((len == err) && !(memcmp(context, buffer, len))) {
+			/* Don't need to canonicalize value */
+			rc = err;
+			goto out_free;
+		}
+		memset(buffer, 0, size);
+	}
+	memcpy(buffer, context, len);
+	rc = len;
+ out_free:
+	kfree(context);
+ out:
+	return secondary_ops->inode_getsecurity(inode,name,buffer,size,err);
+}
+
+static int fireflier_inode_listsecurity(struct inode *inode, char *buffer, 
size_t buffer_size)
+{
+	if(inode->i_security) 
+	{
+	
+		const int len = sizeof(XATTR_NAME_FIREFLIER);
+		if (buffer && len <= buffer_size)
+			memcpy(buffer, XATTR_NAME_FIREFLIER, len);
+		return len+
+			secondary_ops->inode_listsecurity(inode,buffer+len,buffer_size-len);
+	}
+	else 
+		return 0;
+   
+
+}
+
+static void fireflier_socket_post_create(struct socket *sock, int family,
+					 int type, int protocol, int kern)
+{
+	struct fireflier_inode_security_struct *isec;
+	struct fireflier_task_security_struct *tsec = current->security;
+        struct inode* inode=SOCK_INODE(sock);
+   
+	secondary_ops->socket_post_create(sock,family,type,protocol,kern);
+	
+        inode_alloc_security(inode);
+	isec = inode->i_security;
+   
+	isec->sid = kern ? FIREFLIER_SECINITSID_KERNEL : tsec->sid;
+		
+	return;
+}
+
+/**
+ * fireflier_ops - our security_operations hooks
+ * Unused security hooks will be automatically redirected to the dummy 
security module
+ * Does the dummy module call the secondary module? Maybe we should implement 
all the hooks, and call
+ * the secondary module
+ */
+static struct security_operations fireflier_ops =
+{
+	.bprm_alloc_security  	= fireflier_bprm_alloc_security,
+	.bprm_free_security  	= fireflier_bprm_free_security,
+	.bprm_apply_creds  	= fireflier_bprm_apply_creds,
+	.bprm_post_apply_creds  = fireflier_bprm_post_apply_creds,
+	.bprm_set_security 	= fireflier_bprm_set_security,
+	.inode_free_security 	= fireflier_inode_free_security,
+    	.inode_getsecurity 	= fireflier_inode_getsecurity,
+   	.inode_listsecurity 	= fireflier_inode_listsecurity,
+	.file_receive 		= fireflier_file_receive,
+	.task_alloc_security 	= fireflier_task_alloc_security,
+	.task_free_security 	= task_free_security,
+	.socket_post_create 	= fireflier_socket_post_create,
+	.socket_accept 		= fireflier_socket_accept,
+	.register_security 	= fireflier_register_security,
+	.unregister_security 	= fireflier_unregister_security,
+};
+
+/**
+ * stacked - is a secondary module registered
+ */
+static int stacked=0;
+
+/**
+ * label_all_processes - labels already running processes
+ * Can this be done at all? Or do we need to have fireflier loaded during 
boot?
+ */
+static void label_all_processes(void)
+{
+	/* Labeling running processes without using the task_lock seems not possible 
for now*/
+        /* TODO: label processes that are already running */
+        /* TODO: prevent processes from being spawned while we label the 
running ones */
+	/* TODO Priority:Low, it works without this too */
+}
+
+/**
+ * fireflier_cleanup - Cleans up fireflier module
+ * Unregisters security module
+ */
+static void __exit fireflier_cleanup(void)
+{
+	if(stacked) {
+		if(mod_unreg_security("fireflier",&fireflier_ops))
+			printk(KERN_ERR "Fireflier: Error unregistering stacked security module.
\n");
+	}
+	else
+		if(unregister_security(&fireflier_ops))
+			printk(KERN_ERR "Fireflier: Error unregistering security module.\n");
+}
+
+int ff_debug;
+module_param(ff_debug,int,0);
+MODULE_PARM_DESC(ff_debug,"Enable debug info dumping in debugfs");
+/**
+ * fireflier_init - module loading initialization
+ * Registers fireflier as primary or secondary security module
+ */
+static int __init fireflier_init(void)
+{
+        /*Register security_ops with kernel*/
+        int err;
+
+        original_ops = security_ops;
+        /* initialize dummy_security_ops to dummy ops */
+        register_security(&dummy_security_ops);
+        unregister_security(&dummy_security_ops);
+        secondary_ops = &dummy_security_ops;//avoid recursion with capability 
module
+        if (!secondary_ops) {
+                printk (KERN_ERR "Fireflier: No initial security 
operations\n");
+                return -EAGAIN;
+        }
+        if ((err=register_security (&fireflier_ops))) {
+                printk(KERN_INFO "Fireflier: Unable to register as primary 
security module. Attempting to register as stacked security module\n");
+                stacked=1;
+                if((err=mod_reg_security("fireflier",&fireflier_ops))) {
+                        printk(KERN_ERR "Fireflier: Unable to register with 
kernel.\n");
+                        return err;
+                }
+        }
+        else
+                stacked=0;
+        /* Do initialization */
+	if((err=autolabel_init())) {
+		printk(KERN_ERR "Fireflier: autolabeling initialization failed (OOM?)\n");
+		fireflier_cleanup();
+		return err;
+	}
+        label_all_processes();
+	
+	/* Debugging stuff */
+	ff_debug_startup();
+	
+        return 0;
+}
+
+security_initcall(fireflier_init);
+module_exit(fireflier_cleanup);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Török Edwin <edwin@gurde.com>");
+MODULE_DESCRIPTION("Fireflier security module");
+MODULE_VERSION("0.01");
+
diff -uprN null/structures.h fireflier_lsm/structures.h
--- null/structures.h	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/structures.h	2006-04-07 14:41:30.000000000 +0300
@@ -0,0 +1,76 @@
+/*
+ *  Fireflier security labeling module
+ *
+ *
+ *  This file contains the Fireflier hook function implementations.
+ *
+ *  Based on the SELinux hooks.c
+ *
+ *  Copyright (C) 2006 Török Edwin <edwin@gurde.com>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2,
+ *      as published by the Free Software Foundation.
+ */
+#ifndef _FF_STRUCTURES_H_
+#define _FF_STRUCTURES_H_
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include "constants.h"
+/* Structures copied from SELinux, and prefixed with fireflier_ to avoid 
conflicts
+ * I don't want to use SELinux internal structures.
+ */ 
+ 
+ 
+struct fireflier_task_security_struct {
+	unsigned long magic;           /* magic number for this module */
+	struct task_struct *task;      /* back pointer to task object */
+	u32 sid;             /* current SID */
+	u32 osid;	     /* SID prior to execve */
+	u32 ptrace_sid;      /* SID of ptrace parent */
+};
+
+struct fireflier_inode_security_struct {
+	unsigned long magic;           /* magic number for this module */
+	struct inode *inode;           /* back pointer to inode object */
+	struct list_head list;         /* list of inode_security_struct */
+	u32 task_sid;        /* SID of creating task */
+	u32 sid;             /* SID of this object */
+	u16 sclass;       /* security class of this object */
+	unsigned char initialized;     /* initialization flag */
+	unsigned char inherit;         /* inherit SID from parent entry */
+};
+
+struct fireflier_file_security_struct {
+	unsigned long magic;            /* magic number for this module */
+	struct file *file;              /* back pointer to file object */
+	u32 sid;              /* SID of open file description */
+	u32 fown_sid;         /* SID of file owner (for SIGIO) */
+};
+
+struct fireflier_bprm_security_struct {
+	unsigned long magic;           /* magic number for this module */
+	struct linux_binprm *bprm;     /* back pointer to bprm object */
+	u32 sid;                       /* SID for transformed process */
+	unsigned char set;
+
+	/*
+	 * unsafe is used to share failure information from bprm_apply_creds()
+	 * to bprm_post_apply_creds().
+	 */
+	char unsafe;
+};
+/**
+ * getsid_safe - returns the SID, safe to be called with a  NULL pointer
+ * @tsec: a task's security structure to get the SID from, it can be NULL
+ */
+static inline u32 getsid_safe(const struct fireflier_task_security_struct* 
tsec)
+{
+	if(likely(tsec))
+		return tsec->sid;
+	else
+		return FIREFLIER_SID_UNLABELED;
+}
+
+#endif
