Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbUDNLjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbUDNLjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 07:39:08 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:2435 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263855AbUDNLjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 07:39:05 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 8/9] USB usbfs: missing lock in proc_getdriver
Date: Wed, 14 Apr 2004 13:37:28 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141247.24227.baldrick@free.fr> <200404141304.48641.oliver@neukum.org>
In-Reply-To: <200404141304.48641.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141337.28631.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 13:04, Oliver Neukum wrote:
> > +	down_read(&usb_bus_type.subsys.rwsem);
> > +	if (interface && interface->dev.driver) {
> > +		strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
> > +		ret = copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0;
> > +	}
> > +	up_read(&usb_bus_type.subsys.rwsem);
> > +	return ret;
>
> IMHO you should drop the lock before you copy to userspace.

Hi Oliver, I wasn't particularly worried about it since it's a rwsem taken for
reading and writing is a rare event.  Do you think it really matters?  If so,
how about this instead (compiles but otherwise untested):

@@ -702,13 +708,15 @@
 		return -EFAULT;
 	if ((ret = findintfif(ps->dev, gd.interface)) < 0)
 		return ret;
+	down_read(&usb_bus_type.subsys.rwsem);
 	interface = ps->dev->actconfig->interface[ret];
-	if (!interface->dev.driver)
+	if (!interface || !interface->dev.driver) {
+		up_read(&usb_bus_type.subsys.rwsem);
 		return -ENODATA;
+	}
 	strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
-	if (copy_to_user(arg, &gd, sizeof(gd)))
-		return -EFAULT;
-	return 0;
+	up_read(&usb_bus_type.subsys.rwsem);
+	return copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0;
 }
 
 static int proc_connectinfo(struct dev_state *ps, void __user *arg)
