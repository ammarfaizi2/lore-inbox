Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWEaSLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWEaSLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWEaSLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:11:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43314 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965025AbWEaSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:11:10 -0400
Date: Wed, 31 May 2006 20:13:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060531181312.GA29535@suse.de>
References: <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au> <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <Pine.LNX.4.64.0605310755210.24646@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605310755210.24646@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Linus Torvalds wrote:
> 
> 
> On Wed, 31 May 2006, Linus Torvalds wrote:
> > 
> > The reason it's kicked by wait_on_page() is that is when it's needed.
> 
> Btw, that's not how it has always been done.
> 
> For the longest time, it was actually triggered by scheduler activity, in 
> particular, plugging used to be a workqueue event that was triggered by 
> the scheduler (or any explicit points when you wanted it to be triggered 
> earlier).

Now it's time for me to give Linus a history lesson on plugging,
apparently.

Plugging used to be done by the issuer and with immediate unplugging
when you were done issuing the blocks. Both of these actions happened in
ll_rw_block() if the caller was submitting more than on buffer_head, and
it happened without the caller knowing about plugging.  He never had to
unplug.

1.2 then expanded that to be able to plug more than one device at the
time. It didn't really do much except allow the array of buffers passed
in being on separate devices. The plugging was still hidden from the
caller.

1.3 and on introduced a more generalised infrastructure for this, moving
the plugging to a task queue (tq_disk). This meant that we could finally
separate the plugging and unplugging from the direct IO issue. So
whenever someone wanted to the a wait_on_buffer/lock_page() equiv for
something that might to be issued, it would have to do a
run_task_queue(&tq_disk) first which would then unplug all the queues
that were plugged.

tq_disk was then removed and moved to a block list during the 2.5
massive io/bio changes. The functionality remained the same, though -
you had to kick all queues to force the unplug of the page you wanted.
This infrastructure lasted all up to the point where silly people with
lots of CPU's started complaining about lock contention for 32-way
systems with thousands of disks. This is the point where I reevaluated
the benefits of plugging, found it good, and decided to fix it up.
Plugging then became a simple state bit in the queue, and you would have
to pass in eg the page you wanted when asking to unplug. This would kick
just the specific queue you needed. It also got a timer tied to it, so
that we could unplug after foo msecs if we wanted. Additionally, it will
also self-unplug once a certain plug depth has been reached (like 4
requests).

Anyway, the point I wanted to make is that this was never driven by
scheduler activity. So there!

-- 
Jens Axboe

