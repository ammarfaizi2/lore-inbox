Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVGWBH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVGWBH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 21:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGWBH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 21:07:59 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:33811 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262266AbVGWBHs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 21:07:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QH779eNc2+Sw/X3HdgTKlH3/6dcnQjjdEgznbOFCZjMq0rjGDGJ3dBHdCPHZEZwtRGf047vjgG9U/dbdj3Mk9z0x04aUDRcZQ5AKEoqkMSGUC8IG1TuzlocTO38t44lCS/KtB5rYgNFjwY85NkkLJrk+7kDlQ55X7nla468H/6Y=
Message-ID: <699a19ea0507221807220c1704@mail.gmail.com>
Date: Sat, 23 Jul 2005 06:37:48 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is this a bug in linux-2.6.12 ipsec code function xfrm4_rcv_encap ??
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I see a possible race in linux-2.6.12 ipsec code function xfrm4_rcv_encap.
I want to double check with the group.
The issue is with SMP(mostly) or Preemptible Kernels.
The race comes when someone flushes the SA's 
(setkey -Fexecuting  on another processor )
while xfrm_rcv_encap is executing one processor.

Below is the function code.
I am putting comments in the code where probably the race comes.
correct me if I am wrong.

int xfrm4_rcv_encap(struct sk_buff *skb, __u16 encap_type)
{
	int err;
	u32 spi, seq;
	struct sec_decap_state xfrm_vec[XFRM_MAX_DEPTH];
	struct xfrm_state *x;
	int xfrm_nr = 0;
	int decaps = 0;

	if ((err = xfrm4_parse_spi(skb, skb->nh.iph->protocol, &spi, &seq)) != 0)
		goto drop;

	do {
		struct iphdr *iph = skb->nh.iph;

		if (xfrm_nr == XFRM_MAX_DEPTH)
			goto drop;

		x = xfrm_state_lookup((xfrm_address_t *)&iph->daddr, spi,
iph->protocol, AF_INET);

/***************************************************************************************************
First Race here . Check is being done without x being locked. What if
x becomes null because
of SA FLUSH (setkey -F) after the check.
***************************************************************************************************/
		if (x == NULL)
			goto drop;

		spin_lock(&x->lock);
		if (unlikely(x->km.state != XFRM_STATE_VALID))
			goto drop_unlock;

		if (x->props.replay_window && xfrm_replay_check(x, seq))
			goto drop_unlock;

		if (xfrm_state_check_expire(x))
			goto drop_unlock;

		xfrm_vec[xfrm_nr].decap.decap_type = encap_type;
		if (x->type->input(x, &(xfrm_vec[xfrm_nr].decap), skb))
			goto drop_unlock;

		/* only the first xfrm gets the encap type */
		encap_type = 0;

		if (x->props.replay_window)
			xfrm_replay_advance(x, seq);

		x->curlft.bytes += skb->len;
		x->curlft.packets++;

		spin_unlock(&x->lock);

/*******************************************************
 Second Race Here. Note the above line unlock already called.
*******************************************************/
		xfrm_vec[xfrm_nr++].xvec = x;

		iph = skb->nh.iph;

/********************************************************
Third Race Here . Again the Check is without Lock
********************************************************/
		if (x->props.mode) {
			if (iph->protocol != IPPROTO_IPIP)
				goto drop;
			if (!pskb_may_pull(skb, sizeof(struct iphdr)))
				goto drop;
			if (skb_cloned(skb) &&
			    pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
				goto drop;
			if (x->props.flags & XFRM_STATE_DECAP_DSCP)
				ipv4_copy_dscp(iph, skb->h.ipiph);
			if (!(x->props.flags & XFRM_STATE_NOECN))
				ipip_ecn_decapsulate(skb);
			skb->mac.raw = memmove(skb->data - skb->mac_len,
					       skb->mac.raw, skb->mac_len);
			skb->nh.raw = skb->data;
			memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
			decaps = 1;
			break;
		}

		if ((err = xfrm_parse_spi(skb, skb->nh.iph->protocol, &spi, &seq)) < 0)
			goto drop;
	} while (!err);

	/* Allocate new secpath or COW existing one. */

	if (!skb->sp || atomic_read(&skb->sp->refcnt) != 1) {
		struct sec_path *sp;
		sp = secpath_dup(skb->sp);
		if (!sp)
			goto drop;
		if (skb->sp)
			secpath_put(skb->sp);
		skb->sp = sp;
	}
	if (xfrm_nr + skb->sp->len > XFRM_MAX_DEPTH)
		goto drop;

	memcpy(skb->sp->x+skb->sp->len, xfrm_vec, xfrm_nr*sizeof(struct
sec_decap_state));
	skb->sp->len += xfrm_nr;

	if (decaps) {
		if (!(skb->dev->flags&IFF_LOOPBACK)) {
			dst_release(skb->dst);
			skb->dst = NULL;
		}
		netif_rx(skb);
		return 0;
	} else {
		return -skb->nh.iph->protocol;
	}

drop_unlock:
	spin_unlock(&x->lock);
	xfrm_state_put(x);
drop:
	while (--xfrm_nr >= 0)
		xfrm_state_put(xfrm_vec[xfrm_nr].xvec);

	kfree_skb(skb);
	return 0;
}





I am just guessing.
If I am wrong I request anyone to give me a reason why it is not a bug ?
I haven't checked the IPv6 front and the IPSec outbound side.
Once this proves to be a bug I will check them.

S.Kartikeyan
