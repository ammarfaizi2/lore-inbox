Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTHURjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbTHURbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:11974 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262844AbTHURa7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:30:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870682543@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870683797@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:08 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.21.2, 2003/08/13 17:42:56-07:00, janiceg@us.ibm.com

[PATCH] PCI: testing for probe errors in pci-driver.c

Currently if __pci_device_probe locates the correct
device driver, but receives an error from the static
drv->probe function, this error is not reported.

The attached patch reports the above error condition
to the caller.  Only when a match for the device in
the static tables is not found, is the dynamic driver
table searched.


 drivers/pci/pci-driver.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu Aug 21 10:22:52 2003
+++ b/drivers/pci/pci-driver.c	Thu Aug 21 10:22:52 2003
@@ -122,10 +122,8 @@
 
 	if (!pci_dev->driver && drv->probe) {
 		error = pci_device_probe_static(drv, pci_dev);
-		if (error >= 0)
-			return error;
-
-		error = pci_device_probe_dynamic(drv, pci_dev);
+		if (error == -ENODEV)
+			error = pci_device_probe_dynamic(drv, pci_dev);
 	}
 	return error;
 }

