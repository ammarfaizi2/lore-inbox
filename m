Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVAHHyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVAHHyA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVAHHxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:53:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:37765 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261847AbVAHFsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:11 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632573313@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <11051632574046@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.49, 2005/01/06 17:28:25-08:00, david-b@pacbell.net

[PATCH] Driver Core: handle bridged platform bus segments

During setup to access platform bus segments through bridges, the current
platform_device_register() ignores the resource parent specified by the
bridge.  That means it'll always detect a (false) resource conflict with
the bridge, and fail the resource reservation step.

This patch makes that code use the specified parent resource, defaulting
to "iomem_resource" or "ioport_resource" only for a NULL parent (that is,
for devices that aren't accessed through a bridge).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2005-01-07 15:38:05 -08:00
+++ b/drivers/base/platform.c	2005-01-07 15:38:05 -08:00
@@ -141,11 +141,13 @@
 		if (r->name == NULL)
 			r->name = pdev->dev.bus_id;
 
-		p = NULL;
-		if (r->flags & IORESOURCE_MEM)
-			p = &iomem_resource;
-		else if (r->flags & IORESOURCE_IO)
-			p = &ioport_resource;
+		p = r->parent;
+		if (!p) {
+			if (r->flags & IORESOURCE_MEM)
+				p = &iomem_resource;
+			else if (r->flags & IORESOURCE_IO)
+				p = &ioport_resource;
+		}
 
 		if (p && request_resource(p, r)) {
 			printk(KERN_ERR

