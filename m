Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUD2I3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUD2I3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUD2I3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:29:31 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:23937 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S263685AbUD2IZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:25:14 -0400
Message-ID: <4090BBDE.9020201@watson.ibm.com>
Date: Thu, 29 Apr 2004 04:25:02 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [PATCH 5/6] CKRM socket_class classtype
Content-Type: multipart/mixed;
 boundary="------------030104050409020801060509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030104050409020801060509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030104050409020801060509
Content-Type: text/plain;
 name="04-socketclass.ckrm-E12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-socketclass.ckrm-E12.patch"

diff -Nru a/include/linux/ckrm_net.h b/include/linux/ckrm_net.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm_net.h	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,41 @@
+/* ckrm_rc.h - Header file to be used by Resource controllers of CKRM
+ *
+ * Copyright (C) Vivek Kashyap , IBM Corp. 2004
+ * 
+ * Provides data structures, macros and kernel API of CKRM for 
+ * resource controllers.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef _LINUX_CKRM_NET_H
+#define _LINUX_CKRM_NET_H
+
+struct ckrm_sock_class;
+
+struct ckrm_net_struct {
+	int 		 ns_type;                    // type of net class
+	struct sock     *ns_sk;         // pointer to socket
+	pid_t            ns_tgid;       // real process id
+	pid_t            ns_pid;        // calling thread's pid
+	int              ns_family;     // IPPROTO_IPV4 || IPPROTO_IPV6
+					// Currently only IPV4 is supported
+	union {
+		__u32   ns_dipv4;       // V4 listener's address
+	} ns_daddr;
+	__u16 		ns_dport;       // listener's port
+	__u16 ns_sport;                 // sender's port
+	atomic_t ns_refcnt;
+	struct ckrm_sock_class 	*core;		
+	struct list_head       ckrm_link;
+};
+
+#define ns_daddrv4     ns_daddr.ns_dipv4
+
+#endif
diff -Nru a/kernel/ckrm/ckrm_sockc.c b/kernel/ckrm/ckrm_sockc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/ckrm/ckrm_sockc.c	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,554 @@
+/* ckrm_sock.c - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003,2004
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman,  IBM Corp. 2003
+ *	     (C) Vivek Kashyap,	IBM Corp. 2004
+ * 
+ * 
+ * Provides kernel API of CKRM for in-kernel,per-resource controllers 
+ * (one each for cpu, memory, io, network) and callbacks for 
+ * classification modules.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ * 06 Nov 2003
+ *        Made modifications to suit the new RBCE module.
+ * 10 Nov 2003
+ *        Fixed a bug in fork and exit callbacks. Added callbacks_active and
+ *        surrounding logic. Added task paramter for all CE callbacks.
+ * 23 Mar 2004
+ *        moved to referenced counted class objects and correct locking
+ * 12 Apr 2004
+ *        introduced adopted to emerging classtype interface
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <linux/mm.h>
+#include <asm/errno.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/ckrm_rc.h>
+#include <linux/parser.h>
+#include <net/tcp.h>
+
+#include <linux/ckrm_net.h>
+
+struct ckrm_sock_class {
+	struct ckrm_core_class core;
+};
+
+static struct ckrm_sock_class  sockclass_dflt_class = {
+};
+
+#define SOCKET_CLASS_TYPE_NAME  "socket_class"
+
+const char *dflt_sockclass_name = SOCKET_CLASS_TYPE_NAME;
+
+static struct ckrm_core_class *sock_alloc_class(struct ckrm_core_class *parent, const char *name);
+static int  sock_free_class(struct ckrm_core_class *core);
+
+static int  sock_forced_reclassify(ckrm_core_class_t *target, const char *resname);
+static int  sock_show_members(struct ckrm_core_class *core, struct seq_file *seq);
+static void sock_add_resctrl(struct ckrm_core_class *core, int resid);
+static void sock_reclassify_class(struct ckrm_sock_class *cls);
+
+struct ckrm_classtype CT_sockclass = {
+	.mfidx          = 1,
+	.name           = SOCKET_CLASS_TYPE_NAME,
+	.typeID         = CKRM_CLASSTYPE_SOCKET_CLASS, 
+	.maxdepth       = 3,                           
+	.resid_reserved = 0,                           
+	.max_res_ctlrs  = CKRM_MAX_RES_CTLRS,        
+	.max_resid      = 0,
+	.bit_res_ctlrs  = 0L,
+	.res_ctlrs_lock = SPIN_LOCK_UNLOCKED,
+	.classes        = LIST_HEAD_INIT(CT_sockclass.classes),
+
+	.default_class  = &sockclass_dflt_class.core,
+	
+	// private version of functions 
+	.alloc          = &sock_alloc_class,
+	.free           = &sock_free_class,
+	.show_members   = &sock_show_members,
+	.forced_reclassify = &sock_forced_reclassify,
+
+	// use of default functions 
+	.show_shares    = &ckrm_class_show_shares,
+	.show_stats     = &ckrm_class_show_stats,
+	.show_config    = &ckrm_class_show_config,
+	.set_config     = &ckrm_class_set_config,
+	.set_shares     = &ckrm_class_set_shares,
+	.reset_stats    = &ckrm_class_reset_stats,
+
+	// mandatory private version .. no dflt available
+	.add_resctrl    = &sock_add_resctrl,	
+};
+
+/* helper functions */
+
+void
+ckrm_ns_hold(struct ckrm_net_struct *ns)
+{
+        atomic_inc(&ns->ns_refcnt);
+        return;
+}
+
+void
+ckrm_ns_put(struct ckrm_net_struct *ns)
+{
+        if (atomic_dec_and_test(&ns->ns_refcnt))
+                kfree(ns);
+
+        return;
+}
+/*
+ * Change the class of a netstruct 
+ *
+ * Change the task's task class  to "newcls" if the task's current 
+ * class (task->taskclass) is same as given "oldcls", if it is non-NULL.
+ *
+ */
+
+static void
+sock_set_class(struct ckrm_net_struct *ns, struct ckrm_sock_class *newcls,
+	      struct ckrm_sock_class *oldcls, enum ckrm_event event)
+{
+	int i;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype;
+	void  *old_res_class, *new_res_class;
+
+	if ((newcls == oldcls) || (newcls == NULL)) {
+		ns->core = (void *)oldcls;
+		return;
+	}
+
+	class_lock(class_core(newcls));
+	ns->core = newcls;
+	list_add(&ns->ckrm_link, &class_core(newcls)->objlist);
+	class_unlock(class_core(newcls));
+
+	clstype = class_isa(newcls);                 
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		old_res_class = oldcls ? class_core(oldcls)->res_class[i] : NULL;
+		new_res_class = newcls ? class_core(newcls)->res_class[i] : NULL;
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->change_resclass && (old_res_class != new_res_class)) 
+			(*rcbs->change_resclass)(ns, old_res_class, new_res_class);
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return;
+}
+
+static void
+sock_add_resctrl(struct ckrm_core_class *core, int resid)
+{
+	struct ckrm_net_struct *ns;
+	struct ckrm_res_ctlr *rcbs;
+
+	if ((resid < 0) || (resid >= CKRM_MAX_RES_CTLRS) || ((rcbs = core->classtype->res_ctlrs[resid]) == NULL)) 
+		return;
+
+	spin_lock(&core->ckrm_lock);
+	list_for_each_entry(ns, &core->objlist, ckrm_link) {
+		if (rcbs->change_resclass)
+			(*rcbs->change_resclass)(ns, NULL, core->res_class[resid]);
+	}
+	spin_unlock(&core->ckrm_lock);
+}
+
+
+/**************************************************************************
+ *                   Functions called from classification points          *
+ **************************************************************************/
+
+static void
+cb_sockclass_listen_start(struct sock *sk)
+{
+	struct ckrm_net_struct *ns = NULL;
+	struct ckrm_sock_class *newcls = NULL;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype;
+	int i = 0;
+
+	// XXX - TBD ipv6
+	if (sk->sk_family == IPPROTO_IPV6)
+		return;
+
+	// to store the socket address
+	ns = (struct ckrm_net_struct *)
+		kmalloc(sizeof(struct ckrm_net_struct), GFP_ATOMIC);
+	if (!ns)
+		return;
+
+	memset(ns,0, sizeof(ns));
+	INIT_LIST_HEAD(&ns->ckrm_link);
+
+	ns->ns_family = sk->sk_family;
+	if (ns->ns_family == IPPROTO_IPV6)	// IPv6 not supported yet.
+		return;
+
+	ns->ns_daddrv4 = inet_sk(sk)->rcv_saddr;
+	ns->ns_dport = inet_sk(sk)->num;
+		
+	ns->ns_pid = current->pid;
+	ns->ns_tgid = current->tgid;
+
+	ce_protect(&CT_sockclass);
+	CE_CLASSIFY_RET(newcls,&CT_sockclass,CKRM_EVENT_LISTEN_START,ns,current);
+	ce_release(&CT_sockclass);
+
+	if (newcls == NULL)  {
+		newcls = &sockclass_dflt_class;
+		ckrm_core_grab(class_core(newcls));
+	}
+
+	class_lock(class_core(newcls));
+	list_add(&ns->ckrm_link, &class_core(newcls)->objlist);
+	ckrm_ns_put(ns);
+	ns->core = newcls;
+	class_unlock(class_core(newcls));
+	
+
+	// the socket is already locked
+	// take a reference on socket on our behalf
+	sock_hold(sk);
+	sk->sk_ns = (void *)ns;
+	ns->ns_sk = sk;
+
+	// modify its shares
+	clstype = class_isa(newcls);
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->change_resclass) {
+			(*rcbs->change_resclass)((void *)ns, 
+					 NULL,class_core(newcls)->res_class[i]);
+		}
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return;
+}
+
+static void
+cb_sockclass_listen_stop(struct sock *sk)
+{
+	struct ckrm_net_struct *ns = NULL;
+	struct ckrm_sock_class *newcls = NULL;
+
+	// XXX - TBD ipv6
+	if (sk->sk_family == IPPROTO_IPV6)
+		return;
+
+	ns =  (struct ckrm_net_struct *)sk->sk_ns;
+	if (!ns) // listen_start called before socket_aq was loaded
+		return;
+
+	newcls = ns->core;
+	if (newcls) {
+		class_lock(class_core(newcls));
+		list_del(&ns->ckrm_link);
+		INIT_LIST_HEAD(&ns->ckrm_link);
+		ckrm_core_drop(class_core(newcls));
+		class_unlock(class_core(newcls));
+	}
+
+	// the socket is already locked
+	sk->sk_ns = NULL;
+	sock_put(sk);
+
+	// Should be the last count and free it
+	ckrm_ns_put(ns);
+	return;
+}
+
+static struct ckrm_event_spec sock_events_callbacks[] = {
+	CKRM_EVENT_SPEC( LISTEN_START, cb_sockclass_listen_start  ),
+	CKRM_EVENT_SPEC( LISTEN_STOP,  cb_sockclass_listen_stop  ),
+	{ -1 }
+};
+
+/**************************************************************************
+ *                  Class Object Creation / Destruction
+ **************************************************************************/
+
+static struct ckrm_core_class *
+sock_alloc_class(struct ckrm_core_class *parent, const char *name)
+{
+	struct ckrm_sock_class *sockcls;
+	sockcls = kmalloc(sizeof(struct ckrm_sock_class), GFP_KERNEL);
+	if (sockcls == NULL) 
+		return NULL;
+
+	ckrm_init_core_class(&CT_sockclass,class_core(sockcls),parent,name);
+
+	ce_protect(&CT_sockclass);
+	if (CT_sockclass.ce_cb_active && CT_sockclass.ce_callbacks.class_add)
+		(*CT_sockclass.ce_callbacks.class_add)(name,sockcls);
+	ce_release(&CT_sockclass);
+
+	return class_core(sockcls);
+}
+
+static int
+sock_free_class(struct ckrm_core_class *core)
+{
+	struct ckrm_sock_class *sockcls;
+
+	if (!ckrm_is_core_valid(core)) {
+		// Invalid core
+		return (-EINVAL);
+	}
+	if (core == core->classtype->default_class) {
+		// reset the name tag
+		core->name = dflt_sockclass_name;
+ 		return 0;
+	}
+
+	sockcls = class_type(struct ckrm_sock_class, core);
+
+	ce_protect(&CT_sockclass);
+
+	if (CT_sockclass.ce_cb_active && CT_sockclass.ce_callbacks.class_delete)
+		(*CT_sockclass.ce_callbacks.class_delete)(core->name,sockcls);
+
+	sock_reclassify_class ( sockcls );
+
+	ce_release(&CT_sockclass);
+
+	ckrm_release_core_class(core);  // Hubertus .... could just drop the class .. error message
+	return 0;
+}
+
+
+static int                      
+sock_show_members(struct ckrm_core_class *core, struct seq_file *seq) 
+{
+	struct list_head *lh;
+	struct ckrm_net_struct *ns = NULL;
+
+	class_lock(core);
+	list_for_each(lh, &core->objlist) {
+		ns = container_of(lh, struct ckrm_net_struct,ckrm_link);
+		seq_printf(seq, "%d.%d.%d.%d\\%d\n", 
+			   NIPQUAD(ns->ns_daddrv4),ns->ns_dport);
+	}
+	class_unlock(core);
+
+	return 0;
+}
+
+static int
+sock_forced_reclassify_ns(struct ckrm_net_struct *tns, struct ckrm_core_class *core)
+{
+	struct ckrm_net_struct *ns = NULL;
+	struct sock *sk = NULL;
+	struct ckrm_sock_class *oldcls, *newcls;
+	int rc = -EINVAL;
+
+	if (!ckrm_is_core_valid(core)) {
+		return rc;
+	}
+
+	newcls = class_type(struct ckrm_sock_class, core);
+	// lookup the listening sockets
+	// returns with a reference count set on socket
+	sk = tcp_v4_lookup_listener(tns->ns_daddrv4,tns->ns_dport,0);
+	if (!sk) {
+		printk(KERN_INFO "No such listener 0x%x:%d\n",
+				tns->ns_daddrv4, tns->ns_dport);
+		return rc;
+	}
+	lock_sock(sk);
+	if (!sk->sk_ns) {
+		goto out;
+	}
+	ns = sk->sk_ns;
+	ckrm_ns_hold(ns);
+	oldcls = ns->core;
+	if ((oldcls == NULL) || (oldcls == newcls)) {
+		ckrm_ns_put(ns);
+		goto out;
+	}
+
+	// remove the net_struct from the current class
+	class_lock(class_core(oldcls));
+	list_del(&ns->ckrm_link);
+	INIT_LIST_HEAD(&ns->ckrm_link);
+	ns->core = NULL;
+	class_unlock(class_core(oldcls));
+
+	sock_set_class(ns, newcls, oldcls, CKRM_EVENT_MANUAL);
+	ckrm_ns_put(ns);
+	rc = 0;
+out:
+	release_sock(sk);
+	sock_put(sk);
+
+	return rc;
+
+} 
+
+enum sock_target_token_t {
+        IPV4, IPV6, SOCKC_TARGET_ERR
+};
+
+static match_table_t sock_target_tokens = {
+	{IPV4, "ipv4=%s"},
+	{IPV6, "ipv6=%s"},
+        {SOCKC_TARGET_ERR, NULL},
+};
+
+char *
+v4toi(char *s, char c, __u32 *v)
+{
+	unsigned int  k = 0, n = 0;
+
+	while(*s && (*s != c)) {
+		if (*s == '.') {
+			n <<= 8;
+			n |= k;
+			k = 0;
+		}
+		else 
+			k = k *10 + *s - '0';
+		s++;
+	}
+
+	n <<= 8;
+	*v = n | k;
+
+	return s;
+}
+
+static int
+sock_forced_reclassify(struct ckrm_core_class *target,const char *options)
+{	
+	char *p,*p2;
+	struct ckrm_net_struct ns;
+	__u32 v4addr, tmp;
+
+	if (!options)
+		return 1;
+	
+	while ((p = strsep((char**)&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		
+		if (!*p)
+			continue;
+		token = match_token(p, sock_target_tokens, args);
+		switch (token) {
+
+		case IPV4:
+
+			p2 = p;
+			while(*p2 && (*p2 != '='))
+				++p2;
+			p2++;
+			p2 = v4toi(p2, '\\',&(v4addr));
+			ns.ns_daddrv4 = htonl(v4addr);
+			ns.ns_family = 4; //IPPROTO_IPV4
+			p2 = v4toi(++p2, ':',&tmp); ns.ns_dport = (__u16)tmp;
+			p2 = v4toi(++p2,'\0',&ns.ns_pid);
+			
+			sock_forced_reclassify_ns(&ns,target);
+			break;
+
+		case IPV6:
+			printk(KERN_INFO "rcfs: IPV6 not supported yet\n");
+			return 0;	
+		default:
+			return 0;
+		}
+	}
+	return 1;
+}	
+
+/*
+ * Listen_aq reclassification.
+ */
+static void
+sock_reclassify_class(struct ckrm_sock_class *cls)
+{
+	struct ckrm_net_struct *ns, *tns;
+	struct ckrm_core_class *core = class_core(cls);
+	LIST_HEAD(local_list);
+
+	if (!cls)
+		return;
+
+	if (!ckrm_validate_and_grab_core(core))
+		return;
+
+	class_lock(core);
+	// we have the core refcnt
+	if (list_empty(&core->objlist)) {
+		class_unlock(core);
+		ckrm_core_drop(core);
+		return;
+	}
+
+	INIT_LIST_HEAD(&local_list);
+	list_splice_init(&core->objlist, &local_list);
+	class_unlock(core);
+	ckrm_core_drop(core);
+	
+	list_for_each_entry_safe(ns, tns, &local_list, ckrm_link) {
+		ckrm_ns_hold(ns);
+		list_del(&ns->ckrm_link);
+		if (ns->ns_sk) {
+			lock_sock(ns->ns_sk);
+			sock_set_class(ns, &sockclass_dflt_class, NULL, CKRM_EVENT_MANUAL);
+			release_sock(ns->ns_sk);
+		}
+		ckrm_ns_put(ns);
+	}
+	return ;
+}
+
+void __init
+ckrm_meta_init_sockclass(void)
+{
+	printk("...... Initializing ClassType<%s> ........\n",CT_sockclass.name);
+	// intialize the default class
+	ckrm_init_core_class(&CT_sockclass, class_core(&sockclass_dflt_class),
+			     NULL,dflt_sockclass_name);
+
+	// register classtype and initialize default task class
+	ckrm_register_classtype(&CT_sockclass);
+	ckrm_register_event_set(sock_events_callbacks);
+
+	// note registeration of all resource controllers will be done later dynamically 
+	// as these are specified as modules
+}
+
+
+
+#if 1
+
+/***************************************************************************************
+ * Debugging Network Classes:  Utility functions
+ **************************************************************************************/
+
+#endif
diff -Nru a/fs/rcfs/socket_fs.c b/fs/rcfs/socket_fs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/rcfs/socket_fs.c	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,338 @@
+/* ckrm_socketaq.c 
+ *
+ * Copyright (C) Vivek Kashyap,      IBM Corp. 2004
+ * 
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ * Initial version
+ */
+
+/*******************************************************************************
+ *  Socket class type
+ *   
+ * Defines the root structure for socket based classes. Currently only inbound
+ * connection control is supported based on prioritized accept queues. 
+ ******************************************************************************/
+
+
+#include <linux/rcfs.h>
+#include <net/tcp.h>
+
+extern int rcfs_create(struct inode *,struct dentry *, int, struct nameidata *);
+extern int rcfs_unlink(struct inode *, struct dentry *);
+extern int  rcfs_symlink(struct inode *, struct dentry *, const char *);
+extern int rcfs_mknod(struct inode *, struct dentry *, int mode, dev_t);
+extern int rcfs_mkdir(struct inode *, struct dentry *, int);
+extern int rcfs_rmdir(struct inode *, struct dentry *);
+extern int rcfs_rename(struct inode *, struct dentry *, struct inode *, 
+		struct dentry *);
+
+extern int rcfs_create_coredir(struct inode *, struct dentry *);
+int sock_mkdir(struct inode *, struct dentry *, int mode);
+int sock_rmdir(struct inode *, struct dentry *);
+
+
+int sock_create_noperm(struct inode *, struct dentry *,int, struct nameidata *);
+int sock_unlink_noperm(struct inode *,struct dentry *);
+int sock_mkdir_noperm(struct inode *,struct dentry *,int);
+int sock_rmdir_noperm(struct inode *,struct dentry *);
+int sock_mknod_noperm(struct inode *,struct dentry *,int, dev_t);
+
+void sock_set_directory(void);
+
+extern struct file_operations config_fileops,
+			members_fileops,
+			shares_fileops,
+			stats_fileops,
+			target_fileops;
+
+
+struct inode_operations my_iops = {
+	        .create         = rcfs_create,
+		.lookup         = simple_lookup,
+		.link           = simple_link,
+		.unlink         = rcfs_unlink,
+		.symlink        = rcfs_symlink,
+		.mkdir          = sock_mkdir,
+		.rmdir          = sock_rmdir,
+		.mknod          = rcfs_mknod,
+		.rename         = rcfs_rename,
+};
+
+struct inode_operations class_iops = {
+	        .create         = sock_create_noperm,
+		.lookup         = simple_lookup,
+		.link           = simple_link,
+		.unlink         = sock_unlink_noperm,
+		.symlink        = rcfs_symlink,
+		.mkdir          = sock_mkdir_noperm,
+		.rmdir          = sock_rmdir_noperm,
+		.mknod          = sock_mknod_noperm,
+		.rename         = rcfs_rename,
+};
+
+struct inode_operations sub_iops = {
+	        .create         = sock_create_noperm,
+		.lookup         = simple_lookup,
+		.link           = simple_link,
+		.unlink         = sock_unlink_noperm,
+		.symlink        = rcfs_symlink,
+		.mkdir          = sock_mkdir_noperm,
+		.rmdir          = sock_rmdir_noperm,
+		.mknod          = sock_mknod_noperm,
+		.rename         = rcfs_rename,
+};
+
+struct rcfs_magf def_magf = {
+	.mode = RCFS_DEFAULT_DIR_MODE,
+	.i_op = &sub_iops,
+	.i_fop = NULL,
+};
+
+struct rcfs_magf sock_rootdesc[] = {
+	{
+	//	.name = should not be set, copy from classtype name,
+		.mode = RCFS_DEFAULT_DIR_MODE,
+		.i_op = &my_iops,
+		//.i_fop   = &simple_dir_operations,
+		.i_fop = NULL,
+	},
+	{
+		.name = "members",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &members_fileops,
+	},
+	{
+		.name = "target",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &target_fileops,
+	},
+};
+
+struct rcfs_magf sock_magf[] = {
+	{
+		.name = "config",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &config_fileops,
+	},
+	{
+		.name = "members",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop =&members_fileops,
+	},
+	{
+		.name = "shares",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &shares_fileops,
+	},
+	{
+		.name = "stats",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &stats_fileops,
+	},
+	{
+		.name = "target",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &target_fileops,
+	},
+};
+
+struct rcfs_magf sub_magf[] = {
+	{
+		.name = "config",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &config_fileops,
+	},
+	{
+		.name = "shares",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &shares_fileops,
+	},
+	{
+		.name = "stats",
+		.mode = RCFS_DEFAULT_FILE_MODE,
+		.i_op = &my_iops,
+		.i_fop = &stats_fileops,
+	},
+};
+
+struct rcfs_mfdesc sock_mfdesc = {
+	.rootmf		= sock_rootdesc,
+	.rootmflen 	= (sizeof(sock_rootdesc)/sizeof(struct rcfs_magf)),
+};
+
+
+#define SOCK_MAX_MAGF (sizeof(sock_magf)/sizeof(struct rcfs_magf))
+#define LAQ_MAX_SUBMAGF (sizeof(sub_magf)/sizeof(struct rcfs_magf))
+
+int 
+sock_rmdir(struct inode *p, struct dentry *me)
+{
+	struct dentry *mftmp, *mfdentry ;
+
+	// delete all magic sub directories
+	list_for_each_entry_safe(mfdentry, mftmp, &me->d_subdirs, d_child) {
+		if (S_ISDIR(mfdentry->d_inode->i_mode))
+			rcfs_rmdir(me->d_inode, mfdentry);
+	}
+	// delete ourselves
+	rcfs_rmdir(p,me);
+
+	return 0;
+}
+
+#ifdef NUM_ACCEPT_QUEUES
+#define LAQ_NUM_ACCEPT_QUEUES NUM_ACCEPT_QUEUES
+#else
+#define LAQ_NUM_ACCEPT_QUEUES 0
+#endif
+
+int
+sock_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int retval = 0;
+	int i,j;
+	struct dentry *pentry, *mfdentry;
+
+	if (_rcfs_mknod(dir, dentry, mode | S_IFDIR, 0)) {
+		printk(KERN_ERR "rcfs_mkdir: error reaching parent\n");
+		return retval;
+	}
+	
+	// Needed if only _rcfs_mknod is used instead of i_op->mkdir
+	dir->i_nlink++;
+
+	retval = rcfs_create_coredir(dir, dentry);
+	if (retval) 
+		goto mkdir_err;
+
+	/* create the default set of magic files */
+	for (i =0; i < SOCK_MAX_MAGF; i++) {
+		mfdentry = rcfs_create_internal(dentry, &sock_magf[i],0);
+		mfdentry->d_fsdata = &RCFS_IS_MAGIC;
+		RCFS_I(mfdentry->d_inode)->core = 
+				RCFS_I(dentry->d_inode)->core;
+		if (sock_magf[i].i_fop)
+			mfdentry->d_inode->i_fop = sock_magf[i].i_fop;
+		if (sock_magf[i].i_op)
+			mfdentry->d_inode->i_op = sock_magf[i].i_op;
+	}
+	
+	for (i=1; i < LAQ_NUM_ACCEPT_QUEUES; i++) {
+		j = sprintf(def_magf.name, "%d",i);
+		def_magf.name[j] = '\0';
+
+		pentry = rcfs_create_internal(dentry, &def_magf,0);
+		retval = rcfs_create_coredir(dentry->d_inode, pentry);
+		if (retval)
+			goto mkdir_err;
+		for (j=0; j < LAQ_MAX_SUBMAGF; j++) {
+			mfdentry = rcfs_create_internal(pentry, &sub_magf[j],0);
+			mfdentry->d_fsdata = &RCFS_IS_MAGIC;
+			RCFS_I(mfdentry->d_inode)->core = 
+					RCFS_I(pentry->d_inode)->core;
+			if (sub_magf[j].i_fop)
+				mfdentry->d_inode->i_fop = sub_magf[j].i_fop;
+			if (sub_magf[j].i_op)
+				mfdentry->d_inode->i_op = sub_magf[j].i_op;
+		}
+		pentry->d_inode->i_op = &sub_iops;
+	}
+	dentry->d_inode->i_op = &class_iops;
+	return 0;
+
+mkdir_err:
+	// Needed
+	dir->i_nlink--;
+	return retval;
+}
+#ifndef NUM_ACCEPT_QUEUES
+#define NUM_ACCEPT_QUEUES 0
+#endif
+
+char *
+sock_get_name(struct ckrm_core_class *c)
+{
+	char *p = (char *)c->name;
+	
+	while(*p)
+		p++;
+	while( *p != '/' && p != c->name)
+		p--;
+
+	return ++p;
+}
+
+int 
+sock_create_noperm(struct inode *dir,struct dentry *dentry,int mode, struct nameidata *nd)
+{
+	return -EPERM;
+}
+
+int 
+sock_unlink_noperm(struct inode *dir,struct dentry *dentry)
+{
+	return -EPERM;
+}
+
+int 
+sock_mkdir_noperm(struct inode *dir,struct dentry *dentry, int mode)
+{
+	return -EPERM;
+}
+
+int 
+sock_rmdir_noperm(struct inode *dir,struct dentry *dentry)
+{
+	return -EPERM;
+}
+
+int 
+sock_mknod_noperm(struct inode *dir,struct dentry *dentry,int mode, dev_t dev)
+{
+	return -EPERM;
+}
+
+#if 0
+void
+sock_set_directory()
+{
+	struct dentry *pentry, *dentry;
+
+	pentry = rcfs_set_magf_byname("listen_aq", (void *)&my_dir_magf[0]);
+	if (pentry) {
+		dentry = rcfs_create_internal(pentry, &my_dir_magf[1],0);
+		if (my_dir_magf[1].i_fop)
+			dentry->d_inode->i_fop = my_dir_magf[1].i_fop;
+		RCFS_I(dentry->d_inode)->core = 
+				RCFS_I(pentry->d_inode)->core;
+		dentry = rcfs_create_internal(pentry, &my_dir_magf[2],0);
+		if (my_dir_magf[2].i_fop)
+			dentry->d_inode->i_fop = my_dir_magf[2].i_fop;
+		RCFS_I(dentry->d_inode)->core = 
+				RCFS_I(pentry->d_inode)->core;
+	}
+	else  {
+		printk(KERN_ERR "Could not create /rcfs/listen_aq\n"
+				"Perhaps /rcfs needs to be mounted\n");
+	}
+}
+#endif
+

--------------030104050409020801060509--
