Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVLUW2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVLUW2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVLUW2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:28:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:56790 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964838AbVLUW2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:28:30 -0500
Date: Wed, 21 Dec 2005 14:28:11 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       stern@rowland.harvard.edu
Subject: [patch 2/2] usbcore: allow suspend/resume even if drivers don't support it
Message-ID: <20051221222811.GB9518@kroah.com>
References: <20051216185442.633779000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221222743.GA9501@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as618) changes usbcore to prevent derailing the
suspend/resume sequence when a USB driver doesn't include support for
it.  This is a workaround rather than a true fix; the core needs to be
changed so that URB submissions from suspended drivers can be refused
and outstanding URBs cancelled.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/usb.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/usb.c
+++ gregkh-2.6/drivers/usb/core/usb.c
@@ -1432,7 +1432,8 @@ static int usb_generic_suspend(struct de
 			mark_quiesced(intf);
 	} else {
 		// FIXME else if there's no suspend method, disconnect...
-		dev_warn(dev, "no %s?\n", "suspend");
+		dev_warn(dev, "no suspend for driver %s?\n", driver->name);
+		mark_quiesced(intf);
 		status = 0;
 	}
 	return status;
@@ -1460,8 +1461,10 @@ static int usb_generic_resume(struct dev
 	}
 
 	if ((dev->driver == NULL) ||
-	    (dev->driver_data == &usb_generic_driver_data))
+	    (dev->driver_data == &usb_generic_driver_data)) {
+		dev->power.power_state.event = PM_EVENT_FREEZE;
 		return 0;
+	}
 
 	intf = to_usb_interface(dev);
 	driver = to_usb_driver(dev->driver);
@@ -1481,7 +1484,7 @@ static int usb_generic_resume(struct dev
 			mark_quiesced(intf);
 		}
 	} else
-		dev_warn(dev, "no %s?\n", "resume");
+		dev_warn(dev, "no resume for driver %s?\n", driver->name);
 	return 0;
 }
 
