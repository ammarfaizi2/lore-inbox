Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVFCAyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVFCAyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 20:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVFCAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 20:54:41 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:25255 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261468AbVFCAyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 20:54:37 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: External USB2 HDD affects speed hda
Date: Thu, 2 Jun 2005 17:54:04 -0700
User-Agent: KMail/1.7.1
Cc: Grant Coady <grant_lkml@dodo.com.au>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
References: <429BA001.2030405@keyaccess.nl> <ki1v9196ga4hbeif05unuq5f29ohg5fcnc@4ax.com> <429F9C90.2000602@keyaccess.nl>
In-Reply-To: <429F9C90.2000602@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021754.04872.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 June 2005 4:56 pm, Rene Herman wrote:
> Grant Coady wrote:
> 
> > root@sempro:~# cat /sys/class/usb_host/usb1/registers
> > bus pci, device 0000:00:10.4 (driver 10 Dec 2004)
> > EHCI 1.00, hcd state 1
> > structural params 0x00004208
> > capability params 0x00006872
> > status a008 Async Recl FLR
> > command 010009 (park)=0 ithresh=1 period=256 RUN
> 
> David, did I understand correctly that the Async status bit should not 
> be set without the Async command bit, period? Or was that just in my 
> case, with everything idle/off/disconnected?

It's like this:  turn on the command bit, then after a while the status
bit changes and shows the command took effect.  Turn off the command bit,
ditto.  And if everything is idle/disconnected, nothing should be
turning the bit on ... both bits should stay off at all times.

The driver needs to avoid doing certain things while the chip is in
the middle of activating or de-activating one of the schedules, so
it checks to see whether the bits agree.  If they disagree, the chip
hasn't finished the last enable/disable command.


> If first, then I'm happy that it's not just me ...
> 
> > 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 
> ... although maybe still just VIA.

Maybe.  Thing is, normally it should take just no more than a
millisecond or two for the command to take effect.  So the fact
that either of you can consistently see something happening there
is pretty strange.  Something would seem to be turning the async
schedule on/off a lot.  The driver isn't _supposed_ to do that.
But then, neither is the chip (without the driver telling it to
do so) ... something's being annoying there.


> 
> > 2.6.12-rc5-mm2a third run
> 
> [ snip, no Async or Recl status bit ]
> 
> > irq normal 8184 err 0 reclaim 5387 (lost 82)
> 
> No idea about those. Not seeing lost interrupts here, even after 
> generating quite some traffic.

The "lost" interrupts are cases where the VIA hardware (it's never
been seen by me on any other hardware) is supposed to issue an IRQ
as part of the reclaim process, but doesn't.  

- Dave

