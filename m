Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUHUCus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUHUCus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 22:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268825AbUHUCus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 22:50:48 -0400
Received: from home.powernetonline.com ([66.84.210.20]:55777 "EHLO
	home.uspower.net") by vger.kernel.org with ESMTP id S268824AbUHUCua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 22:50:30 -0400
Date: Sat, 21 Aug 2004 02:51:33 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: Backlight and LCD module patches [2]
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
References: <20040617223517.59a56c7e.zap@homelink.ru>
	<20040725215917.GA7279@hydra.mshome.net> <20040813232739.GB5063@kroah.com>
In-Reply-To: <20040813232739.GB5063@kroah.com> (from greg@kroah.com on Fri
	Aug 13 18:27:40 2004)
X-Mailer: Balsa 2.2.3
Message-Id: <1093056693l.30570l.0l@hydra>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-w7BseSVOAO7RPnQx5y4a"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-w7BseSVOAO7RPnQx5y4a
Content-Type: text/plain; charset=ISO-8859-1; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/13/04 18:27:40, Greg KH wrote:
> On Sun, Jul 25, 2004 at 04:59:17PM -0500, John Lenz wrote:
> > The problem I see is that we would like something like a bus to match =20
> > together class devices.  What would be really nice is something like =20
> > this.
> >=20
> > struct class_match {
> >  struct class *class1;
> >  struct class *class2;
> >=20
> >  int (*match)(struct class_device *dev1, struct class_device *dev2);
> > };
> >=20
> > This class match structure would be very similar to a bus, in that it =20
> > matches together two classes instead of matching a device to a driver. =
 =20
> > All the class code would have to do is call the match function for all =
=20
> > possible combinations of class devices in class1 and in class2.  If =20
> > match returned true, then it would create symbolic links between the =20
> > two.
>=20
> Care to provide a proposed implementation of this functionality?
>

Here.  A few notes on the implementation.  I have a global lock protecting
all match operations because otherwise we get a dining philosophers problem=
.
(Say the same class is in two class_match structures, class1 in the first o=
ne
and class2 in the second...)

The bigger question of how should we be linking these together in the first=
 place?
Instead of using this class_match stuff, we could use class_interface.

=46rom my other email:

We have two completly seperate devices,
both have a struct device and both have a struct device_driver.  They can s=
it on
completly seperate buses and be mixed together in lots of different combina=
tions.
One of the devices "knows" if it matches with the other device.

What is the linux preferred way to dynamicly match the two devices together=
?  Should
each driver pair make its own decisions and its own constructs, or should w=
e try and
extend the device/driver/class/bus/etc model to support matching two device=
s together?
Use waitqueues and probe functions?  notify.h?  match by a char *name? clas=
s_match?
class_interface? create a virtual bus and use the bus matching code (not a =
very good
solution, but one nonetheless)?  Secondly, what is the best way to represen=
t this
matching to userspace (sysfs)?

We already tried matching together devices by their name, and that was shot=
 down.
And yet the mtd code matches chips and maps together by their name...  We h=
aven't
really gotten much feedback in which ways of matching devices together is a=
cceptable
and which isn't.

John


--=-w7BseSVOAO7RPnQx5y4a
Content-Type: text/x-patch; charset=us-ascii; name=class_match.patch
Content-Disposition: attachment; filename=class_match.patch
Content-Transfer-Encoding: quoted-printable


#
# Patch managed by http://www.holgerschurig.de/patcher.html
#

--- linux/include/linux/device.h~class_match
+++ linux/include/linux/device.h
@@ -147,6 +147,7 @@
 	struct subsystem	subsys;
 	struct list_head	children;
 	struct list_head	interfaces;
+	struct list_head	matches;
=20
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
@@ -187,6 +188,8 @@
 	void			* class_data;	/* class-specific data */
=20
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
+
+	struct list_head	matched_classes;
 };
=20
 static inline void *
@@ -240,6 +243,16 @@
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
=20
+struct class_match {
+	struct class*	class1;
+	struct class*	class2;
+
+	int (*match)(struct class_device *dev1, struct class_device *dev2);
+};
+
+extern int class_match_register(struct class_match *match);
+extern void class_match_unregister(struct class_match *match);
+
 /* interface for class simple stuff */
 extern struct class_simple *class_simple_create(struct module *owner, char=
 *name);
 extern void class_simple_destroy(struct class_simple *cs);
@@ -248,6 +261,7 @@
 extern int class_simple_set_hotplug(struct class_simple *,=20
 	int (*hotplug)(struct class_device *dev, char **envp, int num_envp, char =
*buffer, int buffer_size));
 extern void class_simple_device_remove(dev_t dev);
