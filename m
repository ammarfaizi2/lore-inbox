Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269249AbUINKYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269249AbUINKYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269256AbUINKYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:24:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26073 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269249AbUINKYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:24:00 -0400
Date: Tue, 14 Sep 2004 12:25:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: [patch] sched, net: fix scheduling latencies in netstat
Message-ID: <20040914102517.GE24622@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <20040914101904.GD24622@elte.hu>
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


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes long scheduling latencies caused by access to
the /proc/net/tcp file. The seqfile functions keep softirqs disabled for
a very long time (i've seen reports of 20+ msecs, if there are enough
sockets in the system). With the attached patch it's below 100 usecs.

the cond_resched_softirq() relies on the implicit knowledge that this
code executes in process context and runs with softirqs disabled.

potentially enabling softirqs means that the socket list might change
between buckets - but this is not an issue since seqfiles have a 4K
iteration granularity anyway and /proc/net/tcp is often (much) larger
than that.

This patch has been in the -VP patchset for weeks.

	Ingo

--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-netstat.patch"


the attached patch fixes long scheduling latencies caused by access to
the /proc/net/tcp file. The seqfile functions keep softirqs disabled for
a very long time (i've seen reports of 20+ msecs, if there are enough
sockets in the system). With the attached patch it's below 100 usecs.

the cond_resched_softirq() relies on the implicit knowledge that this
code executes in process context and runs with softirqs disabled.

potentially enabling softirqs means that the socket list might change
between buckets - but this is not an issue since seqfiles have a 4K
iteration granularity anyway and /proc/net/tcp is often (much) larger
than that.

This patch has been in the -VP patchset for weeks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/net/ipv4/tcp_ipv4.c.orig	
+++ linux/net/ipv4/tcp_ipv4.c	
@@ -2227,7 +2227,10 @@ static void *established_get_first(struc
 		struct sock *sk;
 		struct hlist_node *node;
 		struct tcp_tw_bucket *tw;
-	       
+
+		/* We can reschedule _before_ having picked the target: */
+		cond_resched_softirq();
+
 		read_lock(&tcp_ehash[st->bucket].lock);
 		sk_for_each(sk, node, &tcp_ehash[st->bucket].chain) {
 			if (sk->sk_family != st->family) {
@@ -2274,6 +2277,10 @@ get_tw:
 		}
 		read_unlock(&tcp_ehash[st->bucket].lock);
 		st->state = TCP_SEQ_STATE_ESTABLISHED;
+
+		/* We can reschedule between buckets: */
+		cond_resched_softirq();
+
 		if (++st->bucket < tcp_ehash_size) {
 			read_lock(&tcp_ehash[st->bucket].lock);
 			sk = sk_head(&tcp_ehash[st->bucket].chain);

--Q8BnQc91gJZX4vDc--
