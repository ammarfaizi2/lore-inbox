Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVDDQeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVDDQeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVDDQec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:34:32 -0400
Received: from fmr18.intel.com ([134.134.136.17]:2192 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261272AbVDDQeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:34:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC] PCI bridge driver rewrite
Date: Mon, 4 Apr 2005 09:33:43 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240838EA87@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [RFC] PCI bridge driver rewrite
Thread-Index: AcU5NBEd9FjV/4sOTZuEK8UhJAbGLw==
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <ambx1@neo.rr.com>
Cc: "Greg KH" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 04 Apr 2005 16:33:43.0621 (UTC) FILETIME=[10FFCF50:01C53934]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 24 2005 - 01:33:38 Adam Belay wrote:

>The basic flow of the new code is as follows:
>1.) A standard "driver core" driver binds to a bridge device.
>2.) When "*probe" is called it sets up the hardware and allocates a
"struct pci_bus".
>3.) The "struct pci_bus" is filled with information about the detected
bridge.
>4.) The driver then registers the "struct pci_bus" with the PCI Bus
Class.
>5.) The PCI Bus Class makes the bridge available to sysfs.
>6.) It then detects hardware attached to the bridge.
>7.) Each new PCI bridge device is registered with the driver model.
>8.) All remaining PCI devices are registered with the driver model.
>
>+static void pci_enable_crs(struct pci_dev *dev)
>+{
>+ u16 cap, rpctl;
>+ int rpcap = pci_find_capability(dev, PCI_CAP_ID_EXP);
>+ if (!rpcap)
>+ return;
>+
>+ pci_read_config_word(dev, rpcap + PCI_CAP_FLAGS, &cap);
>+ if (((cap & PCI_EXP_FLAGS_TYPE) >> 4) != PCI_EXP_TYPE_ROOT_PORT)
>+ return;
>+
>+ pci_read_config_word(dev, rpcap + PCI_EXP_RTCTL, &rpctl);
>+ rpctl |= PCI_EXP_RTCTL_CRSSVE;
>+ pci_write_config_word(dev, rpcap + PCI_EXP_RTCTL, rpctl);
>+}

Adam,

We need to coordinate your work with the PCI Express Port bus driver
that was accepted into the 2.6.x kernel.  The PCI Express Port Bus
driver claims all PCI-PCI Bridge's which implements PCI Express
Capability Structure. Please refer to PCIEBUS-HOWTO.txt for why we
developed PCI Express Port Bus driver to support PCI Express features.
Your current patch will claim PCI Express root ports, preventing the PCI
Express Port bus driver from loading.   Given the many advanced features
of PCI Express a separate bus driver was required.   Can you change the
patch so it only loads on standard PCI bridges and not PCI Express
devices?

Thanks,
Long
