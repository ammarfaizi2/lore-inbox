Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268462AbTANArU>; Mon, 13 Jan 2003 19:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268463AbTANArT>; Mon, 13 Jan 2003 19:47:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6919 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268462AbTANArQ>;
	Mon, 13 Jan 2003 19:47:16 -0500
Date: Mon, 13 Jan 2003 16:56:05 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Andries.Brouwer@cwi.nl, mdharm-usb@one-eyed-alien.net, mochel@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: sysfs
Message-ID: <20030114005605.GB10764@kroah.com>
References: <UTC200301111443.h0BEhRZ06262.aeb@smtp.cwi.nl> <20030113162741.A18396@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113162741.A18396@beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 04:27:41PM -0800, Patrick Mansfield wrote:
> 
> I don't have any usb mass storage devices, this patch against 2.5 bk
> compiles but otherwise is not tested. It should put the usb-scsi mass
> storage devices below the usb sysfs dev (I assume in your case under
> /sysfs/devices/pci0/00:07.2/usb1/1-2/1-2.4/1-2.4.4).

This patch works for me, nice.  I'll add it to my trees.

Matt, the struct us_data only holds a pointer to the struct usb_device
for any specific usb storage device.  Is there a pointer to the actual
interface that it is really bound to?  That would be the proper thing to
pass to scsi_set_device() as it's really the interface that you are in
control of, not the whole device.

Hm, you do have the ifnum, how about this patch on top of Pat's patch
instead?  It works for me and shows the relationship better.

thanks,

greg k-h


# USB: put the usb storage's SCSI device in the proper place in sysfs.
# Also makes usb_ifnum_to_if() a public function

diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	Mon Jan 13 16:54:37 2003
+++ b/drivers/usb/core/hcd.h	Mon Jan 13 16:54:37 2003
@@ -353,9 +353,6 @@
 extern void usb_bus_get (struct usb_bus *bus);
 extern void usb_bus_put (struct usb_bus *bus);
 
-extern struct usb_interface *usb_ifnum_to_if (struct usb_device *dev,
-	unsigned ifnum);
-
 extern int usb_find_interface_driver (struct usb_device *dev,
 	struct usb_interface *interface);
 
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Mon Jan 13 16:54:37 2003
+++ b/drivers/usb/core/usb.c	Mon Jan 13 16:54:37 2003
@@ -1484,6 +1484,7 @@
 EXPORT_SYMBOL(usb_driver_release_interface);
 EXPORT_SYMBOL(usb_match_id);
 EXPORT_SYMBOL(usb_find_interface);
+EXPORT_SYMBOL(usb_ifnum_to_if);
 
 EXPORT_SYMBOL(usb_new_device);
 EXPORT_SYMBOL(usb_reset_device);
diff -Nru a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
--- a/drivers/usb/storage/scsiglue.c	Mon Jan 13 16:54:37 2003
+++ b/drivers/usb/storage/scsiglue.c	Mon Jan 13 16:54:37 2003
@@ -88,9 +88,12 @@
 	/* register the host */
 	us->host = scsi_register(sht, sizeof(us));
 	if (us->host) {
+		struct usb_interface *iface;
 		us->host->hostdata[0] = (unsigned long)us;
 		us->host_no = us->host->host_no;
-		scsi_set_device(us->host, &us->pusb_dev->dev);
+		iface = usb_ifnum_to_if(us->pusb_dev, us->ifnum);
+		if (iface)
+			scsi_set_device(us->host, &iface->dev);
 		return 1;
 	}
 
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Mon Jan 13 16:54:37 2003
+++ b/include/linux/usb.h	Mon Jan 13 16:54:37 2003
@@ -277,7 +277,9 @@
 const struct usb_device_id *usb_match_id(struct usb_interface *interface,
 					 const struct usb_device_id *id);
 
-struct usb_interface *usb_find_interface(struct usb_driver *drv, kdev_t kdev);
+extern struct usb_interface *usb_find_interface(struct usb_driver *drv, kdev_t kdev);
+extern struct usb_interface *usb_ifnum_to_if(struct usb_device *dev, unsigned ifnum);
+
 
 /**
  * usb_make_path - returns stable device path in the usb tree
