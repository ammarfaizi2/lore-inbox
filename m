Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267893AbRGROYQ>; Wed, 18 Jul 2001 10:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267891AbRGROYG>; Wed, 18 Jul 2001 10:24:06 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:6542 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S267888AbRGROX7>; Wed, 18 Jul 2001 10:23:59 -0400
Reply-To: mostrows@speakeasy.net
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Friedley <saai@swbell.net>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com, prefect_@gmx.net,
        moritz@chaosdorf.de, egger@suse.de, srwalter@yahoo.com,
        kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
	<15189.2408.59953.395204@pizda.ninka.net>
From: Michal Ostrowski <mostrows@us.ibm.com>
Date: 18 Jul 2001 10:23:36 -0400
In-Reply-To: <15189.2408.59953.395204@pizda.ninka.net>
Message-ID: <sb6y9pmb9jr.fsf@slug.watson.ibm.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> 
> This report has been plagueing us for a month or two now, from
> different people.  But we hadn't been able to track it down.
> 
> Initially we believed it might be some obscure bug in netfilter
> which got triggered more easily when the zerocopy stuff went in.
> But all of our code audits turned up nothing.

This brings up an interesting point.

One of the initial issues in developing PPPoE support was how to
ensure that the layers passing packets to PPPoE allocated the correct
amount of header space in the skb (so as to avoid a copy of the skb to
create space for PPPoE headers).

This issue was resolved by having the PPP layer respect the header
lengths specified by the underlying transport layers (PPPoE) when
defining dev->hard_header_len.  However, just to be on the safe side,
this code that copied the packet was left in place.

My guess is that before zerocopy netfilter, netfilter made an skb that
conformed to the header requirements of PPPoE.  Once netfilter stopped
making copies PPPoE was passed skb's without space for PPPoE headers
and thus invoked the code path you've just fixed.

Is it possible for netfilter to pass to the PPP device a packet that
respect's the PPP device's hard_header_len? (This would avoid the copy
in PPPoE.)  More generally, I'm concerned (without having seen the
code) that we may have problems when passing skb's between devices via
zerocopy-netfilter when those devices have varying hard_header_len
requirements.

> 
> I have no way to test out these changes, so can folks do that for me?
> If I didn't screw something else up, then I'm pretty sure the OOPS
> will go away.  Let me know if something goes wrong due to these
> changes.
> 

As far as I can tell it all seems fine.  (I'd like to hear some
success stories from some of the people using netfilter heavily with
this though who have experienced the oops'es.)

Michal Ostrowski
mostrows@speakeasy.net

