Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWIUXQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWIUXQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWIUXQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:16:04 -0400
Received: from dvhart.com ([64.146.134.43]:35560 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932091AbWIUXQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:16:01 -0400
Message-ID: <45131D2D.8020403@mbligh.org>
Date: Thu, 21 Sep 2006 16:15:57 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rohit Seth <rohitseth@google.com>
Subject: Re: ZONE_DMA
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org> <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org> <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com> <4511E9AC.2050507@mbligh.org> <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com> <4512C469.5060107@mbligh.org> <Pine.LNX.4.64.0609211045400.5959@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609211045400.5959@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>If a device driver wants "DMAable" memory, and thus does a ZONE_DMA
>>allocation, and we've moved all its memory from ZONE_DMA to ZONE_NORMAL
>>(as I think you're proposing doing for PPC64 (and ia64?)), then the
>>allocation will fail.
> 
> I would not presume proposing anything for PPC64 and left everything the 
> way it is. The arch people can control if they want ZONE DMA or not and 
> the default is to leave things as is. If PPC64 wants to go ZONE_DMAless 
> then the arch code needs to be modified not refer to ZONE_DMA anymore and 
> if that works then we can switch CONFIG_ZONE_DMA off for PPC64. See the 
> patches in mm for examples how other arches have done it.

Sorry, there was some confusion then, maybe I misunderstood one of your
earlier emails.

>>So are we saying that no driver code should be calling with GFP_DMA
>>(a quick grep turns up 148 instances under driver/), that if they do
>>they should only work on specific architectures (some instances were
>>s390-only drivers)? If so, should we not be removing the definiton of
>>GFP_DMA itself if ZONE_DMA is config'ed out, so that it fails at
>>compile time, rather than runtime?
> 
> 
> This was covered at length before. Removing all GFP_DMA references would 
> require extensive #ifdefs. The limited patch in mm is only neutering 
> GFP_DMA for arches that do not need it. If an arch has removed its definition of 
> CONFIG_ZONE_DMA then __GFP_DMA will be ignored in the page allocator.

Just ignoring GFP_DMA in the allocator seems like a horrible violation
to me. GFP_DMA means "give me memory from ZONE_DMA". We're both well
aware that the whole concept of ZONE_DMA doesn't make much sense, but
still, that's what it does.

So if you just put all of memory in ZONE_DMA for your particular
machine, and bumped the DMA limit up to infinity, we wouldn't need
any of these patches, right? Which would also match what the other
arches do for this (eg PPC64).

Seems like a much simpler way of solving the problem to me. Or do you
think that won't work for some reason?

M.
