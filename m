Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUCRA67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCRA66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:58:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:11147 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262257AbUCRA6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:58:50 -0500
Date: Wed, 17 Mar 2004 16:58:38 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@steeleye.com
Subject: Re: [PATCH] Fix removable USB drive oops
Message-ID: <20040318005838.GA25884@kroah.com>
References: <200403141810.i2EIAtK9032222@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403141810.i2EIAtK9032222@hera.kernel.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 06:48:36PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1623, 2004/03/13 13:48:36-05:00, James.Bottomley@steeleye.com
> 
> 	[PATCH] Fix removable USB drive oops
> 	
> 	The actual problem reported was because there wasn't a corresponding
> 	check on transport_classdev.class in the unregister.
> 	
> 	However, on closer inspection I also turned up a nasty thinko in the
> 	reference counting.  For reasons best known to the class code authors,
> 	class devices have to obtain their own references to the devices they're
> 	attached to which they release again in their .release routines, so you
> 	have to remember to do a get_device() in the correct place after the
> 	class_device_add().  I put comments in the code so that, hopefully, we
> 	can avoid the problem in future.

Bah, this was my fault, sorry.

Here's a patch that should fix this, and prevent you from needing this
patch.  Can you verify this?

thanks,

greg k-h


# Driver class: remove possible oops
#
# This happens when the device associated with a class device goes away before
# the class does.

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Wed Mar 17 16:57:10 2004
+++ b/drivers/base/class.c	Wed Mar 17 16:57:10 2004
@@ -155,8 +155,7 @@
 
 static void class_device_dev_unlink(struct class_device * class_dev)
 {
-	if (class_dev->dev)
-		sysfs_remove_link(&class_dev->kobj, "device");
+	sysfs_remove_link(&class_dev->kobj, "device");
 }
 
 static int class_device_driver_link(struct class_device * class_dev)
@@ -169,8 +168,7 @@
 
 static void class_device_driver_unlink(struct class_device * class_dev)
 {
-	if ((class_dev->dev) && (class_dev->dev->driver))
-		sysfs_remove_link(&class_dev->kobj, "driver");
+	sysfs_remove_link(&class_dev->kobj, "driver");
 }
 
 
