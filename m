Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUBRVX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268152AbUBRVX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:23:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8599 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268086AbUBRVWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:22:55 -0500
Date: Wed, 18 Feb 2004 16:22:51 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@redhat.com>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: Re: [SELINUX] Event notifications via Netlink
In-Reply-To: <20040218125545.6c499296.davem@redhat.com>
Message-ID: <Xine.LNX.4.44.0402181621390.28705-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, David S. Miller wrote:

> On Wed, 18 Feb 2004 11:52:31 -0500 (EST)
> James Morris <jmorris@redhat.com> wrote:
> 
> > +/* Message structures */
> > +struct selnl_msg_setenforce {
> > +	u_int32_t	val;
> > +};
>  ...
> > +	case SELNL_MSG_SETENFORCE: {
> > +		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
> > +		
> > +		memset(msg, 0, len);
> > +		msg->val = *((int *)data);
> > +		break;
> > +	}
> 
> I think there's a "u32" at 'data' not an "int".

Thanks for catching that.  The source data type is a signed int, 
updated patch below.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.3.o/include/linux/netlink.h linux-2.6.3.w/include/linux/netlink.h
--- linux-2.6.3.o/include/linux/netlink.h	2003-10-15 08:53:19.000000000 -0400
+++ linux-2.6.3.w/include/linux/netlink.h	2004-02-18 08:53:17.000000000 -0500
@@ -11,6 +11,7 @@
 #define NETLINK_TCPDIAG		4	/* TCP socket monitoring			*/
 #define NETLINK_NFLOG		5	/* netfilter/iptables ULOG */
 #define NETLINK_XFRM		6	/* ipsec */
+#define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ARPD		8
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
diff -urN -X dontdiff linux-2.6.3.o/include/linux/selinux_netlink.h linux-2.6.3.w/include/linux/selinux_netlink.h
--- linux-2.6.3.o/include/linux/selinux_netlink.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.3.w/include/linux/selinux_netlink.h	2004-02-18 16:08:22.071035728 -0500
@@ -0,0 +1,37 @@
+/*
+ * Netlink event notifications for SELinux.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#ifndef _LINUX_SELINUX_NETLINK_H
+#define _LINUX_SELINUX_NETLINK_H
+
+/* Message types. */
+#define SELNL_MSG_BASE 0x10
+enum {
+	SELNL_MSG_SETENFORCE = SELNL_MSG_BASE,
+	SELNL_MSG_POLICYLOAD,
+	SELNL_MSG_MAX
+};
+
+/* Multicast groups */
+#define SELNL_GRP_NONE		0x00000000
+#define SELNL_GRP_AVC		0x00000001	/* AVC notifications */
+#define SELNL_GRP_ALL		0xffffffff
+
+/* Message structures */
+struct selnl_msg_setenforce {
+	int32_t		val;
+};
+
+struct selnl_msg_policyload {
+	u_int32_t	seqno;
+};
+
+#endif /* _LINUX_SELINUX_NETLINK_H */
diff -urN -X dontdiff linux-2.6.3.o/security/selinux/Makefile linux-2.6.3.w/security/selinux/Makefile
--- linux-2.6.3.o/security/selinux/Makefile	2004-02-04 08:39:07.000000000 -0500
+++ linux-2.6.3.w/security/selinux/Makefile	2004-02-18 08:53:17.000000000 -0500
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-y := avc.o hooks.o selinuxfs.o
+selinux-y := avc.o hooks.o selinuxfs.o netlink.o
 
 selinux-$(CONFIG_SECURITY_NETWORK) += netif.o
 
