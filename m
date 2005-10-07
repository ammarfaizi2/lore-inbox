Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVJGIFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVJGIFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJGIFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:05:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750979AbVJGIFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:05:47 -0400
Date: Fri, 7 Oct 2005 10:06:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add sysfs to dynamically control blk request tag maintenance
Message-ID: <20051007080620.GQ2889@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5086AEC2E@scsmsx401.amr.corp.intel.com> <20051007074138.GP2889@suse.de> <1128671408.2921.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128671408.2921.12.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07 2005, Arjan van de Ven wrote:
> On Fri, 2005-10-07 at 09:41 +0200, Jens Axboe wrote:
> > Ok that makes more sense! But it's a little worrying that
> > blk_queue_end_tag() would show up as hot in the profile, it is actually
> > quite lean.
> 
> it probably just is the first one to touch the IO structures after the
> completion, and thus gets the penalty for the cachemiss. Something has
> to have that after io completion (the io started usually > 10 msec ago
> after all, and usually on another cpu at that) and my experience is that
> it's one of those jello elephants; you can only move it around but not
> really avoid it.

That thought did occur to me, but I don't really see how that can be the
case. The ->queue_tags should be cache hot if you repeatedly call that
function, since that will never change. The request itself has been
touched by scsi_end_request() already, so unless the layout is really
bad we shouldn't need to fetch a lot of cache lines there. That leaves
__test_and_clear_bit(), I guess that must be it.

-- 
Jens Axboe

