Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVCYXkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVCYXkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 18:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCYXkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 18:40:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:15080 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261872AbVCYXj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 18:39:58 -0500
Date: Fri, 25 Mar 2005 15:39:53 -0800
From: Greg KH <gregkh@suse.de>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/12] More Driver Model Locking Changes
Message-ID: <20050325233952.GA16355@kroah.com>
References: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net> <20050325192024.GA14290@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325192024.GA14290@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 11:20:24AM -0800, Greg KH wrote:
> On Thu, Mar 24, 2005 at 09:54:24PM -0800, Patrick Mochel wrote:
> > 
> > Here is the next round of driver model locking changes. These build off of
> > the previous set of changes, including the klist patch. They eradicate all
> > of the uses of the subsystems' rwsem in the driver core.
> > 
> > It does include the fix posted earlier that happened when removing the
> > driver.
> > 
> > A summary is listed below. The patches follow.
> 
> Looks great, I've pulled all of these into my tree.
> 
> thanks a lot for doing this work.

Oops, I needed a fix for the ieee1394 code (attached and applied to my
trees.

But can you take a look at drivers/scsi/scsi_transport_spi.c, line 265?
That is also going to need fixing up somehow.  Gotta love that FIXME
comment...

thanks,

greg k-h


Subject: [ieee1394] Use device_for_each_child() to unregister devices in nodemgr_remove_host_dev()

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
--- a/drivers/ieee1394/nodemgr.c	2005-03-25 12:04:35 -08:00
+++ b/drivers/ieee1394/nodemgr.c	2005-03-25 12:04:35 -08:00
@@ -695,14 +695,15 @@
 	put_device(dev);
 }
 
+static int __nodemgr_remove_host_dev(struct device *dev, void *data)
+{
+	nodemgr_remove_ne(container_of(dev, struct node_entry, device));
+	return 0;
+}
 
 static void nodemgr_remove_host_dev(struct device *dev)
 {
-	struct device *ne_dev, *next;
-
-	list_for_each_entry_safe(ne_dev, next, &dev->children, node)
-		nodemgr_remove_ne(container_of(ne_dev, struct node_entry, device));
-
+	device_for_each_child(dev, NULL, __nodemgr_remove_host_dev);
 	sysfs_remove_link(&dev->kobj, "irm_id");
 	sysfs_remove_link(&dev->kobj, "busmgr_id");
 	sysfs_remove_link(&dev->kobj, "host_id");
