Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTIWAgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTIWAgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:36:47 -0400
Received: from home.kvack.org ([216.138.200.138]:28116 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262798AbTIWAgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 20:36:41 -0400
Date: Mon, 22 Sep 2003 20:36:29 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Peter Chubb <peter@chubb.wattle.id.au>, davem@redhat.com
Cc: Andi Kleen <ak@suse.de>, Grant Grundler <iod00d@hp.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030922203629.B21836@kvack.org>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au> <20030919043847.GA2996@cup.hp.com> <20030919044315.GC7666@wotan.suse.de> <16234.36238.848366.753588@wombat.chubb.wattle.id.au> <20030919055304.GE16928@wotan.suse.de> <20030919064922.B3783@kvack.org> <16239.38154.969505.748461@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16239.38154.969505.748461@wombat.chubb.wattle.id.au>; from peter@chubb.wattle.id.au on Tue, Sep 23, 2003 at 10:34:18AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denied.  Dave, please explain.

		-ben

On Tue, Sep 23, 2003 at 10:34:18AM +1000, Peter Chubb wrote:
> 
> OK, a patch for the driver in 2.6.0-test5 is appended.
> 
> I suspect that there are other architectures that don't like unaligned
> accesses...  feel free to add them to the #ifdef.
> This is based on code I found in the revision history.  It seems to
> work.
> 
> Without this patch, the console messages saying `unaligned access'
> would come out fast enough and often enough to delay and or miss
> interrupts, leading to an eventual machine hangup on I2000.
> 
> ===== drivers/net/ns83820.c 1.30 vs edited =====
> --- 1.30/drivers/net/ns83820.c	Thu Sep 11 09:46:45 2003
> +++ edited/drivers/net/ns83820.c	Mon Sep 22 12:49:18 2003
> @@ -793,6 +793,25 @@
>  	}
>  }
>  
> +#if defined(__ia64__)
> +static inline struct sk_buff *skb_realign_iphdr(struct sk_buff *skb, int len, struct ns83820 *dev)
> +{
> +	struct sk_buff *tmp = __dev_alloc_skb(len+2, GFP_ATOMIC);
> +	if (!tmp)
> +		return NULL;
> +	tmp->dev = &dev->net_dev;
> +	skb_reserve(tmp, 2);
> +	memcpy(skb_put(tmp, len), skb->data, len);
> +	kfree_skb(skb);
> +	return tmp;
> +}
> +#else
> +static inline  struct sk_buff *skb_realign_iphdr(struct sk_buff *skb, int len, struct ns83820 *dev)
> +{
> +	return skb;
> +}
> +#endif
> +
>  static void FASTCALL(ns83820_rx_kick(struct ns83820 *dev));
>  static void ns83820_rx_kick(struct ns83820 *dev)
>  {
> @@ -862,6 +881,7 @@
>  		if (likely(CMDSTS_OK & cmdsts)) {
>  			int len = cmdsts & 0xffff;
>  			skb_put(skb, len);
> +			skb = skb_realign_iphdr(skb, len, dev);
>  			if (unlikely(!skb))
>  				goto netdev_mangle_me_harder_failed;
>  			if (cmdsts & CMDSTS_DEST_MULTI)

-- 
"The software industry today survives only through an unstated agreement 
not to stir things up too much.  We must hope this lawsuit [by SCO] isn't 
the big stirring spoon." -- Ian Lance Taylor, Linux Journal, June 2003
