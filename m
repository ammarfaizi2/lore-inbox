Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTEUS7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 14:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEUS7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 14:59:15 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:34730 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262239AbTEUS6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 14:58:52 -0400
Date: Wed, 21 May 2003 20:52:12 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030521185212.GC12677@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20030521072318.GA12973@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2003 at 12:23:18AM -0700, Greg KH wrote:
> Oops, forgot to respond to this, sorry...
> 
> On Sun, May 18, 2003 at 12:19:22AM +0200, Manuel Estrada Sainz wrote:
[snip]
> >  - There is a timeout, changeable from userspace. Feedback on a
> >    reasonable default value appreciated.
> 
> Is this really needed?  Especially as you now have:

 There is currently no way to know if hotplug couldn't be called at all
 or if it failed because it didn't have firmware load support.

 If that happens, we would be waiting for ever. And I'd rather make that
 a countable number of seconds :)

 I'll make '0' mean no timeout at all.

> >  - Extended 'loading' semantics:
> >  	echo 1 > loading:
> > 		start a new load, and flush any data from a previous
> > 		partial load.
> > 	echo 0 > loading:
> > 		finish load.
> > 	echo -1 > loading:
> > 		cancel load and give an error to the driver.
> 
> Looks good.
> 
> I'd recommend sending the sysfs patches to Pat Mochel.  He's the one to
> take those.

 Done.
 
> Some minor comments about the code:
> 
> > diff --exclude=CVS -urN linux-2.5.orig/drivers/base/Makefile linux-2.5.mine/drivers/base/Makefile
> > --- linux-2.5.orig/drivers/base/Makefile	2003-05-17 20:44:03.000000000 +0200
> > +++ linux-2.5.mine/drivers/base/Makefile	2003-05-17 23:17:21.000000000 +0200
> > @@ -3,4 +3,6 @@
> >  obj-y			:= core.o sys.o interface.o power.o bus.o \
> >  			   driver.o class.o platform.o \
> >  			   cpu.o firmware.o init.o
> > +obj-m			:= firmware_class.o firmware_sample_driver.o \
> > +			   firmware_sample_firmware_class.o
> 
> Why make the firmware_class.o always a module?  Shouldn't it only be
> included in the core, if a driver that uses it is selected?

 That was the quickest way to get modules to play with :-)

 I am not sure on how to implement "if a driver that uses it is
 selected" and not sure on where to add the Kconfig entries to make it
 available to out-of-kernel modules.

 If the approach in the attached patches is still not right, please
 complain.
 
 Maybe kbuild could allow forcing one option from another, a companion
 for 'depends', lets call it 'hard_depends'

	 depends FOO
		If FOO is not there the entry won't even be shown in the
		menu.
	 hard_depends FOO 
		FOO gets set to satisfy the dependency.

 When trying to deselect an item that is hard_depended upon, the system
 could complain and tell you which options should be deselected or even
 offer to do it automatically.

 This would also simplify the selection of crc32 and
 compression/decompression code. And allow removal of all those comments
 like "Video4Linux support is needed for USB Multimedia device support".

> > +static inline struct class_device *to_class_dev(struct kobject *obj)
> > +{
> > +	return container_of(obj,struct class_device,kobj);
> > +}
> > +static inline
> > +struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
> > +{
> > +	return container_of(_attr,struct class_device_attribute,attr);
> > +}
> 
> Move these two to drivers/base/base.h as they shouldn't be defined in
> two different files.

 OK, I also removed equivalent macros from class.c
 
