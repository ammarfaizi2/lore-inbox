Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVKBPMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVKBPMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVKBPMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:12:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36259 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965074AbVKBPMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:12:23 -0500
Date: Wed, 2 Nov 2005 16:12:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051102151242.GA23809@elte.hu>
References: <200511021420.28104.pluto@agmk.net> <20051102134723.GB13468@elte.hu> <20051102135516.GA16175@elte.hu> <20051102140025.GA17385@elte.hu> <20051102142533.GA18453@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102142533.GA18453@elte.hu>
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


more updates: NETFILTER_DEBUG catches the situation too - the problem 
seems to be wrong reference counts on the skb. I've also added a few 
printouts of ct fields:

NF_IP_ASSERT: include/linux/netfilter_ipv4/ip_conntrack.h:329(ip_conntrack_put)
NF_IP_ASSERT: net/ipv4/netfilter/ip_conntrack_core.c:346(destroy_conntrack)
NF_IP_ASSERT: net/ipv4/netfilter/ip_conntrack_core.c:346(destroy_conntrack)
BUG: NAT ct f0d6cf10 still hashed!
.. list empty ORIG: 0, REPLY: 0
.. expecting: 0
.. timeout pending: 1
.. ct_general: 0 [f0d6cf10]
.. nfct: f0d6cf10
 [<c0103d23>] dump_stack+0x13/0x20 (12)
 [<c03a878b>] check_hashes+0x13b/0x150 (48)
 [<c03a8878>] destroy_conntrack+0xd8/0x1f0 (32)
 [<c0373cf2>] ip_local_deliver+0x182/0x270 (40)
 [<c03742f5>] ip_rcv+0x2f5/0x4e0 (64)
 [<c035f95d>] netif_receive_skb+0x15d/0x1e0 (52)
 [<c02f2d97>] rtl8139_rx+0x1b7/0x340 (80)
 [<c02f3108>] rtl8139_poll+0x58/0x110 (40)
 [<c035fb32>] net_rx_action+0x72/0x140 (24)
 [<c011ee09>] ksoftirqd+0xb9/0x140 (40)
 [<c012d7d4>] kthread+0x94/0xa0 (28)
 [<c01010e9>] kernel_thread_helper+0x5/0xc (138035228)

i.e. we have ct->timeout still pending but the reference count is 0?  
That cannot be right.

	Ingo
