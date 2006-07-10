Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161367AbWGJHKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161367AbWGJHKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbWGJHKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:10:53 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:18843 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161367AbWGJHKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:10:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aGYcZ5bvRk88bSn76lQs9YpjuvHXLMoX3gx0Ac1iwVNDyolpF0WrWTj1jReOY9ttLgu1w3EtmZV3t21r3oh4mduFp/vpE6+e2NqRb0dxKwOUXQM/sm5w6eIF+JiT2TVzMAMjsjIYsWJitwcF0lelRf6uSuQw9GvxNVw+0JMOtso=  ;
Message-ID: <44B1FAE4.9070903@yahoo.com.au>
Date: Mon, 10 Jul 2006 16:59:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
References: <20060709000703.GA9806@cerise.buici.com> <44B0774E.5010103@yahoo.com.au> <20060710025103.GC28166@cerise.buici.com>
In-Reply-To: <20060710025103.GC28166@cerise.buici.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> On Sun, Jul 09, 2006 at 01:26:06PM +1000, Nick Piggin wrote:
> 
>>Marc Singer wrote:
>>
>>>I'm investigating why I am triggering a BUG_ON in split_page() when I
>>>use the sound subsystems dma memory allocation aide.
>>>
>>>The crux of the problem appears to be that snd_malloc_dev_pages()
>>>passes __GFP_COMP into dma_alloc_coherent().  On the ARM and several
>>>other architectures, the dma allocation code calls split_page () with
>>>pages allocated with this flag which, in turn, triggers the BUG_ON()
>>>check for the CompoundPage flag.
>>>
>>>So, the questions are these: Who is doing the wrong thing?  Should the
>>>snd_malloc_dev_pages() call drop the __GFP_COMP flag?  Should
>>>split_page() allow the page to be compound?  Should __GFP_COMP be 0 on
>>>ARM and other architectures that don't support compound pages?
>>
>>I personally never liked the explicit __GFP_COMP going in everywhere,
>>and would have much preferred a GFP_USERMAP, which the architecture /
>>allocator could satisfy as they liked.
> 
> 
> Thus, the __GFP_COMP bit would be part of another flags such that it
> is set on x86 (or any other architecture that supports it) and clear
> on those that don't.

I guess you could do it a number of ways. Maybe having GFP_USERMAP
set __GFP_USERMAP|__GFP_COMP, and the arm dma memory allocator can
strip the __GFP_COMP.

If you get an explicit __GFP_COMP passed down, the allocator doesn't
know whether that was because they want a user mappable area, or
really want a compound page (in which case, stripping __GFP_COMP is
the wrong thing to do).

> 
> 
>>As a hack, you can make arm's dma_alloc_coherent() drop __GFP_COMP,
>>which should work.
> 
> 
> There are many architectures that have this problem, so I suspect that
> such a patch would be unappreciated.
> 

Hacks usually are ;) It would get you working though.

If you want to write a patch that would be appreciated, that would be
appreciated.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
