Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVLXVGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVLXVGR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVLXVGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:06:17 -0500
Received: from mail.dvmed.net ([216.237.124.58]:11719 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750719AbVLXVGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:06:16 -0500
Message-ID: <43ADB83A.4090005@pobox.com>
Date: Sat, 24 Dec 2005 16:06:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Manfred Spraul <manfred@colorfullife.com>,
       Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
References: <43AD4ADC.8050004@colorfullife.com> <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org> <43ADA7D0.9010908@colorfullife.com> <Pine.LNX.4.64.0512241241230.14098@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512241241230.14098@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linus Torvalds wrote: > > On Sat, 24 Dec 2005, Manfred
	Spraul wrote: > > >>Linus Torvalds wrote: >> >> >>>Of course, on the
	alloc path, it seems to add an additional >>>"NV_RX_ALLOC_PAD" thing,
	so maybe the "end-data" thing makes sense. >> >>The problem is the
	pci_unmap_single() call that happens during nv_close() or >>the rx
	interrupt handler. I think it makes more sense to rely on fields in the
	>>individual skb instead of reading from np->rx_buf_sz. If
	np->rx_buf_sz changes >>inbetween, then we have a memory leak. > > >
	Fair enough. Patch applied. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 24 Dec 2005, Manfred Spraul wrote:
> 
> 
>>Linus Torvalds wrote:
>>
>>
>>>Of course, on the alloc path, it seems to add an additional
>>>"NV_RX_ALLOC_PAD" thing, so maybe the "end-data" thing makes sense.
>>
>>The problem is the pci_unmap_single() call that happens during nv_close() or
>>the rx interrupt handler. I think it makes more sense to rely on fields in the
>>individual skb instead of reading from np->rx_buf_sz. If np->rx_buf_sz changes
>>inbetween, then we have a memory leak.
> 
> 
> Fair enough. Patch applied.

Paranoia -- the situation above never occurs.  It is coded as are other 
drivers:  np->rx_buf_sz only changes in ->change_mtu(), which (a) is 
serialized against close and (b) always stops the engine and drains RX 
skbs before changing the size.

So can we please remove the subtraction code now added to the hot path? 
  If not now, for 2.6.16?

	Jeff



