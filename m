Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWCCVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWCCVkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWCCVkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:40:31 -0500
Received: from [198.78.49.142] ([198.78.49.142]:52996 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751522AbWCCVk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:40:26 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 7/8] [I/OAT] Add a sysctl for tuning the I/OAT offloaded I/O threshold
Date: Fri, 03 Mar 2006 13:42:34 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060303214234.11908.99495.stgit@gitlost.site>
In-Reply-To: <20060303214036.11908.10499.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any socket recv of less than this ammount will not be offloaded

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 include/linux/sysctl.h     |    1 +
 include/net/tcp.h          |    1 +
 net/core/user_dma.c        |    4 ++++
 net/ipv4/sysctl_net_ipv4.c |   10 ++++++++++
 4 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index dfcf449..f532f1e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -402,6 +402,7 @@ enum
 	NET_IPV4_IPFRAG_MAX_DIST=112,
  	NET_TCP_MTU_PROBING=113,
 	NET_TCP_BASE_MSS=114,
+	NET_TCP_DMA_COPYBREAK=115,
 };
 
 enum {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2fc7f05..0740f32 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -221,6 +221,7 @@ extern int sysctl_tcp_adv_win_scale;
 extern int sysctl_tcp_tw_reuse;
 extern int sysctl_tcp_frto;
 extern int sysctl_tcp_low_latency;
+extern int sysctl_tcp_dma_copybreak;
 extern int sysctl_tcp_nometrics_save;
 extern int sysctl_tcp_moderate_rcvbuf;
 extern int sysctl_tcp_tso_win_divisor;
diff --git a/net/core/user_dma.c b/net/core/user_dma.c
index 1e1aae5..dd259f0 100644
--- a/net/core/user_dma.c
+++ b/net/core/user_dma.c
@@ -33,6 +33,10 @@ file called LICENSE.
 
 #ifdef CONFIG_NET_DMA
 
+#define NET_DMA_DEFAULT_COPYBREAK 1024
+
+int sysctl_tcp_dma_copybreak = NET_DMA_DEFAULT_COPYBREAK;
+
 /**
  *	dma_skb_copy_datagram_iovec - Copy a datagram to an iovec.
  *	@skb - buffer to copy
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ebf2e0b..f7bd9c2 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -680,6 +680,16 @@ ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_NET_DMA
+	{
+		.ctl_name	= NET_TCP_DMA_COPYBREAK,
+		.procname	= "tcp_dma_copybreak",
+		.data		= &sysctl_tcp_dma_copybreak,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+#endif
 
 	{ .ctl_name = 0 }
 };

