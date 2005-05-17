Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVEQRoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVEQRoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVEQRoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:44:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:5069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbVEQRnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:43:08 -0400
Date: Tue, 17 May 2005 10:43:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
Message-ID: <20050517174300.GE27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu> <20050517165528.GB27549@shell0.pdx.osdl.net> <1116349464.23972.118.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116349464.23972.118.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Woodhouse (dwmw2@infradead.org) wrote:
> On Tue, 2005-05-17 at 09:55 -0700, Chris Wright wrote:
> > Here and up we are in netlink code which does netlink_trim to reduce
> > the skb data size before queing to socket.  This does skb_clone with
> > gfp_any() flag.  We aren't in softirq, so we get GFP_KERNEL flag set
> > even though in_atomic() is true (spin_lock held I'm assuming).
> 
> netlink_unicast() is only calling skb_clone() because we artificially
> increased the refcount on the skb in question. 

It would call pskb_expand_head() otherwise, so we'd hit the same
warning.

> As I understand it, we do that in order to prevent the skb from being
> lost if netlink_unicast() returns an error -- it normally frees the skb
> before returning in that case. Am I alone in thinking that behaviour is
> strange?

I think the idea is build skb, hand off to netlink layer and never think
about it again.  Fire and forget, what's not to like? ;-))

> I'm really not fond of the refcount trick -- I suspect I'd be happier if
> we were just to try to keep track of sk_rmem_alloc so we never hit the
> condition in netlink_attachskb() which might cause it to fail.

This has some issues w.r.t. truesize and socket buffer space.  The trim
is done to keep accounting sane, so we'd either have to trim ourselves
or take into account the change in size.  And ultimately, we'd still get
trimmed by netlink, so the GFP issue is still there.  Ideally, gfp_any()
would really be _any_

thanks,
-chris
