Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVLTUln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVLTUln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLTUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:41:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:53990 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932071AbVLTUlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:41:42 -0500
Subject: Re: [PATCH] block: Better CDROMEJECT
From: john stultz <johnstul@us.ibm.com>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <1135087637.16754.12.camel@localhost.localdomain>
References: <1135047119.8407.24.camel@leatherman>
	 <20051220074652.GW3734@suse.de>
	 <1135082490.16754.0.camel@localhost.localdomain>
	 <20051220132821.GH3734@suse.de>
	 <1135085557.16754.2.camel@localhost.localdomain>
	 <20051220133939.GI3734@suse.de>
	 <1135087637.16754.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 12:41:39 -0800
Message-Id: <1135111300.27117.41.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 09:07 -0500, Ben Collins wrote:
> On Tue, 2005-12-20 at 14:39 +0100, Jens Axboe wrote:
> > > Should be an easy check to add. In fact, I'll resend both patches with
> > > that in place if you want.
> > 
> > There's still the quirky problem of forcing a locked tray out. In some
> > cases this is what you want, if things get stuck for some reason or
> > another. But usually the tray is locked for a good reason, because there
> > are active users of the device.
> > 
> > Say two processes has the cdrom open, one of them doing io (maybe even
> > writing!), the other could do a CDROMEJECT now and force the ejection of
> > a busy drive.
> 
> But that's possible now with "eject -s" as long as you have write access
> to it. Most users are using "eject -s" anyway.
> 
> You can't stop this from happening. However, the fact is that a lot of
> devices (iPod's being the most popular) require this to work.

I'm a little confused. Eject has a number of different ways it
interfaces with the kernel (scsi, cdrom, floppy, tape), which I assume
map to different ioctl commands. In the case I'm familiar with (my usb
ipod, and my firewire disk), the scsi method (via eject -s) is used
which sends a ALLOW_MEDIUM_REMOVAL.

Now I know without passing a specific method, eject will try different
methods until one works, but it seems that the patch below is overriding
the CDROMEJECT ioctl so that it then sends an ALLOW_MEDIUM_REMOVAL as
well as the normal GPCMD_START_STOP_UNIT.

Again, I don't know about the hardware bits, do you want
ALLOW_MEDIUM_REMOVAL to be sent to cdroms when the "eject -r" option is
used, or just for "eject -s"?

Or maybe your patch is addressing more then just my issue w/ USB and
Firewire devices and that is the disconnect on my side?

> Here's the patch. Currently it will not even try the
> ALLOW_MEDIUM_REMOVAL unless they have write access (to avoid returning
> an uneeded error for people using eject -r that isn't patched to open
> the device O_RDRW). However, I still changed the __blk_send_generic()
> function to use verify_command().

I'll play with your patch tonight and let you know how it goes.

Although from just looking at it, don't you still need to add
ALLOW_MEDIUM_REMOVAL in the verify_command() list for this to work?

Alternatively, would just the "safe_for_write(ALLOW_MEDIUM_REMOVAL);" in
verify_command along with the eject-opens-RW fix have almost the same
effect?

thanks
-john

