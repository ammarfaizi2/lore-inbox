Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVFIA1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVFIA1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVFIA0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:26:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:65421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262234AbVFIAZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:25:00 -0400
Date: Wed, 8 Jun 2005 17:24:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, shemminger@osdl.org
Subject: [patch 09/09] [PKT_SCHED]: netem: duplication fix
Message-ID: <20050609002407.GP13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Netem duplication can cause infinite loop in qdisc_run
because the qlen of the parent qdisc is not affected by the duplication.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

Index: 2.6.11.11-net/net/sched/sch_netem.c
===================================================================
--- 2.6.11.11-net.orig/net/sched/sch_netem.c
+++ 2.6.11.11-net/net/sched/sch_netem.c
@@ -184,10 +184,15 @@ static int netem_enqueue(struct sk_buff 
 	/* Random duplication */
 	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor)) {
 		struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
-
-		pr_debug("netem_enqueue: dup %p\n", skb2);
-		if (skb2)
-			delay_skb(sch, skb2);
+		if (skb2) {
+			struct Qdisc *rootq = sch->dev->qdisc;
+			u32 dupsave = q->duplicate; 
+
+			/* prevent duplicating a dup... */
+			q->duplicate = 0;
+			rootq->enqueue(skb2, rootq);
+			q->duplicate = dupsave;
+		}
 	}
 
 	/* If doing simple delay then gap == 0 so all packets
