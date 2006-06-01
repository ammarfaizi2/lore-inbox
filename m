Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbWFAGfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbWFAGfV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbWFAGfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:35:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:17645 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965297AbWFAGfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:35:17 -0400
Date: Thu, 1 Jun 2006 08:35:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       NetDEV list <netdev@vger.kernel.org>
Subject: [patch, -rc5-mm1] lock validator: special locking: net/ipv4/igmp.c #2
Message-ID: <20060601063537.GA19931@elte.hu>
References: <4807377b0605311704g44fe10f1oc54315276890071@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0605311704g44fe10f1oc54315276890071@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

> well, when running e1000 through some code paths on FC4 + 
> 2.6.17-rc5-mm1 + ingo's latest rollup patch, with this lockdep debug 
> option enabled I got this:
> 
> e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
> 
> ======================================
> [ BUG: bad unlock ordering detected! ]
> --------------------------------------
> mDNSResponder/2361 is trying to release lock (&in_dev->mc_list_lock) at:
> [<ffffffff81233f5a>] ip_mc_add_src+0x85/0x1f8

ok, could you try the patch below? (i also updated the rollup with this 
fix)

	Ingo

---------------------
Subject: lock validator: special locking: net/ipv4/igmp.c #2
From: Ingo Molnar <mingo@elte.hu>

another case of non-nested unlocking igmp.c.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/ipv4/igmp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/net/ipv4/igmp.c
===================================================================
--- linux.orig/net/ipv4/igmp.c
+++ linux/net/ipv4/igmp.c
@@ -1646,7 +1646,7 @@ static int ip_mc_add_src(struct in_devic
 		return -ESRCH;
 	}
 	spin_lock_bh(&pmc->lock);
-	read_unlock(&in_dev->mc_list_lock);
+	read_unlock_non_nested(&in_dev->mc_list_lock);
 
 #ifdef CONFIG_IP_MULTICAST
 	sf_markstate(pmc);
