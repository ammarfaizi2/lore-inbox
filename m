Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVDFUMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVDFUMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVDFUMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:12:23 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:22934 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262309AbVDFUMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:12:09 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
Date: Wed, 6 Apr 2005 13:11:53 -0700
User-Agent: KMail/1.7.1
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, debian-powerpc@lists.debian.org
References: <20050405204449.5ab0cdea@jack.colino.net> <200504051353.36788.david-b@pacbell.net> <20050406192007.7f71c61d@jack.colino.net>
In-Reply-To: <20050406192007.7f71c61d@jack.colino.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061311.53720.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 10:20 am, Colin Leroy wrote:
> On 05 Apr 2005 at 13h04, David Brownell wrote:
> > > 
> > > What kind of work on these is needed so that they get in?
> > 
> > Briefly, given 2.6.12-rc2 plus the patches mentioned above,
> > find out what else is needed.
> > ...
> > How's that sound?
> 
> Nice :)
> 
> Ok, here are the results of my tests with 2.6.12-rc2 and the patches
> you sent me applied:
> 
> - plug USB device, sleep, unplug USB device, resume: no more oops
> - sleep, plug in USB device: no oops, but it wakes the laptop up for a
> few seconds; then, it goes back to sleep. No oops on second resume. I
> can live with that :)

Interesting.  Looks like pci_enable_wake(dev, state, 0) isn't actually
disabling wakeup on your hardware.  (Assuming CONFIG_USB_SUSPEND=n; if
not, then it's odd that the system went back to sleep!)  Do you think
that might be related to those calls manipulating the Apple ASICs being
in the OHCI layer rather than up nearer the generic PCI glue?  (I still
think they don't belong in USB code -- ohci or usbcore -- at all.  If
the platform-specific PCI hooks don't suffice, they need fixing.)

Thanks for the testing update.  I'm glad to know that there seems to
be only one (minor) glitch that's PPC-specific!
 

> - once out of two resumes, resume leaves the ports unpowered; so I still
> need my usb-ehci-power.patch that re-powers ports unconditionnaly.

OK, I just posted the patch cleaning up EHCI port power switching;
that should remove the need for that separate patch.  (As well as
fixing some minor annoyances.)

- Dave
