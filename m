Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVCZADW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVCZADW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVCZADW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:03:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:11907 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261873AbVCZADQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:03:16 -0500
Date: Fri, 25 Mar 2005 16:03:10 -0800
From: Greg KH <gregkh@suse.de>
To: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: [0/12] More Driver Model Locking Changes
Message-ID: <20050326000309.GB16602@kroah.com>
References: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net> <20050325192024.GA14290@kroah.com> <20050325233952.GA16355@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325233952.GA16355@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 03:39:52PM -0800, Greg KH wrote:
> But can you take a look at drivers/scsi/scsi_transport_spi.c, line 265?
> That is also going to need fixing up somehow.  Gotta love that FIXME
> comment...

Ok, the patch below seems to fix it, but I would like some validation I
did the correct thing.

Oh, looks like pci express now has problems too, I'll go hit that one
next...

thanks,

greg k-h

-------------

[scsi] use device_for_each_child() to properly access child devices.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
--- a/drivers/scsi/scsi_transport_spi.c	2005-03-25 16:03:09 -08:00
+++ b/drivers/scsi/scsi_transport_spi.c	2005-03-25 16:03:09 -08:00
@@ -254,17 +254,21 @@
 spi_transport_rd_attr(rti, "%d\n");
 spi_transport_rd_attr(pcomp_en, "%d\n");
 
+/* we only care about the first child device so we return 1 */
+static int child_iter(struct device *dev, void *data)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	spi_dv_device(sdev);
+	return 1;
+}
+
 static ssize_t
 store_spi_revalidate(struct class_device *cdev, const char *buf, size_t count)
 {
 	struct scsi_target *starget = transport_class_to_starget(cdev);
 
-	/* FIXME: we're relying on an awful lot of device internals
-	 * here.  We really need a function to get the first available
-	 * child */
-	struct device *dev = container_of(starget->dev.children.next, struct device, node);
-	struct scsi_device *sdev = to_scsi_device(dev);
-	spi_dv_device(sdev);
+	device_for_each_child(&starget->dev, NULL, child_iter);
 	return count;
 }
 static CLASS_DEVICE_ATTR(revalidate, S_IWUSR, NULL, store_spi_revalidate);
