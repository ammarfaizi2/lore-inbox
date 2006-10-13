Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWJMTUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWJMTUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWJMTUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:20:35 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:25301 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S1751831AbWJMTUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:20:34 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Adam Belay <abelay@MIT.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160760867.25218.77.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
	 <1160755562.25218.60.camel@localhost.localdomain>
	 <1160757260.26091.115.camel@localhost.localdomain>
	 <1160759349.25218.62.camel@localhost.localdomain>
	 <20061013164933.GD11633@parisc-linux.org>
	 <1160760867.25218.77.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 15:30:21 -0400
Message-Id: <1160767822.26091.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.217
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 18:34 +0100, Alan Cox wrote:
Ar Gwe, 2006-10-13 am 10:49 -0600, ysgrifennodd Matthew Wilcox:
> > No it didn't.  It's undefined behaviour to perform *any* PCI config
> > access to the device while it's doing a D-state transition.  It may have
> 
> I think you missed the earlier parts of the story - the kernel caches
> the base config register state.
> 
> > happened to work with the chips you tried it with, but more likely you
> > never hit that window because X simply didn't try to do that.
> 
> Which is why the kernel caches the register state. This all came up long
> ago and the solution we currently have was the one chosen after
> considerable debate and analysis about things like locking. We preserved
> the historical reliable interface going back to the early Linux PCI
> support and used by all the apps.
> 
> 
> There are several problems with making it return an error
> 
> - What does user space do ?
> 
> 	while(pci_...() == -EAGAIN) yield();
> 
> which is useful how - there is no select operation for waiting here, and
> while it could be added it just gets uglier
> 

If the sysfs file blocked, this could be handled quite cleanly, and
would reflect accurate PCI config state.

> - Who actually wants to get an error in that specific case ?
> 

Let's say the device is in D3cold (i.e. the parent bridge has been
powered down).  In that case, you might want to get an error (probably
-EIO, but maybe FF...).  A buffered copy would be incorrect if used by a
userspace driver, as this would be hiding a legitimate failure
condition.

> If you can find someone who desperately wants an error code then code in
> O_DIRECT support to do it and preserve the existing sane API.
> 
> The job of the kernel is not to expose hardware directly, it is to
> provide sane interfaces to it. We don't have separate interfaces to
> conf1, conf2, pcibios etc for good reason. Exposing everyone to ugly
> minor details of the PCI transition handling isn't progress.
> 

I suppose we have very different ideas about the actual role and purpose
of this sysfs interface.  As I see it, it provides direct access to
hardware for userspace device drivers (software that actually cares
about the ugly PCI details).  It's much lower-level than the highly
abstracted "vendor", "device", "resourceX", etc. interfaces.  As such,
it's very important that it accurately reflects what's actually going on
in hardware, even if this is of potentially greater hassle to userspace.
Now that's not to suggest that we shouldn't block this interface when
making a power state transition.  But I think it's best to expose the
hardware failure and powered off cases as errors.

On the other hand you seem to suggest that it is a potentially
approximate cache of the pci config space that primarily serves to
provide pci configuration data to userspace hardware detection
mechanisms.  However, in this case, I think it may as well be marked as
deprecated, as it's clearly inferior to the higher order sysfs
attributes ("vendor", "device", "irq", "class", etc.) with regard to
accuracy, code complexity (both for the kernel and userspace), and
ease-of-use.  In other words, I don't see a reason any userspace app
should ever use it other than for debugging (i.e. lspci).

Adam


