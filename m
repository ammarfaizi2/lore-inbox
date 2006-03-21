Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWCUOSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWCUOSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWCUOSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:18:10 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:37085 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030400AbWCUOSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:18:09 -0500
Date: Tue, 21 Mar 2006 09:18:06 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] SELinux - add slab cache for inode security struct
Message-ID: <Pine.LNX.4.64.0603210916260.9206@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a slab cache for the SELinux inode security struct, one of 
which is allocated for every inode instantiated by the system.

The memory savings are considerable.

On 64-bit, instead of the size-128 cache, we have a slab object of 96 
bytes, saving 32 bytes per object.  After booting, I see about 4000 of 
these and then about 17,000 after a kernel compile.  With this patch, we 
save around 530KB of kernel memory in the latter case.  On 32-bit, the 
savings are about half of this.

Please apply.

Signed-off-by: James Morris <jmorris@namei.org>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

---
  
  security/selinux/hooks.c |   10 ++++++++--
  1 files changed, 8 insertions(+), 2 deletions(-)
  

diff -purN -X dontdiff linux-2.6.16/security/selinux/hooks.c linux-2.6.16.w/security/selinux/hooks.c
--- linux-2.6.16/security/selinux/hooks.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16.w/security/selinux/hooks.c	2006-03-20 20:14:19.000000000 -0500
@@ -117,6 +117,8 @@ static struct security_operations *secon
 static LIST_HEAD(superblock_security_head);
 static DEFINE_SPINLOCK(sb_security_lock);
 
+static kmem_cache_t *sel_inode_cache;
+
 /* Allocate and free functions for each kind of security blob. */
 
 static int task_alloc_security(struct task_struct *task)
@@ -146,10 +148,11 @@ static int inode_alloc_security(struct i
 	struct task_security_struct *tsec = current->security;
 	struct inode_security_struct *isec;
 
-	isec = kzalloc(sizeof(struct inode_security_struct), GFP_KERNEL);
+	isec = kmem_cache_alloc(sel_inode_cache, SLAB_KERNEL);
 	if (!isec)
 		return -ENOMEM;
 
+	memset(isec, 0, sizeof(*isec));
 	init_MUTEX(&isec->sem);
 	INIT_LIST_HEAD(&isec->list);
 	isec->inode = inode;
@@ -172,7 +175,7 @@ static void inode_free_security(struct i
 	spin_unlock(&sbsec->isec_lock);
 
 	inode->i_security = NULL;
-	kfree(isec);
+	kmem_cache_free(sel_inode_cache, isec);
 }
 
 static int file_alloc_security(struct file *file)
@@ -4376,6 +4379,9 @@ static __init int selinux_init(void)
 	tsec = current->security;
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 
+	sel_inode_cache = kmem_cache_create("selinux_inode_security",
+					    sizeof(struct inode_security_struct),
+					    0, SLAB_PANIC, NULL, NULL);
 	avc_init();
 
 	original_ops = secondary_ops = security_ops;
