Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUBIXob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUBIX1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:27:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:1981 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265445AbUBIXWp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:45 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689413661@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:21 -0800
Message-Id: <10763689413014@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.17, 2004/02/04 10:03:35-08:00, colpatch@us.ibm.com

[PATCH] PCI: fix "pcibus_class" Device Class, release function

John Rose wrote:
> The function release_pcibus_dev() in probe.c defines the release procedure for
> device class pcibus_class.  I want to suggest that this function be scrapped :)
>
> This release function is called in the code path of class_device_unregister().
> The pcibus_class devices aren't currently unregistered anywhere, from what I
> can tell, so this release function is currently unused.  The runtime removal of
> PCI buses from logical partitions on PPC64 requires the unregistration of these
> class devices.  The natural place to do this IMHO is in pci_remove_bus_device()
> in remove.c.

You're right that the class device isn't currently unregistered, and
that was an oversight in the patch I originally sent.  Attatched is a
patch that remedies that situation.  pci_remove_bus_device() *is* the
natural place to unregister the class_dev, and that's just what the
patch does.


> The problem is that this calls pci_destroy_dev(), which calls put() on the same
> "bridge" device that the release function does.  This should only be done once
> in the course of removing a pci_bus, and I doubt that we want to change
> pci_destroy_dev().   The kfree() of the pci_bus struct is also done in both
> pci_remove_bus_device() and release_pcibus_dev().

Yep.  The patch pulls the kfree() out of pci_remove_bus_device() and
calls class_device_unregister() in it's place.  This will put() the
bridge device and free the pci_bus as needed.  put() does need to be
called twice because the bridge device is get()'d twice: once when the
device is registered and once when it's bus device grabs a reference to it.


 drivers/pci/remove.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c	Mon Feb  9 14:58:38 2004
+++ b/drivers/pci/remove.c	Mon Feb  9 14:58:38 2004
@@ -83,7 +83,7 @@
 		list_del(&b->node);
 		spin_unlock(&pci_bus_lock);
 
-		kfree(b);
+		class_device_unregister(&b->class_dev);
 		dev->subordinate = NULL;
 	}
 

