Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVAMAqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVAMAqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVAMAoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:44:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54253 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261406AbVAMAlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:41:09 -0500
Subject: [PATCH] release_pcibus_dev() crash
From: John Rose <johnrose@austin.ibm.com>
To: jbarnes@sgi.com, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 12 Jan 2005 18:39:16 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the course of a hotplug removal of a PCI bus, release_pcibus_dev()
attempts to remove attribute files from a kobject directory that no longer
exists.  The calls that cause the crash were recently added, and this patch
removes them.  The partial oops traceback, observed on ppc64, is:

[c0000000ba1eb2d0] c0000000000f6eb4 .sysfs_remove_file+0x20/0x38
[c0000000ba1eb350] c00000000024c564 .class_device_remove_file+0x28/0x40
[c0000000ba1eb3d0] c0000000001dad5c .release_pcibus_dev+0x38/0x90
[c0000000ba1eb460] c00000000024c884 .class_dev_release+0x50/0x84
[c0000000ba1eb4e0] c0000000001cf4a8 .kobject_cleanup+0xec/0xf4
[c0000000ba1eb580] c0000000001d02f8 .kref_put+0x90/0x98
[c0000000ba1eb600] c0000000001cf500 .kobject_put+0x34/0x50
[c0000000ba1eb680] c00000000024d2ac .class_device_put+0x1c/0x34
[c0000000ba1eb700] c00000000024d194 .class_device_unregister+0x28/0x44
[c0000000ba1eb790] c0000000001dc8d8 .pci_remove_bus+0x78/0x98
...

The removal of the class device from sysfs is carried out explicitly by
class_device_del(), which occurs prior to class_device_put().  The class device
is gone from sysfs by the time class_device_put() is called.  As such, this
release function should not carry out sysfs cleanups for the class device.

I'm unsure how pci_remove_legacy_files() doesn't cause the same crash for those
who implemented it, but I'll leave that alone for now.

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN drivers/pci/probe.c~01_release_pcibus_dev drivers/pci/probe.c
--- 2_6_linus_2/drivers/pci/probe.c~01_release_pcibus_dev	2005-01-12 18:22:00.000000000 -0600
+++ 2_6_linus_2-johnrose/drivers/pci/probe.c	2005-01-12 18:22:29.000000000 -0600
@@ -96,9 +96,6 @@ static void release_pcibus_dev(struct cl
 	struct pci_bus *pci_bus = to_pci_bus(class_dev);
 
 	pci_remove_legacy_files(pci_bus);
-	class_device_remove_file(&pci_bus->class_dev,
-				 &class_device_attr_cpuaffinity);
-	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
 	if (pci_bus->bridge)
 		put_device(pci_bus->bridge);
 	kfree(pci_bus);

_

