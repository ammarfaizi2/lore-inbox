Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVAXWcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVAXWcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVAXW3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:29:49 -0500
Received: from holomorphy.com ([66.93.40.71]:45020 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261606AbVAXW15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:27:57 -0500
Date: Mon, 24 Jan 2005 14:27:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark_H_Johnson@raytheon.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: Query on remap_pfn_range compatibility
Message-ID: <20050124222741.GG10843@holomorphy.com>
References: <OF0A92B996.F674A9A0-ON86256F93.0066BC3F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0A92B996.F674A9A0-ON86256F93.0066BC3F@raytheon.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli wrote...
>> Not sure. One on kernel version being <= 2.6.10 would probably serve
>> your purposes, though it's not particularly well thought of. I suspect
>> people would suggest splitting up the codebase instead of sharing it
>> between 2.4.x and 2.6.x, where I've no idea how well that sits with you.

On Mon, Jan 24, 2005 at 01:05:44PM -0600, Mark_H_Johnson@raytheon.com wrote:
> I guess I could do that, but if a distribution picks up remap_pfn_range
> in an earlier kernel, that doesn't work either. If it gets back ported
> to 2.4 the conditional gets a little more complicated.
> Splitting the code base is a pretty harsh solution.

I suspect it's the one most often recommended. In general, I'm not the
arbiter of taste in drivers (and as you've worked with them enough, I'm
sure you have unanswered questions of your own on that front), but I'm
expecting the general consensus to be something adverse to your concerns.


On Mon, Jan 24, 2005 at 01:05:44PM -0600, Mark_H_Johnson@raytheon.com wrote:
> I am also trying to avoid an ugly hack like the following:
>   VMA_PARAM_IN_REMAP=`grep remap_page_range
> $PATH_LINUX_INCLUDE/linux/mm.h|grep vma`
>   if [ -z "$VMA_PARAM_IN_REMAP" ]; then
>     export REMAP_PAGE_RANGE_PARAM="4"
>   else
>     export REMAP_PAGE_RANGE_PARAM="5"
>   endif
> in a build script which detects if remap_page_range() has 4 or 5 parameters
> and then pass an appropriate value into the code using gcc -D. [ugh]

Some codebases have literally gone so far as to use autoconf to cope
with constellations of issues like these that arise in portable driver
codebases. I don't have an adequate answer to the simultaneous needs of
mainline acceptance and portability across kernel versions. The second
of those is one I'm very rarely faced with myself and my inexperience
in such is accompanied by a lack of ideas.


On Mon, Jan 24, 2005 at 01:05:44PM -0600, Mark_H_Johnson@raytheon.com wrote:
> Would it be acceptable to add a symbol like
>   #define MM_VM_REMAP_PFN_RANGE
> in include/linux/mm.h or is that too much of a hack as well?

I highly suspect that this notion would not be seriously entertained.


wli wrote...
>> I vaguely suspected something like this would happen, but there were
>> serious and legitimate concerns about new usage of the 32-bit unsafe
>> methods being reintroduced, so at some point the old hook had to go.

On Mon, Jan 24, 2005 at 01:05:44PM -0600, Mark_H_Johnson@raytheon.com wrote:
> I don't doubt the need to remove the old interface. But I see possible
> problem areas on > 4 Gbyte machines, such as virt_to_phys defined in
> linux/asm-i386/io.h, that are not getting fixed or do I misread the
> way that code works.

virt_to_phys() represents something of a trap for unwary programmers,
but not a true semantic gap as remap_pfn_range() addressed. It's also
not of any particular help, as the areas for which it fails are
universally not in ZONE_NORMAL. Primitives for resolving vmallocspace
and userspace addresses to pfn's may be in order if these are
sufficiently used, but the convenience of them can be done without at
the cost of some memory to account physical locations mapped without
the benefit of a struct page to track them, which when present is well
backed by primitives like follow_page(), vmalloc_to_page(), etc.


-- wli
