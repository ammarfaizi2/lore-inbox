Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290121AbSAWV3s>; Wed, 23 Jan 2002 16:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290115AbSAWV3j>; Wed, 23 Jan 2002 16:29:39 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:57092 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290118AbSAWV3d>;
	Wed, 23 Jan 2002 16:29:33 -0500
Date: Wed, 23 Jan 2002 13:24:36 -0800
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Torrey Hoffman <thoffman@arnor.net>, vojtech@ucw.cz,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: depmod problem for 2.5.2-dj4
Message-ID: <20020123212435.GB15259@kroah.com>
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net> <20020123045405.GA12060@kroah.com> <20020123094414.D5170@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020123094414.D5170@suse.cz>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 26 Dec 2001 18:49:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 09:44:14AM +0100, Vojtech Pavlik wrote:
> On Tue, Jan 22, 2002 at 08:54:05PM -0800, Greg KH wrote:
> > Vojtech, is this a USB function that you want added to usb.c?
> 
> Yes, please. This will change later when Pat Mochels devicefs kicks in,
> but for the time being, it'd be very useful.

Here's a patch against 2.5.3-pre3, does it look ok to you (I fixed the
potential memory leak in the second kmalloc call from what was in
2.5.2-dj4)?

greg k-h

diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Wed Jan 23 13:20:28 2002
+++ b/drivers/usb/usb.c	Wed Jan 23 13:20:28 2002
@@ -2513,6 +2513,49 @@
 	return err;
 }
 
+/**
+ * usb_make_path - returns device path in the hub tree
+ * @dev: the device whose path is being constructed
+ * @buf: where to put the string
+ * @size: how big is "buf"?
+ *
+ * Returns length of the string (>= 0) or out of memory status (< 0).
+ */
+int usb_make_path(struct usb_device *dev, char *buf, size_t size)
+{
+	struct usb_device *pdev = dev->parent;
+	char *tmp;
+	char *port;
+	int i;
+
+	if (!(port = kmalloc(size, GFP_KERNEL)))
+		return -ENOMEM;
+	if (!(tmp = kmalloc(size, GFP_KERNEL))) {
+		kfree(port);
+		return -ENOMEM;
+	}
+
+	*port = 0;
+
+	while (pdev) {
+		for (i = 0; i < pdev->maxchild; i++)
+			if (pdev->children[i] == dev)
+				break;
+
+		if (pdev->children[i] != dev)
+			return -1;
+
+		strcpy(tmp, port);
+		snprintf(port, size, strlen(port) ? "%d.%s" : "%d", i + 1, tmp);
+
+		dev = pdev;
+		pdev = dev->parent;
+	}
+
+	snprintf(buf, size, "usb%d:%s", dev->bus->busnum, port);
+	return strlen(buf);
+}
+
 /*
  * By the time we get here, the device has gotten a new device ID
  * and is in the default state. We need to identify the thing and
@@ -2762,5 +2805,6 @@
 EXPORT_SYMBOL(usb_set_configuration);
 EXPORT_SYMBOL(usb_set_interface);
 
+EXPORT_SYMBOL(usb_make_path);
 EXPORT_SYMBOL(usb_devfs_handle);
 MODULE_LICENSE("GPL");
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Wed Jan 23 13:20:28 2002
+++ b/include/linux/usb.h	Wed Jan 23 13:20:28 2002
@@ -881,6 +881,7 @@
 	char *buf, size_t size);
 extern int usb_set_configuration(struct usb_device *dev, int configuration);
 extern int usb_set_interface(struct usb_device *dev, int ifnum, int alternate);
+extern int usb_make_path(struct usb_device *dev, char *buf, size_t size);
 
 /*
  * timeouts, in seconds, used for sending/receiving control messages
