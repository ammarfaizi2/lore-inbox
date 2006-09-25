Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWIYO6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWIYO6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWIYO6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:58:06 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:33456 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750861AbWIYO6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:58:04 -0400
Date: Mon, 25 Sep 2006 16:58:30 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2/9] driver core fixes: device_register() retval check in
 platform.c
Message-ID: <20060925165830.0bcdce55@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060923211032.GA4363@flint.arm.linux.org.uk>
References: <20060922113655.4306a1b5@gondolin.boeblingen.de.ibm.com>
	<20060923211032.GA4363@flint.arm.linux.org.uk>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 22:10:32 +0100,
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> I don't think there's much value in patches such as this - if the
> platform bus type didn't register, what happens when we then try
> to register a platform device driver or a platform device?  ISTR
> doing that before the bus type is registered leads to an OOPS.

Yes, since the klists have not yet been initialized.

> So, presumably to do this properly, if the platform_bus_type failed
> to register, you need to force all platform device/platform device
> driver registrations to also fail.

We should fail registration (gracefully) of all devices/drivers which
specify a bus that is !NULL but has not been registered. Unfortunately,
I don't see an easy way to do this.

However, we can fail the registration of devices that specify a parent
that is !NULL but not yet added to the tree. This catches platform
devices registering before platform_bus_type (since platform_bus is not
registered then), similar for other bus types like iucv.
(Unfortunately, not drivers...)


From: Cornelia Huck <cornelia.huck@de.ibm.com>

Force parent devices to be registered before their children. Otherwise we'll
oops when creating the child's sysfs directory.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/bus.c  |    6 ++++--
 drivers/base/core.c |    5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

--- linux-2.6.18-mm1.orig/drivers/base/core.c
+++ linux-2.6.18-mm1/drivers/base/core.c
@@ -474,7 +474,10 @@ int device_add(struct device *dev)
 	}
 
 	parent = get_device(dev->parent);
-
+	if (parent && !device_is_registered(parent)) {
+		error = -EINVAL;
+		goto Error;
+	}
 	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);
 
 	/* first, register with generic layer. */
--- linux-2.6.18-mm1.orig/drivers/base/bus.c
+++ linux-2.6.18-mm1/drivers/base/bus.c
@@ -418,7 +418,8 @@ int bus_attach_device(struct device * de
 			ret = 0;
 		} else
 			dev->is_registered = 0;
-	}
+	} else
+		dev->is_registered = 1;
 	return ret;
 }
 
@@ -443,7 +444,8 @@ void bus_remove_device(struct device * d
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		put_bus(dev->bus);
-	}
+	} else
+		dev->is_registered = 0;
 }
 
 static int driver_add_attrs(struct bus_type * bus, struct device_driver * drv)
