Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbVJFAKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbVJFAKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 20:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVJFAKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 20:10:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:53124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030433AbVJFAKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 20:10:16 -0400
Date: Wed, 5 Oct 2005 17:09:51 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Message-ID: <20051006000951.GA4411@suse.de>
References: <20050928233114.GA27227@suse.de> <200509300032.50408.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509300032.50408.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 12:32:49AM -0500, Dmitry Torokhov wrote:
> On Wednesday 28 September 2005 18:31, Greg KH wrote:
> > Alright, here's a patch that will add the ability to nest struct
> > class_device structures in sysfs.  This should give everyone the ability
> > to model what they need to in the class directory (input, video, etc.).
> 
> I still do not believe it is the solution we want:
> 
> 1. It does not allow installing separate hotplug handlers for devices
>    and their sub-devices. This will cause hotplug handlers to resort to
>    having some flags or otherwise detect the king of class device hotplug
>    hanlder is being called for and change behavior accordingly - YUCK!

Huh?  I don't understand your complaint here.  Why would we ever want to
have separate hotplug handlers for the same class?  If you do want that,
then create separate classes.

> 2. It does not allow user/program to scan for devices of given subclass.

There is nothing called "subclass" anymore, so sure, you can't scan for
it :)

>    I understand that you want to tech udev about all existing handlers
>    and having hotplug events allows to filter out unneeded names but for
>    other programs I do not think we want to do that. Again, consider task
>    of wanting to know all input interfaces, ot all available partiotions
>    in a system. Do not say that the program has to know that there are hdX
>    and sdX and ubX and adopt every time new type of device comes along
>    since you would need to determine whether the name you see is an
>    ordinary attribute or attribute group or the subdevice you are interested
>    in. You can't really rely on presence of 'dev' attribute since subdevice
>    does not have to have it. A better way would be to do
>    "ls /sys/class/block/partitions/" or "ls /sys/class/input/interfaces"
>    and get all this information.

Yes, class devices can have a "dev" file, and be nested below another
class device, that's fine.  It's only a simple scan of sysfs to find
them, just like we do today for the block devices.  Again, I really
don't see the problem here.

> 3. It does not work well when you have an object that in your model is a
>    logical subdevice but does not have a parent (or has multiple parents).
>    Consider 'mice' multiplexor. Where would you put it? Together with
>    inputX? But it is not an input_dev, it should not be there.

Ok, the "mice" thing is a hack.  A big hack, but one that is needed.
Don't try to bring that one in...  Anyway, I can handle that one too,
see below.

> 4. subdevice should have only one parent, your implementation allows to
>    link subdevice to a class device and a real device at the same time,
>    which IMHO is wrong. Only top-level class devices should be linked with
>    physical /sys/devices/ device. 

Why?  Why arbirtrary make that distinction?  See my example below for an
example of that symlink being in both class devices, and everything is
just fine.

> I firmly believe that creating sub-classes (which solves hotplug issues)
> and linking sub-class devices to their parent via 'device' link, much like
> we link top-level class device to their physical parent devices (which
> solves 2, 3 and 4) is much cleanier way. It provides everything that your
> implementation does plus allows different views useful for other tasks
> besides udev.

I thought this way too.  Until I started to implement the sub-class
device code, and realized that I was just creating the same thing as the
existing class_device code.

And yes, I realize that this is different from nesting classes, but I
_really_ do not think that is the proper solution for this at all.

So, here's a small patch below, on top of the other input patches from
you that I've applied, that moves the mouse devices into the input_dev
class tree.  This works just fine on my box, and is what I think we want
to do.  After this, I'll just convert over the other input driver types,
and then rename the input_dev class to input, and we should be set.

Then you can still do your "convert input drivers to be class
interfaces" as I agree that this is a good thing to do too.

Here's what sysfs looks like on this box with the patch below:

$ tree /sys/class/input_dev/ -d
/sys/class/input_dev/
|-- input0
|   |-- capabilities
|   `-- id
|-- input1
|   |-- capabilities
|   |-- device -> ../../../devices/platform/i8042/serio1
|   `-- id
`-- input2
    |-- capabilities
    |-- device -> ../../../devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0
    |-- id
    `-- mouse0
        `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0


All of the files are in there too, I just did not show them as it
doesn't really matter (there's a "dev" file in
/sys/class/input_dev/input2/mouse0 like expected).

And yes, udev works just fine, as long as udevd is up and running before
you load the mouse drivers, udevstart is what is needed to be fixed up
to handle this properly (and Kay has some patches for that already.)

thanks,

greg k-h

Subject: Input: start nesting the mouse drivers in the proper place in sysfs

This puts the mouse drivers under their proper inputX class_device in
sysfs.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/input.c    |    8 ++++----
 drivers/input/mousedev.c |    4 ++--
 include/linux/input.h    |    1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/input/input.c
+++ gregkh-2.6/drivers/input/input.c
@@ -724,7 +724,7 @@ static void input_dev_release(struct cla
 	module_put(THIS_MODULE);
 }
 
-static struct class input_dev_class = {
+struct class input_dev_class = {
 	.name			= "input_dev",
 	.release		= input_dev_release,
 	.class_dev_attrs	= input_dev_attrs,
@@ -795,6 +795,9 @@ void input_register_device(struct input_
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node, &input_dev_list);
 
+	if (dev->dynalloc)
+		input_register_classdevice(dev);
+
 	list_for_each_entry(handler, &input_handler_list, node)
 		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
 			if ((id = input_match_device(handler->id_table, dev)))
@@ -802,9 +805,6 @@ void input_register_device(struct input_
 					input_link_handle(handle);
 
 
-	if (dev->dynalloc)
-		input_register_classdevice(dev);
-
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
 #endif
--- gregkh-2.6.orig/drivers/input/mousedev.c
+++ gregkh-2.6/drivers/input/mousedev.c
@@ -648,9 +648,9 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			dev->dev, "mouse%d", minor);
+			dev->cdev.dev, "mouse%d", minor);
 
 	return &mousedev->handle;
 }
--- gregkh-2.6.orig/include/linux/input.h
+++ gregkh-2.6/include/linux/input.h
@@ -1075,6 +1075,7 @@ static inline void input_set_abs_params(
 }
 
 extern struct class *input_class;
+extern struct class input_dev_class;
 
 #endif
 #endif
