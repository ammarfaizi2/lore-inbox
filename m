Return-Path: <linux-kernel-owner+willy=40w.ods.org-S286379AbVBEFZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S286379AbVBEFZb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 00:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S286380AbVBEFZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 00:25:30 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:32777 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S286307AbVBEFZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 00:25:19 -0500
Date: Sat, 5 Feb 2005 16:24:07 +1100
To: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050205052407.GA17266@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 31, 2005 at 04:22:02PM +0000, Mirko Parthey wrote:
> 
> How to reproduce the problem (I tried this on a Pentium 4 machine):
> 
> boot: linux init=/bin/bash
> [...booting...]
> # mount proc -t proc /proc
> # ifconfig lo 127.0.0.1
> # brctl addbr br0
> # modprobe e100           # also reproducible with 3c5x9
> # brctl addif br0 eth0
> # ifconfig br0 192.168.1.1
> # ifconfig eth0 up
> # ifconfig lo down

This is the key to the problem.

It took me a while to find the cause of this.  Along the way I
found a few other ref counting bugs in this area as well.

All of these bugs stem from the idev reference held in rtable/rt6_info.
Looking back in my mailbox, it's amazing how many problems this piece
of infrastructure has caused since it was installed last June.  AFAIK
to this day there is still no code in the kernel that actually uses
this infrastructure.

Anyway, this particular problem is due to IPv6 adding local addresses
with split devices.  That is, routes to local addresses are added with
rt6i_dev set to &loopback_dev and rt6i_idev set to the idev of the
device where the address is added.

This is just not going to work unless IPv6 creates its own dst garbage
collection routine since the generic GC in net/core/dst.c has no way
of finding all the rt6_info's referring to a specific net_device through
rt6i_idev.

It is also different from the IPv4 behaviour where we set both dev
and idev to loopback_dev.

Now this stuff is apparently going to be used for IP statistics.  As
it is packets sent to/received from local addresses are counted against
the loopback device.  Linux has behaved this way for a long time. So
when these statistics actually get implemented it will be very strange
if they were accounted to the device owning the local addresses instead
of loopback.

It also goes against the Linux philosophy where the addresses are owned
by the host, not the interface.

Therefore I propose the simple solution of not doing the split device
accounting in rt6_info.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I will send the patches for the other bugs separately.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=q

===== net/ipv6/route.c 1.105 vs edited =====
--- 1.105/net/ipv6/route.c	2005-01-15 19:44:48 +11:00
+++ edited/net/ipv6/route.c	2005-02-05 16:10:19 +11:00
@@ -1395,13 +1395,12 @@
 		return ERR_PTR(-ENOMEM);
 
 	dev_hold(&loopback_dev);
-	in6_dev_hold(idev);
 
 	rt->u.dst.flags = DST_HOST;
 	rt->u.dst.input = ip6_input;
 	rt->u.dst.output = ip6_output;
 	rt->rt6i_dev = &loopback_dev;
-	rt->rt6i_idev = idev;
+	rt->rt6i_idev = in6_dev_get(&loopback_dev);
 	rt->u.dst.metrics[RTAX_MTU-1] = ipv6_get_mtu(rt->rt6i_dev);
 	rt->u.dst.metrics[RTAX_ADVMSS-1] = ipv6_advmss(dst_pmtu(&rt->u.dst));
 	rt->u.dst.metrics[RTAX_HOPLIMIT-1] = ipv6_get_hoplimit(rt->rt6i_dev);

--dDRMvlgZJXvWKvBx--
