Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVKESL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVKESL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVKESL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:11:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28176 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750852AbVKESL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:11:28 -0500
Date: Sat, 5 Nov 2005 18:11:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [DRIVER MODEL] Add platform_driver
Message-ID: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches adds a platform_driver structure, which
is much like the pci_driver structure:

struct platform_driver {
	int (*probe)(struct platform_device *);
	int (*remove)(struct platform_device *);
	void (*shutdown)(struct platform_device *);
	int (*suspend)(struct platform_device *, pm_message_t state);
	int (*resume)(struct platform_device *);
	struct device_driver driver;
};

The idea behind this is to stop using the struct device_driver
suspend/resume fields, and eventually eliminate the other function
pointers from within that structure.

Why?

Virtually every other user wraps the device_driver structure in
their own structure, which contains function pointers specific
to their implementation.  For instance, pci_driver contains:

    int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);
    void (*remove) (struct pci_dev *dev);
    int  (*suspend) (struct pci_dev *dev, pm_message_t state);
    int  (*resume) (struct pci_dev *dev);
    int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);
    void (*shutdown) (struct pci_dev *dev);

and as can be seen, the arguments to these methods are typed
according to the bus type.

Hence, the methods in struct device_driver are just adding needless
bloat to the kernel.  In addition, use of these device_driver methods
invariably requires a container_of() manipulation of the struct_device
structure, and doing that in every driver is also needless code bloat.

Also, from the type safety aspect, it's better to have methods which
are passed the correct type and if they aren't have a compiler
warning or build failure.

Hence, the following patches introduce struct platform_driver, and
then convert the platform device drivers over to this new model.

Due to the way the conversion is done, unconverted drivers will still
continue to work as before... for the time being.

Patches, which are built on top of my previous driver model patch set,
follow.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
