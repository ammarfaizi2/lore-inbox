Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVJRGF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVJRGF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVJRGF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:05:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:2188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932379AbVJRGF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:05:27 -0400
Date: Mon, 17 Oct 2005 23:04:35 -0700
From: Greg KH <gregkh@suse.de>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: dtor_core@ameritech.net, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051018060435.GA10622@suse.de>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017214430.GA5193@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:44:30PM -0700, Greg KH wrote:
> But, if you think we can't break userspace by adding nested class
> devices just yet, I agree, and can probably just put a symlink in
> /sys/class/input to the nested devices, which will make everything "just
> work".  I'll try that out later tonight and let you all know how it
> goes.

Below is a patch that does this for the event portion of input.  Good
news is that the symlink shows up just fine in sysfs.  Bad news is that
even with your previously posted patch, udev dies a horrible death.

And udev dies today with the nested stuff too, so that's not good
either.

So I could just move the class devices back to the main /sys/input/
directory (instead of the nesting) which will make userspace happy, and
then start working on the class -> device stuff.

Or I'll look at udev in the morning to see if it's just an easy fix...

thanks,

greg k-h


--- gregkh-2.6.orig/drivers/input/evdev.c	2005-10-16 13:09:07.000000000 -0700
+++ gregkh-2.6/drivers/input/evdev.c	2005-10-17 22:47:40.000000000 -0700
@@ -661,6 +661,7 @@ static struct file_operations evdev_fops
 static struct input_handle *evdev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct evdev *evdev;
+	struct class_device *cdev;
 	int minor;
 
 	for (minor = 0; minor < EVDEV_MINORS && evdev_table[minor]; minor++);
@@ -686,10 +687,13 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	class_device_create(&input_class, &dev->cdev,
+	cdev = class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->cdev.dev, "event%d", minor);
 
+	/* temporary symlink to keep userspace happy */
+	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj, evdev->name);
+
 	return &evdev->handle;
 }
 
@@ -698,6 +702,7 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
+	sysfs_remove_link(&input_class.subsys.kset.kobj, evdev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev->exist = 0;
