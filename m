Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWEBNgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWEBNgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWEBNgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:36:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:1183 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964815AbWEBNgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:36:12 -0400
Date: Tue, 2 May 2006 15:40:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, coreteam@netfilter.org
Subject: Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in sctp_new(), do_basic_checks()
Message-ID: <20060502134053.GA30917@elte.hu>
References: <20060502113454.GA28601@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502113454.GA28601@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> running an "isic" stresstest on and against a testbox [which, amongst 
> other things, generates random incoming and outgoing packets] on 
> 2.6.17-rc3 (and 2.6.17-rc3-mm1) over gigabit results in a reproducible 
> lockup, after 5-10 minutes of runtime:
> 
> BUG: soft lockup detected on CPU#0!
>  [<c0104e7f>] show_trace+0xd/0xf
>  [<c0104e96>] dump_stack+0x15/0x17
>  [<c015ad02>] softlockup_tick+0xc5/0xd9
>  [<c0134c02>] run_local_timers+0x22/0x24
>  [<c0134fb7>] update_process_times+0x40/0x65
>  [<c011aa56>] smp_apic_timer_interrupt+0x58/0x60
>  [<c010492b>] apic_timer_interrupt+0x27/0x2c
>  [<c0f00df9>] sctp_new+0x8b/0x235
>  [<c0ef9666>] ip_conntrack_in+0x175/0x4ca
>  [<c0eb6dd7>] nf_iterate+0x31/0x94
>  [<c0eb6e83>] nf_hook_slow+0x49/0xda
>  [<c0ec2f55>] ip_rcv+0x24c/0x567
>  [<c0e7dec4>] netif_receive_skb+0x34b/0x397
>  [<c07870cb>] rtl8139_poll+0x3d8/0x5db
>  [<c0e7c7ad>] net_rx_action+0x9b/0x1ba
>  [<c0131955>] __do_softirq+0x6e/0xec
>  [<c0106187>] do_softirq+0x59/0xcd

thinking about it, what prevents the SCTP chunk's len field from being 
zero, and thus causing an infinite loop in for_each_sctp_chunk()? The 
patch below should fix that.

	Ingo

----
From: Ingo Molnar <mingo@elte.hu>

fix infinite loop in the SCTP-netfilter code: check SCTP chunk size to 
guarantee progress of for_each_sctp_chunk(). (all other uses of 
for_each_sctp_chunk() are preceded by do_basic_checks(), so this fix 
should be complete.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
@@ -227,6 +227,15 @@ static int do_basic_checks(struct ip_con
 	flag = 0;
 
 	for_each_sctp_chunk (skb, sch, _sch, offset, count) {
+		unsigned int len = (htons(sch->length) + 3) & ~3;
+
+		/*
+		 * Dont get into a loop with zero-sized or negative
+		 * length values:
+		 */
+		if (!len || len >= skb->len)
+			goto fail;
+
 		DEBUGP("Chunk Num: %d  Type: %d\n", count, sch->type);
 
 		if (sch->type == SCTP_CID_INIT 
@@ -241,6 +250,7 @@ static int do_basic_checks(struct ip_con
 			|| sch->type == SCTP_CID_COOKIE_ECHO
 			|| flag)
 		     && count !=0 ) {
+fail:
 			DEBUGP("Basic checks failed\n");
 			return 1;
 		}
