Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWCZB5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWCZB5M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 20:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCZB5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 20:57:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751188AbWCZB5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 20:57:12 -0500
Date: Sat, 25 Mar 2006 17:53:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: gregkh@suse.de, tiwai@suse.de, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
Subject: Re: bus_add_device() losing an error return from the probe() method
Message-Id: <20060325175322.1e04852b.akpm@osdl.org>
In-Reply-To: <44238489.8090402@keyaccess.nl>
References: <44238489.8090402@keyaccess.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> wrote:
>
>  ===================================================================
>  --- local.orig/drivers/base/bus.c	2006-02-27 19:22:08.000000000 +0100
>  +++ local/drivers/base/bus.c	2006-03-24 04:27:02.000000000 +0100
>  @@ -363,19 +363,21 @@ static void device_remove_attrs(struct b
>   int bus_add_device(struct device * dev)
>   {
>   	struct bus_type * bus = get_bus(dev->bus);
>  -	int error = 0;
>  +	int error;
>   
>   	if (bus) {
>   		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
>  -		device_attach(dev);
>  +		error = device_attach(dev);
>  +		if (error < 0)
>  +			return error;
>   		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
>   		error = device_add_attrs(bus, dev);
>  -		if (!error) {
>  -			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
>  -			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
>  -		}
>  +		if (error)
>  +			return error;
>  +		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
>  +		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
>   	}
>  -	return error;
>  +	return 0;
>   }
>   

Looks sane, but please don't sprinkle `return' statements all over a
function in this manner.


--- devel/drivers/base/bus.c~bus_add_device-losing-an-error-return-from-the-probe-method	2006-03-25 17:46:34.000000000 -0800
+++ devel-akpm/drivers/base/bus.c	2006-03-25 17:49:45.000000000 -0800
@@ -372,14 +372,17 @@ int bus_add_device(struct device * dev)
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		device_attach(dev);
+		error = device_attach(dev);
+		if (error < 0)
+			goto out;
 		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 		error = device_add_attrs(bus, dev);
-		if (!error) {
-			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
-		}
+		if (error)
+			goto out;
+		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+		sysfs_create_link(&dev->kobj,&dev->bus->subsys.kset.kobj,"bus");
 	}
+out:
 	return error;
 }
 

It's a little surprising that this function returns "OK" if bus==NULL.

Note that sysfs_create_link() can fail too.  This was one optimistic
function.

