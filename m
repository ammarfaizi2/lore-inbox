Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272611AbTHELS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272651AbTHELS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:18:59 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:55500 "EHLO gaston")
	by vger.kernel.org with ESMTP id S272611AbTHELS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:18:27 -0400
Subject: Re: IDE locking problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0308051236250.552-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0308051236250.552-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060082295.600.135.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 05 Aug 2003 13:18:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It only works with default/legacy io bases.

Which is all I care about in this specific situation. The "mediabay"
hotswap controller is driven by ide-pmac, which provides it's own
ide_init_hwif_ports() and ide_default_io_base() arch hooks. (In the
PPC arch, those arch functions can be themselves hooked in by the
actual platform code, on pmac, this goes to ide-pmac, though I also
deal with added PCI cards).

> > Also, look at my patch, we also _NEED_ to add some proper
> > device_unregister calls to ide_unregister() or this function will
> > leave dangling entries in the device list, and since those have the
> > same restrictions as the new blk_cleanup_queue(), we really need to
> > do that without the lock held.
> 
> Yes.

That reminds me that without this fix, even ide-cs will break things
when ejecting a CF card for example.

> > I'd suggest merging my patch for now, it won't make things much
> > worse than what they are today regarding racyness of IDE registration
> > and unregistration, we an look into sanitizing this as a 2.7 goal.
> 
> Okay :\.

Heh, thanks... Well... who else uses ide_unregister except ide-pmac and
ide-cs anyway ? If it's really that little used, it's quite under control
and we can try to clean it up a bit more then during early 2.6.0...

Right now, I'm waiting to see what we can come up to with Jens Axboe
regarding race-free teardown of the blk queue. Once that's agreed, we
can think about just removing the call to init_hwif_data and just reinit
the drive array ourselves. That would be a good thing anyway as the
current ide_unregister allocation of a full hwif_t on stack is causing
other problems (stack bloat typically, an issue with people trying to
shrink the kernel process stack to 1 page).

Ben.

