Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUINLD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUINLD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269276AbUINLD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:03:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31971 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269281AbUINLCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:02:31 -0400
Date: Tue, 14 Sep 2004 12:44:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [patch] sched, net: fix scheduling latencies in __release_sock
Message-ID: <20040914104449.GA30790@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20040914102517.GE24622@elte.hu>
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes long scheduling latencies caused by backlog
triggered by __release_sock(). That code only executes in process
context, and we've made the backlog queue private already at this point
so it is safe to do a cond_resched_softirq().

This patch has been in the -VP patchset for some time.

	Ingo

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-release_sock.patch"


the attached patch fixes long scheduling latencies caused by backlog
triggered by __release_sock(). That code only executes in process
context, and we've made the backlog queue private already at this point
so it is safe to do a cond_resched_softirq().

This patch has been in the -VP patchset for some time.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/net/core/sock.c.orig	
+++ linux/net/core/sock.c	
@@ -933,6 +933,15 @@ void __release_sock(struct sock *sk)
 
 			skb->next = NULL;
 			sk->sk_backlog_rcv(sk, skb);
+
+			/*
+			 * We are in process context here with softirqs
+			 * disabled, use cond_resched_softirq() to preempt.
+			 * This is safe to do because we've taken the backlog
+			 * queue private:
+			 */
+			cond_resched_softirq();
+
 			skb = next;
 		} while (skb != NULL);
 

--TB36FDmn/VVEgNH/--
