Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270681AbUJUB36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbUJUB36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270591AbUJUBZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:25:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:63923 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270454AbUJUBRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:17:08 -0400
Date: Wed, 20 Oct 2004 18:17:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][LSM] remove net related includes from security.h
Message-ID: <20041020181702.T2357@build.pdx.osdl.net>
References: <20041020181507.S2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041020181507.S2357@build.pdx.osdl.net>; from chrisw@osdl.org on Wed, Oct 20, 2004 at 06:15:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this we're back to the times when changing skbuff.h
only triggers rebuild of _net_ related stuff 8)

This uncovered a bug in rmap.h, that was not including
mm.h to get the definition of struct vm_area_struct,
working by luck.

Signed-off-by: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Signed-off-by: Chris Wright <chrisw@osdl.org>

--- linux-2.6/include/linux/security.h~uninline	2004-10-20 18:01:57.753401840 -0700
+++ linux-2.6/include/linux/security.h	2004-10-20 18:07:29.143022960 -0700
@@ -30,8 +30,6 @@
 #include <linux/shm.h>
 #include <linux/msg.h>
 #include <linux/sched.h>
-#include <linux/skbuff.h>
-#include <linux/netlink.h>
 
 struct ctl_table;
 
@@ -55,18 +53,14 @@
 extern int cap_syslog (int type);
 extern int cap_vm_enough_memory (long pages);
 
-static inline int cap_netlink_send (struct sock *sk, struct sk_buff *skb)
-{
-	NETLINK_CB (skb).eff_cap = current->cap_effective;
-	return 0;
-}
+struct msghdr;
+struct sk_buff;
+struct sock;
+struct sockaddr;
+struct socket;
 
-static inline int cap_netlink_recv (struct sk_buff *skb)
-{
-	if (!cap_raised (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
-}
+extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
+extern int cap_netlink_recv(struct sk_buff *skb);
 
 /*
  * Values used in the task_security_ops calls
@@ -2518,11 +2512,6 @@
 	return -EINVAL;
 }
 
-/*
- * The netlink capability defaults need to be used inline by default
- * (rather than hooking into the capability module) to reduce overhead
- * in the networking code.
- */
 static inline int security_netlink_send (struct sock *sk, struct sk_buff *skb)
 {
 	return cap_netlink_send (sk, skb);
--- linux-2.6/include/linux/rmap.h~uninline	2004-10-20 17:51:00.568309160 -0700
+++ linux-2.6/include/linux/rmap.h	2004-10-20 18:04:52.862781168 -0700
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/spinlock.h>
 
 /*
--- linux-2.6/security/commoncap.c~uninline	2004-10-20 17:51:00.574308248 -0700
+++ linux-2.6/security/commoncap.c	2004-10-20 18:04:52.875779192 -0700
@@ -24,6 +24,23 @@
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
 
+int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
+{
+	NETLINK_CB(skb).eff_cap = current->cap_effective;
+	return 0;
+}
+
+EXPORT_SYMBOL(cap_netlink_send);
+
+int cap_netlink_recv(struct sk_buff *skb)
+{
+	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
+		return -EPERM;
+	return 0;
+}
+
+EXPORT_SYMBOL(cap_netlink_recv);
+
 int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
