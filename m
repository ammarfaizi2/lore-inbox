Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVGPDV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVGPDV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVGPDTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:19:05 -0400
Received: from peabody.ximian.com ([130.57.169.10]:52369 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262191AbVGPDSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:18:48 -0400
Subject: Re: [RFC][PATCH] Add PCI<->PCI bridge driver [4/9]
From: Adam Belay <abelay@novell.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20050715095814.F25428@flint.arm.linux.org.uk>
References: <1121331319.3398.92.camel@localhost.localdomain>
	 <20050715095814.F25428@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 23:10:52 -0400
Message-Id: <1121483453.3398.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 09:58 +0100, Russell King wrote:
> On Thu, Jul 14, 2005 at 04:55:19AM -0400, Adam Belay wrote:
> > This patch adds a basic PCI<->PCI bridge driver that utilizes the new
> > PCI bus class API.
> 
> Thanks.  I think this breaks Cardbus.
> 
> The whole point of the way PCI is _presently_ organised is that it allows
> busses to be configured and setup _before_ the devices are made available
> to drivers.  This breaks that completely:

Hi Russell,

I'm aware of this issue.  These changes are major and will need more
than one pass to be correct.  I'll be redoing most of the bus
configuration code in the next patch set.  I have a strategy for proper
device and bus configuration.  These are my current thoughts:

1.) When bound to its device PCI bridge drivers will add their current
devices to the bus device list, but will not register them with the
driver model.

2.) The bus class driver will initiate a procedure similar to
pci_bus_add_devices(), but only for host (root) bridges and hot-plugged
devices.

pci_register_bus_devices(struct pci_bus *bus)
{
- register all bios configured bridges
- call pci_register_bus_devices() for each previously registered bridge
- register remaining uninitialized bridges and call
pci_register_bus_devices() for each bridge as it's registered.
}

pci_register_devices(struct pci_bus *bus)
{
- register all remaining PCI devices, including those of child pci buses
}

* pci_register_bus_devices() will be called first followed by
pci_register_devices().

3.) Bridge windows will not be configured until a child device is
enabled.  In other words, resource configuration is lazy much like we
handle PCI IRQ routing.  We will, however, verify the validity of BIOS
assignments.  If the assignments are incorrect, the bridge will be
disabled and then reconfigured when needed.

Thanks,
Adam