> > +int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
> > +int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
> 
> If you need these, add them to include/linux/sysfs.h.
> 
> > +struct firmware_priv {
> > +	char fw_id[FIRMWARE_NAME_MAX];
> > +	struct completion completion;
> > +	struct bin_attribute attr_data;
> > +	struct firmware *fw;
> > +	s32 loading:2;
> > +	u32 abort:1;
> 
> Why s32 and u32?  Why not just ints for both of them?

 Since they are bit fields, I wanted to have more control over them and a
 single bit bit-field should be unsigned, but I guess that David is
 right, it is not worth it. Both are full int's now.
 
> > +struct class firmware_class = {
> > +        .name           = "firmware",
> > +	.hotplug        = firmware_class_hotplug,
> > +};
> 
> Oops, forgot tabs there...
> 
> > +	switch(fw_priv->loading){
> 
> Please add a space before the '{'.
> 
> > +	case 0:
> > +		if(prev_loading==1)
> 
> And a space after the if.  You do this in lots of places.

 Fixed, and just in case, I put it through Lindent which BTW is a little
 evil :-) so I hand removed the evilness I could not take.

> Other than those very minor things, this looks quite good.

 Great.

 Patches:
	firmware-class.diff:
		The code itself against bk-cvs.

	class-casts.diff:
		to_class_dev/to_class_dev_attr changes against bk-cvs.

	sysfs-bin-header.diff
	sysfs-bin-lost-dget.diff
	sysfs-bin-flexible-size.diff:
		Just for completeness, since the above will not work
		without them, but I already send them to Pat Mochel in a
		separate mail.

 	incremental.diff:
		Incremental patch for easier reading, although there are
		lots of formating changes.

 Thanks

 	Manuel

 PS: Sorry, I forgot the patches last time :(
 PS2: Now that I really include the patches I realized their size, and
 compressed some.
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="incremental.diff"

diff -u linux-2.5.mine/drivers/base/Makefile linux-2.5.mine/drivers/base/Makefile
--- linux-2.5.mine/drivers/base/Makefile	2003-05-17 23:17:21.000000000 +0200
+++ linux-2.5.mine/drivers/base/Makefile	2003-05-21 16:25:44.000000000 +0200
@@ -5,4 +5,10 @@
 			   cpu.o firmware.o init.o
-obj-m			:= firmware_class.o firmware_sample_driver.o \
-			   firmware_sample_firmware_class.o
+obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
+
+#The next three lines are just to make testing easier and should not get into
+#the kernel
+obj-$(CONFIG_FW_LOADER_SAMPLE)	+= firmware_class.o
+obj-$(CONFIG_FW_LOADER_SAMPLE)	+= firmware_sample_driver.o \
+				   firmware_sample_firmware_class.o
+
 obj-$(CONFIG_NUMA)	+= node.o  memblk.o
reverted:
--- include/linux/sysfs.h	21 May 2003 13:49:29 -0000
+++ include/linux/sysfs.h	15 May 2003 23:50:23 -0000	1.9
@@ -23,9 +23,6 @@
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
 };
 
-int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
-int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
-
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
only in patch2:
unchanged:
--- linux-2.5.orig/drivers/base/base.h	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/drivers/base/base.h	2003-05-21 10:25:09.000000000 +0200
@@ -4,3 +4,12 @@
 extern int bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);
 
+static inline struct class_device *to_class_dev(struct kobject *obj)
+{
+	return container_of(obj,struct class_device,kobj);
+}
+static inline
+struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
+{
+	return container_of(_attr,struct class_device_attribute,attr);
+}
only in patch2:
unchanged:
--- linux-2.5.orig/drivers/base/class.c	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/drivers/base/class.c	2003-05-21 10:19:41.000000000 +0200
@@ -148,9 +148,6 @@
 }
 
 
-#define to_class_dev(obj) container_of(obj,struct class_device,kobj)
-#define to_class_dev_attr(_attr) container_of(_attr,struct class_device_attribute,attr)
-
 static ssize_t
 class_device_attr_show(struct kobject * kobj, struct attribute * attr,
 		       char * buf)