+extern void class_simple_set_match(struct class_simple *cs, struct class_m=
atch *match, int location);
=20
=20
 struct device {
--- linux/drivers/base/class_simple.c~class_match
+++ linux/drivers/base/class_simple.c
@@ -214,3 +214,13 @@
 	}
 }
 EXPORT_SYMBOL(class_simple_device_remove);
+
+extern void class_simple_set_match(struct class_simple *cs, struct class_m=
atch *match, int location)
+{
+	if (location =3D=3D 1) {
+		match->class1 =3D &cs->class;
+	} else if (location =3D=3D 2) {
+		match->class2 =3D &cs->class;
+	}
+}
+EXPORT_SYMBOL(class_simple_set_match);
--- linux/drivers/base/class.c~class_match
+++ linux/drivers/base/class.c
@@ -139,6 +139,7 @@
=20
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
+	INIT_LIST_HEAD(&cls->matches);
 	error =3D kobject_set_name(&cls->subsys.kset.kobj, cls->name);
 	if (error)
 		return error;
@@ -306,6 +307,133 @@
=20
 static decl_subsys(class_obj, &ktype_class_device, &class_hotplug_ops);
=20
+static spinlock_t class_match_lock =3D SPIN_LOCK_UNLOCKED;
+
+struct class_match_node {
+	struct class_match *match;
+	struct class_device *dev;
+	struct list_head node;
+};
+/* Makes the calls to class_match->match functions and connects devices to=
gether */
+static void class_match_check(struct class_device *dev)
+{
+	struct class *parent =3D dev->class;
+	struct class_match_node *match_node, *other_match_node;
+
+	struct class *other_class;
+	struct class_device *other_device;
+=09
+	int ret;
+
+	spin_lock(&class_match_lock);
+
+	down_read(&parent->subsys.rwsem);
+	list_for_each_entry(match_node, &parent->matches, node) {
+		/* call the match() function and try and match devices together */
+		if (parent =3D=3D match_node->match->class1) {
+			other_class =3D match_node->match->class2;
+		} else if (parent =3D=3D match_node->match->class2) {
+			other_class =3D match_node->match->class1;
+		} else {
+			other_class =3D NULL;
+		}
+
+		if (other_class) {
+			down_read(&other_class->subsys.rwsem);
+
+			list_for_each_entry(other_device, &other_class->children, node) {
+				/* first check if this device is already matched... */
+				list_for_each_entry(other_match_node, &other_device->matched_classes, =
node) {
+					if (other_match_node->match =3D=3D match_node->match) {
+						continue;
+					}
+				}
+
+				/* now call the match function */
+				if (parent =3D=3D match_node->match->class1) {
+					ret =3D match_node->match->match(dev, other_device);
+				} else {
+					ret =3D match_node->match->match(other_device, dev);
+				}
+				if (ret) {
+
+					/* now add this to the matched_classes lists */
+					other_match_node =3D (struct class_match_node *) kmalloc(sizeof(struc=
t class_match_node), GFP_KERNEL);
+					if (other_match_node) {
+						other_match_node->dev =3D other_device;
+						other_match_node->match =3D match_node->match;
+
+						list_add_tail(&other_match_node->node, &dev->matched_classes);
+						sysfs_create_link(&dev->kobj, &other_device->kobj, other_class->name=
);
+					}
+
+					other_match_node =3D (struct class_match_node *) kmalloc(sizeof(struc=
t class_match_node), GFP_KERNEL);
+					if (other_match_node) {
+						other_match_node->dev =3D dev;
+						other_match_node->match =3D match_node->match;
+
+						list_add_tail(&other_match_node->node, &other_device->matched_classe=
s);
+						sysfs_create_link(&other_device->kobj, &dev->kobj, parent->name);
+					}
+				=09
+					break;
+				}
+			}
+			up_read(&other_class->subsys.rwsem);
+		}
+	}
+	up_read(&parent->subsys.rwsem);
+
+	spin_unlock(&class_match_lock);
+}
+
+static void class_match_unlink(struct class_device *class_dev)
+{
+	struct class * parent =3D class_dev->class;
+	struct class_match_node *match_node, *other_match_node, *temp_match_node;
+	struct class *other_class;
+
+	spin_lock(&class_match_lock);
+
+	down_read(&parent->subsys.rwsem);
+
+	/* remove symlinks from devices matched to this device */
+	list_for_each_entry(match_node, &class_dev->matched_classes, node) {
+		if (parent =3D=3D match_node->match->class1) {
+			other_class =3D match_node->match->class2;
+		} else if (parent =3D=3D match_node->match->class2) {
+			other_class =3D match_node->match->class1;
+		} else {
+			/* should never happen */
+			other_class =3D NULL;
+		}
+		if (other_class) {
+			list_for_each_entry_safe(other_match_node, temp_match_node, &match_node=
->dev->matched_classes, node) {
+				if (match_node->match =3D=3D other_match_node->match) {
+					list_del(&other_match_node->node);
+					kfree(other_match_node);
+					sysfs_remove_link(&match_node->dev->kobj, parent->name);
+					break;
+				}
+			}
+		}
+	}
+
+	/* free entries in matched_classes */
+	list_for_each_entry_safe(match_node, temp_match_node, &class_dev->matched=
_classes, node) {
+		list_del(&match_node->node);
+		if (parent =3D=3D match_node->match->class1) {
+			sysfs_remove_link(&class_dev->kobj, match_node->match->class2->name);
+		} else {
+			sysfs_remove_link(&class_dev->kobj, match_node->match->class1->name);
+		}
+		kfree(match_node);
+	}
+
+	up_read(&parent->subsys.rwsem);
+
+	spin_unlock(&class_match_lock);
+}
=20
 static int class_device_add_attrs(struct class_device * cd)
 {
@@ -345,6 +473,7 @@
 	kobj_set_kset_s(class_dev, class_obj_subsys);
 	kobject_init(&class_dev->kobj);
 	INIT_LIST_HEAD(&class_dev->node);
+	INIT_LIST_HEAD(&class_dev->matched_classes);
 }
