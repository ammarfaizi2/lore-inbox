Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSIOTPw>; Sun, 15 Sep 2002 15:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSIOTPw>; Sun, 15 Sep 2002 15:15:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:48651 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S318213AbSIOTPv>; Sun, 15 Sep 2002 15:15:51 -0400
Date: Sun, 15 Sep 2002 21:20:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix 2.5.34+swsusp data corruption on IDE
Message-ID: <20020915192048.GB12993@atrey.karlin.mff.cuni.cz>
References: <20020914100145.GA816@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.10.10209141002020.6925-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10209141002020.6925-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Jens, where is the problem? This should have absolutely zero impact on
> > "interesting" code, making only changes to initialization and
> > suspend/resume...
> 
> I think we are looking to settle current problems before adding anything
> else in the mix.  It will go in somehow, okay.

Good.

> > > Why are we not blocking read/write requests in the mainloop regardless?
> > > If the request gets to the subdriver, ide-disk, has it not gotten to far
> > > down the pipes?
> > 
> > All processes capable of generating requests are safely stopped, so no
> > request should get down to drivers. That's why I simply BUG_ON(), not
> > block or anything more sophiscated. It should never ever happen.
> 
> You have to qualify it to R/W, and that has to be done high than where it
> is now.  What you can not block is the command to reset; regardless, if it
> is soft or hard.  This is how you wake a device, then you have to clean up
> the mess resulting from the reset.
> 
> > > Specifically ls120's and zips.
> > > 
> > > I understand you are address disk but suspend is more than disk in the
> > > power management picture.  Can you walk me through your process of sole
> > > concern with platter media?  Remember microdrvies are platters too, as are
> > > flash drives, and memory drives.
> > 
> > High levels are stopped, so there are no new requests coming.
> 
> Where?

kernel/suspend.c; it puts all processes to refrigerator so there's
noone who can do request. 

> > What is needed in idedisk_suspend is to make sure that no requests are
> > "in flight". DMA scribbling over random memory is not good thing.
> > idedisk_suspend then sends drive to standby to make sure writeback
> > caches are flushed.
> 
> Well then you need to block the queue and the hold until the device goes
> idle via check-power.  Then Flush-Cache, and repeat the host idle check
> until valid.  Otherwise you have no way to insure all data is down.
> 
> Do you disagree with this point?

No.. I guess you are right. Trouble is that I can reproduce data
corruption without patch and can no longer reproduce anything with it.

> Here are two types of media which use DMA and are read/write native.

Too bad I do not have any of these :-(. Yes bad things are going to
happen when suspending with these active.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
