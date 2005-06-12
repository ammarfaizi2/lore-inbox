Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVFLT7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFLT7J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVFLTZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:25:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42508 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262658AbVFLRgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:36:36 -0400
Date: Sun, 12 Jun 2005 19:36:14 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "David S. Miller" <davem@davemloft.net>, xschmi00@stud.feec.vutbr.cz,
       alastair@unixtrix.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612173614.GA11157@alpha.home.local>
References: <42A9C607.4030209@unixtrix.com> <20050611062413.GA1324@pcw.home.local> <20050611074350.GD28759@alpha.home.local> <200506122010.33075.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506122010.33075.vda@ilport.com.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 08:10:33PM +0300, Denis Vlasenko wrote:
> > Does it seem appropriate for mainline ? In this case, I would also backport
> > it to 2.4 and send it to you for inclusion.
> 
> It does not contain a comment why it is configurable.

You're right. Better with this ?

Willy
--

diff -pruNX dontdiff linux-2.6.11.11/Documentation/networking/ip-sysctl.txt linux-2.6.11.11-tcp/Documentation/networking/ip-sysctl.txt
--- linux-2.6.11.11/Documentation/networking/ip-sysctl.txt	Sun Mar  6 13:08:46 2005
+++ linux-2.6.11.11-tcp/Documentation/networking/ip-sysctl.txt	Sun Jun 12 19:28:50 2005
@@ -368,6 +368,27 @@ tcp_frto - BOOLEAN
 	where packet loss is typically due to random radio interference
 	rather than intermediate router congestion.
 
+tcp_simult_connect - BOOLEAN
+	Enables TCP simultaneous connect feature conforming to RFC793.
+	Strict implementation of RFC793 (TCP) requires support for a feature
+	called "simultaneous connect", which allows two clients to connect to
+	each other without anyone entering a listening state.  While almost
+	never used, and supported by few OSes, Linux supports this feature.
+
+	However, it introduces a weakness in the protocol which makes it very
+	easy for an attacker to prevent a client from connecting to a known
+	server. The attacker only has to guess the source port to shut down
+	the client connection during its establishment. The impact is limited,
+	but it may be used to prevent an antivirus or IPS from fetching updates
+	and not detecting an attack, or to prevent an SSL gateway from fetching
+	a CRL for example.
+
+	If you want backwards compatibility with every possible application,
+	you should set it to 1. If you prefer to enhance security on your
+	systems at the risk of breaking very rare specific applications, you'd
+	better let it to 0.
+	Default: 0
+
 somaxconn - INTEGER
 	Limit of socket listen() backlog, known in userspace as SOMAXCONN.
 	Defaults to 128.  See also tcp_max_syn_backlog for additional tuning
diff -pruNX dontdiff linux-2.6.11.11/include/linux/sysctl.h linux-2.6.11.11-tcp/include/linux/sysctl.h
--- linux-2.6.11.11/include/linux/sysctl.h	Sun Jun 12 10:44:01 2005
+++ linux-2.6.11.11-tcp/include/linux/sysctl.h	Sat Jun 11 09:00:22 2005
@@ -345,6 +345,7 @@ enum
 	NET_TCP_MODERATE_RCVBUF=106,
 	NET_TCP_TSO_WIN_DIVISOR=107,
 	NET_TCP_BIC_BETA=108,
+	NET_TCP_SIMULT_CONNECT=109,
 };
 
 enum {
diff -pruNX dontdiff linux-2.6.11.11/include/net/tcp.h linux-2.6.11.11-tcp/include/net/tcp.h
--- linux-2.6.11.11/include/net/tcp.h	Sun Jun 12 10:44:01 2005
+++ linux-2.6.11.11-tcp/include/net/tcp.h	Sat Jun 11 08:56:16 2005
@@ -608,6 +608,7 @@ extern int sysctl_tcp_bic_low_window;
 extern int sysctl_tcp_bic_beta;
 extern int sysctl_tcp_moderate_rcvbuf;
 extern int sysctl_tcp_tso_win_divisor;
+extern int sysctl_tcp_simult_connect;
 
 extern atomic_t tcp_memory_allocated;
 extern atomic_t tcp_sockets_allocated;
diff -pruNX dontdiff linux-2.6.11.11/net/ipv4/sysctl_net_ipv4.c linux-2.6.11.11-tcp/net/ipv4/sysctl_net_ipv4.c
--- linux-2.6.11.11/net/ipv4/sysctl_net_ipv4.c	Sun Jun 12 10:44:01 2005
+++ linux-2.6.11.11-tcp/net/ipv4/sysctl_net_ipv4.c	Sat Jun 11 08:55:27 2005
@@ -690,6 +690,14 @@ ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= NET_TCP_SIMULT_CONNECT,
+		.procname	= "tcp_simult_connect",
+		.data		= &sysctl_tcp_simult_connect,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -pruNX dontdiff linux-2.6.11.11/net/ipv4/tcp_input.c linux-2.6.11.11-tcp/net/ipv4/tcp_input.c
--- linux-2.6.11.11/net/ipv4/tcp_input.c	Sun Jun 12 10:44:01 2005
+++ linux-2.6.11.11-tcp/net/ipv4/tcp_input.c	Sun Jun 12 19:33:56 2005
@@ -84,6 +84,7 @@ int sysctl_tcp_adv_win_scale = 2;
 
 int sysctl_tcp_stdurg;
 int sysctl_tcp_rfc1337;
+int sysctl_tcp_simult_connect;
 int sysctl_tcp_max_orphans = NR_FILE;
 int sysctl_tcp_frto;
 int sysctl_tcp_nometrics_save;
@@ -4620,10 +4621,12 @@ discard:
 	if (tp->rx_opt.ts_recent_stamp && tp->rx_opt.saw_tstamp && tcp_paws_check(&tp->rx_opt, 0))
 		goto discard_and_undo;
 
-	if (th->syn) {
+	if (th->syn && sysctl_tcp_simult_connect) {
 		/* We see SYN without ACK. It is attempt of
 		 * simultaneous connect with crossed SYNs.
 		 * Particularly, it can be connect to self.
+		 * This feature is disabled by default as it introduces a
+		 * weakness in the protocol. It can be enabled by a sysctl.
 		 */
 		tcp_set_state(sk, TCP_SYN_RECV);
 