=20
 int class_device_add(struct class_device *class_dev)
@@ -378,6 +507,7 @@
 			if (class_intf->add)
 				class_intf->add(class_dev);
 		up_write(&parent->subsys.rwsem);
+		class_match_check(class_dev);
 	}
 	class_device_add_attrs(class_dev);
 	class_device_dev_link(class_dev);
@@ -408,6 +538,7 @@
 			if (class_intf->remove)
 				class_intf->remove(class_dev);
 		up_write(&parent->subsys.rwsem);
+		class_match_unlink(class_dev);
 	}
=20
 	class_device_dev_unlink(class_dev);
@@ -505,7 +636,64 @@
 	class_put(parent);
 }
=20
+int class_match_register(struct class_match *match)
+{
+	struct class_match_node *match_node;
+=09
+	if (!match)
+		return -ENODEV;
+	if (!match->class1 || !match->class2)
+		return -ENODEV;
+	if (!match->match || match->class1 =3D=3D match->class2)
+		return -EINVAL;
=20
+	spin_lock(&class_match_lock);
+=09
+	match_node =3D (struct class_match_node *) kmalloc(sizeof(struct class_ma=
tch_node), GFP_KERNEL);
+	if (match_node) {
+		match_node->match =3D match;
+		match_node->dev =3D NULL;
+		down_write(&match->class1->subsys.rwsem);
+		list_add_tail(&match_node->node, &match->class1->matches);
+		up_write(&match->class1->subsys.rwsem);
+	} else {
+		return -ENOMEM;
+	}
+
+	match_node =3D (struct class_match_node *) kmalloc(sizeof(struct class_ma=
tch_node), GFP_KERNEL);
+	if (match_node) {
+		match_node->match =3D match;
+		match_node->dev =3D NULL;
+		down_write(&match->class2->subsys.rwsem);
+		list_add_tail(&match_node->node, &match->class2->matches);
+		up_write(&match->class2->subsys.rwsem);
+	} else {
+		return -ENOMEM;
+	}
+
+	spin_unlock(&class_match_lock);
+=09
+	return 0;
+}
+
+void class_match_unregister(struct class_match *match)
+{
+	struct class_device *class_dev;
+
+	if (!match)
+		return;
+	if (!match->class1 || !match->class2)
+		return;
+	if (!match->match || match->class1 =3D=3D match->class2)
+		return;
+=09
+	/* we only need to call class_match_unlink on one of the class devices */
+
+	down_read(&match->class1->subsys.rwsem);
+	list_for_each_entry(class_dev, &match->class1->children, node)
+		class_match_unlink(class_dev);
+	up_read(&match->class1->subsys.rwsem);
+}
=20
 int __init classes_init(void)
 {
@@ -542,3 +730,5 @@
=20
 EXPORT_SYMBOL(class_interface_register);
 EXPORT_SYMBOL(class_interface_unregister);
+EXPORT_SYMBOL(class_match_register);
+EXPORT_SYMBOL(class_match_unregister);


--=-w7BseSVOAO7RPnQx5y4a--

