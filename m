Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbULVFLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbULVFLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbULVFLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:11:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:46530 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261269AbULVFKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:10:49 -0500
Date: Tue, 21 Dec 2004 21:10:39 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20041222051038.GD31076@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan> <20041222005726.GA13317@kroah.com> <20041221172906.3b9cbbbd@lembas.zaitcev.lan> <20041222050624.GC31076@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222050624.GC31076@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:06:24PM -0800, Greg KH wrote:
> On Tue, Dec 21, 2004 at 05:29:06PM -0800, Pete Zaitcev wrote:
> > On Tue, 21 Dec 2004 16:57:26 -0800, Greg KH <greg@kroah.com> wrote:
> > 
> > > It looks great, thanks for doing this work.  Let me know when you want
> > > it added to the kernel tree.
> > 
> > Thanks, Greg. There's a little tidbit in usbmon about which I wish you to
> > make a pronouncement explicitly:
> > 
> > +	/* XXX Is this how I pin struct bus? Ask linux-usb-devel */
> > +	kobject_get(&ubus->class_dev.kobj);
> > +	mbus->u_bus = ubus;
> > +	ubus->mon_bus = mbus;
> 
> Use usb_bus_get() instead.  Ick, that function's implementation sucks,
> I'll go clean it up and export it for you to be able to use from your
> code.

Does this patch work for you?

thanks,

greg k-h

-----

USB: export usb_bus_get() and usb_bus_put()

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

--- 1.176/drivers/usb/core/hcd.c	2004-12-20 17:14:32 -08:00
+++ edited/hcd.c	2004-12-21 21:09:01 -08:00
@@ -608,27 +608,20 @@ static int usb_rh_urb_dequeue (struct us
 
 /*-------------------------------------------------------------------------*/
 
-/* exported only within usbcore */
-struct usb_bus *usb_bus_get (struct usb_bus *bus)
+struct usb_bus *usb_bus_get(struct usb_bus *bus)
 {
-	struct class_device *tmp;
-
-	if (!bus)
-		return NULL;
-
-	tmp = class_device_get(&bus->class_dev);
-	if (tmp)        
-		return to_usb_bus(tmp);
-	else
-		return NULL;
+	if (bus)
+		class_device_get(&bus->class_dev);
+	return bus; 
 }
+EXPORT_SYMBOL_GPL(usb_bus_get);
 
-/* exported only within usbcore */
-void usb_bus_put (struct usb_bus *bus)
+void usb_bus_put(struct usb_bus *bus)
 {
 	if (bus)
 		class_device_put(&bus->class_dev);
 }
+EXPORT_SYMBOL_GPL(usb_bus_put);
 
 /*-------------------------------------------------------------------------*/
 
