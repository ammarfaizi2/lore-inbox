Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752709AbWKBWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbWKBWlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbWKBWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:41:35 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:47286 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1752709AbWKBWle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:41:34 -0500
Date: Thu, 2 Nov 2006 22:41:32 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       fastboot@lists.osdl.org
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
In-Reply-To: <aec7e5c30611021005y2f26319ei1c61963d354a933f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611022240350.27544@skynet.skynet.ie>
References: <20061102131934.24684.93195.sendpatchset@localhost> 
 <Pine.LNX.4.64.0611021604080.14806@skynet.skynet.ie>
 <aec7e5c30611021005y2f26319ei1c61963d354a933f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Magnus Damm wrote:

> Hi Mel,
>
> Thanks for your input! Great work with the add_active_range() code.
>

Thanks

> On 11/3/06, Mel Gorman <mel@csn.ul.ie> wrote:
>> Hey Magnus,
>> 
>> I see what you are doing and why. However if you look in
>> arch/x86_64/kernel/setup.c, you'll see
>>
>>          parse_early_param();
>>
>>          finish_e820_parsing();
>>
>>          e820_register_active_regions(0, 0, -1UL);
>> 
>> If you just called e820_register_active_regions(0, 0, -1UL) before
>> parse_early_param(), would it still fix the problem without having to call
>> e820_register_active_regions(0, 0, -1UL) twice?
>
> Well, I guess it is possible to move the
> e820_register_active_regions() up, but I'm not sure if that would give
> us anything.
>
> We need to call e820_register_active_regions() before e820_end_of_ram,
> that's for sure, but the "exactmap" code in parse_memmap_opt() sets
> e820.nr_map to 0 after the call to e820_end_of_ram(). Then it adds a
> new set of user-supplied ranges to the e820 map which then need to be
> registered using e820_register_active_regions().
>
> So yeah, we can move the function up above parse_early_param() but
> then we need to insert another call to e820_register_active_regions()
> somewhere after all user-supplied ranges have been added.
>

Ah right, I see the problem now and why you need to do things that way in 
your patch. Sorry about that.

> Another solution could be to rewrite e820_end_of_ram() to instead scan
> e820.map[] backwards from e820.nr_map - 1 to locate the last ram page.
> But can you do that in two lines of code? =)
>

Nope. As the path you are doing this in is not time-critical, the patch is 
fine to me.

> Thanks!
>
> / magnus
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
