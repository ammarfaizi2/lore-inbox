Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272140AbVBFFaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272140AbVBFFaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbVBFFaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:30:24 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:18190 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S272426AbVBFFaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:30:08 -0500
Date: Sun, 06 Feb 2005 14:31:07 +0900 (JST)
Message-Id: <20050206.143107.39728239.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: herbert@gondor.apana.org.au, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050205210411.7e18b8e6.davem@davemloft.net>
References: <20050205201044.1b95f4e8.davem@davemloft.net>
	<20050206.133723.124822665.yoshfuji@linux-ipv6.org>
	<20050205210411.7e18b8e6.davem@davemloft.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050205210411.7e18b8e6.davem@davemloft.net> (at Sat, 5 Feb 2005 21:04:11 -0800), "David S. Miller" <davem@davemloft.net> says:

> On Sun, 06 Feb 2005 13:37:23 +0900 (JST)
> YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:
> 
> > How about making dst->ops->dev_check() like this:
> > 
> > static int inline dst_dev_check(struct dst_entry *dst, struct net_device *dev)
> > {
> > 	if (dst->ops->dev_check)
> > 		return dst->ops->dev_check(dst, dev)
> > 	else
> > 		return dst->dev == dev;
> > }
> 
> Oh I see.  That would work, and it seems the simplest, and
> lowest risk fix for this problem.

Well...

Here, lo is going down.
rt->rt6i_dev = lo and rt->rt6i_idev = ethX.
I think we already see dst->dev == dev (==lo)  now.
So, I doubt that fix the problem.

The source of problem is entry (*) which still on routing entry,
not on gc list. And, the owner of entry is not routing table but
unicast/anycast address structure(s).
We need to "kill" active address on the other interfaces.

*: rt->rt6i_dev = lo and rt->rt6i_idev = ethX


BTW, I wish we could shut down eth0 during lo is pending...

--yoshfuji


