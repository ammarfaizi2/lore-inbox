Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265620AbRGSR16>; Thu, 19 Jul 2001 13:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265488AbRGSR1j>; Thu, 19 Jul 2001 13:27:39 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:64270 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S265478AbRGSR1e>;
	Thu, 19 Jul 2001 13:27:34 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107191727.VAA30738@ms2.inr.ac.ru>
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
To: mostrows@speakeasy.net
Date: Thu, 19 Jul 2001 21:27:05 +0400 (MSK DST)
Cc: davem@redhat.com, saai@swbell.net, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com, prefect_@gmx.net,
        moritz@chaosdorf.de, egger@suse.de, srwalter@yahoo.com,
        rusty@rustcorp.com.au
In-Reply-To: <sb6r8vdgkya.fsf@slug.watson.ibm.com> from "Michal Ostrowski" at Jul 19, 1 08:30:37 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

SOme short comment on the patch:


> -	dev_queue_xmit(skb);
> +	/* The skb we are to transmit may be a copy (see above).  If
> +	 * this fails, then the caller is responsible for the original
> +	 * skb, otherwise we must free it.  Also if this fails we must
> +	 * free the copy that we made.
> +	 */
> +
> +	if (dev_queue_xmit(skb)<0) {

dev_queue_xmit _frees_ frame, not depending on return value.
Return value is not a criterium to assume anything.



> +		if (old_skb) {
> +			/* The skb we tried to send was a copy.  We
> +			 * have to free it (the copy) and let the
> +			 * caller deal with the original one.
> +			 */
> +			skb_unlink(skb);

So, do you pass to dev_queue_xmit some skb, which is on some list?
Not a good idea. Please, clone it and submit clone, if you need to hold
original in some list.

Alexey
