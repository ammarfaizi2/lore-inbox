Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289114AbSBZQJe>; Tue, 26 Feb 2002 11:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290827AbSBZQJY>; Tue, 26 Feb 2002 11:09:24 -0500
Received: from krynn.axis.se ([193.13.178.10]:41860 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S289114AbSBZQJH>;
	Tue, 26 Feb 2002 11:09:07 -0500
Date: Tue, 26 Feb 2002 17:09:00 +0100 (CET)
From: Bjorn Wesen <bjorn.wesen@axis.com>
Reply-To: Bjorn Wesen <bjorn.wesen@axis.com>
To: linux-kernel@vger.kernel.org
Subject: __skb_dequeue irq race ?
In-Reply-To: <20020226164044.A7726@stud.ntnu.no>
Message-ID: <Pine.LNX.3.96.1020226170236.21886G-100000@fafner.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to debug what looks like a race-condition I reach with heavy
interrupt traffic, including heavy ethernet traffic.

The result of the race (if it is one) is that the pointers in
skb_head_pool in the network code get corrupted, like the list heads
->next pointer points to the zero-page and other nasty things.

I've gotten an oops from different codepaths but one caught my eye
especially in that there seems to be a codepath with IRQ's enabled which
calls __skb_dequeue, namely do_softirq calls net_tx_action which uses
qdisc_restart which calls q->dequeue, which contains pfifo_fast_dequeue
which calls __skb_dequeue directly.

Trace; c009a508 <pfifo_fast_dequeue+22/5a>
Trace; c009a16e <qdisc_restart+16/b6> 
Trace; c0094b44 <net_tx_action+7c/8c>
Trace; c0008a8c <do_softirq+4c/94>

Before diving deeper into the fray, is this normal ? If __skb_dequeue is
called with irq's enabled, couldn't another network interrupt cause a
race, corrupting the skb_head_pool linked structure ?

/BW



