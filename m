Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSLSTwN>; Thu, 19 Dec 2002 14:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbSLSTwN>; Thu, 19 Dec 2002 14:52:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:45708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266043AbSLSTwL>;
	Thu, 19 Dec 2002 14:52:11 -0500
Date: Thu, 19 Dec 2002 13:31:43 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Martin Waitz <tali@admingilde.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: device interface api
In-Reply-To: <20021218004039.GA1115@admingilde.org>
Message-ID: <Pine.LNX.4.33.0212191328050.1286-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> int interface_add_data(struct intf_data * data)
> {
> 	struct device_interface * intf = intf_from_data(data);
> 
> 	data->intf_num = data->intf->devnum++;
> 	data->kobj.subsys = &intf->subsys;
> 	kobject_register(&data->kobj);
> 	[...]
> 
> 
> data->kobj.subsys is initialized here, but intf_from_data
> is using this data->kobj.subsys to get intf, instead of data->intf.
> do you want to remove data->intf?
> either way, interface_add_data should change.
> 
> are interface users supposed to set data->intf or data->kobj.subsys?

The former. The appended patch should fix that. Sorry about that. 

> another small glitch i noticed while diggin in the code:
> 
> ================================================================
> --- linux-2.5/lib/kobject.c  Tue Dec 10 12:59:02 2002
> +++ linux/lib/kobject.c       Tue Dec 17 13:15:19 2002
> @@ -218,7 +218,7 @@ int subsystem_register(struct subsystem 
>                 s->kobj.parent = &s->parent->kobj;
>         pr_debug("subsystem %s: registering, parent: %s\n",
>                  s->kobj.name,s->parent ? s->parent->kobj.name : "<none>");
> -       return kobject_register(&s->kobj);
> +       return kobject_add(&s->kobj);
>  }
>  
>  void subsystem_unregister(struct subsystem * s)
> ================================================================
> 
> subsystem_register first calls subsystem_init, which already
> does kobject_init, so a full kobject_register is not needed
> (and is in fact bad, as it again increases the refcounter for kobj.subsys)

Nice catch. The internal semantics changed a while back, and I missed that 
one when fixing up the users. A fix for that is also inluded in the 
following patch.

	-pat

===== drivers/base/intf.c 1.9 vs edited =====
--- 1.9/drivers/base/intf.c	Tue Dec  3 12:40:21 2002
+++ edited/drivers/base/intf.c	Thu Dec 19 13:04:56 2002
@@ -14,9 +14,6 @@
 
 #define to_data(e) container_of(e,struct intf_data,kobj.entry)
 
-#define intf_from_data(d) container_of(d->kobj.subsys,struct device_interface, subsys);
-
-
 /**
  *	intf_dev_link - create sysfs symlink for interface.
  *	@data:	interface data descriptor.
@@ -61,15 +58,18 @@
 
 int interface_add_data(struct intf_data * data)
 {
-	struct device_interface * intf = intf_from_data(data);
+	struct device_interface * intf = data->intf;
 
-	data->intf_num = data->intf->devnum++;
-	data->kobj.subsys = &intf->subsys;
-	kobject_register(&data->kobj);
-
-	list_add_tail(&data->dev_entry,&data->dev->intf_list);
-	intf_dev_link(data);
-	return 0;
+	if (intf) {
+		data->intf_num = intf->devnum++;
+		data->kobj.subsys = &intf->subsys;
+		kobject_register(&data->kobj);
+
+		list_add_tail(&data->dev_entry,&data->dev->intf_list);
+		intf_dev_link(data);
+		return 0;
+	}
+	return -EINVAL;
 }
 
 
@@ -121,9 +121,9 @@
 
 static void del(struct intf_data * data)
 {
-	struct device_interface * intf = intf_from_data(data);
+	struct device_interface * intf = data->intf;
 
-	pr_debug(" -> %s ",data->intf->name);
+	pr_debug(" -> %s ",intf->name);
 	interface_remove_data(data);
 	if (intf->remove_device)
 		intf->remove_device(data);
===== include/linux/kobject.h 1.8 vs edited =====
--- 1.8/include/linux/kobject.h	Thu Nov 21 17:01:53 2002
+++ edited/include/linux/kobject.h	Thu Dec 19 13:05:41 2002
@@ -52,7 +52,7 @@
 
 static inline struct subsystem * subsys_get(struct subsystem * s)
 {
-	return container_of(kobject_get(&s->kobj),struct subsystem,kobj);
+	return s ? container_of(kobject_get(&s->kobj),struct subsystem,kobj) : NULL;
 }
 
 static inline void subsys_put(struct subsystem * s)
===== lib/kobject.c 1.9 vs edited =====
--- 1.9/lib/kobject.c	Sun Dec  1 23:24:33 2002
+++ edited/lib/kobject.c	Thu Dec 19 13:00:05 2002
@@ -74,10 +74,13 @@
 {
 	int error = 0;
 	struct subsystem * s = kobj->subsys;
-	struct kobject * parent = kobject_get(kobj->parent);
+	struct kobject * parent;
 
 	if (!(kobj = kobject_get(kobj)))
 		return -ENOENT;
+
+	parent = kobject_get(kobj->parent);
+
 	pr_debug("kobject %s: registering. parent: %s, subsys: %s\n",
 		 kobj->name, parent ? parent->name : "<NULL>", 
 		 kobj->subsys ? kobj->subsys->kobj.name : "<NULL>" );
@@ -93,8 +96,8 @@
 		up_write(&s->rwsem);
 	}
 	error = create_dir(kobj);
-	if (error && kobj->parent)
-		kobject_put(kobj->parent);
+	if (error && parent)
+		kobject_put(parent);
 	return error;
 }
 
@@ -218,7 +221,7 @@
 		s->kobj.parent = &s->parent->kobj;
 	pr_debug("subsystem %s: registering, parent: %s\n",
 		 s->kobj.name,s->parent ? s->parent->kobj.name : "<none>");
-	return kobject_register(&s->kobj);
+	return kobject_add(&s->kobj);
 }
 
 void subsystem_unregister(struct subsystem * s)

