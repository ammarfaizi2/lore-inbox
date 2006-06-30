Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWF3H1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWF3H1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWF3H1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:27:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:64236 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751227AbWF3H1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:27:19 -0400
Date: Fri, 30 Jun 2006 09:22:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060630072231.GB7057@elte.hu>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630065041.GB6572@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5089]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Miles, does the patch below make the message go away?

	Ingo

----------------
Subject: lockdep, annotate slocks: turn lockdep off for them
From: Ingo Molnar <mingo@elte.hu>

temporary solution to turn off slock related false positives:
the slock is pretty much the only lock type in the kernel that
is half spinlock, half waitqueue. "Process level" and "softirq level"
uses of slock are excluded - albeit the spinlock itself is not
permanently held in process context.

The right solution will be to annotate slock uses with
acquire()/release(). (i.e. to treat sock_owned_by_user() flagged
areas as an exclusion area too)

(this temporary solution is not as bad as it might sound, because it 
does not eliminate the various ->sk_backlog_rcv() related dependencies 
from the validator's dependency graph - what it does is that it doesnt 
record them relative to slock. [the callbacks will still be executed and 
covered when the backlog is processed.])

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/core/sock.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux/net/core/sock.c
===================================================================
--- linux.orig/net/core/sock.c
+++ linux/net/core/sock.c
@@ -250,9 +250,17 @@ int sk_receive_skb(struct sock *sk, stru
 	skb->dev = NULL;
 
 	bh_lock_sock(sk);
-	if (!sock_owned_by_user(sk))
+	if (!sock_owned_by_user(sk)) {
+		/*
+		 * FIXME: teach the validator about slocks.
+		 *
+		 * For now we dont record dependencies in
+		 * this codepath.
+		 */
+		lockdep_off();
 		rc = sk->sk_backlog_rcv(sk, skb);
-	else
+		lockdep_on();
+	} else
 		sk_add_backlog(sk, skb);
 	bh_unlock_sock(sk);
 out:
