Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUHGPBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUHGPBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 11:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUHGPBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 11:01:08 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:23485 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262927AbUHGPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 11:01:00 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040805150032.GF12483@suse.de>
References: <200408051348.i75DmlGD004576@burner.fokus.fraunhofer.de> 
	<20040805150032.GF12483@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Aug 2004 08:00:44 -0700
Message-Id: <1091890845.1727.29.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 08:00, Jens Axboe wrote:
> On Thu, Aug 05 2004, Joerg Schilling wrote:
> > -	Parallel (50 bin) SCSI (unknown HBA) on Linux-2.6 does not work if
> > 	DMA size is not a multiple of 4. The data transferred from the SCSI
> > 	device is OK for the first part that is a multiple of 4.
> > 	The remainder of bytes arrive as binary zeroes.
> > 
> > 	This is a new bug (I received the related information this week).
> 
> Might be a hardware issue.

Probably it is.  Lots of hardware FIFO chips are 4 or 8 bytes wide and
can't do partial transfers (because of the way the cycle the data off
the bus).  Usually they have logic that sends only partial fragments on
to the device for commands, but its not unknown for them to forget this
on actual data transfers

> > -	DMA residual count is not returned (reported in 1998).
> > 	This is extremely important - it prevents me from unsing Linux as a
> > 	development platform.
> > 
> > 	Time to fix: about one month to rework the whole SCSI driver stack.
> 
> That's bogus, the SCSI stack (as well as the block layer) is very well
> capable of reporting residual counts, and if the hardware can do it (we
> can't get it from some ide hardware :/), we will report residuals.
> 
> So if it doesn't work it's a bug, but not a design bug.

Well...more likely a driver bug.  Residuals have to be reported by the
driver.  I thought all of the drivers that could were now doing this,
but I might have missed some...which driver is it?

> > -	Unclear documentation whether DID_TIME_OUT should apply to a selection
> > 	time out, a SCSI command timeout or both.
> > 
> > 	Time to fix: one day
> > 
> > -	It seems that the only way to find out whether a SCSI command did time 
> > 	out is to meter the time it takes and guess for any unclear return
> > 	codes that coincidence with a command time >= the set up timeout to
> > 	assume a SCSI command timeout.
> > 
> > 	Time to fix: one day
> 
> Maybe James can clarify these?

I can try:

A selection timeout is reported as DID_NO_CONNECT.

DID_TIME_OUT is for cards that can watchdog their commands in hw and is
what they return when the watchdog fires.

If you actually want visibility into the SCSI mid layer timeout, that's
harder since it feeds directly into the error handler that tries to
ready the transport and device for action.  In general, a command that
times out this way is retried.  If you set the FASTFAIL flag, it will
come out with DRIVER_TIMEOUT set in its result area.

> > -	Many unclear problem reports lead me to the assumption that Linux-2.6
> > 	does not set up the SCSI command timeout properly. See previous point!
> 
> Issued through SG_IO, or how? Again, more details are required.

Yes, more details please.  I do a lot of limited testing on 2.6 but the
hardware manufacturers are doing much more.  The general consensus seems
to be that 2.6 is pretty solid at least for FC and SPI.

> > From the current number of problem reports, it looks like Linux-2.6 is
> > not yet ready for general use as too many problems only appear on
> > Linux-2.6. I currently give peeople the advise to either go back to
> > Linux-2.4 or to check Solaris (see
> > http://wwws.sun.com/software/solaris/solaris-express/get.html).

2.6 has just gone out to a wider audience via SLES9.  As is inevitable,
the test cases people have in the field are wider than those we
necessarily have the hw to produce, so it's expected that the arrival
rate for bugs will increase.

The only comparitive metric I have shows me that 2.4 was orders of
magnitude worse at this point (which was earlier: 2.4.2 from redhat).

James


