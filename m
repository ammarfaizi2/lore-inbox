Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWGHWot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWGHWot (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGHWot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:44:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:13131 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751318AbWGHWos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:44:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:user-agent:cc:mime-version:content-disposition:date:content-type:content-transfer-encoding:message-id;
        b=kkiOxG3YVjw1bnQtVbThCxPjOnD28VVH0NKxWXi7HVf57wpcY/hwliptMrxxuYeHiHdCeiYCqoTXafcwtKL0Cmi1VQ8M4H3aHA42vNWT9QBeYQbiP02cIHHhsrZrx1itPKPvtvj3jtpebJ0bYf16jysJOInXewIqnHpap7NxDbs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL][ACPI] Missing newline in acpi messes up dmesg output
User-Agent: KMail/1.9.3
Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       akpm@osdl.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 9 Jul 2006 00:43:26 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200607090043.27121.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This was already send once on July 6'th but got no response, so resending)

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



