Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVCQUwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVCQUwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCQUwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:52:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:9649 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261170AbVCQUwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:52:30 -0500
Date: Thu, 17 Mar 2005 14:52:14 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: vm_dirty_ratio seems a bit large.
Message-ID: <20050317205213.GC17353@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

We have some fairly large installations that are running into long
pauses while running fsync().  One of the issues that was noted is the
vm_dirty_ratio, while probably adequate for a desktop type installation,
seems excessively large for a larger configuration.  For your reference,
the machine that first reported this is running with 384GB of memory.
Others that reported the problem range from 256GB to 4TB.  At those sizes,
we are talking dirty buffers in the range of 100GB to 1TB.  That seems
a bit excessive.

Is there any chance of limiting vm_dirty_ratio to something other than
a hard-coded 40%?  Maybe add something like the following two lines to
the beginning of page_writeback_init().  This would limit us to roughly
2GB of dirty buffers.  I picked that number assuming that nobody would
want to affect machines in the 4GB and below range.


	vm_dirty_ratio = min(40, TWO_GB_IN_PAGES / total_pages * 100);
	dirty_background_ratio = vm_dirty_ratio / 4;


One other issue we have is the vm_dirty_ratio and background_ratio
adjustments are a little coarse with these memory sizes.  Since our
minimum adjustment is 1%, we are adjusting by 40GB on the largest
configuration from above.  The hardware we are shipping today is capable
of going to far greater amounts of memory, but we don't have customers
demanding that yet.  I would like to plan ahead for that and change
vm_dirty_ratio from a straight percent into a millipercent (thousandth
of a percent).  Would that type of change be acceptable?

Thanks,
Robin Holt
