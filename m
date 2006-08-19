Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWHSHJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWHSHJe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 03:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWHSHJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 03:09:34 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:37288 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751067AbWHSHJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 03:09:34 -0400
Message-ID: <44E6B8EA.2010100@colorfullife.com>
Date: Sat, 19 Aug 2006 09:08:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andi Kleen <ak@muc.de>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com> <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com> <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com> <44E3FC4F.2090506@colorfullife.com> <Pine.LNX.4.64.0608170922030.24204@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608170922030.24204@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>>If you have non-power-of-two caches, you could store the control data at
>>(addr&(~PAGE_SIZE)) - the lookup would be much faster. I wrote a patch a few
>>weeks ago, it's attached.
>>    
>>
>
>That would only work for slabs that use order 0 pages.
>
>  
>
Most slabs are order 0. Actually: there are only 6 slabs that are not 
order 0 (excluding the kmalloc caches) on my system.

What about:

if (unlikely(addr & (~(PAGE_SIZE-1))))
    slabp=virt_to_page(addr)->pagefield;
 else
    slabp=addr & (~(PAGE_SIZE-1));

Modify the kmalloc caches slightly and use non-power-of-2 cache sizes. 
Move the kmalloc(PAGE_SIZE) users to gfp.

 From my system:
good order 1 slab caches: (i.e.: forcing them to order 0 wastes some memory)
    biovec-128
    blkdev_queue
    mqueue_inode_cache
    RAWv6
    UDPv6
bogus order 1 caches: (i.e.: they could be order 0 without wasting memory)
    biovec-(256)

--
    Manfred
