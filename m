Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVG0TM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVG0TM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVG0TJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:09:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51609 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262418AbVG0S2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:28:34 -0400
Date: Wed, 27 Jul 2005 13:28:48 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 15/15] lsm stacking v0.3: stacking for digsig
Message-ID: <20050727182848.GP22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support stacking in digsig.  This patch is on top of the cvs version from
www.sf.net/projects/disec.

	[Jul 16] Update to support dynamic unloading by freeing
		object->security data at unload.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 digsig.c |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 128 insertions(+), 14 deletions(-)

--- digsig/digsig.c	2005-07-06 08:41:38.000000000 -0500
+++ digsig-patched/digsig.c	2005-07-25 16:08:36.000000000 -0500
@@ -33,6 +33,7 @@
 #include <linux/fs.h>
 #include <asm/uaccess.h>
 #include <linux/security.h>
+#include <linux/security-stack.h>
 #include <linux/dcache.h>
 #include <linux/kobject.h>
 #include <linux/mman.h>
@@ -47,6 +48,8 @@
 #include "gnupg/mpi/mpi.h"
 #include "gnupg/cipher/rsa-verify.h"
 
+#define DIGSIG_LSM_ID 0x5AA8
+
 #ifdef DIGSIG_DEBUG
 #define DIGSIG_MODE 0		/*permissive  mode */
 #define DIGSIG_BENCH 1
@@ -55,11 +58,11 @@
 #define DIGSIG_BENCH 0
 #endif
 
-#define get_inode_security(ino) ((unsigned long)(ino->i_security))
-#define set_inode_security(ino,val) (ino->i_security = (void *)val)
-
-#define get_file_security(file) ((unsigned long)(file->f_security))
-#define set_file_security(file,val) (file->f_security = (void *)val)
+struct digsig_ksec {
+	struct security_list lsm_list;
+	struct list_head chain;
+	unsigned count;
+};
 
 unsigned long int total_jiffies = 0;
 
@@ -82,6 +85,73 @@ int dsi_cache_buckets = 128;
 module_param(dsi_cache_buckets, int, 0);
 MODULE_PARM_DESC(dsi_cache_buckets, "Number of cache buckets for signatures validations.\n");
 
