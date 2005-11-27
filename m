Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVK0N5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVK0N5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 08:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVK0N5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 08:57:31 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:29554 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751057AbVK0N5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 08:57:31 -0500
Message-ID: <4389BB45.7050108@gentoo.org>
Date: Sun, 27 Nov 2005 13:57:25 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: len.brown@intel.com
CC: linux-acpi@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, trenn@suse.de, rajesh.shah@intel.com
Subject: [PATCH] ACPI scan: Revert acpi_bus_find_driver() return value check
Content-Type: multipart/mixed;
 boundary="------------040501000308070609050005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040501000308070609050005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2.6.13 introduced a change to drivers/acpi/scan.c along the lines of:

          *
          * TBD: Assumes LDM provides driver hot-plug capability.
          */
-       result = acpi_bus_find_driver(device);
+       acpi_bus_find_driver(device);

        end:
         if (!result)

This was inside this commit:
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3fb02738b0fd36f47710a2bf207129efd2f5daa2

Since then, various HP/Compaq laptops have not been able to boot, freezing 
after these messages:

PCI: Using ACPI for IRQ routing
PCI: If a device does not work, try "pci=routeirq". If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1

Rajesh Shah (the author of said commit) has since then acked that this small 
change should probably be reverted:
> Looking at this closely now, checking for the result does appear
> to be wrong. Binding a driver for a device should be optional,
> and should not fail adding the device to the acpi list. I suspect
> a previous iteration through this code failed to find a driver
> match, returned failure to the caller and caused bad things to
> happen. So, your patch looks good to me.

The main diagnosis/discussion has been at:
https://bugzilla.novell.com/show_bug.cgi?id=116763

There are also some other reports elsewhere:
http://bugzilla.kernel.org/show_bug.cgi?id=5221
http://bugs.gentoo.org/112601

So far the investigation/fixing has been done by Thomas Renninger and others. 
I'm just hoping to breathe some life into an issue which has been sitting 
around for nearly 3 months.

If acceptable, please apply.

--------------040501000308070609050005
Content-Type: text/x-patch;
 name="acpi-scan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-scan.patch"

From: Thomas Renninger <trenn@suse.de>

This patch reverts the acpi_bus_find_driver() return value check which was
accidentally added in a big commit titled:

	[PATCH] acpi bridge hotadd: Allow ACPI .add and .start operations to be
	done independently

This particular change broke booting of some HP/Compaq laptops unless
acpi=noirq is used.

See http://bugzilla.kernel.org/show_bug.cgi?id=5221

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- vanilla-linux-2.6.14-rc3.orig/drivers/acpi/scan.c	2005-10-03 18:21:35.000000000 +0200
+++ vanilla-linux-2.6.14-rc3/drivers/acpi/scan.c	2005-10-03 18:21:58.000000000 +0200
@@ -1111,7 +1111,7 @@
 	 *
 	 * TBD: Assumes LDM provides driver hot-plug capability.
 	 */
-	result = acpi_bus_find_driver(device);
+	acpi_bus_find_driver(device);
 
       end:
 	if (!result)

--------------040501000308070609050005--
