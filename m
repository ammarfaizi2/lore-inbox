Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268845AbUIAHa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268845AbUIAHa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUIAHaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:30:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8671 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268845AbUIAH3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:29:22 -0400
Date: Wed, 1 Sep 2004 09:30:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040901073056.GA20020@elte.hu>
References: <OF8AC76C1C.20634F1C-ON86256F00.007813C0@raytheon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <OF8AC76C1C.20634F1C-ON86256F00.007813C0@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> >regarding this particular latency, could you try the attached patch
> >ontop of -Q5? It turns the ->poll() loop into separate, individually
> >preemptable iterations instead of one batch of processing. In theory
> >this should result in latency being lower regardless of the
> >netdev_max_backlog value.

> In all cases, Ctrl-Alt-Del was good enough to get a clean reboot.
> 
> This looks like a bad patch; will go back to the last good kernel for
> further testing.

ok, i think i found why it broke for you - forgot to update 'budget' in
the else branch. Could you try the attached patch ontop of -Q5? You'll
get a new sysctl as /proc/sys/net/core/netdev_backlog_granularity, with
a default value of 1. This should result in a working system with a
healthy backlog but with the preemption properties of netdev_max_backlog
== 1. Increasing the granularity will do give more chunkyness of
processing. Do you still get long RX latencies with the finest
granularity of 1, without any of the bad side-effects like booting
problems or lost packets?

	Ingo

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rx-granularity.patch"

--- linux/net/core/dev.c.orig
+++ linux/net/core/dev.c
@@ -1403,6 +1403,7 @@ out:
   =======================================================================*/
 
 int netdev_max_backlog = 8;
+int netdev_backlog_granularity = 1;
 int weight_p = 64;            /* old backlog weight */
 /* These numbers are selected based on intuition and some
  * experimentatiom, if you have more scientific way of doing this
@@ -1903,7 +1904,8 @@ static void net_rx_action(struct softirq
 {
 	struct softnet_data *queue = &__get_cpu_var(softnet_data);
 	unsigned long start_time = jiffies;
-	int budget = netdev_max_backlog;
+	int budget = netdev_max_backlog, left,
+		gran = netdev_backlog_granularity;
 
 	
 	local_irq_disable();
@@ -1926,7 +1928,8 @@ static void net_rx_action(struct softirq
 		dev = list_entry(queue->poll_list.next,
 				 struct net_device, poll_list);
 
-		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
+		left = gran;
+		if (dev->quota <= 0 || dev->poll(dev, &left)) {
 			local_irq_disable();
 			list_del(&dev->poll_list);
 			list_add_tail(&dev->poll_list, &queue->poll_list);
@@ -1938,6 +1941,7 @@ static void net_rx_action(struct softirq
 			dev_put(dev);
 			local_irq_disable();
 		}
+		budget -= gran - left;
 	}
 out:
 	local_irq_enable();
--- linux/net/core/sysctl_net_core.c.orig
+++ linux/net/core/sysctl_net_core.c
@@ -12,7 +12,7 @@
 
 #ifdef CONFIG_SYSCTL
 
-extern int netdev_max_backlog;
+extern int netdev_max_backlog, netdev_backlog_granularity;
 extern int weight_p;
 extern int no_cong_thresh;
 extern int no_cong;
@@ -99,6 +99,14 @@ ctl_table core_table[] = {
 		.proc_handler	= &proc_dointvec
 	},
 	{
+		.ctl_name	= NET_CORE_MAX_BACKLOG,
+		.procname	= "netdev_backlog_granularity",
+		.data		= &netdev_backlog_granularity,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
 		.ctl_name	= NET_CORE_NO_CONG_THRESH,
 		.procname	= "no_cong_thresh",
 		.data		= &no_cong_thresh,

--X1bOJ3K7DJ5YkBrT--
