Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSAPXd2>; Wed, 16 Jan 2002 18:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSAPXdT>; Wed, 16 Jan 2002 18:33:19 -0500
Received: from apogee.whack.org ([167.216.255.203]:61426 "EHLO mx1.whack.org")
	by vger.kernel.org with ESMTP id <S287991AbSAPXdF>;
	Wed, 16 Jan 2002 18:33:05 -0500
Date: Wed, 16 Jan 2002 15:33:04 -0800 (PST)
From: Wilson Yeung <wilson@whack.org>
To: linux-kernel@vger.kernel.org
cc: linux-net@vger.kernel.org
Subject: hires timestamps for netif_rx()
In-Reply-To: <20020116180042.A21447@willow.seitz.com>
Message-ID: <Pine.GSO.4.40.0201161514030.5375-100000@apogee.whack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd love to have a run-time tuneable kernel parameter that lets me use
do_gettimeofday() instead of get_fast_time for received packet
timestamping.  Does this seem reasonable?

This is especially useful for me when I perform round trip time
measurements (despite the affects of interrupt latency).

Here's a patch against the 2.4.17.  Modified files are
include/linux/sysctl.h, net/core/dev.c, and net/core/sysctrl_net_core.c.
The sysctl tuneable parameter is /proc/sys/net/core/hires_rx_timestamp,
which is set to 0 by default.

Feedback, advice would be appreciated.

Patch follows:

diff -urN -X dontdiff linux-2.4.17/include/linux/sysctl.h linux-2.4.17-wilson/include/linux/sysctl.h
--- linux-2.4.17/include/linux/sysctl.h	Mon Nov 26 05:29:17 2001
+++ linux-2.4.17-wilson/include/linux/sysctl.h	Wed Jan 16 11:54:00 2002
@@ -204,7 +204,8 @@
 	NET_CORE_NO_CONG_THRESH=13,
 	NET_CORE_NO_CONG=14,
 	NET_CORE_LO_CONG=15,
-	NET_CORE_MOD_CONG=16
+	NET_CORE_MOD_CONG=16,
+	NET_CORE_HIRES_RX_TIMESTAMP=17
 };

 /* /proc/sys/net/ethernet */
diff -urN -X dontdiff linux-2.4.17/net/core/dev.c linux-2.4.17-wilson/net/core/dev.c
--- linux-2.4.17/net/core/dev.c	Wed Nov  7 14:39:36 2001
+++ linux-2.4.17-wilson/net/core/dev.c	Wed Jan 16 11:53:30 2002
@@ -1069,7 +1069,6 @@
 /*=======================================================================
 			Receiver routines
   =======================================================================*/
-
 int netdev_max_backlog = 300;
 /* These numbers are selected based on intuition and some
  * experimentatiom, if you have more scientific way of doing this
@@ -1082,6 +1081,7 @@

 struct netif_rx_stats netdev_rx_stat[NR_CPUS];

+int hires_rx_timestamp;

 #ifdef CONFIG_NET_HW_FLOWCONTROL
 atomic_t netdev_dropping = ATOMIC_INIT(0);
@@ -1217,8 +1217,12 @@
 	struct softnet_data *queue;
 	unsigned long flags;

-	if (skb->stamp.tv_sec == 0)
-		get_fast_time(&skb->stamp);
+	if (skb->stamp.tv_sec == 0) {
+		if (hires_rx_timestamp)
+			do_gettimeofday(&skb->stamp);
+		else
+			get_fast_time(&skb->stamp);
+	}

 	/* The code is rearranged so that the path is the most
 	   short when CPU is congested, but is still operating.
diff -urN -X dontdiff linux-2.4.17/net/core/sysctl_net_core.c linux-2.4.17-wilson/net/core/sysctl_net_core.c
--- linux-2.4.17/net/core/sysctl_net_core.c	Tue Oct 10 10:33:52 2000
+++ linux-2.4.17-wilson/net/core/sysctl_net_core.c	Wed Jan 16 11:52:39 2002
@@ -19,6 +19,7 @@
 extern int netdev_fastroute;
 extern int net_msg_cost;
 extern int net_msg_burst;
+extern int hires_rx_timestamp;

 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
@@ -62,6 +63,9 @@
 	{NET_CORE_MOD_CONG, "mod_cong",
 	 &mod_cong, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
+	{NET_CORE_HIRES_RX_TIMESTAMP, "hires_rx_timestamp",
+	 &hires_rx_timestamp, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
 #ifdef CONFIG_NET_FASTROUTE
 	{NET_CORE_FASTROUTE, "netdev_fastroute",
 	 &netdev_fastroute, sizeof(int), 0644, NULL,


