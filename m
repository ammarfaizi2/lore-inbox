Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUDLI3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 04:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUDLI3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 04:29:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:19602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262744AbUDLI3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 04:29:04 -0400
Date: Mon, 12 Apr 2004 01:28:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Joe Thornber <thornber@redhat.com>
Subject: Re: 2.6.5-mm4
Message-Id: <20040412012840.1f3a65e2.akpm@osdl.org>
In-Reply-To: <20040412082215.GP14129@stingr.net>
References: <20040410200551.31866667.akpm@osdl.org>
	<20040412064605.GO14129@stingr.net>
	<20040412004244.0f50a7d4.akpm@osdl.org>
	<20040412082215.GP14129@stingr.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do not edit people out of the Cc line.

Paul P Komkoff Jr <i@stingr.net> wrote:
>
> Replying to Andrew Morton:
> > I added a might_sleep() to generic_unplug_device(), because some drivers'
> > unplug functions can sleep.
> > 
> > It appears that either the EVMS or the udm2 patch is calling
> > generic_unplug_device() under a lock.  Probably spin_lock_irq(q->lock).
> 
> can it be thisi (raid1.c):

Yes.  The below locking is not correct.

> static void unplug_slaves(mddev_t *mddev)
> {
>         conf_t *conf = mddev_to_conf(mddev);
>         int i;
>         unsigned long flags;
> 
>         spin_lock_irqsave(&conf->device_lock, flags);
>         for (i=0; i<mddev->raid_disks; i++) {
>                 mdk_rdev_t *rdev = conf->mirrors[i].rdev;
>                 if (rdev && !rdev->faulty) {
>                         request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
> 
>                         if (r_queue->unplug_fn)
>                                 r_queue->unplug_fn(r_queue);
>                 }
>         }
>         spin_unlock_irqrestore(&conf->device_lock, flags);
> }

I do not know which drivers insist on sleeping in their unplug functions,
but apparently they're out there.
