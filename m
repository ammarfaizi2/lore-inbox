Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbRGSSBE>; Thu, 19 Jul 2001 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265771AbRGSSAz>; Thu, 19 Jul 2001 14:00:55 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:1949 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S265714AbRGSSAj>; Thu, 19 Jul 2001 14:00:39 -0400
Reply-To: mostrows@speakeasy.net
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
In-Reply-To: <200107191727.VAA30738@ms2.inr.ac.ru>
From: Michal Ostrowski <mostrows@us.ibm.com>
Date: 19 Jul 2001 14:00:54 -0400
In-Reply-To: <200107191727.VAA30738@ms2.inr.ac.ru>
Message-ID: <sb666cohk89.fsf@slug.watson.ibm.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

kuznet@ms2.inr.ac.ru writes:

> Hello!
> 
> SOme short comment on the patch:
> 
> 
> > -	dev_queue_xmit(skb);
> > +	/* The skb we are to transmit may be a copy (see above).  If
> > +	 * this fails, then the caller is responsible for the original
> > +	 * skb, otherwise we must free it.  Also if this fails we must
> > +	 * free the copy that we made.
> > +	 */
> > +
> > +	if (dev_queue_xmit(skb)<0) {
> 
> dev_queue_xmit _frees_ frame, not depending on return value.
> Return value is not a criterium to assume anything.
> 

My mistake.  It seemed perfectly reasonable at 6:00 am.  :-)

However, could we not have dev_queue_xmit behave as such (not free
frame on failure)?  That is, could we extend dev_queue_xmit to tell it
(optionally) that we want the skb back in case of failure?
dev_queue_xmit unconditionally frees the skb in any failure mode,
which is I would venture to say that we could do this.

The reason why I'm proposing this is that ppp_generic.c assumes that
the skb is still available after a transmission failure via pppoe.  To
support the semantics of dev_queue_xmit and ppp_generic we would have
to always copy skb's inside pppoe_xmit.  Then, if dev_queue_xmit fails
the original is deleted.

In the common case dev_queue_xmit will not fail, and so in that case
I'd like to have to avoid making a copy of the skb.

Michal Ostrowski
mostrows@speakeasy.net

