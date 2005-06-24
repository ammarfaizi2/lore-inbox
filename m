Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVFXC2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVFXC2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 22:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVFXC2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 22:28:24 -0400
Received: from apollo.tuxdriver.com ([24.172.12.2]:2315 "EHLO
	apollo.tuxdriver.com") by vger.kernel.org with ESMTP
	id S263004AbVFXC2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 22:28:15 -0400
Date: Thu, 23 Jun 2005 22:28:07 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-pm <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC] firmware leaves device in D3hot at boot
Message-ID: <20050624022807.GF28077@tuxdriver.com>
Mail-Followup-To: linux-pm <linux-pm@lists.osdl.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <20050623191451.GA20572@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623191451.GA20572@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 03:14:52PM -0400, John W. Linville wrote:

> This issue regarding D3hot->D0 state transitions seems like a piece
> of minutiae that we should not force individual drivers to address.

After some thought, I'm inclined to think that the patch below is
the right one.  It unconditionally saves and restores the PCI config
registers when pci_enable_device is called.  Although this is often
(usually?) unnecessary, it seems like a safe thing to do and it should
not be a performance-sensitive path.  The code to check for whether
or not this is necessary would be a little harder to read IMHO,
so I think this is warranted.

The comment block at the head of pci_enable_device says "Initialize
device before it's used by a driver" which implies that saving and
restoring the PCI config should be safe if the function is used
as intended.  Out of ~318 files referencing pci_enable_device, ~47
of them (~15%) of them are actually calling pci_enable_device from
multiple places.  Most of these that I've looked at so far are calling
it from ->resume as well as ->probe.  A few drivers seem to call
pci_enable_device from one of several branches within the same if
statement inside the ->probe function, but I figure thoese examples
are equivalent to just calling it from a single place.

Is calling pci_enable_device from ->resume really proper?  If not,
what should those devices be doing?  I'll be happy to take a glance
at all the drivers calling pci_enable_device multiple times if there
is general agreement that the approach below would be acceptable.

What do you all think?

John

P.S.  Below is the one-liner I used to determine who is accessing
pci_enable_device.  It probably misses a few strays...

# Generate list of calls to pci_enable_device
find . -type f -name '*.c' -exec \
	grep -H pci_enable_device[[:space:]]*\(.*\).*[\;\)] {} \; | \
	cut -f1 -d: | sort | uniq -c

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -399,10 +399,23 @@ pci_enable_device(struct pci_dev *dev)
 {
 	int err;
 
+	/* Need to save the PCI config space because some firmware
+	   will leave devices in D3hot on boot and some devices
+	   will loose config (incl BARs) in D3hot->D0 PM state
+	   transition.	Could make drivers do this, but better to
+	   leave them ignorant of PCI PM trivia...
+	*/
+	if (err = pci_save_state(dev))
+		return err;
+
 	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
 	dev->is_enabled = 1;
+
+	if (err = pci_restore_state(dev))
+		return err;
+
 	return 0;
 }
 
-- 
John W. Linville
linville@tuxdriver.com
