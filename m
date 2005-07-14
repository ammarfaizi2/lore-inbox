Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVGNJFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVGNJFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVGNJFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:05:24 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3721 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262960AbVGNJFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:22 -0400
Subject: [RFC][PATCH] PCI bus class driver rewrite for 2.6.13-rc2 [0/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:54:56 -0400
Message-Id: <1121331296.3398.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm in the process of overhauling some aspects of the PCI subsystem.
This patch series is a rewrite of the PCI probing and detection code.
It creates a well defined PCI bus class API and allows a standard PCI
driver to bind to PCI bridge devices.  This results in the following:

* cleaner code
* improved driver core support
* the option of adding new PCI bridge drivers
* better power management

Example from sysfs:
(/sys/bus/pci/drivers)
|-- pci-bridge
|   |-- 0000:00:1e.0 -> ../../../../devices/pci0000:00/0000:00:1e.0
|   |-- bind
|   |-- new_id
|   `-- unbind

Summary:
 drivers/pci/Makefile         |   10
 drivers/pci/bus.c            |   69 ---
 drivers/pci/bus/Makefile     |    9
 drivers/pci/bus/bus.c        |  144 ++++++
 drivers/pci/bus/bus.h        |    5
 drivers/pci/bus/config.c     |  466 ++++++++++++++++++++
 drivers/pci/bus/device.c     |  187 ++++++++
 drivers/pci/bus/pci-bridge.c |  206 ++++++++-
 drivers/pci/bus/probe.c      |  512 +++++++++++++++++++++-
 drivers/pci/probe.c          |  971 -------------------------------------------
 drivers/pci/remove.c         |  122 -----
 include/linux/pci.h          |    4
 12 files changed, 1501 insertions(+), 1204 deletions(-)

For these changes to be fully effective, the following code (some of
which was broken by these changes) will need to be fixed:

1.) PCI resource management and bus numbers
- We need to utilize ACPI provided PCI root bridge resource information.
- Lazy allocation should be used for device resource assignments.
- The PCI bus resource assignment API needs to be refined.
- We need smarter bus number assignment algorithms that maintain BIOS
configuration when possible.

2.) PCI Hotplug
- Hotplug drivers should use PCI subsystem resource assignment and
configuration code whenever possible (e.g. the recent changes to ACPI
PCI hotplug were a step in the right direction).
- I have some changes planned for device registration.

3.) ACPI
- The new probing code breaks _PRT handling.
- We need to register ACPI devices in the /sys/devices tree so we can
bind to the root bridge device.

4.) Platform Specific PCI support
- I'd like to improve the "pcibios" API.

5.) PCMCIA/Cardbus
- This needs to use the new PCI bus class driver.

I'm currently working on these issues.

I look forward to any comments or suggestions.

Cheers,
Adam


