Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbULaDba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbULaDba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 22:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbULaDba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 22:31:30 -0500
Received: from smtp.knology.net ([24.214.63.101]:14484 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261818AbULaDbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 22:31:12 -0500
Subject: Re: [RFC 2.6.10 5/22] xfrm: Attempt to offload bundled xfrm_states
	for outbound xfrms
From: David Dillow <dave@thedillows.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041230233443.GB5247@electric-eye.fr.zoreil.com>
References: <20041230035000.13@ori.thedillows.org>
	 <20041230035000.14@ori.thedillows.org>
	 <20041230233443.GB5247@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Dec 2004 22:31:07 -0500
Message-Id: <1104463867.10590.2.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 00:34 +0100, Francois Romieu wrote:
> David Dillow <dave@thedillows.org> :
> [...]
> > diff -Nru a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > --- a/net/xfrm/xfrm_policy.c	2004-12-30 01:11:18 -05:00
> > +++ b/net/xfrm/xfrm_policy.c	2004-12-30 01:11:18 -05:00
> > @@ -705,6 +705,31 @@
> >  	};
> >  }
> >  
> > +static void xfrm_accel_bundle(struct dst_entry *dst)
> > +{
> > +	struct xfrm_bundle_list bundle, *xbl, *tmp;
> > +	struct net_device *dev = dst->dev;
> > +	INIT_LIST_HEAD(&bundle.node);
> > +
> > +	if (dev && netif_running(dev) && (dev->features & NETIF_F_IPSEC)) {
> > +		while (dst) {
> > +			xbl = kmalloc(sizeof(*xbl), GFP_ATOMIC);
> > +			if (!xbl)
> > +				goto out;
> > +
> > +			xbl->dst = dst;
> > +			list_add_tail(&xbl->node, &bundle.node);
> > +			dst = dst->child;
> > +		}
> > +
> > +		dev->xfrm_bundle_add(dev, &bundle);
> > +	}
> > +
> > +out:
> > +	list_for_each_entry_safe(xbl, tmp, &bundle.node, node)
> > +		kfree(xbl);
> > +}
> 
> If the driver knows the max depth which is allowed, why not have it
> allocate its own bundle-like struct during initialization one for once ?
> Instead of pushing the bundle list, dst is walked by the code of
> the device's own xyz_xfrm_bundle_add into the said circular list,
> entries get overwriten if the dst chain is longer and when the end of
> dst is reached, the bundle-like list is walked in reverse order.
> It avoids a few failure points imho.

Good idea! I'll see if I can't code it up. I definitely want to get rid
of that GFP_ATOMIC allocation.
-- 
David Dillow <dave@thedillows.org>
