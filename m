Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWDGSvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWDGSvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWDGSsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:43 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:1680
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964875AbWDGSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 7/7] stacking support for capability module
Date: Fri, 7 Apr 2006 21:46:53 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
In-Reply-To: <200604072124.24000.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072146.53572.edwin@gurde.com>
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

Adds stacking support to capability module. Without this patch, I have to boot 
with capability.disable=1 to get fireflier registered as security module.

What is current status of stacking support, how should LSM's handle stacking 
with the capability module?


---
 capability.c |  114 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commoncap.c  |   10 ++++-
 2 files changed, 123 insertions(+), 1 deletion(-)
diff -uprN -X vanilla/linux-2.6.16/Documentation/dontdiff 
vanilla/linux-2.6.16/security/capability.c linux-2.6.16/security/capability.c
--- vanilla/linux-2.6.16/security/capability.c	2006-03-20 18:29:57.000000000 
+0200
+++ linux-2.6.16/security/capability.c	2006-04-07 16:32:43.000000000 +0300
@@ -24,6 +24,104 @@
 #include <linux/ptrace.h>
 #include <linux/moduleparam.h>
 
+/* stacking support */
+struct security_operations *cap_original_ops = NULL;
+extern struct security_operations *cap_secondary_ops;
+
+int cap_stack_bprm_alloc_security(struct linux_binprm *bprm)
+{
+  return cap_secondary_ops->bprm_alloc_security(bprm);
+}
+
+void cap_stack_bprm_free_security(struct linux_binprm *bprm)
+{  	
+  return cap_secondary_ops->bprm_free_security(bprm);
+}
+
+void cap_stack_bprm_post_apply_creds(struct linux_binprm *bprm)
+{
+  return cap_secondary_ops->bprm_post_apply_creds(bprm);
+}
+void cap_stack_inode_free_security(struct inode *inode)
+{
+  return cap_secondary_ops->inode_free_security(inode);
+}
+
+int cap_stack_inode_getsecurity(struct inode *inode, const char *name, void 
*buffer, size_t size, int err)
+{
+  return cap_secondary_ops->inode_getsecurity(inode,name,buffer,size,err);
+}
+
+int cap_stack_inode_listsecurity(struct inode *inode, char *buffer, size_t 
buffer_size)
+{
+  return cap_secondary_ops->inode_listsecurity(inode,buffer,buffer_size);
+}
+
+
+int cap_stack_file_receive(struct file* file)
+{
+  return cap_secondary_ops->file_receive(file);
+}
+
+int cap_stack_task_alloc_security(struct task_struct *task)
+{
+   if(cap_secondary_ops)
+     return cap_secondary_ops->task_alloc_security(task);
+   else return 0;
+}
+
+void cap_stack_task_free_security(struct task_struct *task)
+{
+  return cap_secondary_ops->task_free_security(task);
+}
+
+void cap_stack_socket_post_create(struct socket *sock, int family,
+					 int type, int protocol, int kern)
+{
+  return 
cap_secondary_ops->socket_post_create(sock,family,type,protocol,kern);
+}
+
+int cap_stack_socket_accept(struct socket *sock, struct socket *newsock)
+{
+  return cap_secondary_ops->socket_accept(sock,newsock);
+}
+
+
+
+int cap_stack_register_security (const char *name, struct security_operations 
*ops)
+{
+	if (cap_secondary_ops != cap_original_ops)
+	{
+		printk(KERN_INFO "%s:  There is already a secondary security "
+		       "module registered.\n", __FUNCTION__);
+		return -EINVAL;
+	}
+	
+	cap_secondary_ops = ops;
+	
+	printk(KERN_INFO "%s:  Registering secondary module %s\n",
+	       __FUNCTION__,
+	       name);
+	
+	return 0;
+}
+
+static int cap_stack_unregister_security (const char *name, struct 
security_operations *ops)
+{
+        if (ops != cap_secondary_ops)
+        {
+                printk (KERN_INFO "%s:  trying to unregister a security 
module "
+                        "that is not registered.\n", __FUNCTION__);
+                return -EINVAL;
+        }
+
+        cap_secondary_ops = cap_original_ops;
+
+        return 0;
+}
+
+
+
 static struct security_operations capability_ops = {
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
@@ -47,6 +145,20 @@ static struct security_operations capabi
 	.syslog =                       cap_syslog,
 
 	.vm_enough_memory =             cap_vm_enough_memory,
+	/* for stacking */
+	.bprm_alloc_security  	= cap_stack_bprm_alloc_security,
+	.bprm_free_security  	= cap_stack_bprm_free_security,
+	.bprm_post_apply_creds  = cap_stack_bprm_post_apply_creds,
+	.inode_free_security 	= cap_stack_inode_free_security,
+    	.inode_getsecurity 	= cap_stack_inode_getsecurity,
+   	.inode_listsecurity 	= cap_stack_inode_listsecurity,
+	.file_receive 		= cap_stack_file_receive,
+	.task_alloc_security 	= cap_stack_task_alloc_security,
+	.task_free_security 	= cap_stack_task_free_security,
+	.socket_post_create 	= cap_stack_socket_post_create,
+	.socket_accept 		= cap_stack_socket_accept,
+	.register_security 	= cap_stack_register_security,
+	.unregister_security 	= cap_stack_unregister_security,
 };
 
 /* flag to keep track of how we were registered */
@@ -58,6 +170,7 @@ MODULE_PARM_DESC(disable, "To disable ca
 
 static int __init capability_init (void)
 {
+        cap_original_ops = cap_secondary_ops = security_ops;
 	if (capability_disable) {
 		printk(KERN_INFO "Capabilities disabled at initialization\n");
 		return 0;
@@ -100,3 +213,4 @@ module_exit (capability_exit);
 
 MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
 MODULE_LICENSE("GPL");
+
diff -uprN -X vanilla/linux-2.6.16/Documentation/dontdiff 
vanilla/linux-2.6.16/security/commoncap.c linux-2.6.16/security/commoncap.c
--- vanilla/linux-2.6.16/security/commoncap.c	2006-03-20 18:29:57.000000000 
+0200
+++ linux-2.6.16/security/commoncap.c	2006-04-07 15:48:21.000000000 +0300
@@ -25,6 +25,9 @@
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
 
+
+struct security_operations *cap_secondary_ops = NULL;
+
 int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	NETLINK_CB(skb).eff_cap = current->cap_effective;
@@ -135,7 +138,9 @@ int cap_bprm_set_security (struct linux_
 		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
 	}
-	return 0;
+       if(cap_secondary_ops)
+	return cap_secondary_ops->bprm_set_security(bprm);
+       else return 0;
 }
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
@@ -179,6 +184,8 @@ void cap_bprm_apply_creds (struct linux_
 	/* AUD: Audit candidate if current->cap_effective is set */
 
 	current->keep_capabilities = 0;
+        if(cap_secondary_ops)
+          cap_secondary_ops->bprm_apply_creds(bprm,unsafe);
 }
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
@@ -341,6 +349,7 @@ EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
 EXPORT_SYMBOL(cap_vm_enough_memory);
+EXPORT_SYMBOL(cap_secondary_ops);
 
 MODULE_DESCRIPTION("Standard Linux Common Capabilities Security Module");
 MODULE_LICENSE("GPL");
