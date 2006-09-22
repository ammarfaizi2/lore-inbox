Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWIVGYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIVGYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWIVGYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:24:50 -0400
Received: from osiris.atheme.org ([69.60.119.211]:58299 "EHLO
	osiris.atheme.org") by vger.kernel.org with ESMTP id S1750761AbWIVGYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:24:50 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: William Pitcock <nenolod@atheme.org>
Subject: [PATCH 2.6.18 1/1] net/ipv4: sysctl to allow non-superuser to bypass CAP_NET_BIND_SERVICE requirement
Date: Fri, 22 Sep 2006 01:25:13 -0500
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows for a user to disable the requirement to meet the  
CAP_NET_BIND_SERVICE capability for a non-superuser. It is toggled by  
the net.ipv4.allow_lowport_bind_nonsuperuser sysctl value.

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e4b1a4d..c3f7c3c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -411,6 +411,7 @@ enum
	NET_IPV4_TCP_WORKAROUND_SIGNED_WINDOWS=115,
	NET_TCP_DMA_COPYBREAK=116,
	NET_TCP_SLOW_START_AFTER_IDLE=117,
+	NET_IPV4_ALLOW_LOWPORT_BIND_NONSUPERUSER=118,
   };
   enum {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c84a320..a2ea829 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -394,6 +394,11 @@ int inet_release(struct socket *sock)
   /* It is off by default, see below. */
   int sysctl_ip_nonlocal_bind;

+/* When this is enabled, it allows normal users to bind to ports <=  
1023.
+ * This is set by the net.ipv4.allow_lowport_bind_nonsuperuser  
sysctl value.
+ */
+int sysctl_ip_allow_lowport_bind_nonsuperuser;
+
   int inet_bind(struct socket *sock, struct sockaddr *uaddr, int  
addr_len)
   {
  	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
@@ -432,7 +437,8 @@ int inet_bind(struct socket *sock, struc
  	snum = ntohs(addr->sin_port);
  	err = -EACCES;
-	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+	if (!sysctl_ip_allow_lowport_bind_nonsuperuser && snum && snum <  
PROT_SOCK &&
+		!capable(CAP_NET_BIND_SERVICE))
  		goto out;
  	/*      We keep a pair of addresses. rcv_saddr is the one
@@ -1412,3 +1418,4 @@ EXPORT_SYMBOL(inet_stream_ops);
   EXPORT_SYMBOL(inet_unregister_protosw);
   EXPORT_SYMBOL(net_statistics);
   EXPORT_SYMBOL(sysctl_ip_nonlocal_bind);
+EXPORT_SYMBOL(sysctl_ip_allow_lowport_bind_nonsuperuser);
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 70cea9d..c57ef3a 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -20,6 +20,7 @@ #include <net/tcp.h>
   /* From af_inet.c */
   extern int sysctl_ip_nonlocal_bind;
+extern int sysctl_ip_allow_lowport_bind_nonsuperuser;
  #ifdef CONFIG_SYSCTL
  static int zero;
@@ -197,6 +198,14 @@ ctl_table ipv4_table[] = {
  		.proc_handler	= &proc_dointvec
  	},
  	{
+		.ctl_name	= NET_IPV4_ALLOW_LOWPORT_BIND_NONSUPERUSER,
+		.procname	= "allow_lowport_bind_nonsuperuser",
+		.data		= &sysctl_ip_allow_lowport_bind_nonsuperuser,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
  		.ctl_name	= NET_IPV4_TCP_SYN_RETRIES,
  		.procname	= "tcp_syn_retries",
  		.data		= &sysctl_tcp_syn_retries,


Signed-off-by: William Pitcock <nenolod@atheme.org>
