Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTEVRVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTEVRVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:21:55 -0400
Received: from palrel12.hp.com ([156.153.255.237]:22493 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262827AbTEVRVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:21:53 -0400
Date: Thu, 22 May 2003 10:34:53 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ted Kremenek <kremenek@cs.stanford.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CHECKER] 12 potential leaks in kernel 2.5.69
Message-ID: <20030522173453.GA9303@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Kremenek wrote :
> 
> linux-2.5.69/net/irda/af_irda.c (lines 868-911)
> [BUG/LEAK, kfree_skb not called on error path]

	Fixed in the mega "memory-leak" patch that I sent to Jeff a
few days ago :
	http://marc.theaimsgroup.com/?l=linux-kernel&m=105286497718003&w=2

> linux-2.5.69/drivers/net/wireless/wavelan.c (lines 3012-3041)
> [BUG/LEAK: skb_padto may return new address.  Note certain what
>            the exact semantics are, but skb_padto returns possibly
>            a new skb.  It also may free the skb pointer passed to
>            it, meaning the calling function may have a dangling reference.]
>
>     printk(KERN_DEBUG "%s: ->wavelan_packet_xmit(0x%X)\n", dev->name,
>            (unsigned) skb);
> #endif
> 
>     if (skb->len < ETH_ZLEN) {
> Start --->
>         skb = skb_padto(skb, ETH_ZLEN);
> 
>     ... DELETED 23 lines ...
> 
>         printk(KERN_INFO "skb has next\n");
> #endif
> 
>     /* Write packet on the card */
>     if(wv_packet_write(dev, skb->data, skb->len))
> Error --->
>         return 1;    /* We failed */
> 
>     dev_kfree_skb(skb);

	This is very yucky. The memory leak is easy to fix, but the
dandling reference is *very* serious. And I don't see how to fix that
without either changing the behaviour of skb_padto or the semantic of
the xmit API.
	Alan, would you mind thinking 2sec about this one ?
	Thanks...

	Jean

