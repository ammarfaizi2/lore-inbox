Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWJMO32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWJMO32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWJMO32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:29:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:31251 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750889AbWJMO32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:29:28 -0400
Date: Fri, 13 Oct 2006 10:29:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Adam Belay <abelay@MIT.EDU>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
In-Reply-To: <1160729427.26091.98.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Adam Belay wrote:

> Personally, I don't think exposing a cached version of the PCI config
> space when direct device access is prohibited is the right approach
> here.  We really shouldn't be lying about the internal state of PCI
> devices (the cached version could be quite inaccurate).  After all, if
> the device is in D3cold, then the spec claims it's perfectly valid for
> it to not respond to PCI configuration access.
> 
> I can only assume this hack was done to satisfy some terribly broken
> userspace app.  It's not surprising that even reading PCI config can
> easily crash systems.  However, it's the responsibility of those apps
> with permission to access the PCI sysfs interface, not the kernel, to be
> aware of these constraints.

According to the comment in the code, access is blocked only during the
time that the device is making the transition between different power
states.

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

Could you resubmit your old patches and include a corresponding fix for 
this access problem?

BTW, is it possible for userspace to try accessing a device in D3cold?  
Doesn't the fact that it is D3cold rather than D3hot mean the computer is 
turned off?  Or have I been missing out on new developments?

Alan Stern

