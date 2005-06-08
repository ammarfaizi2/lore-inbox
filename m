Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVFIAAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVFIAAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVFHX6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:58:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:48262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261408AbVFHX4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:56:49 -0400
Date: Wed, 8 Jun 2005 16:55:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       laforge@netfilter.org
Subject: [patch 02/09] [NETFILTER]: Fix deadlock with ip_queue and tcp local input path
Message-ID: <20050608235553.GI13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we have ip_queue being used from LOCAL_IN, then we end up with a
situation where the verdicts coming back from userspace traverse the TCP
input path from syscall context.  While this seems to work most of the
time, there's an ugly deadlock:

syscall context is interrupted by the timer interrupt.  When the timer
interrupt leaves, the timer softirq get's scheduled and calls
tcp_delack_timer() and alike.  They themselves do bh_lock_sock(sk),
which is already held from somewhere else -> boom.

I've now tested the suggested solution by Patrick McHardy and Herbert Xu to
simply use local_bh_{en,dis}able().

Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>

--- 1/net/ipv4/netfilter/ip_queue.c	2005-05-27 09:44:32.000000000 +0200
+++ 2/net/ipv4/netfilter/ip_queue.c	2005-05-27 09:47:13.000000000 +0200
@@ -3,6 +3,7 @@
  * communicating with userspace via netlink.
  *
  * (C) 2000-2002 James Morris <jmorris@intercode.com.au>
+ * (C) 2003-2005 Netfilter Core Team <coreteam@netfilter.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,6 +15,7 @@
  *             Zander).
  * 2000-08-01: Added Nick Williams' MAC support.
  * 2002-06-25: Code cleanup.
+ * 2005-05-26: local_bh_{disable,enable} around nf_reinject (Harald Welte)
  *
  */
 #include <linux/module.h>
@@ -66,7 +68,15 @@
 static void
 ipq_issue_verdict(struct ipq_queue_entry *entry, int verdict)
 {
+	/* TCP input path (and probably other bits) assume to be called
+	 * from softirq context, not from syscall, like ipq_issue_verdict is
+	 * called.  TCP input path deadlocks with locks taken from timer
+	 * softirq, e.g.  We therefore emulate this by local_bh_disable() */
+
+	local_bh_disable();
 	nf_reinject(entry->skb, entry->info, verdict);
+	local_bh_enable();
+
 	kfree(entry);
 }
 
