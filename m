Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265835AbVBFGxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbVBFGxU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 01:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272629AbVBFGwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 01:52:42 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:17683 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266847AbVBFGwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 01:52:25 -0500
Date: Sun, 6 Feb 2005 17:51:17 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050206065117.GC16057@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050205052407.GA17266@gondor.apana.org.au> <20050204213813.4bd642ad.davem@davemloft.net> <20050205061110.GA18275@gondor.apana.org.au> <20050204221344.247548cb.davem@davemloft.net> <20050205064643.GA29758@gondor.apana.org.au> <20050205201044.1b95f4e8.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205201044.1b95f4e8.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 08:10:44PM -0800, David S. Miller wrote:
> 
> > Alternatively we can
> > remove the dst->dev == dev check in dst_dev_event and dst_ifdown
> > and move that test down to the individual ifdown functions.
> 
> I think there is a hole in this idea.... maybe.
> 
> If the idea is to scan dst_garbage_list down in ipv6 specific code,
> you can't do that since 'dst' objects from every pool in the kernel
> get put onto the dst_garbage_list.   It is generic.

The idea is to move the check into dst->ops->ifdown.  By definition
ipv6_dst_ifdown will only see rt6_info entries.  So dst_dev_event
will become

for (dst = dst_garbage_list; dst; dst = dst->next) {
	dst_ifdown(dst, event != NETDEV_DOWN);
}

dst_ifdown will become

...

do {
	if (dst->dev == dev && unregister) {
		...
	}

	dst->ops->ifdown(dst, dev, unregister);
} while ((dst = dst->child) && dst->flags & DST_NOHASH);

...

Note the extra dev argument to ifdown.  ipv6_dst_ifdown will be

static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
			   int how)
{
	struct rt6_info *rt = (struct rt6_info *)dst;
	struct inet6_dev *idev = rt->rt6i_idev;

	if (idev != NULL && idev->dev != &loopback_dev && idev->dev == dev) {
		struct inet6_dev *loopback_idev = in6_dev_get(&loopback_dev);
		if (loopback_idev != NULL) {
			rt->rt6i_idev = loopback_idev;
			in6_dev_put(idev);
		}
	}
}

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
