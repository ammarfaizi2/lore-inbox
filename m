Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUJNT6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUJNT6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJNT5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:57:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26600 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267508AbUJNT5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:57:12 -0400
Date: Thu, 14 Oct 2004 21:57:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014195757.GA19295@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <1097782921.5310.10.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097782921.5310.10.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> This was during NFS startup in init.
> 
> using smp_processor_id() in preemptible [00000001] code:
> rpc.rquotad/2158
> caller is ipt_do_table+0x7b/0x3a0
>  [<c011aa15>] smp_processor_id+0x95/0xa0
>  [<c038cbfb>] ipt_do_table+0x7b/0x3a0

ugh, this is a nasty one - if you look at the TABLE_OFFSET trickery in
ipt_do_table it's basically an open-coded per-CPU variable in essence. 
(probably predating percpu.h so it's fair.) Could you try the quick hack
below? (it compiles but is otherwise untested)

The proper solution would be to change the code to use per-cpu variables
(and get that patch accepted upstream) and then trivially convert it to
get_cpu_var_locked().

	Ingo

--- linux/net/ipv4/netfilter/ip_tables.c.orig
+++ linux/net/ipv4/netfilter/ip_tables.c
@@ -287,10 +287,14 @@ ipt_do_table(struct sk_buff **pskb,
 	 * match it. */
 	offset = ntohs(ip->frag_off) & IP_OFFSET;
 
+#ifdef CONFIG_PREEMPT_REALTIME
+	write_lock_bh(&table->lock);
+#else
 	read_lock_bh(&table->lock);
+#endif
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
 	table_base = (void *)table->private->entries
-		+ TABLE_OFFSET(table->private, smp_processor_id());
+		+ TABLE_OFFSET(table->private, _smp_processor_id());
 	e = get_entry(table_base, table->private->hook_entry[hook]);
 
 #ifdef CONFIG_NETFILTER_DEBUG
@@ -397,7 +401,11 @@ ipt_do_table(struct sk_buff **pskb,
 #ifdef CONFIG_NETFILTER_DEBUG
 	((struct ipt_entry *)table_base)->comefrom = 0xdead57ac;
 #endif
+#ifdef CONFIG_PREEMPT_REALTIME
+	write_unlock_bh(&table->lock);
+#else
 	read_unlock_bh(&table->lock);
+#endif
 
 #ifdef DEBUG_ALLOW_ALL
 	return NF_ACCEPT;
