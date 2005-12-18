Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965299AbVLRWZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbVLRWZn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVLRWZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:25:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:54957 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965297AbVLRWZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:25:41 -0500
Date: Sun, 18 Dec 2005 14:25:16 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB rejecting sleep
Message-ID: <20051218222516.GA19183@kroah.com>
References: <1134937642.6102.85.camel@gaston> <20051218215051.GA18257@kroah.com> <1134944031.6102.103.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134944031.6102.103.camel@gaston>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 09:13:50AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2005-12-18 at 13:50 -0800, Greg KH wrote:
> 
> > Yes it is, and I have a patch in my tree now that fixes this up and
> > keeps the suspend process working properly for usb drivers that do not
> > have a suspend function.
> > 
> > Hm, I wonder if it should go in for 2.6.15?
> 
> Do you have an URL I can send to those users to test ?

Here's the patch itself, feel free to spread it around.

It's also at:
  kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usbcore-allow-suspend-resume-even-if-drivers-don-t-support-it.patch

thanks,

greg k-h



>From stern@rowland.harvard.edu Wed Dec 14 09:39:01 2005
Date: Wed, 14 Dec 2005 12:22:17 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <greg@kroah.com>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: [PATCH] usbcore: allow suspend/resume even if drivers don't support it
Message-ID: <Pine.LNX.4.44L0.0512141215510.7421-100000@iolanthe.rowland.org>

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
@@ -1029,7 +1029,8 @@ static int usb_generic_suspend(struct de
 			mark_quiesced(intf);
 	} else {
 		// FIXME else if there's no suspend method, disconnect...
-		dev_warn(dev, "no %s?\n", "suspend");
+		dev_warn(dev, "no suspend for driver %s?\n", driver->name);
+		mark_quiesced(intf);
 		status = 0;
 	}
 	return status;
@@ -1057,8 +1058,10 @@ static int usb_generic_resume(struct dev
 	}
 
 	if ((dev->driver == NULL) ||
-	    (dev->driver_data == &usb_generic_driver_data))
+	    (dev->driver_data == &usb_generic_driver_data)) {
+		dev->power.power_state.event = PM_EVENT_FREEZE;
 		return 0;
+	}
 
 	intf = to_usb_interface(dev);
 	driver = to_usb_driver(dev->driver);
@@ -1078,7 +1081,7 @@ static int usb_generic_resume(struct dev
 			mark_quiesced(intf);
 		}
 	} else
-		dev_warn(dev, "no %s?\n", "resume");
+		dev_warn(dev, "no resume for driver %s?\n", driver->name);
 	return 0;
 }
 
