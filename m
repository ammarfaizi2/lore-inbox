Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWBFL5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWBFL5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWBFL5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:57:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19852 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751101AbWBFL5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:57:42 -0500
Date: Mon, 6 Feb 2006 22:57:25 +1100
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-ID: <20060206115725.GL43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <20060206054815.GJ43335175@melbourne.sgi.com> <20060205222215.313f30a9.akpm@osdl.org> <20060205223611.5789a062.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205223611.5789a062.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 10:36:11PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > If so, why would that happen?  Take a look at wb_kupdate().  It's supposed
> >  to work *continuously* on the inodes until writeback_inodes() failed to
> >  write back enough pages.  It takes this as an indication that there's no
> >  more work to do at this time.
> > 
> >  It'd be interesting to take a look at what's happening in wb_kupdate().
> 
> Took a quick look at xfs_convert_page().  I don't immediately see a cause
> in there, but
> 
> 		if (count) {
> 			struct backing_dev_info *bdi;
> 
> 			bdi = inode->i_mapping->backing_dev_info;
> 			if (bdi_write_congested(bdi)) {
> 				wbc->encountered_congestion = 1;
> 				done = 1;
> 			} else if (--wbc->nr_to_write <= 0) {
> 				done = 1;
> 			}
> 		}
> 		xfs_start_page_writeback(page, wbc, !page_dirty, count);
> 
> shouldn't we be decrementing wbc->nr_to_write even if the queue is congested?

Yes, you are right. I'll fix it tomorrow.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
