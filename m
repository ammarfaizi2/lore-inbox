Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315885AbSEGQNw>; Tue, 7 May 2002 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315887AbSEGQNv>; Tue, 7 May 2002 12:13:51 -0400
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:27298 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S315885AbSEGQNu>; Tue, 7 May 2002 12:13:50 -0400
Message-Id: <200205071613.MAA22929@contents-vnder-pressvre.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: [patch] use sysctl to adjust SOMAXCONN 
Date: Tue, 07 May 2002 12:13:45 -0400
From: Nickolai Zeldovich <kolya@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the effective SOMAXCONN value to be adjusted
by sysctl, as net.core.listen_max.  The user-space value remains
fixed at the current value of 128, so this should not affect the
behavior of applications by default.  A value larger than 128 is
sometimes useful for benchmarking purposes, when lots of new TCP
connections are established at once.

-- kolya

--- linux-2.5.14/net/socket.c.orig	Sun May  5 23:37:59 2002
+++ linux-2.5.14/net/socket.c	Tue May  7 12:09:56 2002
@@ -1055,14 +1055,15 @@
  *	ready for listening.
  */
 
+int sysctl_listen_max = SOMAXCONN;
 asmlinkage long sys_listen(int fd, int backlog)
 {
 	struct socket *sock;
 	int err;
 	
 	if ((sock = sockfd_lookup(fd, &err)) != NULL) {
-		if ((unsigned) backlog > SOMAXCONN)
-			backlog = SOMAXCONN;
+		if ((unsigned) backlog > sysctl_listen_max)
+			backlog = sysctl_listen_max;
 		err=sock->ops->listen(sock, backlog);
 		sockfd_put(sock);
 	}
--- linux-2.5.14/net/core/sysctl_net_core.c.orig	Sun May  5 23:38:00 2002
+++ linux-2.5.14/net/core/sysctl_net_core.c	Tue May  7 12:09:56 2002
@@ -29,6 +29,7 @@
 extern int sysctl_core_destroy_delay;
 extern int sysctl_optmem_max;
 extern int sysctl_hot_list_len;
+extern int sysctl_listen_max;
 
 #ifdef CONFIG_NET_DIVERT
 extern char sysctl_divert_version[];
@@ -88,6 +89,9 @@
 	 (void *)sysctl_divert_version, 32, 0444, NULL,
 	 &proc_dostring},
 #endif /* CONFIG_NET_DIVERT */
+	{NET_CORE_LISTEN_MAX, "listen_max",
+	 &sysctl_listen_max, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
 #endif /* CONFIG_NET */
 	{ 0 }
 };
--- linux-2.5.14/include/linux/sysctl.h.orig	Sun May  5 23:37:52 2002
+++ linux-2.5.14/include/linux/sysctl.h	Tue May  7 12:10:34 2002
@@ -203,7 +203,8 @@
 	NET_CORE_NO_CONG=14,
 	NET_CORE_LO_CONG=15,
 	NET_CORE_MOD_CONG=16,
-	NET_CORE_DEV_WEIGHT=17
+	NET_CORE_DEV_WEIGHT=17,
+	NET_CORE_LISTEN_MAX=18
 };
 
 /* /proc/sys/net/ethernet */
