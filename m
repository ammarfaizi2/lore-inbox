Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTHYQ1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTHYQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:27:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63499 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261763AbTHYQ1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:27:40 -0400
Date: Mon, 25 Aug 2003 17:27:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030825172737.E16790@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308250840360.1157-100000@cherise>; from mochel@osdl.org on Mon, Aug 25, 2003 at 08:47:16AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 08:47:16AM -0700, Patrick Mochel wrote:
> > There is a hell of a lot of work which now needs to be done to re-fix
> > everything which was working.  For example, there is no sign of any
> > power management for platform devices currently.  Could you give some
> > clues as to what you'd like to see there?
> 
> How about following the system device scheme: 1 call, with interrupts 
> disabled? 

I don't think that's going to work well when you have more conventional
devices below a platform device which need to be power managed (eg, a
USB host.)

I think we need to expand the platform device support to include the
notion of platform drivers.  For example:

	struct platform_driver {
		int (*probe)(struct platform_device *);
		int (*remove)(struct platform_device *);
		int (*suspend)(struct platform_device *, u32);
		int (*resume)(struct platform_device *);
		struct device_driver drv;
	};

(Aside: I like the movement of the suspend/resume methods to the bus_type,
and I'd like to see the probe/remove methods also move there.  For the
vast majority of cases, the probe/remove methods in struct device_driver
end up pointing at the same functions for any particular bus.)

> > There's also a fair number of drivers to update to this new power
> > management model - eg, ARM device drivers, PCMCIA socket drivers to
> > name just two.
> 
> That's fine. I will fix PCMCIA, as I have devices to test with. I have no 
> ARM devices (nor do I want any). I can take a stab, but won't guarantee 
> anything. Could you tell me, though, when/if these devices did work with 
> what power management scheme? APM? 

I know it works on ARM, but, since APM is completely fscked in 2.6
kernels and no one seems to be interested in the issue, its something
I can't test on x86.

> > We also need to fix the device model probing so we can have a generic
> > PCI bridge driver but override it if we have a more specific driver.
> 
> We talked about that, and it's going to require some changes to the core, 
> albeit small. We're not prepared to do that right now, though we'll 
> reconsider depending on necessity and impact of the patch.. 

Bear in mind that Red Hat kernels contain a generic PCI bridge driver
in order to save its state across suspend/resume, and that the PPC
people also seem to need it.  Also bear in mind that the Mobility Docks
have some non-standard configuration controls in their PCI-PCI bridge
which needs a vendor specific PCI-PCI bridge driver.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

