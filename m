Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUGFSsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUGFSsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUGFSsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:48:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:47560 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264265AbUGFSsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:48:37 -0400
Date: Tue, 6 Jul 2004 11:47:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bert hubert <ahu@ds9a.nl>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, netdev@oss.sgi.com,
       alessandro.suardi@oracle.com, phyprabab@yahoo.com, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040706093503.GA8147@outpost.ds9a.nl>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	<20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent TCP changes exposed the problem that there ar lots of really broken firewalls 
that strip or alter TCP options.
When the options are modified TCP gets busted now.  The problem is that when
we propose window scaling, we expect that the other side receives the same initial
SYN request that we sent.  If there is corrupting firewalls that strip it then
the window we send is not correctly scaled; so the other side thinks there is not
enough space to send.

I propose that the following that will avoid sending window scaling that
is big enough to break in these cases unless the tcp_rmem has been increased.
It will keep default configuration from blowing in a corrupt world.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	2004-07-06 11:45:18 -07:00
+++ b/include/linux/sysctl.h	2004-07-06 11:45:18 -07:00
@@ -337,7 +337,7 @@
  	NET_TCP_BIC=102,
  	NET_TCP_BIC_FAST_CONVERGENCE=103,
 	NET_TCP_BIC_LOW_WINDOW=104,
-	NET_TCP_DEFAULT_WIN_SCALE=105,
+/*	NET_TCP_DEFAULT_WIN_SCALE */
 	NET_TCP_MODERATE_RCVBUF=106,
 };
 
diff -Nru a/include/net/tcp.h b/include/net/tcp.h
--- a/include/net/tcp.h	2004-07-06 11:45:18 -07:00
+++ b/include/net/tcp.h	2004-07-06 11:45:18 -07:00
@@ -611,7 +611,6 @@
 extern int sysctl_tcp_bic;
 extern int sysctl_tcp_bic_fast_convergence;
 extern int sysctl_tcp_bic_low_window;
-extern int sysctl_tcp_default_win_scale;
 extern int sysctl_tcp_moderate_rcvbuf;
 
 extern atomic_t tcp_memory_allocated;
@@ -1690,6 +1689,13 @@
 		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_WINDOW << 16) | (TCPOLEN_WINDOW << 8) | (wscale));
 }
 
+/* Default window scaling based on the size of the maximum window  */
+static inline __u8 tcp_default_win_scale(void)
+{
+	int b = ffs(sysctl_tcp_rmem[2]);
+	return (b < 17) ? 0 : b-16;
+}
+
 /* Determine a window scaling and initial window to offer.
  * Based on the assumption that the given amount of space
  * will be offered. Store the results in the tp structure.
@@ -1732,8 +1738,7 @@
 		    space - max((space>>sysctl_tcp_app_win), mss>>*rcv_wscale) < 65536/2)
 			(*rcv_wscale)--;
 
-		*rcv_wscale = max((__u8)sysctl_tcp_default_win_scale,
-				  *rcv_wscale);
+		*rcv_wscale = max(tcp_default_win_scale(), *rcv_wscale);
 	}
 
 	/* Set initial window to value enough for senders,
diff -Nru a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
--- a/net/ipv4/sysctl_net_ipv4.c	2004-07-06 11:45:18 -07:00
+++ b/net/ipv4/sysctl_net_ipv4.c	2004-07-06 11:45:18 -07:00
@@ -667,14 +667,6 @@
 		.proc_handler	= &proc_dointvec,
 	},
 	{
-		.ctl_name	= NET_TCP_DEFAULT_WIN_SCALE,
-		.procname	= "tcp_default_win_scale",
-		.data		= &sysctl_tcp_default_win_scale,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
 		.ctl_name	= NET_TCP_MODERATE_RCVBUF,
 		.procname	= "tcp_moderate_rcvbuf",
 		.data		= &sysctl_tcp_moderate_rcvbuf,
diff -Nru a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c	2004-07-06 11:45:18 -07:00
+++ b/net/ipv4/tcp.c	2004-07-06 11:45:18 -07:00
@@ -276,8 +276,6 @@
 
 atomic_t tcp_orphan_count = ATOMIC_INIT(0);
 
-int sysctl_tcp_default_win_scale = 7;
-
 int sysctl_tcp_mem[3];
 int sysctl_tcp_wmem[3] = { 4 * 1024, 16 * 1024, 128 * 1024 };
 int sysctl_tcp_rmem[3] = { 4 * 1024, 87380, 87380 * 2 };
