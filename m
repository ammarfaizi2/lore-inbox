Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318790AbSIPEzg>; Mon, 16 Sep 2002 00:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSIPEzg>; Mon, 16 Sep 2002 00:55:36 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29714
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318790AbSIPEze>; Mon, 16 Sep 2002 00:55:34 -0400
Date: Sun, 15 Sep 2002 21:57:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix 2.5.34+swsusp data corruption on IDE
In-Reply-To: <20020915192048.GB12993@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10209151820320.11597-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Pavel Machek wrote:

> Hi!
> 
> > > Jens, where is the problem? This should have absolutely zero impact on
> > > "interesting" code, making only changes to initialization and
> > > suspend/resume...
> > 
> > I think we are looking to settle current problems before adding anything
> > else in the mix.  It will go in somehow, okay.
> 
> Good.

I'm not the same old difficult person you knew prior to recent events,
just now I will start asking for justifications and proof like everyone
else does.  I have the sense of what needs to be done and can explain why,
but over email is difficult, so I am searching for a solution for that
bridge.

> > > > Why are we not blocking read/write requests in the mainloop regardless?
> > > > If the request gets to the subdriver, ide-disk, has it not gotten to far
> > > > down the pipes?
> > > 
> > > All processes capable of generating requests are safely stopped, so no
> > > request should get down to drivers. That's why I simply BUG_ON(), not
> > > block or anything more sophiscated. It should never ever happen.
> > 
> > You have to qualify it to R/W, and that has to be done high than where it
> > is now.  What you can not block is the command to reset; regardless, if it
> > is soft or hard.  This is how you wake a device, then you have to clean up
> > the mess resulting from the reset.
> > 
> > > > Specifically ls120's and zips.
> > > > 
> > > > I understand you are address disk but suspend is more than disk in the
> > > > power management picture.  Can you walk me through your process of sole
> > > > concern with platter media?  Remember microdrvies are platters too, as are
> > > > flash drives, and memory drives.
> > > 
> > > High levels are stopped, so there are no new requests coming.
> > 
> > Where?
> 
> kernel/suspend.c; it puts all processes to refrigerator so there's
> noone who can do request. 

EEK!!  Depending on the S-level of the suspend with total blocking it may
not be possible to bring it back to life.

> > > What is needed in idedisk_suspend is to make sure that no requests are
> > > "in flight". DMA scribbling over random memory is not good thing.
> > > idedisk_suspend then sends drive to standby to make sure writeback
> > > caches are flushed.
> > 
> > Well then you need to block the queue and the hold until the device goes
> > idle via check-power.  Then Flush-Cache, and repeat the host idle check
> > until valid.  Otherwise you have no way to insure all data is down.
> > 
> > Do you disagree with this point?
> 
> No.. I guess you are right. Trouble is that I can reproduce data
> corruption without patch and can no longer reproduce anything with it.

I am not disputing your findings, I am asking you to rethink the location
of the block and why it is in the low level and not the main loop of
ide.c.  If you can justify why each subdriver needs it then it must become
part of the ide-driver-struct.

> > Here are two types of media which use DMA and are read/write native.
> 
> Too bad I do not have any of these :-(. Yes bad things are going to
> happen when suspending with these active.

Well I sent Jens one of a pair of Hitachi Type 1 DVD-RAM devices w/ media.
Maybe he could send it to you as a loaner.

LS-120 drives are everywhere.

								Pavel
> -- 
> Casualities in World Trade Center: ~3k dead inside the building,
> cryptography in U.S.A. and free speech in Czech Republic.
> 

Andre Hedrick
LAD Storage Consulting Group

