Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBPAOt>; Thu, 15 Feb 2001 19:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBPAOj>; Thu, 15 Feb 2001 19:14:39 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:5318 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129378AbRBPAOX>;
	Thu, 15 Feb 2001 19:14:23 -0500
Date: Fri, 16 Feb 2001 01:14:01 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102160014.BAA07108@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, twaugh@redhat.com
Subject: 2.4.1-ac breaks parport_pc when CONFIG_PCI=n
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.1-ac breaks parport_pc in PCI-less configs.
Attempting to 'make vmlinux' in 2.4.1-ac14 with

# CONFIG_MODULES is not set
# CONFIG_PCI is not set
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y

results in

drivers/parport/driver.o: In function `parport_pc_init_superio':
drivers/parport/driver.o(.text.init+0x1311): undefined reference to `pci_devices'
drivers/parport/driver.o(.text.init+0x1316): undefined reference to `pci_devices'
drivers/parport/driver.o(.text.init+0x1323): undefined reference to `pci_devices'
make: *** [vmlinux] Error 1

parport_pc_init_superio() contains a pci_for_each_dev loop. This macro
references pci_devices which doesn't exist when CONFIG_PCI=n.
2.4.1 vanilla has a #ifdef CONFIG_PCI/#endif pair around the offending
code, but 2.4.1-ac removes the #ifdef leading to the error above.

Either the #ifdef needs to be put back in, or pci_for_each_dev should
have a dummy #define in <linux/pci.h> for !CONFIG_PCI, like many of the
other pci functions.

/Mikael