only in patch2:
unchanged:
--- linux-2.5.orig/drivers/base/Kconfig.lib	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.mine/drivers/base/Kconfig.lib	2003-05-21 16:24:14.000000000 +0200
@@ -0,0 +1,17 @@
+#
+# To be sourced from lib/Kconfig
+#
+
+config FW_LOADER
+	tristate "Hotplug firmware loading support"
+	---help---
+	  This option is provided for the case where no in-kernel-tree modules
+	  require hotplug firmware loading support, but a module built outside
+	  the kernel tree does.
+
+config FW_LOADER_SAMPLE
+	tristate "Hotplug firmware loading samples"
+	---help---
+	  This should not get in the kernel, it is just here to make playing
+	  with firmware loading easier.
+
only in patch2:
unchanged:
--- linux-2.5.orig/lib/Kconfig	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/lib/Kconfig	2003-05-21 16:12:41.000000000 +0200
@@ -26,5 +26,6 @@
 		(PPP_DEFLATE=m || JFFS2_FS=m || CRYPTO_DEFLATE=m)
 	default y if PPP_DEFLATE=y || JFFS2_FS=y || CRYPTO_DEFLATE=y
 
-endmenu
+source "drivers/base/Kconfig.lib"
 
+endmenu
only in patch2:
unchanged:
--- linux-2.5.orig/include/linux/sysfs.h	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/include/linux/sysfs.h	2003-05-21 10:22:08.000000000 +0200
@@ -23,6 +23,9 @@
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
 };
 
+int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
diff -u linux-2.5.mine/drivers/base/firmware_class.c linux-2.5.mine/drivers/base/firmware_class.c
--- linux-2.5.mine/drivers/base/firmware_class.c	2003-05-17 22:44:27.000000000 +0200
+++ linux-2.5.mine/drivers/base/firmware_class.c	2003-05-21 16:38:06.000000000 +0200
@@ -11,88 +11,82 @@
 #include <linux/timer.h>
 #include <asm/hardirq.h>
 
-#include "linux/firmware.h"
+#include <linux/firmware.h>
+#include "base.h"
 
 MODULE_AUTHOR("Manuel Estrada Sainz <ranty@debian.org>");
 MODULE_DESCRIPTION("Multi purpose firmware loading support");
 MODULE_LICENSE("GPL");
 
-static int loading_timeout = 10; /* In seconds */
-
-static inline struct class_device *to_class_dev(struct kobject *obj)
-{
-	return container_of(obj,struct class_device,kobj);
-}
-static inline
-struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
-{
-	return container_of(_attr,struct class_device_attribute,attr);
-}
-
-int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
-int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+static int loading_timeout = 10;	/* In seconds */
 
 struct firmware_priv {
 	char fw_id[FIRMWARE_NAME_MAX];
 	struct completion completion;
 	struct bin_attribute attr_data;
 	struct firmware *fw;
-	s32 loading:2;
-	u32 abort:1;
+	int loading;
+	int abort;
 	int alloc_size;
 	struct timer_list timeout;
 };
 
-static ssize_t firmware_timeout_show(struct class *class, char *buf)
+static ssize_t
+firmware_timeout_show(struct class *class, char *buf)
 {
 	return sprintf(buf, "%d\n", loading_timeout);
 }
-static ssize_t firmware_timeout_store(struct class *class,
-				      const char *buf, size_t count)
+static ssize_t
+firmware_timeout_store(struct class *class, const char *buf, size_t count)
 {
 	loading_timeout = simple_strtol(buf, NULL, 10);
 	return count;
 }
+
 CLASS_ATTR(timeout, 0644, firmware_timeout_show, firmware_timeout_store);
 
 int firmware_class_hotplug(struct class_device *dev, char **envp,
 			   int num_envp, char *buffer, int buffer_size);
 
 struct class firmware_class = {
-        .name           = "firmware",
-	.hotplug        = firmware_class_hotplug,
+	.name		= "firmware",
+	.hotplug	= firmware_class_hotplug,
 };
 
-
-int firmware_class_hotplug(struct class_device *class_dev, char **envp,
-			   int num_envp, char *buffer, int buffer_size)
+int
+firmware_class_hotplug(struct class_device *class_dev, char **envp,
+		       int num_envp, char *buffer, int buffer_size)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	int i=0;
-	char *scratch=buffer;
+	int i = 0;
+	char *scratch = buffer;
 
-	if (buffer_size < (FIRMWARE_NAME_MAX+10))
+	if (buffer_size < (FIRMWARE_NAME_MAX + 10))
+		return -ENOMEM;
+	if (num_envp < 1)
 		return -ENOMEM;
 
