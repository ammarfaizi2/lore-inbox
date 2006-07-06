Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWGFVjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWGFVjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWGFVjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:39:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:60977 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750778AbWGFVjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:39:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ucL9px/Va1C5UDMT2ZaULXtoSlaxO4yp8SLBqJGxy5Kz+lM+VOQ8M5p82Qys1JDD/Aa99QghQ4moB/3fcdgK2pNwKiRf0QHcBgFVQpRX1i1Ev4Den0rXnkcME7jgdtQoZga9BfPyVIKNlukzFc0Dl8lH6tcKzfAF2tE53MOZHQM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][ACPI] Missing newline in acpi messes up dmesg output
Date: Thu, 6 Jul 2006 23:40:22 +0200
User-Agent: KMail/1.9.3
Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607062340.23137.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's a tiny bug in 2.6.18-rc1.
In drivers/acpi/bus.c::acpi_bus_set_power() there's a check to see if
the device is power_manageable and if not then print a debug message
and return -ENODEV. The debug printk() is missing a \n.

The printk statement looks like this : 

          printk(KERN_DEBUG "Device `[%s]' is not power manageable",
                          device->kobj.name);

As you can see, there's no newline at the end, and that causes 
problems for the next message to be printed.

On my system the above results in this in dmesg : 

...
Device `[PEB1]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
Device `[PEB2]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
...

Adding a newline (as the patch below does) turns this into

...
Device `[PEB1]' is not power manageable
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
Device `[PEB2]' is not power manageable
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
...

Which is much nicer :-)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/acpi/bus.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18-rc1-orig/drivers/acpi/bus.c	2006-07-06 19:39:29.000000000 +0200
+++ linux-2.6.18-rc1/drivers/acpi/bus.c	2006-07-06 23:23:12.000000000 +0200
@@ -192,7 +192,7 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		printk(KERN_DEBUG "Device `[%s]' is not power manageable",
+		printk(KERN_DEBUG "Device `[%s]' is not power manageable\n",
 				device->kobj.name);
 		return -ENODEV;
 	}



