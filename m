Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWIUQ5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWIUQ5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWIUQ5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:57:19 -0400
Received: from dvhart.com ([64.146.134.43]:16872 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751341AbWIUQ5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:57:19 -0400
Message-ID: <4512C469.5060107@mbligh.org>
Date: Thu, 21 Sep 2006 09:57:13 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: ZONE_DMA
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org> <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org> <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com> <4511E9AC.2050507@mbligh.org> <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Martin J. Bligh wrote:
> 
> 
>>>ZONE_DMA is only used as ZONE_NORMAL if the architecture does not need
>>>ZONE_NORMAL because all of memory is reachable via DMA.
>>
>>That's still inconsistent because it doesn't say DMA for *which*
>>device.
> 
> 
> Thats the way ZONE_DMA works right now and AFAIK the only way forward is 
> to make it optional and then introduce another way of allocating memory
> for a device. The migrate away from it. The first step is to allow people
> who do not need ZONE_DMA to opt out.

OK. Let's leave aside the issue for a second of whether ZONE_DMA should
be configurable or not (ie your patch), and just worry about how this
works in practice going forwards in the short term. Don't get me wrong,
I'd love to kill ZONE_DMA, or at least the 16MB way it's implemented in
i386 right now.

I presume the fallback order for everything is still
HIGHMEM -> NORMAL -> DMA, and nobody is proposing changing that.
(ignoring DMA32 to keep thing simpler).

If a device driver wants "DMAable" memory, and thus does a ZONE_DMA 
allocation, and we've moved all its memory from ZONE_DMA to ZONE_NORMAL
(as I think you're proposing doing for PPC64 (and ia64?)), then the
allocation will fail.

So are we saying that no driver code should be calling with GFP_DMA
(a quick grep turns up 148 instances under driver/), that if they do
they should only work on specific architectures (some instances were
s390-only drivers)? If so, should we not be removing the definiton of
GFP_DMA itself if ZONE_DMA is config'ed out, so that it fails at
compile time, rather than runtime?

>>AFAICS, the correct way to do this is have the requestor pass a memory
>>bound into the allocator, and have the arch figure out which zones
>>are applicable.
> 
> Exactly. But you cannot do that with ZONE_DMA __GFP_DMA. We likely need a 
> new page  allocator API for that.

Glad we're agreed on that, at least.

M.
