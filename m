Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUC2ILI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUC2ILI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:11:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51853 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262744AbUC2IK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:10:29 -0500
Date: Mon, 29 Mar 2004 10:09:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329080943.GR24370@suse.de>
References: <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40671FAF.6080501@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> >The driver may not know exactly, but it does know a ball park figure.
> >You know if you are driving floppy (sucky transfer and latency), hard
> >drive, cdrom (decent transfer, sucky seeks), etc.
> 
> Agreed.  Really we have two types of information:
> * the device's hard limit
> * the default limit that should be applied to that class of devices
> 
> I would much rather do something like
> 
> 	blk_queue_set_class(q, CLASS_DISK)
> 
> and have that default per-class policy
> 
> 	switch (class) {
> 	case CLASS_DISK:
> 	q->max_sectors = min(q->max_sectors, CLASS_DISK_MAX_SECTORS);
> 	...

Oh god no, I was afraid you'd come up with something like this :-). I'm
quite sure this will lead to an unmaintainable mess, as more and various
different classes are introduced. Don't try to model something that you
really cannot model.

> than hardcode the limit in the driver.  That's easy and quick.  That's a 
> minimal solution that gives me what I want -- don't hardcode generic 
> limits in the driver -- while IMO giving you what you want, a sane limit 
> in an easy way.
> 
> Right now we are hardcoding the same per-class limits into each floppy 
> driver, each disk driver, etc.  At the very least devices that act the 
> same way should all be using the same tunable, whether it's a 
> compile-time tunable (CLASS_xxx_MAX_SECTORS) or a runtime tunable.
> 
> Long term, the IO scheduler and the VM should really be figuring out the 
> best request size, from zero to <hardware limit>.

Lets leave it like it is, and try and tweak latencies dynamically. Could
be used to limit tcq depth, not just request sizes solving two problems
at once. I already have a tiny bit of keeping this accounting to do
proper unplugs (right now it just looks at missing requests from the
pool, doesn't work on tcq).

-- 
Jens Axboe