+LIST_HEAD(digsig_del_chain);
+DEFINE_SPINLOCK(digsig_chain_lock);
+
+static int get_file_security(struct file *file)
+{
+	struct digsig_ksec *ksec;
+
+	ksec = security_get_value_type(&file->f_security, DIGSIG_LSM_ID,
+				struct digsig_ksec);
+	if (!ksec)
+		return 0;
+	return ksec->count;
+}
+
+static int set_file_security(struct file *file, int v)
+{
+	struct digsig_ksec *ksec;
+
+	ksec = security_get_value_type(&file->f_security, DIGSIG_LSM_ID,
+				struct digsig_ksec);
+	if (!ksec) {
+		ksec = kmalloc(sizeof(struct digsig_ksec), GFP_KERNEL);
+		if (!ksec)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&ksec->chain);
+		spin_lock(&digsig_chain_lock);
+		list_add_rcu(&ksec->chain, &digsig_del_chain);
+		spin_unlock(&digsig_chain_lock);
+		security_add_value_type(&file->f_security, DIGSIG_LSM_ID,
+				 ksec);
+	}
+	ksec->count = v;
+	return 0;
+}
+
+
+static int get_inode_security(struct inode *inode)
+{
+	struct digsig_ksec *ksec;
+
+	ksec = security_get_value_type(&inode->i_security, DIGSIG_LSM_ID,
+				struct digsig_ksec);
+	if (!ksec)
+		return 0;
+	return ksec->count;
+}
+
+static int set_inode_security(struct inode *inode, int v)
+{
+	struct digsig_ksec *ksec;
+
+	ksec = security_get_value_type(&inode->i_security, DIGSIG_LSM_ID,
+				struct digsig_ksec);
+	if (!ksec) {
+		ksec = kmalloc(sizeof(struct digsig_ksec), GFP_KERNEL);
+		if (!ksec)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&ksec->chain);
+		spin_lock(&digsig_chain_lock);
+		list_add(&ksec->chain, &digsig_del_chain);
+		spin_unlock(&digsig_chain_lock);
+		security_add_value_type(&inode->i_security, DIGSIG_LSM_ID,
+				 ksec);
+	}
+	ksec->count = v;
+	return 0;
+}
 
 /******************************************************************************
 Description : 
@@ -342,18 +412,22 @@ static int digsig_deny_write_access(stru
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	unsigned long isec;
+	int err;
 
 	spin_lock(&inode->i_lock);
 	isec = get_inode_security(inode);
 	if (atomic_read(&inode->i_writecount) > 0) {
-		spin_unlock(&inode->i_lock);
-		return -ETXTBSY;
+		err = -ETXTBSY;
+		goto out;
 	}
 	set_inode_security(inode, (isec+1));
-	set_file_security(file, 1);
-	spin_unlock(&inode->i_lock);
+	err = set_file_security(file, 1);
+	if (err)
+		set_inode_security(inode, (isec));
 
-	return 0;
+out:
+	spin_unlock(&inode->i_lock);
+	return err;
 }
 
 /*
@@ -379,9 +453,17 @@ static void digsig_allow_write_access(st
  */
 static void digsig_file_free_security(struct file *file)
 {
-	if (file->f_security) {
-		digsig_allow_write_access(file);
-	}
+	struct digsig_ksec *ksec;
+
+	ksec = security_get_value_type(&file->f_security, DIGSIG_LSM_ID,
+				struct digsig_ksec);
+	if (!ksec)
+		return;
+
+	spin_lock(&digsig_chain_lock);
+	list_del(&ksec->chain);
+	spin_unlock(&digsig_chain_lock);
+	kfree(ksec);
 }
 
 /**
@@ -530,7 +612,7 @@ static inline int is_unprotected_file(st
 			__FUNCTION__, file->f_dentry->d_name.name, exec_time); \
 	}
 	
-static int digsig_file_mmap(struct file * file, unsigned long prot, unsigned long flags)
+static int digsig_file_mmap(struct file * file, unsigned long reqprot, unsigned long prot, unsigned long flags)
 {
 	struct elf64_hdr *elf64_ex;
 	struct elf32_hdr *elf32_ex;
@@ -668,8 +750,20 @@ static int digsig_file_mmap(struct file 
 
 static void digsig_inode_free_security(struct inode *inode)
 {
+	struct digsig_ksec *ksec;
+
 	if (is_cached_signature(inode))
 		remove_signature(inode);
+
+	ksec = security_del_value_type(&inode->i_security, DIGSIG_LSM_ID,
+				struct digsig_ksec);
+	if (!ksec)
+		return;
+
+	spin_lock(&digsig_chain_lock);
+	list_del(&ksec->chain);
+	spin_unlock(&digsig_chain_lock);
+	kfree(ksec);
 }
 
 static struct security_operations digsig_security_ops = {
@@ -715,6 +809,25 @@ out:
 	return ret;
 }
 
+static void digsig_free_secchain(void)
+{
+	struct digsig_ksec *ksec, *n;
+
+	list_for_each_entry_safe(ksec, n, &digsig_del_chain, chain) {
+		printk(KERN_NOTICE "free_ichain unlinking %u, %d, %lu\n",
+			ksec->count, ksec->lsm_list.security_id,
+			(unsigned long)ksec->lsm_list.list.pprev);
+		security_unlink_value(&ksec->lsm_list.list);
+	}
+
+	synchronize_rcu();
+	list_for_each_entry_safe(ksec, n, &digsig_del_chain, chain) {
+		printk(KERN_NOTICE "free_ichain freeing 1\n");
+		list_del(&ksec->chain);
+		kfree(ksec);
+	}
+}
+
 static void __exit digsig_exit_module(void)
 {
 	DSM_PRINT (DEBUG_INIT, "Deinitializing module\n");
@@ -734,6 +847,7 @@ static void __exit digsig_exit_module(vo
 	digsig_cleanup_sysfs();
 	digsig_cleanup_revocation();
 	digsig_cache_cleanup();
+	digsig_free_secchain();
 	mpi_free(digsig_public_key[0]);
 	mpi_free(digsig_public_key[1]);
 }
