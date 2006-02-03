Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWBCVT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWBCVT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWBCVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:19:26 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:44498 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030245AbWBCVTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:19:25 -0500
Subject: [patch 1/1] selinux:  require SECURITY_NETWORK
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 03 Feb 2006 16:25:09 -0500
Message-Id: <1139001909.24638.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make SELinux depend on SECURITY_NETWORK (which depends on SECURITY),
as it requires the socket hooks for proper operation even in the local
case.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 security/selinux/Kconfig  |    2 +-
 security/selinux/Makefile |    4 +---
 security/selinux/hooks.c  |   21 +++------------------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.16-rc2/security/selinux/hooks.c linux-2.6.16-rc2-x/security/selinux/hooks.c
--- linux-2.6.16-rc2/security/selinux/hooks.c	2006-02-03 10:14:34.000000000 -0500
+++ linux-2.6.16-rc2-x/security/selinux/hooks.c	2006-02-03 10:56:45.000000000 -0500
@@ -232,7 +232,6 @@ static void superblock_free_security(str
 	kfree(sbsec);
 }
 
-#ifdef CONFIG_SECURITY_NETWORK
 static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
 	struct sk_security_struct *ssec;
@@ -261,7 +260,6 @@ static void sk_free_security(struct sock
 	sk->sk_security = NULL;
 	kfree(ssec);
 }
-#endif	/* CONFIG_SECURITY_NETWORK */
 
 /* The security server must be initialized before
    any labeling or access decisions can be provided. */
@@ -2736,8 +2734,6 @@ static void selinux_task_to_inode(struct
 	return;
 }
 
-#ifdef CONFIG_SECURITY_NETWORK
-
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb, struct avc_audit_data *ad)
 {
@@ -3556,15 +3552,6 @@ static unsigned int selinux_ipv6_postrou
 
 #endif	/* CONFIG_NETFILTER */
 
-#else
-
-static inline int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
-#endif	/* CONFIG_SECURITY_NETWORK */
-
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	struct task_security_struct *tsec;
@@ -4340,7 +4327,6 @@ static struct security_operations selinu
 	.getprocattr =                  selinux_getprocattr,
 	.setprocattr =                  selinux_setprocattr,
 
-#ifdef CONFIG_SECURITY_NETWORK
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
 
@@ -4362,7 +4348,6 @@ static struct security_operations selinu
 	.sk_alloc_security =		selinux_sk_alloc_security,
 	.sk_free_security =		selinux_sk_free_security,
 	.sk_getsid = 			selinux_sk_getsid_security,
-#endif
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	.xfrm_policy_alloc_security =	selinux_xfrm_policy_alloc,
@@ -4440,7 +4425,7 @@ next_sb:
    all processes and objects when they are created. */
 security_initcall(selinux_init);
 
-#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_NETFILTER)
+#if defined(CONFIG_NETFILTER)
 
 static struct nf_hook_ops selinux_ipv4_op = {
 	.hook =		selinux_ipv4_postroute_last,
@@ -4501,13 +4486,13 @@ static void selinux_nf_ip_exit(void)
 }
 #endif
 
-#else /* CONFIG_SECURITY_NETWORK && CONFIG_NETFILTER */
+#else /* CONFIG_NETFILTER */
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 #define selinux_nf_ip_exit()
 #endif
 
-#endif /* CONFIG_SECURITY_NETWORK && CONFIG_NETFILTER */
+#endif /* CONFIG_NETFILTER */
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 int selinux_disable(void)
diff -X /home/sds/dontdiff -rup linux-2.6.16-rc2/security/selinux/Kconfig linux-2.6.16-rc2-x/security/selinux/Kconfig
--- linux-2.6.16-rc2/security/selinux/Kconfig	2006-02-03 10:57:37.000000000 -0500
+++ linux-2.6.16-rc2-x/security/selinux/Kconfig	2006-02-03 10:57:31.000000000 -0500
@@ -1,6 +1,6 @@
 config SECURITY_SELINUX
 	bool "NSA SELinux Support"
-	depends on SECURITY && NET && INET
+	depends on SECURITY_NETWORK && NET && INET
 	default n
 	help
 	  This selects NSA Security-Enhanced Linux (SELinux).
diff -X /home/sds/dontdiff -rup linux-2.6.16-rc2/security/selinux/Makefile linux-2.6.16-rc2-x/security/selinux/Makefile
--- linux-2.6.16-rc2/security/selinux/Makefile	2006-02-03 10:14:34.000000000 -0500
+++ linux-2.6.16-rc2-x/security/selinux/Makefile	2006-02-03 10:55:35.000000000 -0500
@@ -4,9 +4,7 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o
-
-selinux-$(CONFIG_SECURITY_NETWORK) += netif.o
+selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 

-- 
Stephen Smalley
National Security Agency

