Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUHFVMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUHFVMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUHFVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:12:15 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:54656 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268326AbUHFVKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:10:53 -0400
Date: Fri, 6 Aug 2004 23:10:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040806211033.GE30518@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200407310723.12137.david-b@pacbell.net> <1091308167.7396.31.camel@gaston> <200408020940.14300.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408020940.14300.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So suspend-to-RAM more or less matches PCI D3hot, and
> > > suspend-to-DISK matches PCI D3cold.  If those power states
> > > were passed to the device suspend(), the disk driver could act
> > > appropriately.  In my observation, D3cold was never passed
> > > down, it was always D3hot.
> > 
> > Not really, they really have nothing to do with the PCI state
> > at all.
> 
> The PCI power state is rather fundamental to what PCI suspend()
> does!  Even if you want to redefine the "u32 state" parameter
> to be something that's first got to be mapped _into_ a PCI
> power state before calling pci_set_power_state().

For example harddrive wants to be in D0 during reboot. Now imagine
that BIOS can't handle soundcard in D0 during reboot (I believe some
such examples exists).... You only have D0, D1, D2, D3hot, D3cold; but
low-level driver really needs more info.

Now, you could have quirks at PCI layer saying "this device needs to
be D3 during reboot", but I believe thats ugly.

I believe right solution is to pass system state into suspend(), and
provide system_to_pci_state(), so that drivers that only care about
PCI state can use.

If you are right, every PCI driver will use system_to_pci_state.. but
I do not think that's the case. For example:

static void ide_device_shutdown(struct device *dev)
{
        ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);

#ifdef  CONFIG_ALPHA
        /* On Alpha, halt(8) doesn't actually turn the machine off,
           it puts you into the sort of firmware monitor. Typically,
           it's used to boot another kernel image, so it's not much
           different from reboot(8). Therefore, we don't need to
           spin down the disk in this case, especially since Alpha
           firmware doesn't handle disks in standby mode properly.
           On the other hand, it's reasonably safe to turn the power
           off when the shutdown process reaches the firmware prompt,
           as the firmware initialization takes rather long time -
           at least 10 seconds, which should be sufficient for
           the disk to expire its write cache. */
        if (system_state != SYSTEM_POWER_OFF) {
#else
        if (system_state == SYSTEM_RESTART) {
#endif

...drivers are weird. Please provide them with full information.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
