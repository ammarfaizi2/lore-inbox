Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVHUJOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVHUJOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVHUJOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:14:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750886AbVHUJOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:14:49 -0400
Date: Sun, 21 Aug 2005 02:13:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
Message-Id: <20050821021322.3986dd4a.akpm@osdl.org>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> It has been pointed out to me that ia64 doesn't boot
> with CONFIG_PRINTK_TIME=y.  The issue is the call to
> sched_clock() ... which on ia64 accesses some per-cpu
> data to adjust for possible variations in processor
> speed between different cpus.  Since the per-cpu page
> is not set up for the first few printk() calls, we die.
> 
> Is this an issue on any other architecture?  Most versions
> of sched_clock() seem to just scale jiffies into nanoseconds,
> so I guess they don't.  s390, sparc64, x86 and x86_64 all
> have more sophisticated versions but they don't appear to me
> to have limitations on how early they might be called.
> 
> Possible solutions:
> 
> 1) Fix ia64 version of sched_clock() to check whether
> the per-cpu page hase been initialized before using it.
> 
> I don't like this solution as it will make sched_clock()
> slower for its primary uses in kernel/sched.c ... none of
> which can be called before the per-cpu area is initialized.
> 
> 
> 2) Add some test to the printk() path along the lines of:
> 
>   t = (can_call_sched_clock) ? sched_clock() : 0;
> 
> This is somewhat ugly ... perhaps too unpleasant for words in
> that can_call_sched_clock is a per-cpu concept!
> 
> 3) Make the printk() code get the time in some other way.
> 
> Using sched_clock() here seems wrong.  The ia64 version
> has a big fat comment about not comparing the results of
> two calls from different cpus ... but since printk() calls
> can come from any cpu ... it seems likely that a user who
> turns on PRINTK_TIME might subtract timestamps from two
> lines to see how long it was between the messages.  This
> could have significant error on a system that has been up
> for a long time.
> 
> But I don't have a better suggestion from existing code.
> I assume that sched_clock() was picked as it is both fast and
> lockless.

Yes, using sched_clock() there is a bit abusive.

It's not terribly performance-sensitive in printk().

How about we give each arch a printk_clock()?
