Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVCABMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVCABMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVCABMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:12:36 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2385 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261173AbVCABMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:12:10 -0500
Date: Mon, 28 Feb 2005 19:10:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: swapper: page allocation failure. order:1, mode:0x20
In-reply-to: <3CRTy-82M-27@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4223C121.6090904@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3CRTy-82M-27@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert wrote:
> Oh no, not this page allocation problems again. In summer I already posted 
> problems with page allocation errors with 2.6.7, but to me it seemed that 
> nobody cared. That time we got those problems every morning during the cron 
> jobs and our main file server always completely crashed.
> This time its our cluster master system and first happend after an uptime 
> of 89 days, kernel is 2.6.9. Besides of those messages, the system still 
> seems to run stable
> 
> I really beg for help here, so please please please help me solving this 
> probem. What can I do to solve it?
> 
> First a (dumb) question, what does 'page allocation failure' really mean? 
> Is it some out of memory case?
> Feb 28 10:04:45 hitchcock kernel: swapper: page allocation failure. order:1, mode:0x20
> Feb 28 10:04:45 hitchcock kernel:
> Feb 28 10:04:45 hitchcock kernel: Call Trace:<IRQ> <ffffffff8015b0de>{__alloc_pages+878} <ffffffff8015b10e>{__get_free_pages+14}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8015edc6>{kmem_getpages+38} <ffffffff803d064a>{ip_frag_create+26}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8016061e>{cache_grow+190} <ffffffff80160e80>{cache_alloc_refill+560}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff801617e3>{__kmalloc+195} <ffffffff803b5680>{alloc_skb+64}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8031727e>{tg3_alloc_rx_skb+222} <ffffffff80317553>{tg3_rx+371}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff80317977>{tg3_poll+183} <ffffffff803bc306>{net_rx_action+134}

Essentially the tg3 Ethernet driver is trying to allocate memory to 
store a received packet, and is unable to do so. Since this is done 
inside interrupt context, this allocation has to be serviced from 
physical memory. Order 1 means it only wanted one page of memory, and 
since that failed it looks like the system must have been awfully short 
on available physical RAM.. it could be some kind of kernel memory leak 
or VM issue, though this condition may not be entirely unexpected in 
certain cases, like if the system has little physical RAM free at a 
certain point and then a flood of network packets arrive.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


