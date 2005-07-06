Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVGFXMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVGFXMC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVGFXJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:09:36 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:62870 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262560AbVGFXHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:07:53 -0400
Date: Thu, 7 Jul 2005 03:07:56 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: [patch 2.6.13-rc2] yet another fix for setup-bus.c/x86 merge
Message-ID: <20050707030756.B6806@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a slight disagreement between setup-bus.c code and traditional
x86 PCI setup wrt which recourses are invalid vs resources that are
free for further allocations.
Precisely, in the setup-bus.c, if we failed to allocate some resource,
we nullify "start" and "flags" fields, but *not* the "end" one.
But x86 pcibios_enable_resources() does the following check:
if (!r->start && r->end) {
	printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
	return -EINVAL;
which means that the device owning the offending resource cannot be
enabled.
In particular, this breaks cardbus behind the normal decode p2p bridge -
the cardbus code from setup-bus.c requests rather large IO and MEM windows,
and if it fails, the socket is completely unavailable. Which is wrong, as
the yenta code is capable to allocate smaller windows.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

--- 2.6.13-rc2/drivers/pci/setup-bus.c	Thu Jul  7 01:30:58 2005
+++ linux/drivers/pci/setup-bus.c	Thu Jul  7 01:32:43 2005
@@ -74,6 +74,7 @@ pbus_assign_resources_sorted(struct pci_
 		idx = res - &list->dev->resource[0];
 		if (pci_assign_resource(list->dev, idx)) {
 			res->start = 0;
+			res->end = 0;
 			res->flags = 0;
 		}
 		tmp = list;
