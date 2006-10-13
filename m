Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJMJRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJMJRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 05:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWJMJRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 05:17:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:60840 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750850AbWJMJRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 05:17:15 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@MIT.EDU>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160729427.26091.98.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
	 <1160701263.4792.179.camel@localhost.localdomain>
	 <1160729427.26091.98.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 19:16:44 +1000
Message-Id: <1160731004.4792.245.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Personally, I don't think exposing a cached version of the PCI config
> space when direct device access is prohibited is the right approach
> here.  We really shouldn't be lying about the internal state of PCI
> devices (the cached version could be quite inaccurate).  After all, if
> the device is in D3cold, then the spec claims it's perfectly valid for
> it to not respond to PCI configuration access.

Yes, but the problem is that lspci etc... will suddenly see a bunch of
ffff's all over the place instead of the device. In fact, I think we do
use -some- cached infos already there but not for everything.

And that breaks .... distro installers :0

For example, currently, if I power off the ethernet of my mac, or the
firewire chip (which are powered off if the module isn't loaded), lspci
will get the device id and vendor id right ... but won't get the class
code.

I'm not sure about kudzu/udev/whoever, I've had problems with distros
not loading the modules because they couldn't find the chip because it
was off because the module wasn't loaded ... (typical of chips like
firewire which are loaded by class code).

So I agree... but :)

In a perfect world were everthing goes via sysfs and we have files that
expose all the necessary cached infos for identifying the device
(vendor, device, subsystem ids, class code, etc... which we do have in
sysfs), then yes, we can probably make config space accesses to an off
device just return ff's or an error (on some platform, they have to be
blocked as they can lockup, happens with some cells on the mac when
unclocked).
 
> I can only assume this hack was done to satisfy some terribly broken
> userspace app.

Yes, distro HW detection tools mostly.

>   It's not surprising that even reading PCI config can
> easily crash systems.  However, it's the responsibility of those apps
> with permission to access the PCI sysfs interface, not the kernel, to be
> aware of these constraints.

I agree.

> The PCI configuration space cache was originally introduced to support
> power management.  However, it's mostly incorrect, as it unnecessarily
> stores the values of read only registers (and even BIST which is
> potentially dangerous).  A while back I posted a series of patches that
> address this issue, and the net result was that the config cache stays
> around wasting memory because of the pci_block_user_cfg_access()
> dependency despite being useless to PCI PM.
> 
> I'd like to propose that we have the pci config sysfs interface return
> -EIO  when it's blocked (e.g. active BIST or D3cold).  This accurately
> reflects the state of the device to userspace, reduces complexity, and
> could potentially save some memory per PCI device instance.

We need to enquire which userspace apps have a problem here. It's mostly
a distro matter... or we can force their hand :)

The problem is mostly obsolete crap not using sysfs, like ... lspci :) 

Ben.