-	envp [i++] = scratch;
+	envp[i++] = scratch;
 	scratch += sprintf(scratch, "FIRMWARE=%s", fw_priv->fw_id) + 1;
 	return 0;
 }
 
-static ssize_t firmware_loading_show(struct class_device *class_dev, char *buf)
+static ssize_t
+firmware_loading_show(struct class_device *class_dev, char *buf)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 	return sprintf(buf, "%d\n", fw_priv->loading);
 }
-static ssize_t firmware_loading_store(struct class_device *class_dev,
-				      const char *buf, size_t count)
+static ssize_t
+firmware_loading_store(struct class_device *class_dev,
+		       const char *buf, size_t count)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 	int prev_loading = fw_priv->loading;
 
 	fw_priv->loading = simple_strtol(buf, NULL, 10);
-	
-	switch(fw_priv->loading){
+
+	switch (fw_priv->loading) {
 	case -1:
 		fw_priv->abort = 1;
 		wmb();
@@ -100,23 +94,25 @@
 		break;
 	case 1:
 		kfree(fw_priv->fw->data);
-		fw_priv->fw->data=NULL;
-		fw_priv->fw->size=0;
-		fw_priv->alloc_size=0;
+		fw_priv->fw->data = NULL;
+		fw_priv->fw->size = 0;
+		fw_priv->alloc_size = 0;
 		break;
 	case 0:
-		if(prev_loading==1)
+		if (prev_loading == 1)
 			complete(&fw_priv->completion);
 		break;
 	}
 
 	return count;
 }
+
 CLASS_DEVICE_ATTR(loading, 0644,
 		  firmware_loading_show, firmware_loading_store);
 
-static ssize_t firmware_data_read(struct kobject *kobj,
-				  char *buffer, loff_t offset, size_t count)
+static ssize_t
+firmware_data_read(struct kobject *kobj,
+		   char *buffer, loff_t offset, size_t count)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
@@ -132,32 +128,33 @@
 	memcpy(buffer, fw->data, fw->size);
 	return count;
 }
