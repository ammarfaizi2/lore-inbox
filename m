Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTJZPbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 10:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTJZPbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 10:31:53 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:23193 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S263205AbTJZPbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 10:31:52 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [PATCH] ide write barrier support
Date: Sun, 26 Oct 2003 17:38:01 +0200
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031013140858.GU1107@suse.de> <200310231920.39888.phillips@arcor.de> <20031024093635.GA22894@hh.idb.hist.no>
In-Reply-To: <20031024093635.GA22894@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310261638.02345.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 October 2003 11:36, Helge Hafting wrote:
> On Thu, Oct 23, 2003 at 07:20:39PM +0200, Daniel Phillips wrote:
> > These are essentially the same, they both rely on draining the downstream
> > queues.  But if we could keep the downstream queues full, bus transfers
> > for post-barrier writes will overlap the media transfers for pre-barrier
> > writes, which would seem to be worth some extra effort.
> >
> > To keep the downstream queues full, we must submit write barriers to all
> > the downstream devices and not wait for completion.  That is, as soon as
> > a barrier is issued to a given downstream device we can start passing
> > through post-barrier writes to it.
>
> This approach may fail:
>
> a. Some pre-barrier writes go to all devices
> b. barrier is sent to all devices
> c. Post-barrier writes go to all devices
> d. drive 1 commits all its pre-barrier writes, then
>    commits its post-barrier writes.
> e. drive 2 is slow and havent done the pre-barrier writes yet
> f. power is lost - leaving inconsistent devices.
>
> The problem is that drive 1 don't know wether drive 2
> did the barrier yet.

I was originally talking about SCSI multipath where more than one host adapter 
issues commands to the same drive, however this idea works for M adapters 
connected to N disks as well.  Several barriers sent down different paths 
share a count of the number of paths; on receiving a barrier, a driver 
decrements the count and if it is nonzero it blocks; if zero it unblocks the 
other drivers and each driver submits a barrier to its respective device 
before resuming normal processing.

Under balanced load this will keep all the device queues full, and it should 
be clear that there is no hole in this multi-device barrier for a write to 
tunnel through.  This strategy does however require some mechanism that isn't 
currently present in the barrier API.  I agree with Jens that for now the 
easiest thing to do is to block at the point of the multipath virtual device 
and allow the queues to drain.

The real purpose of this line of thinking was to see whether barriers want to 
be a third type of request, distinct from read or write.  This gets away from 
arbitrary tying of the barrier to a specific IO request, which might work out 
ok in some usages but leads to awkward posturing in others.  As a bonus, it 
gets rid of the question of how many bits to reserve for barrier type and 
makes it easy to set aside fields for such a purpose as a multi-queue 
barrier, as described above.  The cost is that the barrier needs to be 
submitted as a seperate request, which is not a big deal.

Overall, it's conceptually correct to treat a barrier as a separator rather 
than as a property of some other request.

Regards,

Daniel

