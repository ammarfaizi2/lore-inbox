Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCQVbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCQVbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVCQVbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:31:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:61069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261204AbVCQVbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:31:45 -0500
Date: Thu, 17 Mar 2005 13:31:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm_dirty_ratio seems a bit large.
Message-Id: <20050317133148.1122e9c4.akpm@osdl.org>
In-Reply-To: <20050317205213.GC17353@lnx-holt.americas.sgi.com>
References: <20050317205213.GC17353@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> Andrew,
> 
> We have some fairly large installations that are running into long
> pauses while running fsync().  One of the issues that was noted is the
> vm_dirty_ratio, while probably adequate for a desktop type installation,
> seems excessively large for a larger configuration.  For your reference,
> the machine that first reported this is running with 384GB of memory.
> Others that reported the problem range from 256GB to 4TB.  At those sizes,
> we are talking dirty buffers in the range of 100GB to 1TB.  That seems
> a bit excessive.

I'd have thought that dirty_background_ratio is the problem here: you want
pdflush to kick in earlier to start the I/O while permitting the write()ing
application to keep running.

> Is there any chance of limiting vm_dirty_ratio to something other than
> a hard-coded 40%?  Maybe add something like the following two lines to
> the beginning of page_writeback_init().  This would limit us to roughly
> 2GB of dirty buffers.  I picked that number assuming that nobody would
> want to affect machines in the 4GB and below range.
> 
> 
> 	vm_dirty_ratio = min(40, TWO_GB_IN_PAGES / total_pages * 100);
> 	dirty_background_ratio = vm_dirty_ratio / 4;

All that dirty pagecache allows us to completely elide I/O when overwrites
are happening, to get better request queue merging, to get better file
layout if the fs does allocate-on-flush and, probably most importantly, to
avoid I/O completely for short-lived files.

So I'm sure there's someone out there who will say "hey, how come by
seeky-writing application just got 75% slower?".

That being said, perhaps reducing the default will help more people than it
hurts - I simply do not know.  That's why it's tuneable ;)

Would it be correct to assume that these applications are simply doing
large, linear writes?  If so, do they write quickly or at a relatively slow
rate?  The latter, I assume.

Which fs are you using?

Other things we can think about are

- Setting the dirty limit on a per-inode basis (non-trivial)

- Adding a new fadvise command to start async writeback of a section of
  the file (easy).

> 
> One other issue we have is the vm_dirty_ratio and background_ratio
> adjustments are a little coarse with these memory sizes.  Since our
> minimum adjustment is 1%, we are adjusting by 40GB on the largest
> configuration from above.  The hardware we are shipping today is capable
> of going to far greater amounts of memory, but we don't have customers
> demanding that yet.  I would like to plan ahead for that and change
> vm_dirty_ratio from a straight percent into a millipercent (thousandth
> of a percent).  Would that type of change be acceptable?

Oh drat.  I think such a change would require a new set of /proc entries.
