Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbTHYJ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTHYJ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:59:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30433 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261701AbTHYJ7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:59:09 -0400
Date: Mon, 25 Aug 2003 11:58:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Clements <Paul.Clements@SteelEye.com>
Cc: Lou Langholtz <ldl@aros.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
Message-ID: <20030825095857.GI863@suse.de>
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net> <3F332ED7.712DFE5D@SteelEye.com> <3F334396.7030008@aros.net> <20030808065908.GB18823@suse.de> <3F33BB2A.94599C5C@SteelEye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F33BB2A.94599C5C@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08 2003, Paul Clements wrote:
> Jens Axboe wrote:
> > 
> > On Fri, Aug 08 2003, Lou Langholtz wrote:
> > > >@@ -499,12 +508,14 @@ static void do_nbd_request(request_queue
> > > >                                     lo->disk->disk_name);
> > > >                     spin_lock(&lo->queue_lock);
> > > >                     list_del_init(&req->queuelist);
> > > >+                    req->ref_count--;
> > > >                     spin_unlock(&lo->queue_lock);
> > > >                     nbd_end_request(req);
> > > >                     spin_lock_irq(q->queue_lock);
> > > >                     continue;
> > > >             }
> > > >
> > > >+            req->ref_count--;
> > > >             spin_lock_irq(q->queue_lock);
> > > >
> > > Since ref_count isn't atomic, shouldn't ref_count only be changed while
> > > the queue_lock is held???
> > 
> > Indeed, needs to be done after regrabbing the lock.
> 
> But req is pulled off of nbd's main request queue at this point, so I
> don't think anyone else could be touching it, could they?

In that case you are right, and it would probably be best not to touch
the reference count at all (just leave it at 1).

-- 
Jens Axboe

