Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWKBSUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWKBSUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWKBSUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:20:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:55937 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751781AbWKBSUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:20:52 -0500
Date: Thu, 2 Nov 2006 13:20:11 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Mel Gorman <mel@csn.ul.ie>, Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       fastboot@lists.osdl.org
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Message-ID: <20061102182011.GE8074@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061102131934.24684.93195.sendpatchset@localhost> <Pine.LNX.4.64.0611021604080.14806@skynet.skynet.ie> <aec7e5c30611021005y2f26319ei1c61963d354a933f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30611021005y2f26319ei1c61963d354a933f@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 03:05:08AM +0900, Magnus Damm wrote:
> Hi Mel,
> 
> Thanks for your input! Great work with the add_active_range() code.
> 
> On 11/3/06, Mel Gorman <mel@csn.ul.ie> wrote:
> >Hey Magnus,
> >
> >I see what you are doing and why. However if you look in
> >arch/x86_64/kernel/setup.c, you'll see
> >
> >         parse_early_param();
> >
> >         finish_e820_parsing();
> >
> >         e820_register_active_regions(0, 0, -1UL);
> >
> >If you just called e820_register_active_regions(0, 0, -1UL) before
> >parse_early_param(), would it still fix the problem without having to call
> >e820_register_active_regions(0, 0, -1UL) twice?
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
> Another solution could be to rewrite e820_end_of_ram() to instead scan
> e820.map[] backwards from e820.nr_map - 1 to locate the last ram page.
> But can you do that in two lines of code? =)
> 

Is there are reason that why e820_end_of_ram() should be looking at active
regions instead of dicrectly probing e820 memory map? If no, then modifying
e820_end_of_ram() wil save us extra calls.

Thanks
Vivek
