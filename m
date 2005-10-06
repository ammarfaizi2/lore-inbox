Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVJFG3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVJFG3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 02:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVJFG3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 02:29:34 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:31606 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750739AbVJFG3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 02:29:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Date: Thu, 6 Oct 2005 01:29:27 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050928233114.GA27227@suse.de> <200509300032.50408.dtor_core@ameritech.net> <20051006000951.GA4411@suse.de>
In-Reply-To: <20051006000951.GA4411@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 9840
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200510060129.28066.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 October 2005 19:09, Greg KH wrote:
> On Fri, Sep 30, 2005 at 12:32:49AM -0500, Dmitry Torokhov wrote:
> > On Wednesday 28 September 2005 18:31, Greg KH wrote:
> > > Alright, here's a patch that will add the ability to nest struct
> > > class_device structures in sysfs.  This should give everyone the ability
> > > to model what they need to in the class directory (input, video, etc.).
> > 
> > I still do not believe it is the solution we want:
> > 
> > 1. It does not allow installing separate hotplug handlers for devices
> >    and their sub-devices. This will cause hotplug handlers to resort to
> >    having some flags or otherwise detect the king of class device hotplug
> >    hanlder is being called for and change behavior accordingly - YUCK!
> 
> Huh?  I don't understand your complaint here.  Why would we ever want to
> have separate hotplug handlers for the same class?  If you do want that,
> then create separate classes.
>

Yes. I do want separate [sub]classes. I just want them grouped together
under some <subsystem> name. And I want separate hotplug handlers because
actions that are needed for these objects are different. When a new
input_dev appears you want to match its capabilities with one or more
input handlers and load appropriate handler module if it has not been
loaded yet. When a new input interface device appears you want to create
a new device node for it. The handlers should be diffrent if you want
clean implementation, do you see?
 
> > 2. It does not allow user/program to scan for devices of given subclass.
> 
> There is nothing called "subclass" anymore, so sure, you can't scan for
> it :)
>

I am pointing out what I think are deficiences in your design. I do not
think saying "We won't have it at all so problem does not exists" is
allowed. I do want to be able to easily get/enumerate devices of a logical
subclass whether they are represented this way in sysfs or not.
 
> >    I understand that you want to tech udev about all existing handlers
> >    and having hotplug events allows to filter out unneeded names but for
> >    other programs I do not think we want to do that. Again, consider task
> >    of wanting to know all input interfaces, ot all available partiotions
> >    in a system. Do not say that the program has to know that there are hdX
> >    and sdX and ubX and adopt every time new type of device comes along
> >    since you would need to determine whether the name you see is an
> >    ordinary attribute or attribute group or the subdevice you are interested
> >    in. You can't really rely on presence of 'dev' attribute since subdevice
> >    does not have to have it. A better way would be to do
> >    "ls /sys/class/block/partitions/" or "ls /sys/class/input/interfaces"
> >    and get all this information.
> 
> Yes, class devices can have a "dev" file, and be nested below another
> class device, that's fine.  It's only a simple scan of sysfs to find
> them, just like we do today for the block devices.  Again, I really
> don't see the problem here.
> 

Ok, so how do you scan for all instances of input interfaces under your
proposal of you don't know their names? Remember you need to support
special instances that do not have parent devices too.

> > 3. It does not work well when you have an object that in your model is a
> >    logical subdevice but does not have a parent (or has multiple parents).
> >    Consider 'mice' multiplexor. Where would you put it? Together with
> >    inputX? But it is not an input_dev, it should not be there.
> 
> Ok, the "mice" thing is a hack.  A big hack, but one that is needed.
> Don't try to bring that one in...  Anyway, I can handle that one too,
> see below.
>

