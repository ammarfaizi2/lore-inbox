Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVFUByU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVFUByU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVFUAAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:00:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:52708 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261781AbVFTXAA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:00 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] usb: klist_node_attached() fix
In-Reply-To: <11193083671399@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <1119308367755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] usb: klist_node_attached() fix

The original code looks like this:

        /* if interface was already added, bind now; else let
         * the future device_add() bind it, bypassing probe()
         */
        if (!list_empty (&dev->bus_list))
                device_bind_driver(dev);

IOW, it's checking to see if the device is attached to the bus or not
and binding the driver if it is. It's checking the device's bus list,
which will only appear empty when the device has been initialized, but
not added. It depends way too much on the driver model internals, but it
seems to be the only way to do the weird crap they want to do with
interfaces.

When I converted it to use klists, I accidentally inverted the logic,
which led to bad things happening. This patch returns the check to its
orginal value.

From: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Index: gregkh-2.6/drivers/usb/core/usb.c
===================================================================

---
commit 273971bade8a6d37c1b162146de1a53965cdc245
tree ef78c4a7c1b8ab39c9b6f47fef82278d5145e74d
parent 12eac738e5889a10da5b391c02eeb61229c796dc
author Patrick Mochel <mochel@digitalimplant.org> Mon, 20 Jun 2005 15:15:28 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:28 -0700

 drivers/usb/core/usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -293,7 +293,7 @@ int usb_driver_claim_interface(struct us
 	/* if interface was already added, bind now; else let
 	 * the future device_add() bind it, bypassing probe()
 	 */
-	if (!klist_node_attached (&dev->knode_bus))
+	if (klist_node_attached(&dev->knode_bus))
 		device_bind_driver(dev);
 
 	return 0;

