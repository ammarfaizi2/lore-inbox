Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWCCVO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWCCVO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWCCVO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:14:26 -0500
Received: from fmr19.intel.com ([134.134.136.18]:32421 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750723AbWCCVOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:14:25 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "Hefty, Sean" <sean.hefty@intel.com>, <netdev@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Cc: <openib-general@openib.org>
Subject: [PATCH 3/5] export of ip_dev_find as part of Infiniband connection abstraction
Date: Fri, 3 Mar 2006 13:14:23 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcYnaoPoeQwbN57KSxu+/VIzb9oBFwAAQpKQBePSw1A=
In-Reply-To: <ORSMSX401X3cf3ednHM0000009a@orsmsx401.amr.corp.intel.com>
Message-ID: <ORSMSX4013SOlbpH71y00000016@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 03 Mar 2006 21:14:23.0842 (UTC) FILETIME=[721C5C20:01C63F07]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to make doubly sure that this didn't get lost in the patch series, but
ip_dev_find() is re-exported.  The use is shown below.

- Sean

>+int rdma_translate_ip(struct sockaddr *addr, struct rdma_dev_addr *dev_addr)
>+{
>+	struct net_device *dev;
>+	u32 ip = ((struct sockaddr_in *) addr)->sin_addr.s_addr;
>+	int ret;
>+
>+	dev = ip_dev_find(ip);
>+	if (!dev)
>+		return -EADDRNOTAVAIL;
>+
>+	ret = copy_addr(dev_addr, dev, NULL);
>+	dev_put(dev);
>+	return ret;
>+}

{snip}

>+static int addr_resolve_local(struct sockaddr_in *src_in,
>+			      struct sockaddr_in *dst_in,
>+			      struct rdma_dev_addr *addr)
>+{
>+	struct net_device *dev;
>+	u32 src_ip = src_in->sin_addr.s_addr;
>+	u32 dst_ip = dst_in->sin_addr.s_addr;
>+	int ret;
>+
>+	dev = ip_dev_find(dst_ip);
>+	if (!dev)
>+		return -EADDRNOTAVAIL;
>+
>+	if (!src_ip) {
>+		src_in->sin_family = dst_in->sin_family;
>+		src_in->sin_addr.s_addr = dst_ip;
>+		ret = copy_addr(addr, dev, dev->dev_addr);
>+	} else {
>+		ret = rdma_translate_ip((struct sockaddr *)src_in, addr);
>+		if (!ret)
>+			memcpy(addr->dst_dev_addr, dev->dev_addr, MAX_ADDR_LEN);
>+	}
>+
>+	dev_put(dev);
>+	return ret;
>+}

{snip}

>diff -uprN -X linux-2.6.git/Documentation/dontdiff
>linux-2.6.git/net/ipv4/fib_frontend.c
>linux-2.6.ib/net/ipv4/fib_frontend.c
>--- linux-2.6.git/net/ipv4/fib_frontend.c	2006-01-16 10:28:29.000000000
-0800
>+++ linux-2.6.ib/net/ipv4/fib_frontend.c	2006-01-16 16:14:24.000000000
-0800
>@@ -666,4 +666,5 @@ void __init ip_fib_init(void)
> }
>
> EXPORT_SYMBOL(inet_addr_type);
>+EXPORT_SYMBOL(ip_dev_find);
> EXPORT_SYMBOL(ip_rt_ioctl);

