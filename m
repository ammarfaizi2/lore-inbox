Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVJGHlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVJGHlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVJGHlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:41:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45097 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750716AbVJGHlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:41:02 -0400
Date: Fri, 7 Oct 2005 09:41:39 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add sysfs to dynamically control blk request tag maintenance
Message-ID: <20051007074138.GP2889@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5086AEC2E@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB5086AEC2E@scsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07 2005, Chen, Kenneth W wrote:
> Jens Axboe wrote on Friday, October 07, 2005 12:24 AM
> > I don't understand the need for this patch - the generic tagging is
> only
> > used if the SCSI LLD indicated it wanted it by issuing a
> > scsi_activate_tcq(). So blk_queue_start_tag() is only called if the
> LLD
> > already did a scsi_activate_tcq(), and blk_queue_end_tag() is only
> > called if the rq is block layer tagged. blk_queue_find_tag() is only
> > used with direct use of scsi_find_tag(), a function that should (and
> is)
> > only usable by users of the generic tagging already.
> > 
> 
> You beat me by a couple of minutes.  I was about to say that the culprit
> is in the qla2x00 driver where it unnecessarily activated generic blk
> tag queuing by calling scsi_activate_tcq() and it never uses tag.
> 
> > So please, a description of what problem you are trying to solve would
> > be appreciated :-)
> 
> It starts out with scsi_end_request being a fairly hot function in the
> execution profile, then I noticed blk_queue_start/end_tag() are being
> called but no actual consumer of using the tag.  I'm trying to find a
> way to avoid making these blk_queue_start/end_tag calls.  I got the
> answer
> now. The proper way is to fix it in the scsi LLDD.  Scratch this patch,
> new patch to follow :-)

Ok that makes more sense! But it's a little worrying that
blk_queue_end_tag() would show up as hot in the profile, it is actually
quite lean.

-- 
Jens Axboe

