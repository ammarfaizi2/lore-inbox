Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264611AbTFVKUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 06:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTFVKUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 06:20:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9098 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264611AbTFVKUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 06:20:07 -0400
Date: Sun, 22 Jun 2003 12:30:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Steven Whitehouse <steve@chygwyn.com>,
       akpm@digeo.com
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030622103002.GK608@suse.de>
References: <3EF3F08B.5060305@aros.net> <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk> <3EF48A30.3010203@aros.net> <20030621193124.GK6754@parcelfarce.linux.theplanet.co.uk> <3EF4BEC5.1060301@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF4BEC5.1060301@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21 2003, Lou Langholtz wrote:
> >Because often that lock protects driver-internal objects that are used
> >by all queues.
> >
> Not sure I understand what you're saying... I was going by the kernel 
> blk_init_queue(q, rfn, lock) source that assigns q->queue_lock to the 
> given lock pointer. Given how big struct request_queue was compared to a 
> spinlock_t and since we require all disks to have there very own 
> seperate struct request_queue (by virtue of all the sysfs stuff imbedded 
> now in there), I'm pursauded to find requiring each request_queue to 
> have its very own lock (by making queue_lock a spinlock_t rather than a 
> pointer to such) a relatively low weighted addition for worthwhile gain. 
> I don't doubt that I've missed something though. So unless some more 
> experienced folks chime in for having queue_lock become a spinlock_t 
> instead of spinlock_t *, I'll just not say anymore about queue_lock.

I don't know how to express what Al says any more clearly, looks very
clear to me. One example of such is IDE, which has two drives on one
channel and the channel is the syncronization point. So it actually
makes sense to have one lock per channel, and have that lock be shared
by the two queues (drives) on that channel.

Seems to me, you are suffering somewhat from the 'more locks is just
faster' disease. This is often not the case. ->queue_lock being a
pointer is just more powerful than having the lock embedded, because it
gives you the option to make your locking hierachy the way you want it.

So please, leave the single global nbd_lock and just use that for all
queues until you have anything close to resembling real evidence that
splitting it up is worth it. I do guarentee you that for X busy queues,
the patch you sent will be _slower_ than maintaining one single lock due
to dirty cache line bouncing.

-- 
Jens Axboe

