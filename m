Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVKLWth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVKLWth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVKLWth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:49:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:34263 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964874AbVKLWtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:49:36 -0500
Date: Sat, 12 Nov 2005 13:33:33 -0800
From: Greg KH <greg@kroah.com>
To: George Anzinger <george@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Calibration issues with USB disc present.
Message-ID: <20051112213332.GA16016@kroah.com>
References: <43750EFD.3040106@mvista.com> <1131746228.2542.11.camel@cog.beaverton.ibm.com> <20051112050502.GC27700@kroah.com> <4376130D.1080500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4376130D.1080500@mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 08:06:37AM -0800, George Anzinger wrote:
> Greg KH wrote:
> >On Fri, Nov 11, 2005 at 01:57:07PM -0800, john stultz wrote:
> >
> >>On Fri, 2005-11-11 at 13:37 -0800, George Anzinger wrote:
> >>
> >>>John,
> >>>
> >>>Have you run into this.  One of the USB disc controllers has the ability 
> >>>to boot the system, however, it needs SMM code to do this.  This SMM 
> >>>code, somehow, causes SMI interrupts (which are higher priority than NMI 
> >>>interrutps and not maskable) which it needs to do its thing.
> >>>
> >>>Problem is that if one of these occurs while calibrating the TSC or the 
> >>>delay code, it can cause a wrong result.  We have seen both a too long 
> >>>and a too short result (depending on where the interrut happens).
> >>>
> >>>They have found the root cause of TSC calibration problem.
> >>>Now they ask for the fix or workaround.
> >>>
> >>>That is the BIOS is periodically interrupted by USB controller and the 
> >>>CPU
> >>>waits during the processing of these interrupts.
> >>>Their experiments say the interrupt interval is 260mSec and the BIOS 
> >>>needs
> >>>150uSec - 200uSec for processing.
> >>>It is proved that the problem doesn't reproduce by masking such SMI in 
> >>>BIOS.
> >>>They say SMI is for BIOS emulation for connecting legacy devices to USB.
> >>>Without such an emulation it's impossible to boot from USB-FD for 
> >>>instance,
> >>>they say too.
> >>
> >>Hmmm. I haven't heard of this issue specifically, but yes, I'm quite
> >>familiar with the pain BIOS SMIs can cause and I'm not surprised that it
> >>would affect the TSC/delay calibration code.
> >>
> >>Is this still an issue w/ 2.6.14? I know the new TSC based delay
> >>calibration code is supposed to be SMI resilient, but I haven't really
> >>played with it closely.
> >>
> >>Not sure what the best method to move forward would be. I suspect
> >>disabling the SMI code early in boot (I thought the usb legacy handoff
> >>stuff already did this?) would help. Then the actual Linux USB drivers
> >>can take over before we switch from the initrd to the root filesystem.
> >>
> >>Greg, do you have a suggestion?
> >
> >
> >I only ever saw this when people forgot to load the USB drivers.  Once
> >the kernel took over USB support, there was no problem (if there was,
> >that's a BIOS bug.)  The handoff code in 2.6.14 should help a lot with
> >this too.
> >
> Ah... are you saying that the USB support code stops the SMM/SMI prior to 
> the TSC & delay calibration?  Also, this problem was noted in a 2.4.20 
> kernel.  Any help there?

I do not know where in the boot process the TSC and delay calibration is
done.  If it happens before the PCI bus is probed, then no, it does not
happen before this.

On these boxes, I'd just recommend disabling USB legacy support
completly, if possible.  And then complain loudly to the vendor to fix
their BIOS.

thanks,

greg k-h