-static int fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
+static int
+fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
 {
 	u8 *new_data;
 
 	if (min_size <= fw_priv->alloc_size)
 		return 0;
 
-	new_data = kmalloc(fw_priv->alloc_size+PAGE_SIZE, GFP_KERNEL);
-	if(!new_data){
-		printk(KERN_ERR "%s: unable to alloc buffer\n",
-		       __FUNCTION__);
+	new_data = kmalloc(fw_priv->alloc_size + PAGE_SIZE, GFP_KERNEL);
+	if (!new_data) {
+		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
 		/* Make sure that we don't keep incomplete data */
 		fw_priv->abort = 1;
 		return -ENOMEM;
 	}
 	fw_priv->alloc_size += PAGE_SIZE;
-	if(fw_priv->fw->data){
+	if (fw_priv->fw->data) {
 		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
 		kfree(fw_priv->fw->data);
 	}
-	fw_priv->fw->data=new_data;
+	fw_priv->fw->data = new_data;
 	BUG_ON(min_size > fw_priv->alloc_size);
 	return 0;
 }
-static ssize_t firmware_data_write(struct kobject *kobj,
-				   char *buffer, loff_t offset, size_t count)
+static ssize_t
+firmware_data_write(struct kobject *kobj,
+		    char *buffer, loff_t offset, size_t count)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
@@ -165,16 +162,15 @@
 	int retval;
 
 	printk("%s: count:%d offset:%lld\n", __FUNCTION__, count, offset);
-	retval = fw_realloc_buffer(fw_priv, offset+count);
-	if(retval){
+	retval = fw_realloc_buffer(fw_priv, offset + count);
+	if (retval) {
 		printk("%s: retval:%d\n", __FUNCTION__, retval);
 		return retval;
 	}
-	printk("%s: retval:%d\n", __FUNCTION__, retval);
 
-	memcpy(fw->data+offset, buffer, count);
+	memcpy(fw->data + offset, buffer, count);
 
-	fw->size = max_t(size_t, offset+count, fw->size);
+	fw->size = max_t(size_t, offset + count, fw->size);
 
 	return count;
 }
@@ -184,41 +180,42 @@
 	.read = firmware_data_read,
 	.write = firmware_data_write,
 };
-static void firmware_class_timeout(u_long data)
+static void
+firmware_class_timeout(u_long data)
 {
 	struct firmware_priv *fw_priv = (struct firmware_priv *)data;
-	fw_priv->abort=1;
+	fw_priv->abort = 1;
 	wmb();
-	complete(&fw_priv->completion);	
+	complete(&fw_priv->completion);
 }
-static inline void fw_setup_class_device_id(struct class_device *class_dev,
-				       struct device *dev)
+static inline void
+fw_setup_class_device_id(struct class_device *class_dev, struct device *dev)
 {
 #warning we should watch out for name collisions
 	strncpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
-	class_dev->class_id[BUS_ID_SIZE-1] = '\0';
+	class_dev->class_id[BUS_ID_SIZE - 1] = '\0';
 }
-static int fw_setup_class_device(struct class_device *class_dev,
-				 const char *fw_name,
-				 struct device *device)
+static int
+fw_setup_class_device(struct class_device *class_dev,
+		      const char *fw_name, struct device *device)
 {
 	int retval = 0;
-	struct firmware_priv *fw_priv = kmalloc(sizeof(struct firmware_priv),
+	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
 						GFP_KERNEL);
 
-	if(!fw_priv){
+	if (!fw_priv) {
 		retval = -ENOMEM;
 		goto out;
 	}
-	memset(fw_priv, 0, sizeof(*fw_priv));
-	memset(class_dev, 0, sizeof(*class_dev));
+	memset(fw_priv, 0, sizeof (*fw_priv));
+	memset(class_dev, 0, sizeof (*class_dev));
 
 	init_completion(&fw_priv->completion);
 	memcpy(&fw_priv->attr_data, &firmware_attr_data_tmpl,
-	       sizeof(firmware_attr_data_tmpl));
+	       sizeof (firmware_attr_data_tmpl));
 
 	strncpy(fw_priv->fw_id, fw_name, FIRMWARE_NAME_MAX);
-	fw_priv->fw_id[FIRMWARE_NAME_MAX-1] = '\0';
+	fw_priv->fw_id[FIRMWARE_NAME_MAX - 1] = '\0';
 
 	fw_setup_class_device_id(class_dev, device);
 	class_dev->dev = device;
@@ -227,18 +224,17 @@
 	fw_priv->timeout.data = (u_long)fw_priv;
 	init_timer(&fw_priv->timeout);
 
-	class_dev->class = &firmware_class,
+	class_dev->class = &firmware_class;
 	class_set_devdata(class_dev, fw_priv);
 	retval = class_device_register(class_dev);
-	if (retval){
+	if (retval) {
 		printk(KERN_ERR "%s: class_device_register failed\n",
 		       __FUNCTION__);
 		goto error_free_fw_priv;
 	}
 
-	retval = sysfs_create_bin_file(&class_dev->kobj,
-				       &fw_priv->attr_data);
-	if (retval){
+	retval = sysfs_create_bin_file(&class_dev->kobj, &fw_priv->attr_data);
+	if (retval) {
 		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
 		       __FUNCTION__);
 		goto error_unreg_class_dev;
@@ -246,23 +242,23 @@
 
 	retval = class_device_create_file(class_dev,
 					  &class_device_attr_loading);
-	if (retval){
+	if (retval) {
 		printk(KERN_ERR "%s: class_device_create_file failed\n",
 		       __FUNCTION__);
 		goto error_remove_data;
 	}
 
-	fw_priv->fw=kmalloc(sizeof(struct firmware), GFP_KERNEL);
-	if(!fw_priv->fw){
+	fw_priv->fw = kmalloc(sizeof (struct firmware), GFP_KERNEL);
+	if (!fw_priv->fw) {
 		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
 		       __FUNCTION__);
 		retval = -ENOMEM;
 		goto error_remove_loading;
 	}
-	memset(fw_priv->fw, 0, sizeof(*fw_priv->fw));
+	memset(fw_priv->fw, 0, sizeof (*fw_priv->fw));
 
 	goto out;
-	
+
 error_remove_loading:
 	class_device_remove_file(class_dev, &class_device_attr_loading);
 error_remove_data:
@@ -274,7 +270,8 @@
 out:
 	return retval;
 }
-static void fw_remove_class_device(struct class_device *class_dev)
+static void
+fw_remove_class_device(struct class_device *class_dev)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 
@@ -283,38 +280,41 @@
 	class_device_unregister(class_dev);
 }
 
-int request_firmware (const struct firmware **firmware, const char *name,
-		      struct device *device)
+int
+request_firmware(const struct firmware **firmware, const char *name,
+		 struct device *device)
 {
-	struct class_device *class_dev = kmalloc(sizeof(struct class_device),
+	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
 						 GFP_KERNEL);
 	struct firmware_priv *fw_priv;
 	int retval;
 
-	if(!class_dev)
+	if (!class_dev)
 		return -ENOMEM;
 
-	if(!firmware){
+	if (!firmware) {
 		retval = -EINVAL;
 		goto out;
 	}
-	*firmware=NULL;
+	*firmware = NULL;
 
 	retval = fw_setup_class_device(class_dev, name, device);
-	if(retval)
+	if (retval)
 		goto out;
 
 	fw_priv = class_get_devdata(class_dev);
 
-	fw_priv->timeout.expires = jiffies + loading_timeout*HZ;
-	add_timer(&fw_priv->timeout);
+	if (loading_timeout) {
+		fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
+		add_timer(&fw_priv->timeout);
+	}
 
 	wait_for_completion(&fw_priv->completion);
 
 	del_timer(&fw_priv->timeout);
 	fw_remove_class_device(class_dev);
 
-	if(fw_priv->fw->size && !fw_priv->abort){
+	if (fw_priv->fw->size && !fw_priv->abort) {
 		*firmware = fw_priv->fw;
 	} else {
 		retval = -ENOENT;
@@ -326,15 +326,18 @@
 	kfree(class_dev);
 	return retval;
 }
-void release_firmware (const struct firmware *fw)
+
+void
+release_firmware(const struct firmware *fw)
 {
-	if(fw){
+	if (fw) {
 		kfree(fw->data);
 		kfree(fw);
 	}
 }
 
-void register_firmware (const char *name, const u8 *data, size_t size)
+void
+register_firmware(const char *name, const u8 *data, size_t size)
 {
 	/* This is meaningless without firmware caching, so until we
 	 * decide if firmware caching is reasonable just leave it as a
@@ -351,11 +354,12 @@
 	void (*cont)(const struct firmware *fw, void *context);
 };
 
-static void request_firmware_work_func(void *arg)
+static void
+request_firmware_work_func(void *arg)
 {
 	struct firmware_work *fw_work = arg;
 	const struct firmware *fw;
-	if(!arg)
+	if (!arg)
 		return;
 	request_firmware(&fw, fw_work->name, fw_work->device);
 	fw_work->cont(fw, fw_work->context);
@@ -364,21 +368,22 @@
 	kfree(fw_work);
 }
 
-int request_firmware_nowait (
+int
+request_firmware_nowait(
 	struct module *module,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
-	struct firmware_work *fw_work = kmalloc(sizeof(struct firmware_work),
+	struct firmware_work *fw_work = kmalloc(sizeof (struct firmware_work),
 						GFP_ATOMIC);
-	if(!fw_work)
+	if (!fw_work)
 		return -ENOMEM;
-	if(!try_module_get(module)){
+	if (!try_module_get(module)) {
 		kfree(fw_work);
 		return -EFAULT;
 	}
 
-	*fw_work = (struct firmware_work){
+	*fw_work = (struct firmware_work) {
 		.module = module,
 		.name = name,
 		.device = device,
@@ -391,30 +396,30 @@
 	return 0;
 }
 
-
-
-static int __init firmware_class_init(void)
+static int __init
+firmware_class_init(void)
 {
 	int error;
-        error = class_register(&firmware_class);
-        if (error) {
-		printk(KERN_ERR "%s: class_register failed\n",
-		       __FUNCTION__);
+	error = class_register(&firmware_class);
+	if (error) {
+		printk(KERN_ERR "%s: class_register failed\n", __FUNCTION__);
 	}
 	error = class_create_file(&firmware_class, &class_attr_timeout);
-	if (error){
+	if (error) {
 		printk(KERN_ERR "%s: class_create_file failed\n",
 		       __FUNCTION__);
 		class_unregister(&firmware_class);
 	}
-        return error;
+	return error;
 
 }
-static void __exit firmware_class_exit(void)
+static void __exit
+firmware_class_exit(void)
 {
 	class_remove_file(&firmware_class, &class_attr_timeout);
 	class_unregister(&firmware_class);
 }
+
 module_init(firmware_class_init);
 module_exit(firmware_class_exit);
 
diff -u linux-2.5.mine/drivers/base/firmware_sample_firmware_class.c linux-2.5.mine/drivers/base/firmware_sample_firmware_class.c
--- linux-2.5.mine/drivers/base/firmware_sample_firmware_class.c	2003-05-17 23:19:44.000000000 +0200
+++ linux-2.5.mine/drivers/base/firmware_sample_firmware_class.c	2003-05-21 15:58:34.000000000 +0200
@@ -32,8 +32,8 @@
 
 struct firmware_priv {
 	char fw_id[FIRMWARE_NAME_MAX];
-	s32 loading:2;
-	u32 abort:1;
+	int loading;
+	int abort;
 };
 
 extern struct class firmware_class;
@@ -68,8 +68,8 @@
 
 	return count;
 }
-CLASS_DEVICE_ATTR(loading, 0644,
-		  firmware_loading_show, firmware_loading_store);
+static CLASS_DEVICE_ATTR(loading, 0644,
+			 firmware_loading_show, firmware_loading_store);
 
 static ssize_t firmware_data_read(struct kobject *kobj,
 				  char *buffer, loff_t offset, size_t count)

--dDRMvlgZJXvWKvBx
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="class-casts.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWX5GnVcAATDfgAowSH//+kgBCQC//5/aQAIWcJBRgAAAABoNAGgGgGqepon6
phqMCYCDI00xGRoGCRJCaajajajag9IeoDajQNPUekAqiEmhpqaZqTyYpiDQ0NNpAGi2wAlq
rATYTnOeXBDyuYbBn2fGsEgkpMINd0AhtYyrZEMsC+7aaTyNYdV+vgG9rXG1Z9NwSNRKiYu5
nP04NxTr1KqVBbyGTIW+Ubm5ojiHFyCkrBkCmIrb4PBiVWXakpSvcSf8PApcl2OU8h/TUXiS
gmH4mZmZ95FxJ8yhtKmB44LjLFwz31X31Gc7yha+xQvtTMsaRpvs0tiss1tdHi3NvsNrvNrc
+zrc3Nw7XZ5RgG8J0iFszhJy3YBhiCySUlMrm7ITGsQXCgkvxF6Y2IxnCgJ0tgw0H6CzacpG
RSkZnFQ0jy6XOaRKjcRUwVRw9PJZwsZjOoKrQj6sXNvNmTqSbzX04QxjGDRiscGp6G81xYXE
aeUHJdGMRGSgo1mzObIiNZI2Hb6d0pS4nqwMDLu6uhglMRvUKaPNSGs6yMzMhYjcbRakQnQR
orSIjLzS2zuVZIKNIWsQwpWdF5UqrW9CSoBTJKsrBdBw5L1IjUMxlxIpBqr0CpbJdL/i7kin
ChIPyNOq4A==

--dDRMvlgZJXvWKvBx
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="firmware-class.diff.bz2"
Content-Transfer-Encoding: base64

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
/wENATJIsIM/yNgf/F3JFOFCQdyJWOQ=

--dDRMvlgZJXvWKvBx
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="sysfs-bin-flexible-size.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWdr7Mx8AAYJfgAIwYH///2+v3xC/79/6QAJ8A1kDCUlMRoNDQAAAADQANNAG
gNU9TQTE0AephNAABkwmgaAABzAEYJiAYBME0ZDQwCYIxMJEhEwJMp5TaZTamjIHqaA0GmgD
IwmBYFGXFCRIIJD5hk2DnORJSIJDGSkNEREgcFvC3LWKCDXLuGigmdwwrYXTCFWO6uk6PBCI
ZzpLwnSjpzG2wfQFeYMh7+Tk/ZNmQ6sB4MXQXQgmMZQ4+TvdJxGJgQcANRDB6uHmngVFVAkZ
qBkAq4ODiwvNEBq+8CNOvfoHrGF043uZjjx2GKQNGhuIFZTtL9hlHf6tkbtxF4jXgDiPSPad
oQsqwgrdVlocIWBiFn6bgMArLCwyzLRnKQbq9JQliUsR7K6vCVSySqcyjBmonCBk6SuBg5gq
GQEpzATBBY0CNWmuuT3Ag4FLQIgoEjh6UEc8imgQVtIxDcBAbQ6EfLzzX4RXuL46D6IkKNyD
JoQeGDop3D0FmmRxQ2Lj0RDO068hOISFFHPNg9eK6QVjaj6S+4T4E0zByN6+pEUjCBwoI+uX
/wNtI0L6ozTWWDTyseM0LzdaSoPCEozokmIKjqzmasStDSEBYVk2AX3lA6w1FDMFArSVxKxQ
D0kio/NuXsOAuRYKaziUDRsIDSXHWmawypg0rOxYxefwkkHSscG1fjGq/OGCaKzu7lkRoy23
EhCmcYO0FcYbAyLaMYLKNEDb1Lfa3jCZKiO/sCpINtaLMKrAtU8QtzGfYFSSC204R/i7kinC
hIbX2Zj4

--dDRMvlgZJXvWKvBx
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="sysfs-bin-header.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWQiLF+sAAJ/fgAIwQH/7+kgBCQC//9/6MAFWUAwAA0AAZNAAAGgEqnomTUPS
GgMmmho0ADQ0ASSI1T9IJ7SaZAmTJkNDQwNTR5WbhsH2adI0ImKatVsHbRCtEEUJcJd76cpR
iHBYzhkVSt2QFKC5OtLMRlTdWwxsGgCzKikZ6YgTscDUOUieEx2DWPnbH6bArCAS4MzBQHmK
AhSKJBY8qnYXSEGEooakTYGEIg4JrS5Fo1dVWfuwS8yVvt5b9/MiZ3DDkbtqdePkYGOiXELZ
igNL4eCOySluDoNVQc0XTd0T70NtrKsVJjSebA6p8QwsROodAuPcrAhFEEsyWAYIg19GAyTi
KWEXJX4SxxKdFFynM74xmB5xcI/rEu6XKxVn4tUz9bHNDZQZeKpQUMiLM9SDJihITCHCziMi
NOgLwFpVfA0XksCKT/F3JFOFCQCIsX6w

--dDRMvlgZJXvWKvBx
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="sysfs-bin-lost-dget.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWYpG9FUAAIHfgAIwYH//uk4BSQCv595qMAEVlIaJNCZkaj1GnqeoeoGgAaaD
1CJpPSCeSMIDNAEMCGmAShKYbVTwpnqg9TQwjaaIAY9UdAnBCoEAoRImBPqn14CJbBQqQCjn
4mN7M1yBf8k1tyheprju6Vxkjvg+zRzOfUFixaEFhkJaHyvJYNBStEgUk2b0NxMIULmxxC0K
g76YfSr0AsDLgMRFOAxnIGN5mvXTASgyLhkqKlzwHB67B/vrrrTJMFto3DO1oEx+eykwvaB9
hQKnJIop2hLNIX8qrIrSNfBVKSO4Q2v5ST4W4N4MPcdSNWPOY0hViHSYRkUhIl4F9qpgohh8
1JAKIonNgjEV6XB5NYpCcQsClMoAYPADGgHNQsOayaBlPSx9eaYBYE8cRVAW5P4u5IpwoSEU
jeiq

--dDRMvlgZJXvWKvBx--
