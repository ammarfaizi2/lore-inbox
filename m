Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWDMRHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWDMRHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWDMRHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:07:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33293 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751101AbWDMRHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:07:02 -0400
Date: Thu, 13 Apr 2006 18:05:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       ALSA devel <alsa-devel@alsa-project.org>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again if probe was unsuccessful
Message-ID: <20060413170549.GB7805@flint.arm.linux.org.uk>
Mail-Followup-To: Rene Herman <rene.herman@keyaccess.nl>,
	Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
	ALSA devel <alsa-devel@alsa-project.org>
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl> <20060413145756.GA29959@flint.arm.linux.org.uk> <443E79AD.50505@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443E79AD.50505@keyaccess.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 06:17:49PM +0200, Rene Herman wrote:
> Russell King wrote:
> 
> >On Thu, Apr 13, 2006 at 04:05:33PM +0200, Rene Herman wrote:
> 
> >>Not honouring/passing up probe() method error returns, not even -ENODEV, 
> >>makes some sense for discoverable busses such as PCI where you at least 
> >>have a driver independent bus_id sitting in /sys/devices/pci* that you 
> >>can later echo into /sys/bus/pci/drivers/*/bind to make the driver bind 
> >>to a device, but not much sense for the platform bus. Platform devices 
> >>only "exist" (in /sys/devices/platform) due to the driver creating them 
> >>itself and keeping them after failing a probe means that directory 
> >>becomes an enumeration of the drivers we loaded, rather than a view of 
> >>what's present in the system.
> >
> >Incorrect.  In some circumstances, they may be created by architecture
> >support code, and might be created and destroyed dynamically by
> >architecture support code.
> 
> Okay, thanks, that's relevant information. Please explain though what's 
> incorrect about the fact that for these ISA devices on the plain old PC, 
> with nothing other than the driver available to probe for them, just 
> keeping them registered after failing a probe turns 
> /sys/devices/platform into a view of "what drivers did we load".

If a driver for an ISA device only wants to register a device and driver
if the hardware exists, it needs to handle behaviour itself and not force
such behaviour on the upper layers (which is what you're arguing for.)

> >>The driver model crowd did not seem exceedingly interested in the 
> >>problem though:
> >>
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=114417829014332&w=2
> >
> >Incorrect summary.  The ALSA use model of the driver model doesn't fit
> >with the driver model use model.  It's not that we're not interested
> >in it - it's that it's perverted to the way driver model folk intend
> >the subsystem to work, and the way that platform devices are used on
> >some architectures.
> 
> And I take it that interest is reflected in getting a grand total of 0 
> comments from anyone on my own feeble attempts to suggest things in that 
> thread such as the settable flag that would make the driver model pass 
> up the error return from probe when set, or having an additional 
> .discover method, or ..

I never commented on it because I'm not specifically a driver model
person - I just happen to be one of the major users of platform devices,
though I have put forward some changes to the platform driver model to
facilitate getting rid of quite frankly some extremely poor and buggy
driver code (and fixed up that crap code in the process.)

Greg is the maintainer of the driver model, and it's Greg who needs to
comment on changes to the way it works.

> M'kay. I believe there's one clean way out of this. We could add an "isa 
> bus", where the _user_ would first need to setup the hardware from 
> userspace by echoing values into sysfs. Say, something like:

Maybe this is the best solution for ISA devices - they do appear to
have differing semantics at the probe level from platform devices.
Maybe this "discovery" should be part of the bus matching method, prior
to the driver probe method being called?  With an ISA bus type, you can
certainly arrange for that to happen without changing existing driver
model behaviour.

In addition, you can check whether the driver was bound by checking
whether dev->driver is non-NULL.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
