Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267634AbUG3MLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUG3MLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 08:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267639AbUG3MLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 08:11:41 -0400
Received: from av9-1-sn4.m-sp.skanova.net ([81.228.10.108]:58559 "EHLO
	av9-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S267634AbUG3MLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 08:11:39 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Per kthread freezer flags
References: <1090999301.8316.12.camel@laptop.cunninghams>
	<20040729190438.GA468@openzaurus.ucw.cz>
	<1091139864.2703.24.camel@desktop.cunninghams>
	<20040729224422.GG18623@elf.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jul 2004 14:11:22 +0200
In-Reply-To: <20040729224422.GG18623@elf.ucw.cz>
Message-ID: <m3llh1k845.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > > > -	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
> > > > +	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", 0, pd->name);
> > > >  	if (IS_ERR(pd->cdrw.thread)) {
> > > >  		printk("pktcdvd: can't start kernel thread\n");
> > > >  		ret = -ENOMEM;
> > > 
> > > What if someone does swapon /dev/pktdvd0?
> > 
> > Sorry. That's my ignorance. I thought the packet writer was only for
> > writing :>

pktcdvd devices are standard writable block devices, so you can use
them for anything you want, including swapping.

> Well, swapon /dev/pktdvd would be *very* bad idea as optical drives
> are very slow,

Agreed. Seek times before writes are in the range of 500-1000ms on my
drives. This will probably make your machine unresponsive for a *very*
long time when you start to swap to an optical disc.

It should work though, unless you wear out your disc before it's done
swapping, in which case nasty things will probably happen. I don't
think I/O errors on a swap device can be handled in a sane way by the
kernel.

> but PF_NOFREEZE is more correct here.

Yes. What about this code in the main loop in kcdrwd?

			/* make swsusp happy with our thread */
			if (current->flags & PF_FREEZE)
				refrigerator(PF_FREEZE);

Should it still be there when the task is marked as PF_NOFREEZE?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
