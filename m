Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUFSQZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUFSQZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUFSQYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:24:07 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:53699 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264213AbUFSQTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:19:14 -0400
Message-ID: <40D46758.10304@colorfullife.com>
Date: Sat, 19 Jun 2004 18:18:32 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Brian Lazara <blazara@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew de Quincey <adq@lidskialf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new device support for forcedeth.c second try
References: <40D43DC3.9000909@gmx.net>
In-Reply-To: <40D43DC3.9000909@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

>Hi,
>
>Brian, thank you very much for contributing to forcedeth.
>
I agree, thanks a lot.

> 	NvRegOffloadConfig = 0x90,
> #define NVREG_OFFLOAD_HOMEPHY	0x601
>-#define NVREG_OFFLOAD_NORMAL	0x5ee
>+#define NVREG_OFFLOAD_NORMAL	RX_NIC_BUFSIZE
>  
>
Interesting - does that explain why VLAN doesn't work properly? I have a 
report that maximum sized packets are rejected.

>+		struct {
>+			u32 Length:14;
>+			u32 Flags:18;
>+		} v2;
>  
>
Bitfields for hw access are evil, it caused problems before. I'd prefer 
a macro with explicit shifts.

>+
>+	//wait for 500ms
>+	mdelay(500);
>  
>
Waiting for phy reset is also evil - it should be done either in a 
separate thread or asynchroneously. Not urgent, we can fix it later.

>+
>+	// check auto negotiation is complete
>+	mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
>+	while (!(mii_status & BMSR_ANEGCOMPLETE)) {
>+		udelay(NV_MIIBUSY_DELAY);
>+		mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
>+		microseconds++;
>+		if (microseconds == 20) {
>+			microseconds = 0;
>+			milliseconds++;
>+		}
>+		if (milliseconds > 1200) {
>+			printk(KERN_INFO "%s: phy init failed to autoneg.\n", dev->name);
>+			return PHY_TIMEOUT;
>+		}
>  
>
Dito.

The phy code needs a big rewrite and support for ethtool anyway. I'd 
propose to merge the patch after removing the bitfields - everything 
else looks good. Perhaps there is a bit too much code duplication with 
the v1/v2 functions, but that's also not fatal.

--
    Manfred
