Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269933AbTGPCRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 22:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270067AbTGPCRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 22:17:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:50122 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269933AbTGPCRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 22:17:39 -0400
Date: Tue, 15 Jul 2003 19:31:50 -0700
From: Greg KH <greg@kroah.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030716023150.GA2302@kroah.com>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org> <20030716012948.GA1877@matchmail.com> <20030716013743.GA2112@kroah.com> <20030716014650.GB2681@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716014650.GB2681@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:46:50PM -0700, Mike Fedyk wrote:
> On Tue, Jul 15, 2003 at 06:37:43PM -0700, Greg KH wrote:
> > On Tue, Jul 15, 2003 at 06:29:48PM -0700, Mike Fedyk wrote:
> > > Here's a nice oops for you guys.
> > > 
> > > Hotplug is the trigger.  I can't reproduce without hotplug.
> > > 
> > > hotplug tries to load ohci, ehci, and finally uhci (the correct module), it
> > > oopses for each driver with hotplug, but if I try without hotplug ('apt-get
> > > remove hotplug' before rebooting), I can load all three usb drivers with no
> > > oops.
> > 
> > If you just load these drivers by hand, does the oops happen?
> > 
> 
> I didn't look into the hotplug scripts to see which hotplug modules (and
> they are modules for me) were being loaded and in which order.

It should just do:
	modprobe -q ehci-hcd >/dev/null 2>&1
	modprobe -q ohci-hcd >/dev/null 2>&1
	modprobe -q uhci-hcd >/dev/null 2>&1
		    
That's what the latest hotplug package has in it.  I don't know what
Debian has lately...

> I did load the usb drivers by hand with no oops though.

That's really strange.

> > Can you enable debugging in the kobject code, or the driver base code to
> > try to get some better debug messages of what is going on?
> > 
> 
> Please tell me which file that's in, and what I need to change, or give a
> patch.

Here's a patch that I always run with.  It is pretty verbose, but helps
me out a lot in debugging and development.

Let us know if it shows anything interesting.

thanks,

greg k-h


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Tue Jul 15 19:23:44 2003
+++ b/drivers/base/bus.c	Tue Jul 15 19:23:44 2003
@@ -8,7 +8,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG 1
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Tue Jul 15 19:24:11 2003
+++ b/drivers/base/class.c	Tue Jul 15 19:24:11 2003
@@ -10,7 +10,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG 1
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Jul 15 19:23:45 2003
+++ b/drivers/base/core.c	Tue Jul 15 19:23:45 2003
@@ -8,7 +8,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG 1
 
 #include <linux/device.h>
 #include <linux/err.h>
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Tue Jul 15 19:24:11 2003
+++ b/drivers/base/driver.c	Tue Jul 15 19:24:11 2003
@@ -8,7 +8,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG 1
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Tue Jul 15 19:23:44 2003
+++ b/lib/kobject.c	Tue Jul 15 19:23:44 2003
@@ -10,7 +10,7 @@
  * about using the kobject interface.
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -213,6 +213,7 @@
 
 void kobject_init(struct kobject * kobj)
 {
+	WARN_ON(atomic_read(&kobj->refcount));
 	atomic_set(&kobj->refcount,1);
 	INIT_LIST_HEAD(&kobj->entry);
 	kobj->kset = kset_get(kobj->kset);
@@ -379,6 +380,7 @@
 		atomic_inc(&kobj->refcount);
 	} else
 		ret = NULL;
+	WARN_ON((kobj != NULL) && (ret==NULL));
 	return ret;
 }
 
