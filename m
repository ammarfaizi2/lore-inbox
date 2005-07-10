Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVGJGfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVGJGfr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 02:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVGJGfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 02:35:47 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:55477 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261858AbVGJGfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 02:35:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [RFC][PATCH 2.6.13-rc1] driver core: subclasses
Date: Sun, 10 Jul 2005 01:35:38 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Jon Smirl <jonsmirl@gmail.com>, Hannes Reinecke <hare@suse.de>
References: <20050708225448.GA18193@lists.us.dell.com> <20050709024000.GA7608@kroah.com> <20050709130414.GA6362@lists.us.dell.com>
In-Reply-To: <20050709130414.GA6362@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6GM0Cz0UBQslzIe"
Message-Id: <200507100135.38899.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6GM0Cz0UBQslzIe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 09 July 2005 08:04, Matt Domsch wrote:
> On Fri, Jul 08, 2005 at 07:40:00PM -0700, Greg KH wrote:
> > On Fri, Jul 08, 2005 at 05:54:48PM -0500, Matt Domsch wrote:
> > > The below patch is a first pass at implementing subclasses, for review
> > > and comment.
> > 
> > Oops, when you mentioned this on irc, I thought you were referring to
> > class_devices not classes.  I don't want classes to be able to be
> > nested, only class devices.
> > 
> > I don't see a need for nested classes,

[dtor@core ~]$ ls -1d /sys/class/ieee1394*
/sys/class/ieee1394
/sys/class/ieee1394_host
/sys/class/ieee1394_node
/sys/class/ieee1394_protocol

This one is worst. But USB, SCSI, I2C all could use subclasses too.

> > as I thought the input thread had 
> > resolved itself so that it didn't need it (but I stopped paying
> > attention, sorry, so I might be wrong here...)
>

As far as input subsystem goes we do need nested classes if we were to
keep compatibility with hotplug/udev installations. Please take a look
at the patch below. It complements my version of nested classes patch
(I am attaching it too since I think Matt's version is too complex).
Basically top class will define subsystem while nested classes will
define individual components of subsystem. This will allow keeping old
input hotplug handlers for both input devices and interface devices.

I want the tree look somethng like this:

/sys/class/input/input_dev/input_dev0
                |          input_dev1
                |          input_dev2
		|
                /input_intf/mouse0
                            mice
                            js1
                            js2 

Or we can go even deeper makeing input_intf a subtree with a subclass
for every interface type (evdev, mousedev, etc). But I think that would
be overkill.
 
> The tailing part of the thread is here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111873628324649&w=2
> http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=111877313202313&w=2
> where Hannes and Dmitry seemed to indicate (to my reading) that they
> were looking for subclasses.  Perhaps it's not necessary.
> 
> > Why can't you just use class_device's that can have children?  That way
> > the /sys/block stuff could be converted to also use this.
>

We need both I think.
 
-- 
Dmitry

===================================================================
Driver core: make parent class define subsystem for its children

When there is a hierarchy of classes make parent class define
subsystem as reported in hotplug notifications. The full class
path is reported in a new CLASS environment variable.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -332,25 +332,35 @@ static int class_hotplug_filter(struct k
 static const char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
+	struct class *class = class_dev->class;
 
-	return class_dev->class->name;
+	while (class->parent)
+		class = class->parent;
+
+	return class->name;
 }
 
 static int class_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
 			 int num_envp, char *buffer, int buffer_size)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
+	const char *path;
 	int i = 0;
 	int length = 0;
 	int retval = 0;
 
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
 
+	path = kobject_get_path(&class_dev->class->subsys.kset.kobj, GFP_KERNEL);
+	add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+			    &length, "CLASS=%s", path);
+	kfree(path);
+
 	if (class_dev->dev) {
 		/* add physical device, backing this device  */
 		struct device *dev = class_dev->dev;
-		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
+		path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
 				    &length, "PHYSDEVPATH=%s", path);
 		kfree(path);

--Boundary-00=_6GM0Cz0UBQslzIe
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nested-classes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nested-classes.patch"

Subject: Allow nesting classes

Driver core: allow classes have children.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c   |    5 ++++-
 include/linux/device.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -146,7 +146,10 @@ int class_register(struct class * cls)
 	if (error)
 		return error;
 
-	subsys_set_kset(cls, class_subsys);
+	if (cls->parent)
+		subsys_set_kset(cls, cls->parent->subsys);
+	else
+		subsys_set_kset(cls, class_subsys);
 
 	error = subsystem_register(&cls->subsys);
 	if (!error) {
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -157,6 +157,7 @@ struct class {
 	struct module		* owner;
 
 	struct subsystem	subsys;
+	struct class		* parent;
 	struct list_head	children;
 	struct list_head	interfaces;
 	struct semaphore	sem;	/* locks both the children and interfaces lists */

--Boundary-00=_6GM0Cz0UBQslzIe--
