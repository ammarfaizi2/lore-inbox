Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUHTAvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUHTAvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 20:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267279AbUHTAvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 20:51:17 -0400
Received: from kingklip.aims.ac.za ([196.21.78.18]:24526 "EHLO aims.ac.za")
	by vger.kernel.org with ESMTP id S267540AbUHTAvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 20:51:09 -0400
To: linux-kernel@vger.kernel.org
Subject: cb_alloc misses vendor_id (2.4.26)
X-Mailer: MH-E 7.4.4; nmh 1.1; GNU Emacs 21.3.1
Date: Fri, 20 Aug 2004 02:51:00 +0200
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1BxxcS-0001zs-00@approximate.corpus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI (or cardbus) subsystem often does not recognize my wireless
Cardbus PCMCIA card, an Intersil ISL3890 [Prism GT/Prism Duette].  When
it works, the syslog msg is:

  kernel: cs: cb_alloc(bus 4): vendor 0x1260, device 0x3890

When it doesn't, I see

  kernel: cs: cb_alloc(bus 4): vendor 0xffff, device 0x3890

where 0xffff is 'Illegal Vendor ID'.  Now I almost always see the
not-working form.  lspci confirms the trouble:

$ lspci -G -s 04:00.0
Trying method 1......No.
Trying method 2......using /proc/bus/pci...OK
Decided to use /proc/bus/pci
0000:04:00.0 Network controller: Illegal Vendor ID: Unknown device 3890 (rev 01)
But if I tell it to ask the hardware directly:

$ lspci -G -s 04:00.0 -H1
Decided to use Intel-conf1
Scanning bus 00 for devices...
Scanning bus 01 for devices...
Scanning bus 04 for devices...
0000:04:00.0 Network controller: Intersil Corporation Intersil ISL3890 [Prism GT/Prism Duette] (rev 01)

After I added an "I don't care about the Vendor ID" entry to the prism54
driver (in islpci_hotplug.c), it recognizes the card based on the device
id of 0x3890, and wireless then works.  

However, But I wouldn't mind tracking down why /proc/bus/pci contains
the wrong vendor id while the hardware says the right vendor id.  Is it
a hardware problem with my card (in which case I can live with it thanks
to hacking prism54) or is it a problem in the pci or cardbus drivers?
Am happy to try various patches and report the results.  Looking at cs.c
didn't bring enlightenment.

I'm running 2.4.26 with Debian patches, on an i586 (Thinkpad 560X) with
a few extra options for Thinkpads.  My PCI options are:

CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG_PCI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_PCI_HERMES=m

And I'm using the in-kernel PCMCIA card services.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
      --Bertrand de Jouvenal
