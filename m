Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWC2HYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWC2HYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWC2HYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:24:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5420 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751134AbWC2HYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:24:30 -0500
Date: Wed, 29 Mar 2006 09:21:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Linda Walsh <lkml@tlinx.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Block I/O Schedulers: Can they be made selectable/device? @runtime?
Message-ID: <20060329072124.GR8186@suse.de>
References: <4426377C.7000605@tlinx.org> <442A08AA.80305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A08AA.80305@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Tejun Heo wrote:
> Linda Walsh wrote:
> >Is it still the case that block I/O schedulers (AS, CFQ, etc.)
> >are only selectable at boot time?
> >
> >How difficult would it be to allow multiple, concurrent I/O
> >schedulers running on different block devices?
> >
> >How close is the kernel to "being there"?  I.e. if someone has a
> >"regular" hard disk and a high-end solid state disk, can
> >Linux allow whichever algorithm is best for the hardware?
> >(or applications if they are run on separate block devices)?
> >
> 
> Hello, Linda, Jens.
> 
> Actually, I've been thinking about related stuff for sometime. e.g. It 
> doesn't make much sense to use any scheduler other than noop for SSDs 
> and it also doesn't make much sense to plug requests for milliseconds to 
> such devices. So, what I'm currently thinking is...
> 
> * Give LLDD a chance to say that it doesn't need fancy scheduling.

Something I've been meaning to do for ages as well. I figure the
simplest way is to define a simple set of profiles, ala

enum {
        BLK_QUEUE_TYPE_HD,
        BLK_QUEUE_TYPE_SS,
        BLK_QUEUE_TYPE_CDROM,
};

Make BLK_QUEUE_TYPE_HD the default setting, and then let setting of this
look something ala:

        q = blk_init_queue(rfn, lock);
        blk_set_queue_type(q, BLK_QUEUE_TYPE_SS);
        ...

and be done with it.

> * Automagically tune plugging time. We can maintain running average of 
> request turn-around time and use fraction of it to plug the device. This 
> should be give good enough merging behavior while not adding excessive 
> delay to seek time.

Sounds like too much work for little (or zero) benefit. The current
heuristics are a little rough, and if you can show a tangible benefit
from actually looking/calculating this stuff, then we can talk :-)

> * Don't leave device devices with queue depth > 1 idle. For queued 
> devices, we can push the first request fast such that the head moves to 
> proximity of what would probably follow. So, don't plug the first 
> request, plug from the second.

Trade off, if the next io is mergable it will still be a loss. But
generally I like the idea!

-- 
Jens Axboe

