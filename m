Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUHKBGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUHKBGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 21:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUHKBGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 21:06:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:18653 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267863AbUHKBGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 21:06:10 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <Pine.LNX.4.50.0408101539540.28789-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <1092098425.14102.69.camel@gaston>
	 <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
	 <20040810100751.GC9034@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.50.0408100700460.13807-100000@monsoon.he.net>
	 <20040810175637.GB28113@elf.ucw.cz>
	 <Pine.LNX.4.50.0408101539540.28789-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1092186134.14102.107.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 11:02:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 08:41, Patrick Mochel wrote:
> On Tue, 10 Aug 2004, Pavel Machek wrote:
> 
> > I still do not see it... swsusp does not care about logical state of
> > device. (Actually manipulating logical state of device might make
> > swsusp less transparent). It cares about device not doing DMA (I also
> > said "no interrupts", but that is not strictly neccessary: we disable
> > interrupts for atomic copy. Device should do no NMIs, through).
> 
> Perhaps it is unncessary to do at a class level, at least at this point.
> I think we all agree that we need some sort of stop/start methods for
> devices, though. In which, we can add to struct bus_type:
> 
> 	int (*dev_stop)(struct device *);
> 	int (*dev_start)(struct device *);
> 
> Sound good?

Well, darwin has those, though I'm not sure if it's that necessary to
have them at all, well, maybe...

One thing is sure, having those at the class device level, if I
understand correctly, means we would have broken the ordering
requirement of always following the bus tree.

Honestly, I would stick to not having those at first, the PM callbacks
are enough for most cases, and just have "helpers" that the PM callbacks
call provided by their "class". For example, we could have a
netdev_quiesce_device() call that wuold wrap queue stopping and whatever
else (not much) has to be done at the network level.

IDE sort-of already has that via the PM request infrastructure, low
drivers only implement the few state machine steps they need for things
like cache flush or standby command. It would make sense to do a similar
mecanism for SCSI.

Honestly, there is really not that much to do related to class-side
start/stop, most of the work is usually at the driver level anyway from
experience (I implemented working PM for a bunch of drivers), there are
few things to take care with the "upper level", but not really that
much, and I would rather keep that as a helper function.

Let's keep things simple,

Ben.


