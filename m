Return-Path: <linux-kernel-owner+willy=40w.ods.org-S290389AbVBEFqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S290389AbVBEFqF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 00:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S290387AbVBEFqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 00:46:05 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:21674
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S290364AbVBEFp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 00:45:57 -0500
Date: Fri, 4 Feb 2005 21:38:13 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-Id: <20050204213813.4bd642ad.davem@davemloft.net>
In-Reply-To: <20050205052407.GA17266@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
	<20050205052407.GA17266@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 16:24:07 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This is the key to the problem.
 ...
> All of these bugs stem from the idev reference held in rtable/rt6_info.
 ...
> Anyway, this particular problem is due to IPv6 adding local addresses
> with split devices.  That is, routes to local addresses are added with
> rt6i_dev set to &loopback_dev and rt6i_idev set to the idev of the
> device where the address is added.
 ...
> It also goes against the Linux philosophy where the addresses are owned
> by the host, not the interface.
> 
> Therefore I propose the simple solution of not doing the split device
> accounting in rt6_info.

I agree with your analysis, however... this change is not sufficient.
You have to then walk over all the uses of rt6i_dev and sanitize the
cases that still expect the split semantics.  For example, things like
this piece of coe in rt6_device_match():

			if (dev->flags & IFF_LOOPBACK) {
				if (sprt->rt6i_idev == NULL ||
				    sprt->rt6i_idev->dev->ifindex != oif) {
					if (strict && oif)
						continue;
					if (local && (!oif || 
						      local->rt6i_idev->dev->ifindex == oif))
						continue;
				}
				local = sprt;
			}

It is just the first such thing I found, scanning rt6i_idev uses
will easily find several others.
