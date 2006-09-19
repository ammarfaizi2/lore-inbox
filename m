Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWISFzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWISFzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 01:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWISFzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 01:55:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54693 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751109AbWISFzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 01:55:50 -0400
From: Andi Kleen <ak@suse.de>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Tue, 19 Sep 2006 07:52:36 +0200
User-Agent: KMail/1.9.3
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <4492D5D3.4000303@atmos.washington.edu> <200609181850.22851.ak@suse.de> <20060918210321.GA4780@ms2.inr.ac.ru>
In-Reply-To: <20060918210321.GA4780@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609190752.36072.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 23:03, Alexey Kuznetsov wrote:

> 
> > And do you have some other prefered way to solve this? Even if the timer
> > was fast it would be still good to avoid it in the fast path when DHCPD
> > is running.
> 
> No. The way, which you suggested, seems to be the best.

Ok. I also checked my desktop and for some reason I got a timestamp counter
of 7 (and it doesn't even run client dhcp). Haven't investigated why yet, and I am 
still hoping it's not a leak. 

But that hints that trying to fix all of user space to not use the ioctl 
would have been probably too much work.


> 1. It even does not disable possibility to record timestamp inside
>    driver, which Alan was afraid of. The sequence is:
> 
> 	if (!skb->tstamp.off_sec)
>                 net_timestamp(skb);
> 
> 2. Maybe, netif_rx() should continue to get timestamp in netif_rx().

Hmm, there are still quite a lot users and even with netif_rx() you
can have long delays from interrupt mitigation etc.

% grep -rw netif_rx drivers/net/*  | wc -l
253

> 3. NAPI already introduced almost the same inaccuracy. And it is really
>    silly to waste time getting timestamp in netif_receive_skb() a few
>    moments before the packet is delivered to a socket.
> 
> 4. ...but clock source, which takes one of top lines in profiles
>    must be repaired yet. :-)

It's being worked on, but it'll take some time. But even when TSC 
can be used it's still a good idea to not call gtod unnecessarily 
because it can be still relatively slow (e.g. on P4 RDTSC takes
hundreds of cycles because it synchronizes the CPU). Also on some 
other non x86 platforms it is also relatively slow because they have 
to reach out to the chipset and every time you do that things get slow.

-Andi

