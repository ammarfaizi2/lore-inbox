Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVGQMds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVGQMds (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 08:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVGQMds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 08:33:48 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:59889 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261283AbVGQMdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 08:33:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=X5akoCV4edYXP542lgu8paZ9vhrHLolEPG1FtBj0OeotFnP91r4GKg9m2LYsHGc8Cjxo/5PBBfNrvm6aoColeYbl0y6/vHcEg/XojG4bEw9GT7z413VTwgDG9IGwzDPSBX9tYqZQldqtYYupwMCeuBRcmXFLlr8dqs7WRFOE3Ak=
Date: Sun, 17 Jul 2005 16:40:27 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.13-rc3
Message-ID: <20050717124026.GA17936@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org> <200507171318.54723.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507171318.54723.petkov@uni-muenster.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 01:18:54PM +0200, Borislav Petkov wrote:
> net/ipv4/netfilter/ip_conntrack_core.c: In function 'ip_conntrack_in':
> net/ipv4/netfilter/ip_conntrack_core.c:612: warning: 'set_reply' may be used
> uninitialized in this function

> --- net/ipv4/netfilter/ip_conntrack_core.c.orig
> +++ net/ipv4/netfilter/ip_conntrack_core.c
> @@ -609,7 +609,7 @@ unsigned int ip_conntrack_in(unsigned in

> -	int set_reply;
> +	int set_reply = 0;

> However, being so trivial, is it at all worth it fixing them

99% of "may be used uninitialized" warnings are bogus.

> or should I just ignore them?

You should ingnore them.
----------------------------------------------------------------------------
ip_conntrack_in(...)
{
	int set_reply;

		...
	ct = resolve_normal_ct(*pskb, proto, &set_reply, hooknum, &ctinfo);
	if (!ct) {
		...
		return NF_ACCEPT;
	}
	if (IS_ERR(ct)) {
		...
		return NF_DROP;
	}
		...
/* Will be reached if resolve_normal_ct() returns successfully */
	if (set_reply)
		set_bit(IPS_SEEN_REPLY_BIT, &ct->status);
}
----------------------------------------------------------------------------
Is it possible for resolve_normal_ct() to return successfully and not
touch set_reply?
----------------------------------------------------------------------------
struct ip_conntrack *resolve_normal_ct(..., int set_reply, ...)
{
		...
	if (!ip_ct_get_tuple(skb->nh.iph, skb, skb->nh.iph->ihl*4,
				&tuple, proto))
		return NULL;
	h = ip_conntrack_find_get(&tuple, NULL);
	if (!h) {
		h = init_conntrack(&tuple, proto, skb);
		if (!h)
			return NULL;
		if (IS_ERR(h))
			return (void *)h;
	}
	/* h is valid from now */
	ct = tuplehash_to_ctrack(h);
	/* ct is valid from now */
	if (DIRECTION(h) == IP_CT_DIR_REPLY) {
			...
		*set_reply = 1;
	} else {
			...
		*set_reply = 0;
	}
	/* set_reply is initialized */
	...
	return ct;
}
----------------------------------------------------------------------------

