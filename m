Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVKXKvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVKXKvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVKXKvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:51:40 -0500
Received: from spc1-leed3-6-0-cust185.seac.broadband.ntl.com ([80.7.68.185]:31722
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S1751359AbVKXKvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:51:39 -0500
Date: Thu, 24 Nov 2005 10:51:30 +0000
From: Patrick Caulfield <patrick@tykepenguin.com>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, steve@chygwyn.com
Subject: [PATCH] DECnet: add memory buffer settings
Message-ID: <20051124105130.GA22111@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -670,6 +670,9 @@ enum {
 	NET_DECNET_DST_GC_INTERVAL = 9,
 	NET_DECNET_CONF = 10,
 	NET_DECNET_NO_FC_MAX_CWND = 11,
+	NET_DECNET_MEM = 12,
+	NET_DECNET_RMEM = 13,
+	NET_DECNET_WMEM = 14,
 	NET_DECNET_DEBUG_LEVEL = 255
 };
 
diff --git a/include/net/dn.h b/include/net/dn.h
--- a/include/net/dn.h
+++ b/include/net/dn.h
@@ -234,4 +234,8 @@ extern int decnet_di_count;
 extern int decnet_dr_count;
 extern int decnet_no_fc_max_cwnd;
 
+extern int sysctl_decnet_mem[3];
+extern int sysctl_decnet_wmem[3];
+extern int sysctl_decnet_rmem[3];
+
 #endif /* _NET_DN_H */
diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -153,6 +153,7 @@ static struct proto_ops dn_proto_ops;
 static DEFINE_RWLOCK(dn_hash_lock);
 static struct hlist_head dn_sk_hash[DN_SK_HASH_SIZE];
 static struct hlist_head dn_wild_sk;
+static atomic_t decnet_memory_allocated;
 
 static int __dn_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen, int flags);
 static int __dn_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen, int flags);
@@ -446,10 +447,26 @@ static void dn_destruct(struct sock *sk)
 	dst_release(xchg(&sk->sk_dst_cache, NULL));
 }
 
+static int dn_memory_pressure;
+
+static void dn_enter_memory_pressure(void)
+{
+	if (!dn_memory_pressure) {
+		dn_memory_pressure = 1;
+	}
+}
+
 static struct proto dn_proto = {
-	.name	  = "DECNET",
-	.owner	  = THIS_MODULE,
-	.obj_size = sizeof(struct dn_sock),
+	.name			= "NSP",
+	.owner			= THIS_MODULE,
+	.enter_memory_pressure	= dn_enter_memory_pressure,
+	.memory_pressure	= &dn_memory_pressure,
+	.memory_allocated	= &decnet_memory_allocated,
+	.sysctl_mem		= sysctl_decnet_mem,
+	.sysctl_wmem		= sysctl_decnet_wmem,
+	.sysctl_rmem		= sysctl_decnet_rmem,
+	.max_header		= DN_MAX_NSP_DATA_HEADER + 64,
+	.obj_size		= sizeof(struct dn_sock),
 };
 
 static struct sock *dn_alloc_sock(struct socket *sock, gfp_t gfp)
@@ -470,6 +487,8 @@ static struct sock *dn_alloc_sock(struct
 	sk->sk_family      = PF_DECnet;
 	sk->sk_protocol    = 0;
 	sk->sk_allocation  = gfp;
+	sk->sk_sndbuf	   = sysctl_decnet_wmem[1];
+	sk->sk_rcvbuf	   = sysctl_decnet_rmem[1];
 
 	/* Initialization of DECnet Session Control Port		*/
 	scp = DN_SK(sk);
diff --git a/net/decnet/sysctl_net_decnet.c b/net/decnet/sysctl_net_decnet.c
--- a/net/decnet/sysctl_net_decnet.c
+++ b/net/decnet/sysctl_net_decnet.c
@@ -10,6 +10,7 @@
  *
  * Changes:
  * Steve Whitehouse - C99 changes and default device handling
+ * Steve Whitehouse - Memory buffer settings, like the tcp ones
  *
  */
 #include <linux/config.h>
@@ -37,6 +38,11 @@ int decnet_dr_count = 3;
 int decnet_log_martians = 1;
 int decnet_no_fc_max_cwnd = NSP_MIN_WINDOW;
 
+/* Reasonable defaults, I hope, based on tcp's defaults */
+int sysctl_decnet_mem[3] = { 768 << 3, 1024 << 3, 1536 << 3 };
+int sysctl_decnet_wmem[3] = { 4 * 1024, 16 * 1024, 128 * 1024 };
+int sysctl_decnet_rmem[3] = { 4 * 1024, 87380, 87380 * 2 };
+
 #ifdef CONFIG_SYSCTL
 extern int decnet_dst_gc_interval;
 static int min_decnet_time_wait[] = { 5 };
@@ -428,6 +434,33 @@ static ctl_table dn_table[] = {
 		.extra1 = &min_decnet_no_fc_max_cwnd,
 		.extra2 = &max_decnet_no_fc_max_cwnd
 	},
+       {
+                .ctl_name = NET_DECNET_MEM,
+                .procname = "decnet_mem",
+                .data = &sysctl_decnet_mem,
+                .maxlen = sizeof(sysctl_decnet_mem),
+                .mode = 0644,
+                .proc_handler = &proc_dointvec,
+                .strategy = &sysctl_intvec,
+        },
+        {
+                .ctl_name = NET_DECNET_RMEM,
+                .procname = "decnet_rmem",
+                .data = &sysctl_decnet_rmem,
+                .maxlen = sizeof(sysctl_decnet_rmem),
+                .mode = 0644,
+                .proc_handler = &proc_dointvec,
+                .strategy = &sysctl_intvec,
+        },
+        {
+                .ctl_name = NET_DECNET_WMEM,
+                .procname = "decnet_wmem",
+                .data = &sysctl_decnet_wmem,
+                .maxlen = sizeof(sysctl_decnet_wmem),
+                .mode = 0644,
+                .proc_handler = &proc_dointvec,
+                .strategy = &sysctl_intvec,
+        },
 	{
 		.ctl_name = NET_DECNET_DEBUG_LEVEL,
 		.procname = "debug",