Still a hck as far as I can see ;(
 
> > 4. subdevice should have only one parent, your implementation allows to
> >    link subdevice to a class device and a real device at the same time,
> >    which IMHO is wrong. Only top-level class devices should be linked with
> >    physical /sys/devices/ device. 
> 
> Why?  Why arbirtrary make that distinction?  See my example below for an
> example of that symlink being in both class devices, and everything is
> just fine.
>

Because at the interface level all I care is what inputX device my mouse0
is connected to and what capabilities it has. When I talk about mouse0
I do not care that input_dev is actually connected to
/sys/bus/serio/devices/serio1. If I want this info I will just travel
dev->device->device->device chain and get this data. What you doing is just
cluttering /sys with unneeded data.
 
> > I firmly believe that creating sub-classes (which solves hotplug issues)
> > and linking sub-class devices to their parent via 'device' link, much like
> > we link top-level class device to their physical parent devices (which
> > solves 2, 3 and 4) is much cleanier way. It provides everything that your
> > implementation does plus allows different views useful for other tasks
> > besides udev.
> 
> I thought this way too.  Until I started to implement the sub-class
> device code, and realized that I was just creating the same thing as the
> existing class_device code.
> 

See the patch below - it simply allows you to link class device to any
valid kobject. No code duplication and together with bested classes
it works nicely:

[dtor@core ~]$ tree -d /sys/class/input/devices/input2
/sys/class/input/devices/input2
|-- capabilities
|-- device -> ../../../../devices/platform/i8042/serio0/serio2
|-- id
|-- interfaces:event2 -> ../../../../class/input/interfaces/event2
|-- interfaces:mouse1 -> ../../../../class/input/interfaces/mouse1
`-- interfaces:ts1 -> ../../../../class/input/interfaces/ts1

> And yes, I realize that this is different from nesting classes, but I
> _really_ do not think that is the proper solution for this at all.
> 

Arguments please. I think I explained why I do not like your proposal but
I have not heard why you think nesting classes is a bad idea.

-- 
Dmitry

Driver core: allow linking class devices to any kobject

This will allow linking class devices not only to physical
devices but also to other class devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c   |   31 +++++++++++++++++--------------
 include/linux/device.h |    3 ++-
 2 files changed, 19 insertions(+), 15 deletions(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -485,9 +485,9 @@ static char *make_class_name(struct clas
 
 int class_device_add(struct class_device *class_dev)
 {
-	struct class * parent = NULL;
-	struct class_interface * class_intf;
-	char *class_name = NULL;
+	struct class *parent = NULL;
+	struct class_interface *class_intf;
+	char *class_name;
 	int error;
 
 	class_dev = class_device_get(class_dev);
@@ -532,12 +532,16 @@ int class_device_add(struct class_device
 	}
 
 	class_device_add_attrs(class_dev);
-	if (class_dev->dev) {
+
+	if (class_dev->dev)
+		class_dev->parent_dev = &class_dev->dev->kobj;
+	if (class_dev->parent_dev) {
 		class_name = make_class_name(class_dev);
 		sysfs_create_link(&class_dev->kobj,
-				  &class_dev->dev->kobj, "device");
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+				  class_dev->parent_dev, "device");
+		sysfs_create_link(class_dev->parent_dev, &class_dev->kobj,
 				  class_name);
+		kfree(class_name);
 	}
 
 	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
@@ -556,7 +560,6 @@ int class_device_add(struct class_device
 	if (error && parent)
 		class_put(parent);
 	class_device_put(class_dev);
-	kfree(class_name);
 	return error;
 }
 
@@ -621,7 +624,7 @@ void class_device_del(struct class_devic
 {
 	struct class * parent = class_dev->class;
 	struct class_interface * class_intf;
-	char *class_name = NULL;
+	char *class_name;
 
 	if (parent) {
 		down(&parent->sem);
@@ -635,7 +638,8 @@ void class_device_del(struct class_devic
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev);
 		sysfs_remove_link(&class_dev->kobj, "device");
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		sysfs_remove_link(class_dev->parent_dev, class_name);
+		kfree(class_name);
 	}
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
@@ -646,7 +650,6 @@ void class_device_del(struct class_devic
 
 	if (parent)
 		class_put(parent);
-	kfree(class_name);
 }
 
 void class_device_unregister(struct class_device *class_dev)
@@ -695,18 +698,18 @@ int class_device_rename(struct class_dev
 	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
 		 new_name);
 
-	if (class_dev->dev)
+	if (class_dev->parent_dev)
 		old_class_name = make_class_name(class_dev);
 
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
 	error = kobject_rename(&class_dev->kobj, new_name);
 
-	if (class_dev->dev) {
+	if (class_dev->parent_dev) {
 		new_class_name = make_class_name(class_dev);
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+		sysfs_create_link(class_dev->parent_dev, &class_dev->kobj,
 				  new_class_name);
-		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
+		sysfs_remove_link(class_dev->parent_dev, old_class_name);
 	}
 	class_device_put(class_dev);
 
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -199,7 +199,8 @@ struct class_device {
 	struct class		* class;	/* required */
 	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
 	struct class_device_attribute *devt_attr;
-	struct device		* dev;		/* not necessary, but nice to have */
+	struct kobject		* parent_dev;	/* parent [class_]device */
+	struct device		* dev;		/* going away */
 	void			* class_data;	/* class-specific data */
 
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
