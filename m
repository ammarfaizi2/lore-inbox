Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVBAIIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVBAIIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVBAIIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:08:40 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:16213 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261863AbVBAIIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:08:17 -0500
Message-ID: <41FF33E5.4070107@yahoo.com.au>
Date: Tue, 01 Feb 2005 18:46:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Zou Nan hai <nanhai.zou@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: possible performance issue in 4-level page tables
References: <1107231570.2555.19.camel@linux-znh>
In-Reply-To: <1107231570.2555.19.camel@linux-znh>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zou Nan hai wrote:
> There is a performance regression of lmbench
> lat_proc fork result on ia64.
> 
> in 
> 2.6.10 
> 
> I got 
> Process fork+exit:164.8438 microseconds.
> 
> in 2.6.11-rc2
> Process fork+exit:183.8621 microseconds.
> 
> I believe this regression was caused by 
> the 4-level page tables change.
> 
> Since most of the kernel time spend in lat_proc fork is copy_page_range
> in fork path and clear_page_range in the exit path. Now they are 1 level
> deeper.
> 
> Though pud and pgd is same on IA64, there is still some overhead
> introduced I think.
>  
> Are any other architectures seeing the same sort of results?
> 

I didn't think the i386 numbers were down that much, but I can't recall
the exact figures I got.... just some rambling thoughts:

There will be a little more overhead in copy_page_range. I am surprised
it is that much though. Another likely place to look at is clear_page_range
in the exit path - that has had some bigger changes, and I would be less
*unhappy* if the slowdown is mostly coming from there.

I was thinking about this, and I believe it may be possible to implement
macros for walking page table ranges that optimise out the folded levels
without the additional function call. I didn't want to get too carried away
yet though, because I didn't want to deviate too much from Andi's work, and
everybody seems to do it slightly differently and it might not be possible
to sanely reconcile them all.

Maybe the best option is inlining. If these are inline, the compiler might
be smart enough to optimise it away itself. I did definitely see a small
but non trivial improvement in lmbench fork+exit when making page table
walkers all inline.

This was objected to for debuggability (stack trace) reasons, which is fair
enough. I'm told the gcc option -funit-at-a-time will do the job nicely, and
even generate proper backtrace info... but gcc's inlining can bloat stack
usage, and Linus won't enable this until that's fixed.

So we may be a bit stuck, for the moment. You could probably try some
preliminary tests with the inline keyword and/or -funit-at-a-time.

Maybe for now we could just enable -funit-at-a-time for some select important
files in mm/, if there is a large gain to be had?

Thanks,
Nick

