Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbTC3SZD>; Sun, 30 Mar 2003 13:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbTC3SZD>; Sun, 30 Mar 2003 13:25:03 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:1803 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261510AbTC3SZC>; Sun, 30 Mar 2003 13:25:02 -0500
Date: Mon, 31 Mar 2003 03:35:24 +0900 (JST)
Message-Id: <20030331.033524.114862210.yoshfuji@linux-ipv6.org>
To: pioppo@ferrara.linux.it
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Don't assign a same IPv6 address on a same
 interface (is Re: IPv6 duplicate address bugfix)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030330163656.GA18645@ferrara.linux.it>
References: <20030330.220829.129728506.yoshfuji@linux-ipv6.org>
	<20030330.235809.70243437.yoshfuji@linux-ipv6.org>
	<20030330163656.GA18645@ferrara.linux.it>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030330163656.GA18645@ferrara.linux.it> (at Sun, 30 Mar 2003 18:36:56 +0200), Simone Piunno <pioppo@ferrara.linux.it> says:

> Because everywhere else in the file {read,write}_lock_bh() is used 
> instead of {read,write}_lock(), so I'm assuming that _bh is required 
> but I really don't know why.

maybe.

>  - locking inside ipv6_add_addr() is simpler and more linear but
>    semantically wrong because you're unable to tell the user why his 
>    "ip addr add" failed.  E.g. you answer ENOBUFS instead of EEXIST.

We don't want to create duplicate address in any case.
ipv6_add_addr() IS right place.
And, we can return error code by using IS_ERR() etc.
I'll fix this.


>  - your ipv6_chk_same_addr() does a useless check for (dev != NULL)
> 
>    > +static
>    > +int ipv6_chk_same_addr(const struct in6_addr *addr, struct net_device *dev)
>    > +{
>    > +	struct inet6_ifaddr * ifp;
>    > +	u8 hash = ipv6_addr_hash(addr);
>    > +
>    > +	read_lock_bh(&addrconf_hash_lock);
>    > +	for(ifp = inet6_addr_lst[hash]; ifp; ifp=ifp->lst_next) {
>    > +		if (ipv6_addr_cmp(&ifp->addr, addr) == 0) {
>    > +			if (dev != NULL && ifp->idev->dev == dev)
>    >  				break;
>    >  		}
> 
>    your never "break" if dev == NULL, so you could return 0 before
>    even acquiring the lock.

It is not a problem because dev is always non-NULL.
However, it should be dev == NULL || ifp->idev->dev == dev.
Thanks.
(I don't understand what you mean by "you could return 0
before even acquiring the lock.")

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
