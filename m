Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWAUXhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWAUXhT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWAUXhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:37:19 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:21672 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751228AbWAUXhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:37:18 -0500
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH 3/5] [RFC] Infiniband: connection
 abstraction
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX4011XvpFVjCRG00000041@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 21 Jan 2006 15:37:12 -0800
In-Reply-To: <ORSMSX4011XvpFVjCRG00000041@orsmsx401.amr.corp.intel.com> (Sean
 Hefty's message of "Tue, 17 Jan 2006 15:28:17 -0800")
Message-ID: <ada3bjhrw47.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 21 Jan 2006 23:37:16.0933 (UTC) FILETIME=[9D227B50:01C61EE3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, it's probably worth highlighting these parts of this patch:

First off, ip_dev_find() is exported again:

 > --- linux-2.6.git/net/ipv4/fib_frontend.c	2006-01-16 10:28:29.000000000 -0800
 > +++ linux-2.6.ib/net/ipv4/fib_frontend.c	2006-01-16 16:14:24.000000000 -0800
 > @@ -666,4 +666,5 @@ void __init ip_fib_init(void)
 >  }
 >  
 >  EXPORT_SYMBOL(inet_addr_type);
 > +EXPORT_SYMBOL(ip_dev_find);
 >  EXPORT_SYMBOL(ip_rt_ioctl);

And then it's used here:

 > +int rdma_translate_ip(struct sockaddr *addr, struct rdma_dev_addr *dev_addr)
 > +{
 > +	struct net_device *dev;
 > +	u32 ip = ((struct sockaddr_in *) addr)->sin_addr.s_addr;
 > +	int ret;
 > +
 > +	dev = ip_dev_find(ip);
 > +	if (!dev)
 > +		return -EADDRNOTAVAIL;
 > +
 > +	ret = copy_addr(dev_addr, dev, NULL);
 > +	dev_put(dev);
 > +	return ret;
 > +}

And also here to find the local device to use when connecting to a
loopback address:

 > +static int addr_resolve_local(struct sockaddr_in *src_in,
 > +			      struct sockaddr_in *dst_in,
 > +			      struct rdma_dev_addr *addr)
 > +{
 > +	struct net_device *dev;
 > +	u32 src_ip = src_in->sin_addr.s_addr;
 > +	u32 dst_ip = dst_in->sin_addr.s_addr;
 > +	int ret;
 > +
 > +	dev = ip_dev_find(dst_ip);
 > +	if (!dev)
 > +		return -EADDRNOTAVAIL;
 > +
 > +	if (!src_ip) {
 > +		src_in->sin_family = dst_in->sin_family;
 > +		src_in->sin_addr.s_addr = dst_ip;
 > +		ret = copy_addr(addr, dev, dev->dev_addr);
 > +	} else {
 > +		ret = rdma_translate_ip((struct sockaddr *)src_in, addr);
 > +		if (!ret)
 > +			memcpy(addr->dst_dev_addr, dev->dev_addr, MAX_ADDR_LEN);
 > +	}
 > +
 > +	dev_put(dev);
 > +	return ret;
 > +}

I don't really have an opinion one way or another about this usage,
but I think it's a good idea to make sure that this stuff doesn't get
lost in all the other code, since it is (re)exporting a function that
is currently private to networking.

 - R.