diff -urN -X dontdiff linux-2.6.3.o/security/selinux/netlink.c linux-2.6.3.w/security/selinux/netlink.c
--- linux-2.6.3.o/security/selinux/netlink.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.3.w/security/selinux/netlink.c	2004-02-18 09:01:54.000000000 -0500
@@ -0,0 +1,113 @@
+/*
+ * Netlink event notifications for SELinux.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/selinux_netlink.h>
+
+static struct sock *selnl;
+
+static int selnl_msglen(int msgtype)
+{
+	int ret = 0;
+	
+	switch (msgtype) {
+	case SELNL_MSG_SETENFORCE:
+		ret = sizeof(struct selnl_msg_setenforce);
+		break;
+	
+	case SELNL_MSG_POLICYLOAD:
+		ret = sizeof(struct selnl_msg_policyload);
+		break;
+		
+	default:
+		BUG();
+	}
+	return ret;
+}
+
+static void selnl_add_payload(struct nlmsghdr *nlh, int len, int msgtype, void *data)
+{
+	switch (msgtype) {
+	case SELNL_MSG_SETENFORCE: {
+		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
+		
+		memset(msg, 0, len);
+		msg->val = *((int *)data);
+		break;
+	}
+	
+	case SELNL_MSG_POLICYLOAD: {
+		struct selnl_msg_policyload *msg = NLMSG_DATA(nlh);
+		
+		memset(msg, 0, len);
+		msg->seqno = *((u32 *)data);
+		break;
+	}
+
+	default:
+		BUG();
+	}
+}
+
+static void selnl_notify(int msgtype, void *data)
+{
+	int len;
+	unsigned char *tmp;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	
+	len = selnl_msglen(msgtype);
+	
+	skb = alloc_skb(NLMSG_SPACE(len), GFP_USER);
+	if (!skb)
+		goto oom;
+
+	tmp = skb->tail;
+	nlh = NLMSG_PUT(skb, 0, 0, msgtype, len);
+	selnl_add_payload(nlh, len, msgtype, data);
+	nlh->nlmsg_len = skb->tail - tmp;
+	netlink_broadcast(selnl, skb, 0, SELNL_GRP_AVC, GFP_USER);
+out:
+	return;
+	
+nlmsg_failure:
+	kfree_skb(skb);
+oom:
+	printk(KERN_ERR "SELinux:  OOM in %s\n", __FUNCTION__);
+	goto out;
+}
+
+void selnl_notify_setenforce(int val)
+{
+	selnl_notify(SELNL_MSG_SETENFORCE, &val);
+}
+
+void selnl_notify_policyload(u32 seqno)
+{
+	selnl_notify(SELNL_MSG_POLICYLOAD, &seqno);
+}
+
+static int __init selnl_init(void)
+{
+	selnl = netlink_kernel_create(NETLINK_SELINUX, NULL);
+	if (selnl == NULL)
+		panic("SELinux:  Cannot create netlink socket.");
+	netlink_set_nonroot(NETLINK_SELINUX, NL_NONROOT_RECV);	
+	return 0;
+}
+
+__initcall(selnl_init);
diff -urN -X dontdiff linux-2.6.3.o/security/selinux/selinuxfs.c linux-2.6.3.w/security/selinux/selinuxfs.c
--- linux-2.6.3.o/security/selinux/selinuxfs.c	2004-02-18 00:17:09.000000000 -0500
+++ linux-2.6.3.w/security/selinux/selinuxfs.c	2004-02-18 08:53:17.000000000 -0500
@@ -17,6 +17,8 @@
 #include "security.h"
 #include "objsec.h"
 
+extern void selnl_notify_setenforce(int val);
+
 /* Check whether a task is allowed to use a security operation. */
 int task_has_security(struct task_struct *tsk,
 		      u32 perms)
@@ -111,6 +113,7 @@
 		selinux_enforcing = new_value;
 		if (selinux_enforcing)
 			avc_ss_reset(0);
+		selnl_notify_setenforce(selinux_enforcing);
 	}
 	length = count;
 out:
diff -urN -X dontdiff linux-2.6.3.o/security/selinux/ss/services.c linux-2.6.3.w/security/selinux/ss/services.c
--- linux-2.6.3.o/security/selinux/ss/services.c	2004-02-18 00:17:09.000000000 -0500
+++ linux-2.6.3.w/security/selinux/ss/services.c	2004-02-18 08:53:17.000000000 -0500
@@ -28,6 +28,8 @@
 #include "services.h"
 #include "mls.h"
 
+extern void selnl_notify_policyload(u32 seqno);
+
 static rwlock_t policy_rwlock = RW_LOCK_UNLOCKED;
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
 #define POLICY_WRLOCK write_lock_irq(&policy_rwlock)
@@ -1052,6 +1054,7 @@
 	sidtab_destroy(&oldsidtab);
 
 	avc_ss_reset(seqno);
+	selnl_notify_policyload(seqno);
 
 	return 0;
 

