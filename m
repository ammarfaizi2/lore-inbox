Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267643AbUHELSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267643AbUHELSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267630AbUHELSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:18:31 -0400
Received: from zero.aec.at ([193.170.194.10]:19972 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267643AbUHELRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:17:35 -0400
To: prasanna@in.ibm.com
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com
Subject: Re: [3/3] kprobes-netpktlog-268-rc3.patch
References: <2pNvS-1CQ-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 05 Aug 2004 13:17:16 +0200
In-Reply-To: <2pNvS-1CQ-1@gated-at.bofh.it> (Prasanna S. Panchamukhi's
 message of "Thu, 05 Aug 2004 12:20:04 +0200")
Message-ID: <m33c31ygub.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
> +
> +static struct jprobe netpkt[] = {
> +	{
> +		{.addr = (kprobe_opcode_t *) netif_rx},
> +		.entry = (kprobe_opcode_t *) jnetif_rx

[...] Perhaps it would be better to resolve this using kallsyms. 
This way you could support the user passing a list of functions
they want to be traced. and you wouldn't need to add all these 
EXPORT_SYMBOLS.

> +
> +	printk("Filtering of network packets enabled...\n");

Nit - it doesn't filter anything.

> +
> +static inline void netfilter_ip(struct sk_buff *skb)
> +{
> +	struct ipt_log_info info;
> +	struct iphdr *iph;
> +	/* Log IP options */
> +	info.logflags = IPT_LOG_IPOPT;
> +
> +	/*
> +	 * Check if the protocol is IP before dumping the packet.
> +	 */
> +	if (skb->protocol == htons(ETH_P_IP) )
> +	{
> +		iph = (struct iphdr *) skb->data;
> +
> +		if ((src_ip == 0 && iph->daddr == tgt_ip)
> +			|| (tgt_ip == 0 && iph->saddr == src_ip)
> +			|| (iph->saddr == src_ip && iph->daddr == tgt_ip))

This looks a bit fragile. I don't think skb->data == iphdr is guaranteed
everywhere (I'm surprised it works for your dupack hook for example, Does it
really?). Better is to use skb->nh.iph, but that is also not true
everywhere. Better would be probably to let this be passed
by the individual hook function.

Also a Lindent run on the file couldn't hurt.

-Andi

