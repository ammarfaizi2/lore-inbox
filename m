Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312379AbSDNRoW>; Sun, 14 Apr 2002 13:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312380AbSDNRoV>; Sun, 14 Apr 2002 13:44:21 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:19978 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312379AbSDNRoU>;
	Sun, 14 Apr 2002 13:44:20 -0400
Date: Sun, 14 Apr 2002 09:43:55 -0700
From: Greg KH <greg@kroah.com>
To: Ian Molton <spyro@armlinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-ID: <20020414164355.GA18040@kroah.com>
In-Reply-To: <20020414004022.6450f038.spyro@armlinux.org> <20020414150719.GA17826@kroah.com> <20020414183247.016a2ec3.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 17 Mar 2002 14:36:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 06:32:47PM +0100, Ian Molton wrote:
> 
> > What devices do you have plugged in?
> 
> one alcatel usb speedtouch ADSL modem, using the 'user mode' driver.

Ah, please try using the patch below from David Brownell to fix this
problem.  I've already applied this to my trees, and will get pushed to
the main kernels soon.

Let me know if this helps or not.

thanks,

greg k-h



--- drivers/usb-dist/devio.c	Tue Nov 20 22:39:48 2001
+++ drivers/usb/devio.c	Wed Mar 20 08:47:37 2002
@@ -286,7 +286,9 @@
 }
 
 /*
- * interface claiming
+ * interface claims are made only at the request of user level code,
+ * which can also release them (explicitly or by closing files).
+ * they're also undone when devices disconnect.
  */
 
 static void *driver_probe(struct usb_device *dev, unsigned int intf,
@@ -299,7 +301,20 @@
 {
 	struct dev_state *ps = (struct dev_state *)context;
 
+	if (!ps)
+		return;
+
+	/* this waits till synchronous requests complete */
+	down_write (&ps->devsem);
+
+	/* prevent new I/O requests */
+	ps->dev = 0;
 	ps->ifclaimed = 0;
+
+	/* force async requests to complete */
+	destroy_all_async (ps);
+
+	up_write (&ps->devsem);
 }
 
 struct usb_driver usbdevfs_driver = {
