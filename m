Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVJGIG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVJGIG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJGIG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:06:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33856 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751108AbVJGIG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:06:57 -0400
Date: Fri, 7 Oct 2005 10:07:35 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add sysfs to dynamically control blk request tag maintenance
Message-ID: <20051007080734.GR2889@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5086AEC31@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB5086AEC31@scsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07 2005, Chen, Kenneth W wrote:
> Jens Axboe wrote on Friday, October 07, 2005 12:42 AM
> > > It starts out with scsi_end_request being a fairly hot function in
> the
> > > execution profile, then I noticed blk_queue_start/end_tag() are
> being
> > > called but no actual consumer of using the tag.  I'm trying to find
> a
> > > way to avoid making these blk_queue_start/end_tag calls.  I got the
> > > answer
> > > now. The proper way is to fix it in the scsi LLDD.  Scratch this
> patch,
> > > new patch to follow :-)
> > 
> > Ok that makes more sense! But it's a little worrying that
> > blk_queue_end_tag() would show up as hot in the profile, it is
> actually
> > quite lean.
> 
> It's probably a very small number that I'm chasing with avoiding blk
> layer tagging.  Nevertheless, any number no matter how small, is a gold
> mine to me :-)
> 
> Latest execution profile taken with 2.6.14-rc2 kernel with "industry
> standard transaction processing database workload".  First column is
> clock ticks (a direct measure of time), 2nd column is instruction
> retired,
> and 3rd column is number of L3 misses occurred inside the function.
> 
> Symbol			Clockticks	Inst. Retired	L3 Misses
> scsi_request_fn		8.12%	9.27%	11.18%
> Schedule			6.52%	4.93%	7.26%
> scsi_end_request		4.44%	3.59%	6.76%
> __blockdev_direct_IO	4.28%	4.38%	3.98%
> __make_request		3.59%	4.16%	3.47%
> __wake_up			2.46%	1.56%	3.33%
> dio_bio_end_io		2.14%	1.67%	3.18%
> aio_complete		2.05%	1.27%	3.56%
> kmem_cache_free		1.95%	1.70%	0.71%
> kmem_cache_alloc		1.45%	1.84%	0.45%
> put_page			1.42%	0.60%	1.27%
> follow_hugetlb_page	1.41%	0.75%	1.27%
> __generic_file_aio_read	1.37%	0.36%	1.68%

The above looks pretty much as expected. What change in profile did you
see when eliminating the blk_queue_end_tag() call?

-- 
Jens Axboe

