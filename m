Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbTH0Wva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTH0Wva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:51:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:39845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262342AbTH0Wv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:51:27 -0400
Date: Wed, 27 Aug 2003 15:57:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Russell King <rmk@arm.linux.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI PM & compatibility
In-Reply-To: <20030826185147.H28810@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308271523490.4140-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Aug 2003, Russell King wrote:

> On Tue, Aug 26, 2003 at 08:31:55AM -0700, Patrick Mochel wrote:
> > > So in one case, we have PARENT SIBLING SIBLING SIBLING and in the
> > > other case we have SIBLING SIBLING SIBLING PARENT.
> > 
> > I haven't been ignoring you. I've been trying to figure exactly what 
> > you're talking about. Do you have a concrete example? Is it some PCMCIA 
> > driver, or some platform driver? 
> 
> It's a multi-function chip (again):
> 
>             sa1111 bus
>     SA1111------+-------Interrupt controller
>                 +-------USB host
>                 +-------PS/2 ports
> 
> The SA1111 probe function registers devices whose parent is the SA1111
> device.
> 
> In this case, we end up placing these devices on the list in the wrong
> order.
> 
> At the point where the SA1111 probe function is called, the SA1111 device
> is not on the dpm lists, because of the ordering in device_add().

Bah, sorry, I overlooked that. The patch below will add the device before 
calling bus_add_device(). Sorry about the confusion. 


	Pat


===== drivers/base/core.c 1.73 vs edited =====
--- 1.73/drivers/base/core.c	Fri Aug 15 10:27:01 2003
+++ edited/drivers/base/core.c	Wed Aug 27 15:49:08 2003
@@ -225,28 +225,30 @@
 		dev->kobj.parent = &parent->kobj;
 
 	if ((error = kobject_add(&dev->kobj)))
-		goto register_done;
-
-	/* now take care of our own registration */
-
+		goto Error;
+	if ((error = device_pm_add(dev)))
+		goto PMError;
+	if ((error = bus_add_device(dev)))
+		goto BusError;
 	down_write(&devices_subsys.rwsem);
 	if (parent)
 		list_add_tail(&dev->node,&parent->children);
 	up_write(&devices_subsys.rwsem);
 
-	bus_add_device(dev);
-
-	device_pm_add(dev);
-
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
-
- register_done:
-	if (error && parent)
-		put_device(parent);
+ Done:
 	put_device(dev);
 	return error;
+ BusError:
+	device_pm_remove(dev);
+ PMError:
+	kobject_unregister(&dev->kobj);
+ Error:
+	if (parent)
+		put_device(parent);
+	goto Done;
 }
 
 
@@ -312,8 +314,6 @@
 {
 	struct device * parent = dev->parent;
 
-	device_pm_remove(dev);
-
 	down_write(&devices_subsys.rwsem);
 	if (parent)
 		list_del_init(&dev->node);
@@ -324,14 +324,11 @@
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
-
 	bus_remove_device(dev);
-
+	device_pm_remove(dev);
 	kobject_del(&dev->kobj);
-
 	if (parent)
 		put_device(parent);
-
 }
 
 /**

