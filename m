Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUHAAov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUHAAov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUHAAov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:44:51 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:44496 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S264113AbUHAAos
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:44:48 -0400
From: David Brownell <david-b@pacbell.net>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: Solving suspend-level confusion
Date: Sat, 31 Jul 2004 17:41:12 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200407310723.12137.david-b@pacbell.net> <200407311901.17390.oliver@neukum.org>
In-Reply-To: <200407311901.17390.oliver@neukum.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407311741.12406.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 July 2004 10:01, Oliver Neukum wrote:
> 
> Maybe a better approach would be to describe the required features to
> the drivers rather than encoding them in a single integer. Rather
> like passing a request that states "lowest power level with device state
> retained, must not do DMA, enable remote wake up"

A pointer to some sort of struct could be generic and typesafe;
better than an integer or enum.

	// <linux/device.h>
	struct device {
		... unchanged; but fix or remove this:
		struct dev_pm_state *power_state;
		...
	}; 

	// <linux/pm.>
	struct dev_pm_state {
		char *name;
		unsigned number;
		// maybe more
	};
	struct dev_pm_info {
		struct dev_pm_state	*power_state;
		struct dev_pm_state	**supported;
		unsigned could_wakeup:1;
		unsigned should_wakeup:1;
		... plus the rest
	};

There would be bus-specific rules about how those get used,
for example what device power states exist. 

	// <linux/pci.h>
	extern const struct dev_pm_state PCI_D0, PCI_D1, PCI_D2,
				PCI_D3cold, PCI_D3hot;

	... eventually signatures change:
	struct pci_driver {
		int  (*suspend) (struct pci_dev *dev, struct dev_pm_state *state);
		int  (*enable_wake) (struct pci_dev *dev, struct dev_pm *state,
					int enable);
	};
	int pci_set_power_state(struct pci_dev *dev, struct dev_pm *state);
	int pci_enable_wake(struct pci_dev *dev, struct dev_pm *state, int enable);

	// <asm/arch/bus.h>
	... support for whatever non-PCI device states work here
	... maybe even special states for the platform's busses:
	struct mybus_dev_pm_state {
		struct dev_pm_state public;
		// private state:  clock hooks, power switches,
		// linkage to devices sharing clock or power, etc
	};

So for example maybe dev->power.power_state == PCI_D0, and
dev->power->supported == { PCI_D0, PCI_D3hot, PCI_D3cold, NULL }
on some controller, and sysfs would say "D3hot" not "3" (or "2" or
whatever).  Other busses would report different states..

- Dave
