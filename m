Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWAUMLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWAUMLB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 07:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAUMLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 07:11:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21888 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932124AbWAUMLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 07:11:00 -0500
Date: Sat, 21 Jan 2006 13:10:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpiphp: treat dck separate from dock bridge
Message-ID: <20060121121046.GA1530@elf.ucw.cz>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy> <1137808506.16192.69.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137808506.16192.69.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> actual p2p bridge, and what I try to do here is:
> 1) find the device that _DCK is defined under
> 2) if this is a bridged device, we are done (i.e. is has _ADR and is
> ejectable)
> 3) if not, then walk the namespace looking for _EJD.  If you find one,
> see if the dependency is on the dock device.  The dock bridge should be
> dependent on the dock device.  
> 
> 	- when you find something that is dependent on the dock device,
> 	  see if it has an _ADR and a _PRT entry.  If so, then it is the
> 	  p2p dock bridge.
> 
> So, this is likely a wrong assumption, so I will be thinking some more
> about how to tell which acpi device is the dock bridge.  But meanwhile,
> this patch could be tested/reviewed to see if it gets us a step further
> in the right direction.

Oopsen seems to be called because add_p2p_bridge is never called. I
think it should be called for this device:

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)

--- clean-mm//drivers/pci/hotplug/acpiphp_glue.c	2006-01-21 11:38:51.000000000 +0100
+++ linux-mm/drivers/pci/hotplug/acpiphp_glue.c	2006-01-21 12:53:28.000000000 +0100
@@ -454,16 +457,22 @@
 		return AE_OK;
 	}
 
+	printk("ADR ok\n");
+
 	device = (tmp >> 16) & 0xffff;
 	function = tmp & 0xffff;
 
 	dev = pci_get_slot(pci_bus, PCI_DEVFN(device, function));
 
+	printk("device, function = %lx\n", tmp);
+
 	if (!dev || !dev->subordinate)
 		goto out;
 
+	printk("detect slots\n");
+
 	/* check if this bridge has ejectable slots */
-	if (detect_ejectable_slots(handle) > 0) {
+	if ((tmp == 0x1e0000) || (detect_ejectable_slots(handle) > 0)) {
 		dbg("found PCI-to-PCI bridge at PCI %s\n", pci_name(dev));
 		add_p2p_bridge(handle, dev);
 	}

...but then bridge->slots is still empty. I tried forcing
is_ejectable(), but then I get:

Jan 21 13:09:52 amd kernel: acpiphp: ACPI Hot Plug PCI Controller
Driver version: 0.5
Jan 21 13:09:53 amd kernel: add_bridge
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1f0000
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 10000
Jan 21 13:09:53 amd kernel: detect slots
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1e0000
Jan 21 13:09:53 amd kernel: detect slots
Jan 21 13:09:53 amd kernel: acpiphp_glue: found PCI-to-PCI bridge at
PCI 0000:00:1e.0
Jan 21 13:09:53 amd kernel: add_p2p_bridge
Jan 21 13:09:53 amd kernel: acpiphp_glue: _HPP evaluation failed
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1f0001
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1d0000
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1d0001
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1d0002
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1d0007
Jan 21 13:09:53 amd kernel: find_p2p_bridge
Jan 21 13:09:53 amd kernel: ADR ok
Jan 21 13:09:53 amd kernel: device, function = 1f0006
Jan 21 13:09:53 amd kernel: acpiphp_glue: Bus 0000:02 has 0 slots
Jan 21 13:09:53 amd kernel: acpiphp_glue: Total 0 slots
Jan 21 13:10:05 amd pam_limits[1345]: wrong limit value 'unlimited'

								Pavel
-- 
Thanks, Sharp!
