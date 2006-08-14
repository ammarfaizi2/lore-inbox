Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWHNAnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWHNAnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHNAnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 20:43:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21156 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751274AbWHNAnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 20:43:09 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=A4PPtFCQ8uZIOK7JPACmxKXM/hewpTbDeUKtV+lbbeHUpxmil/cr7BeYHg9yYGRAi
	5mR3b7k0Vrb+qQ/cH7PcA==
Message-ID: <44DFC707.7000404@google.com>
Date: Sun, 13 Aug 2006 17:42:47 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Indan Zupancic <indan@nul.nu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 0/4] VM deadlock prevention -v4
References: <20060812141415.30842.78695.sendpatchset@lappy>	 <33471.81.207.0.53.1155401489.squirrel@81.207.0.53>	 <1155404014.13508.72.camel@lappy>	 <47227.81.207.0.53.1155406611.squirrel@81.207.0.53> <1155408846.13508.115.camel@lappy>
In-Reply-To: <1155408846.13508.115.camel@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Sat, 2006-08-12 at 20:16 +0200, Indan Zupancic wrote:
>>What was missing or wrong in the old approach? Can't you use the new
>>approach, but use alloc_pages() instead of SROG?
>>
>>Sorry if I bug you so, but I'm also trying to increase my knowledge here. ;-)
> 
> I'm almost sorry I threw that code out...

Good instinct :-)

> Lemme see what I can do to explain; what I need/want is:
>  - single allocation group per packet - that is, when I free a packet
> and all its associated object I get my memory back.

First, try to recast all your objects as pages, as Evgeniy Polyakov
suggested.  Then if there is some place where that just doesn't work
(please point it out) put a mempool there and tweak the high level
reservation setup accordingly.

>  - not waste too much space managing the various objects

If we waste a little space only where the network would have otherwise
dropped a packet, that is still a big win.  We just need to be sure the
normal path does not become more wasteful.

> skb operations want to allocate various sk_buffs for the same data
> clones. Also, it wants to be able to break the COW or realloc the data.
> 
> The trivial approach would be one page (or higher alloc page) per
> object, and that will work quite well, except that it'll waste a _lot_
> of memory. 

High order allocations are just way too undependable without active
defragmentation, which isn't even on the horizon at the moment.  We
just need to treat any network hardware that can't scatter/gather into
single pages as too broken to use for network block io.

As for sk_buff cow break, we need to look at which network paths do it
(netfilter obviously, probably others) and decide whether we just want
to declare that the feature breaks network block IO, or fix the feature
so it plays well with reserve accounting.

> So I tried manual packing (parts of that you have seen in previous
> attempts). This gets hard when you want to do unlimited clones and COW
> breaks. To do either you need to go link several pages.

You need to avoid the temptation to fix the entire world on the first
attempt.  Sure, there will be people who call for gobs of overengineering
right from the start, but simple has always worked better for Linux than
lathering on layers of complexity just to support some feature that may
arguably be broken by design.  For example, swapping through a firewall.

Changing from per-interface to a global block IO reserve was a great
simplification, we need more of those.

Looking forward to -v5 ;-)

Regards,

Daniel
