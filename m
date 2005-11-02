Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVKBPde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVKBPde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVKBPde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:33:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39064 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965085AbVKBPdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:33:33 -0500
Date: Wed, 2 Nov 2005 16:33:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051102153352.GA26115@elte.hu>
References: <200511021420.28104.pluto@agmk.net> <20051102134723.GB13468@elte.hu> <20051102135516.GA16175@elte.hu> <20051102140025.GA17385@elte.hu> <20051102142533.GA18453@elte.hu> <20051102151242.GA23809@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102151242.GA23809@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> more updates: NETFILTER_DEBUG catches the situation too - the problem 
> seems to be wrong reference counts on the skb. [...]

ok, could you check whether the patch below fixes the problem for you?  
(I have also put it into -rt4)

local_bh_disable()/enable() is a NOP under PREEMPT_RT, and the 
ip_ct_deliver_cached_events PER_CPU code relies on not being preempted 
by the net_rx_action softirq handler. So this is a bug in PREEMPT_RT and 
the upstream code should be fine.

	Ingo

Index: linux/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ linux/net/ipv4/netfilter/ip_conntrack_core.c
@@ -105,11 +105,11 @@ void ip_ct_deliver_cached_events(const s
 {
 	struct ip_conntrack_ecache *ecache;
 	
-	local_bh_disable();
+	read_lock_bh(&ip_conntrack_lock);
 	ecache = &__get_cpu_var(ip_conntrack_ecache);
 	if (ecache->ct == ct)
 		__ip_ct_deliver_cached_events(ecache);
-	local_bh_enable();
+	read_unlock_bh(&ip_conntrack_lock);
 }
 
 void __ip_ct_event_cache_init(struct ip_conntrack *ct)
