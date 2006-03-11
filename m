Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752309AbWCKC1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbWCKC1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 21:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWCKC1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 21:27:16 -0500
Received: from [198.78.49.142] ([198.78.49.142]:1797 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1752304AbWCKC1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 21:27:10 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 7/8] [I/OAT] Add a sysctl for tuning the I/OAT offloaded I/O threshold
Date: Fri, 10 Mar 2006 18:29:34 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060311022933.3950.44450.stgit@gitlost.site>
In-Reply-To: <20060311022759.3950.58788.stgit@gitlost.site>
References: <20060311022759.3950.58788.stgit@gitlost.site>
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
index 76eaeff..cd9e7c0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -403,6 +403,7 @@ enum
  	NET_TCP_MTU_PROBING=113,
 	NET_TCP_BASE_MSS=114,
 	NET_IPV4_TCP_WORKAROUND_SIGNED_WINDOWS=115,
+	NET_TCP_DMA_COPYBREAK=116,
 };
 
 enum {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index afc4b8a..f319368 100644
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
index 24e51eb..a85d1f1 100644
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
index 6b6c3ad..6a6aa53 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -688,6 +688,16 @@ ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec
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
 

