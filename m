Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUJEAXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUJEAXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUJEAXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:23:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7851 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268711AbUJEAXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:23:32 -0400
Date: Mon, 4 Oct 2004 17:23:17 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: vojtech@suse.cz
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: usblp BKL removal
Message-ID: <20041004172317.372bc9a9@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs119.1 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Vojtech,

the appended patch is not in yet, what gives? I sent it to Marcelo with
an understanding that it would be in Linus tree any day now. It was a couple
of months ago. It's not just BKL witchhunt either. I remember that it fixed
an oops, although I do not remember the precise scenario by now (it had
something to do with a race between ->release and ->disconnect).

-- Pete

--- linux-2.6.9-rc3-mm2/drivers/usb/class/usblp.c	2004-10-04 16:59:42.849589554 -0700
+++ linux-2.6.9-rc3-mm2-usblp/drivers/usb/class/usblp.c	2004-10-04 17:15:42.983282509 -0700
@@ -222,6 +222,7 @@
 
 /* forward reference to make our lives easier */
 static struct usb_driver usblp_driver;
+static DECLARE_MUTEX(usblp_sem);	/* locks the existence of usblp's */
 
 /*
  * Functions for usblp control messages.
@@ -343,7 +344,7 @@
 	if (minor < 0)
 		return -ENODEV;
 
-	lock_kernel();
+	down (&usblp_sem);
 
 	retval = -ENODEV;
 	intf = usb_find_interface(&usblp_driver, minor);
@@ -389,7 +390,7 @@
 		}
 	}
 out:
-	unlock_kernel();
+	up (&usblp_sem);
 	return retval;
 }
 
@@ -415,13 +416,13 @@
 {
 	struct usblp *usblp = file->private_data;
 
-	down (&usblp->sem);
+	down (&usblp_sem);
 	usblp->used = 0;
 	if (usblp->present) {
 		usblp_unlink_urbs(usblp);
-		up(&usblp->sem);
 	} else 		/* finish cleanup from disconnect */
 		usblp_cleanup (usblp);
+	up (&usblp_sem);
 	return 0;
 }
 
@@ -1149,8 +1150,8 @@
 		BUG ();
 	}
 
+	down (&usblp_sem);
 	down (&usblp->sem);
-	lock_kernel();
 	usblp->present = 0;
 	usb_set_intfdata (intf, NULL);
 
@@ -1159,12 +1160,11 @@
 			usblp->writebuf, usblp->writeurb->transfer_dma);
 	usb_buffer_free (usblp->dev, USBLP_BUF_SIZE,
 			usblp->readbuf, usblp->readurb->transfer_dma);
+	up (&usblp->sem);
 
 	if (!usblp->used)
 		usblp_cleanup (usblp);
-	else 	/* cleanup later, on release */
-		up (&usblp->sem);
-	unlock_kernel();
+	up (&usblp_sem);
 }
 
 static struct usb_device_id usblp_ids [] = {
