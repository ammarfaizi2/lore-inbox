Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbVBEGr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbVBEGr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbVBEGr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:47:28 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:55562 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263862AbVBEGrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:47:22 -0500
Date: Sat, 5 Feb 2005 17:46:43 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050205064643.GA29758@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050205052407.GA17266@gondor.apana.org.au> <20050204213813.4bd642ad.davem@davemloft.net> <20050205061110.GA18275@gondor.apana.org.au> <20050204221344.247548cb.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204221344.247548cb.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:13:44PM -0800, David S. Miller wrote:
> 
> But Herbert, let's take a step back real quick because I want
> to point something out.  IPv6 does try to handle the dangling
> mismatched idev's, in route.c:ip6_dst_ifdown(), this is called
> via net/core/dst.c:dst_ifdown(), and this releases the ipv6
> idev correctly in the split device case.
> 
> Did your analysis of this bridging release bug take this into
> account?  That's why we added this dst->ops method, specifically
> to handle this problem.

This doesn't work because net/core/dst.c can only search based
on dst->dev.  For the split device case, dst->dev is set to
loopback_dev while rt6i_idev is set to the real device.

Therefore net/core/dst.c stands no chance of finding the correct
local address routes that it needs to process.

If we wanted to preserve the split device semantics, then we
can create a local GC list in IPv6 so that it can search based
on rt6i_idev as well as the other keys.  Alternatively we can
remove the dst->dev == dev check in dst_dev_event and dst_ifdown
and move that test down to the individual ifdown functions.

However, IMHO the split device semantics is inconsistent with
the philosphy that addresses belong to the host and not the
interface.  So it doesn't really make sense in the current
networking stack.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
