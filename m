Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUDLJMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 05:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUDLJMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 05:12:15 -0400
Received: from stingr.net ([212.193.32.15]:32990 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S262596AbUDLJMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 05:12:10 -0400
Date: Mon, 12 Apr 2004 13:10:49 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-mm4
Message-ID: <20040412091049.GQ14129@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>
References: <20040410200551.31866667.akpm@osdl.org> <20040412064605.GO14129@stingr.net> <20040412004244.0f50a7d4.akpm@osdl.org> <20040412082215.GP14129@stingr.net> <20040412012840.1f3a65e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20040412012840.1f3a65e2.akpm@osdl.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Andrew Morton:
> Yes.  The below locking is not correct.
> 
> > static void unplug_slaves(mddev_t *mddev)
> > {
> >         conf_t *conf = mddev_to_conf(mddev);
> >         int i;
> >         unsigned long flags;
> > 
> >         spin_lock_irqsave(&conf->device_lock, flags);
> >         for (i=0; i<mddev->raid_disks; i++) {
> >                 mdk_rdev_t *rdev = conf->mirrors[i].rdev;
> >                 if (rdev && !rdev->faulty) {
> >                         request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
> > 
> >                         if (r_queue->unplug_fn)
> >                                 r_queue->unplug_fn(r_queue);
> >                 }
> >         }
> >         spin_unlock_irqrestore(&conf->device_lock, flags);
> > }

raid5 version of the same is slightly different:
static void unplug_slaves(mddev_t *mddev)
{
        raid5_conf_t *conf = mddev_to_conf(mddev);
        int i;

        for (i=0; i<mddev->raid_disks; i++) {
                mdk_rdev_t *rdev = conf->disks[i].rdev;
                if (rdev && !rdev->faulty) {
                        struct block_device *bdev = rdev->bdev;
                        if (bdev) {
                                request_queue_t *r_queue = bdev_get_queue(bdev);
                                if (r_queue && r_queue->unplug_fn)
                                        r_queue->unplug_fn(r_queue);
                        }
                }
        }
}

so is it racy or someone just can do the same in raid1?

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
