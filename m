Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUGSUTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUGSUTT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUGSUTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 16:19:19 -0400
Received: from mail.tmr.com ([216.238.38.203]:54026 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265500AbUGSUTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 16:19:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Date: Mon, 19 Jul 2004 16:21:48 -0400
Organization: TMR Associates, Inc
Message-ID: <cdha25$6bl$1@gatekeeper.tmr.com>
References: <1089851451.15336.3962.camel@abyss.home><1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090268038 6517 192.168.12.100 (19 Jul 2004 20:13:58 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040715015431.GF3411@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, 2004-07-14 at 15:44, Andrew Morton wrote:
> 
>>>If the kernel has no swap there is nothing it can do with an anonymous page
>>>(ie: the thing whcih malloc() gives you).  It is effectively pinned memory,
>>>because there's nowhere we can write it to get rid of it.
> 
> 
> On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> 
>>Why can't it be moved to other zone if there is a lot of place where ?
>>In general I was not pushing system in some kind of stress mode - There
>>was still a lot of cache memory available. Why it could not be instead
>>shrunk to accommodate allocation ? 
> 
> 
> The only method the kernel now has to relocate userspace memory is IO.
> When mlocked, or if anonymous when there's no swap, it's pinned.
> 
> 
> On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> 
>>As I understand in my case with 4G there is  Normal zone and HighMem
>>zone where "user" anonymous memory can be located in any of these zones.
>>Is this observation correct ? 
> 
> 
> Yes.
> 
> 
> On Wed, 2004-07-14 at 15:44, Andrew Morton wrote:
> 
>>>If you end up pinning all of your ZONE_NORMAL pages with anonymous memory,
>>>further GFP_KERNEL allocation attempts will go oom.
> 
> 
> On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> 
>>Aha I see. So user level memory allocations can't cause OOM only kernel
>>level allocations can ?   In this case why do not you have some reserved
>>amount of space for these types of allocations by default ? 
> 
> 
> Userspace allocations can also trigger OOM, it's merely that in this
> case only allocations restricted to ZONE_NORMAL or below, e.g. kernel
> allocations, are affected. Your memory pressure is restricted to one zone.
> 
> 
> On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> 
>>In this case I also do not understand how swap space helps here ? If you
>>can't move page to over zone or shrink cache because of allocation type
>>how it happens you can however perform page swap ? 
> 
> 
> In order to relocate a userspace page, the kernel performs IO to write
> the page to some backing store, then lazily faults it back in later. When
> the userspace page lacks a backing store, e.g. anonymous pages on
> swapless systems, Linux does not now understand how to relocate them.

Can you briefly explain why the obvious method of moving a page from 
point A to point B, both in physical memory, can't be used? Or even the 
less obvious marking of some physical memory as swap space.

Clearly if this was as easy as it looks it would have been done, I just 
don't quite follow why it isn't easy.

And on a related topic, there was a way in 2.4 kernels to designate part 
of physical memory as swap. It was really useful if you had one of those 
386 chipsets which could only cache 64MB, and more memory than that. It 
was long ago enough that I can't remember if that was a feature or a 
patch. Actually so long ago it could have been 2.2.xx on that machine, I 
just booted it an ran it for years.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
