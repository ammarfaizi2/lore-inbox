Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTEVPTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTEVPTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:19:49 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:29387 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261944AbTEVPTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:19:25 -0400
Date: Thu, 22 May 2003 17:31:54 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030522153154.GD13224@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com> <20030521185212.GC12677@ranty.ddts.net> <20030521200736.GA2606@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20030521200736.GA2606@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2003 at 01:07:36PM -0700, Greg KH wrote:
> On Wed, May 21, 2003 at 08:52:12PM +0200, Manuel Estrada Sainz wrote:
> > On Wed, May 21, 2003 at 12:23:18AM -0700, Greg KH wrote:
> > > Oops, forgot to respond to this, sorry...
> > > 
> > > On Sun, May 18, 2003 at 12:19:22AM +0200, Manuel Estrada Sainz wrote:
> > [snip]
> > > >  - There is a timeout, changeable from userspace. Feedback on a
> > > >    reasonable default value appreciated.
> > > 
> > > Is this really needed?  Especially as you now have:
> > 
> >  There is currently no way to know if hotplug couldn't be called at all
> >  or if it failed because it didn't have firmware load support.
> > 
> >  If that happens, we would be waiting for ever. And I'd rather make that
> >  a countable number of seconds :)
> > 
> >  I'll make '0' mean no timeout at all.
> 
> Ok, that's fine with me.  A bit of documentation for all of this might
> be nice.  Just add some kerneldoc comments to your public functions, and
> you should be fine.

 Done. I am not a good documentation writer, but the attached patches
 should include enough documentation to understand how things work.
 
> >  I am not sure on how to implement "if a driver that uses it is
> >  selected" and not sure on where to add the Kconfig entries to make it
> >  available to out-of-kernel modules.
> 
> You could do something like what has been done for the mii module.  Look
> at lib/Makefile and drivers/usb/net/Makefile.mii for an example.
> 
> I'm not saying that this is the best way, but it could be one solution.
> Ideally, the user would never have to select the firmware core option,
> it would just get automatically built if a driver that needs it is also
> selected.

 But if a driver not in the kernel tree needs it, the user should be
 able to enable it unconditionally, like the CRC32 stuff.

 And currently there is no in-kernel driver that uses it, so the only
 way to enable it is manually. 

 Once Atmel PCMCIA driver (which will use it) gets in, the new 'enable'
 kconfig keyword should be already available and no makefile tricks will
 be needed.

[snip]
> Add a bit of documentation, and some build integration,

 Until drivers start using it, there is not much build integration to
 do.

> and I'd think you are finished.  Unless anyone else has any
> objections?

 Simon Kelley had an objection, it was badly corrupting kernel memory :-/.

 It was a bug in the sysfs pieces which is now fixed.

 So I am finished :-) What do I do now? Should I send it to Linus or you
 take care of that?

> Very nice job, thanks again for doing this.

 No problem.

 News:
 	- Fixed the sysfs corruption problem.
	- Use refcounting with class_device instances.
		- I had to add support for 'release forwarding' to
		  the class subsystem.
	- Removed firmware_sample_firmware_class.c
		- It is ugly, if found interesting, it should get
		  polished first.
	- Removed FW_LOADER_SAMPLE Kconfig/Makefile stuff.
	- Some more formatting changes.

 Patches:
 	incremental.diff:
		For easier reading as usual.
	
 	firmware-class.diff.bz2:
		The code itself

	firmware-class-sample-driver.diff.bz2:
		The sample driver, for easier ignoring :)

	class-casts+release.diff.bz2:
		to_class_dev/to_class_dev_attr and 'release forwarding'
		changes.
	
	sysfs-bin-header.diff.bz2
	sysfs-bin-lost-dget.diff.bz2
	sysfs-bin-flexible-size.diff.bz2:
		sysfs bits. This time, they don't corrupt kernel memory :-/
		(I'll send them to Patrick Mochel in a few moments.)

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="incremental.diff"

diff -u linux-2.5.mine/drivers/base/class.c linux-2.5.mine/drivers/base/class.c
--- linux-2.5.mine/drivers/base/class.c	2003-05-21 10:19:41.000000000 +0200
+++ linux-2.5.mine/drivers/base/class.c	2003-05-22 16:51:46.000000000 +0200
@@ -179,7 +179,15 @@
 	.store	= class_device_attr_store,
 };
 
+static void class_dev_release(struct kobject * kobj)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
+	if (class_dev->release)
+		class_dev->release(class_dev);
+}
+
 static struct kobj_type ktype_class_device = {
+	.release	= &class_dev_release,
 	.sysfs_ops	= &class_dev_sysfs_ops,
 };
 
only in patch2:
unchanged:
--- linux-2.5.orig/include/linux/device.h	2003-05-22 13:05:16.000000000 +0200
+++ linux-2.5.mine/include/linux/device.h	2003-05-22 12:05:45.000000000 +0200
@@ -204,6 +204,7 @@
 	void			* class_data;	/* class-specific data */
 
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
+	void	(*release)(struct class_device * class_dev);
 };
 
 static inline void *
diff -u linux-2.5.mine/drivers/base/Kconfig.lib linux-2.5.mine/drivers/base/Kconfig.lib
--- linux-2.5.mine/drivers/base/Kconfig.lib	2003-05-21 16:24:14.000000000 +0200
+++ linux-2.5.mine/drivers/base/Kconfig.lib	2003-05-22 13:11:42.000000000 +0200
@@ -12,6 +11,0 @@
-config FW_LOADER_SAMPLE
-	tristate "Hotplug firmware loading samples"
-	---help---
-	  This should not get in the kernel, it is just here to make playing
-	  with firmware loading easier.
-
diff -u linux-2.5.mine/drivers/base/Makefile linux-2.5.mine/drivers/base/Makefile
--- linux-2.5.mine/drivers/base/Makefile	2003-05-21 16:25:44.000000000 +0200
+++ linux-2.5.mine/drivers/base/Makefile	2003-05-22 13:12:20.000000000 +0200
@@ -6,9 +6,2 @@
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
-
-#The next three lines are just to make testing easier and should not get into
-#the kernel
-obj-$(CONFIG_FW_LOADER_SAMPLE)	+= firmware_class.o
-obj-$(CONFIG_FW_LOADER_SAMPLE)	+= firmware_sample_driver.o \
-				   firmware_sample_firmware_class.o
-
 obj-$(CONFIG_NUMA)	+= node.o  memblk.o
diff -u linux-2.5.mine/drivers/base/firmware_class.c linux-2.5.mine/drivers/base/firmware_class.c
--- linux-2.5.mine/drivers/base/firmware_class.c	2003-05-21 16:38:06.000000000 +0200
+++ linux-2.5.mine/drivers/base/firmware_class.c	2003-05-22 16:49:39.000000000 +0200
@@ -3,6 +3,19 @@
  *
  * Copyright (c) 2003 Manuel Estrada Sainz <ranty@debian.org>
  *
+ * Simple hotplug script sample:
+ * 
+ *	HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
+ *	echo 1 > /sysfs/$DEVPATH/loading
+ *	cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
+ *	echo 0 > /sysfs/$DEVPATH/loading
+ *
+ * To cancel the load in case of error:
+ *
+ *	echo -1 > /sysfs/$DEVPATH/loading
+ *
+ * Both $DEVPATH and $FIRMWARE are already provided in the environment.
+ *
  */
 
 #include <linux/device.h>
@@ -36,6 +49,17 @@
 {
 	return sprintf(buf, "%d\n", loading_timeout);
 }
+
+/**
+ * firmware_timeout_store:
+ * Description:
+ *	Sets the number of seconds to wait for the firmware.  Once
+ *	this expires an error will be return to the driver and no
+ *	firmware will be provided.
+ *
+ *	Note: zero means 'wait for ever'
+ *  
+ **/
 static ssize_t
 firmware_timeout_store(struct class *class, const char *buf, size_t count)
 {
@@ -77,6 +101,16 @@
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 	return sprintf(buf, "%d\n", fw_priv->loading);
 }
+
+/**
+ * firmware_loading_store: - loading control file
+ * Description:
+ *	The relevant values are: 
+ *
+ *	 1: Start a load, discarding any previous partial load.
+ *	 0: Conclude the load and handle the data to the driver code.
+ *	-1: Conclude the load with an error and discard any written data.
+ **/
 static ssize_t
 firmware_loading_store(struct class_device *class_dev,
 		       const char *buf, size_t count)
@@ -125,7 +159,7 @@
 	if (offset + count > fw->size)
 		count = fw->size - offset;
 
-	memcpy(buffer, fw->data, fw->size);
+	memcpy(buffer, fw->data + offset, count);
 	return count;
 }
 static int
@@ -152,6 +186,15 @@
 	BUG_ON(min_size > fw_priv->alloc_size);
 	return 0;
 }
+
+/**
+ * firmware_data_write:
+ *
+ * Description:
+ *
+ *	Data written to the 'data' attribute will be later handled to
+ *	the driver as a firmware image.
+ **/
 static ssize_t
 firmware_data_write(struct kobject *kobj,
 		    char *buffer, loff_t offset, size_t count)
@@ -180,10 +223,17 @@
 	.read = firmware_data_read,
 	.write = firmware_data_write,
 };
+
+static void
+fw_class_dev_release(struct class_device *class_dev)
+{
+	kfree(class_dev);
+}
+
 static void
 firmware_class_timeout(u_long data)
 {
-	struct firmware_priv *fw_priv = (struct firmware_priv *)data;
+	struct firmware_priv *fw_priv = (struct firmware_priv *) data;
 	fw_priv->abort = 1;
 	wmb();
 	complete(&fw_priv->completion);
@@ -196,16 +246,18 @@
 	class_dev->class_id[BUS_ID_SIZE - 1] = '\0';
 }
 static int
-fw_setup_class_device(struct class_device *class_dev,
+fw_setup_class_device(struct class_device **class_dev_p,
 		      const char *fw_name, struct device *device)
 {
 	int retval = 0;
 	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
 						GFP_KERNEL);
+	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
+						 GFP_KERNEL);
 
-	if (!fw_priv) {
+	if (!fw_priv || !class_dev) {
 		retval = -ENOMEM;
-		goto out;
+		goto error_kfree;
 	}
 	memset(fw_priv, 0, sizeof (*fw_priv));
 	memset(class_dev, 0, sizeof (*class_dev));
@@ -221,16 +273,17 @@
 	class_dev->dev = device;
 
 	fw_priv->timeout.function = firmware_class_timeout;
-	fw_priv->timeout.data = (u_long)fw_priv;
+	fw_priv->timeout.data = (u_long) fw_priv;
 	init_timer(&fw_priv->timeout);
 
+	class_dev->release = fw_class_dev_release;
 	class_dev->class = &firmware_class;
 	class_set_devdata(class_dev, fw_priv);
 	retval = class_device_register(class_dev);
 	if (retval) {
 		printk(KERN_ERR "%s: class_device_register failed\n",
 		       __FUNCTION__);
-		goto error_free_fw_priv;
+		goto error_kfree;
 	}
 
 	retval = sysfs_create_bin_file(&class_dev->kobj, &fw_priv->attr_data);
@@ -265,9 +318,12 @@
 	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
 error_unreg_class_dev:
 	class_device_unregister(class_dev);
-error_free_fw_priv:
+error_kfree:
 	kfree(fw_priv);
+	kfree(class_dev);
+	*class_dev_p = NULL;
 out:
+	*class_dev_p = class_dev;
 	return retval;
 }
 static void
@@ -280,25 +336,32 @@
 	class_device_unregister(class_dev);
 }
 
+/** 
+ * request_firmware: - request firmware to hotplug and wait for it
+ * Description:
+ *	@firmware will be used to return a firmware image by the name
+ *	of @name for device @device.
+ *
+ *	Should be called from user context where sleeping is allowed.
+ *
+ *	@name will be use as $FIRMWARE in the hotplug environment and
+ *	should be distinctive enough not to be confused with any other
+ *	firmware image for this or any other device.
+ **/
 int
 request_firmware(const struct firmware **firmware, const char *name,
 		 struct device *device)
 {
-	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
-						 GFP_KERNEL);
+	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
 	int retval;
 
-	if (!class_dev)
-		return -ENOMEM;
+	if (!firmware)
+		return -EINVAL;
 
-	if (!firmware) {
-		retval = -EINVAL;
-		goto out;
-	}
 	*firmware = NULL;
 
-	retval = fw_setup_class_device(class_dev, name, device);
+	retval = fw_setup_class_device(&class_dev, name, device);
 	if (retval)
 		goto out;
 
@@ -323,10 +386,12 @@
 	}
 	kfree(fw_priv);
 out:
-	kfree(class_dev);
 	return retval;
 }
 
+/**
+ * release_firmware: - release the resource associated with a firmware image
+ **/
 void
 release_firmware(const struct firmware *fw)
 {
@@ -336,6 +401,15 @@
 	}
 }
 
+/**
+ * register_firmware: - provide a firmware image for later usage
+ * 
+ * Description:
+ *	Make sure that @data will be available by requesting firmware @name.
+ *
+ *	Note: This will not be possible until some kind of persistence
+ *	is available.
+ **/
 void
 register_firmware(const char *name, const u8 *data, size_t size)
 {
@@ -368,6 +442,20 @@
 	kfree(fw_work);
 }
 
+/**
+ * request_firmware_nowait:
+ *
+ * Description:
+ *	Asynchronous variant of request_firmware() for contexts where
+ *	it is not possible to sleep.
+ *
+ *	@cont will be called asynchronously when the firmware request is over.
+ *
+ *	@context will be passed over to @cont.
+ *
+ *	@fw may be %NULL if firmware request fails.
+ *
+ **/
 int
 request_firmware_nowait(
 	struct module *module,
diff -u linux-2.5.mine/include/linux/firmware.h linux-2.5.mine/include/linux/firmware.h
--- linux-2.5.mine/include/linux/firmware.h	2003-05-17 22:16:36.000000000 +0200
+++ linux-2.5.mine/include/linux/firmware.h	2003-05-22 16:55:06.000000000 +0200
@@ -9,12 +9,12 @@
 };
-int request_firmware (const struct firmware **fw, const char *name,
-		      struct device *device);
-int request_firmware_nowait (
+int request_firmware(const struct firmware **fw, const char *name,
+		     struct device *device);
+int request_firmware_nowait(
 	struct module *module,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
 /* Maybe 'device' should be 'struct device *' */
 
-void release_firmware (const struct firmware *fw);
-void register_firmware (const char *name, const u8 *data, size_t size);
+void release_firmware(const struct firmware *fw);
+void register_firmware(const char *name, const u8 *data, size_t size);
 #endif
diff -u linux-2.5.mine/fs/sysfs/bin.c linux-2.5.mine/fs/sysfs/bin.c
--- linux-2.5.mine/fs/sysfs/bin.c	2003-05-17 14:53:01.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/bin.c	2003-05-22 16:52:42.000000000 +0200
@@ -33,7 +33,7 @@
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 
-	if(size){
+	if (size) {
 		if (offs > size)
 			return 0;
 		if (offs + count > size)
@@ -46,7 +46,7 @@
 	count = ret;
 
 	ret = -EFAULT;
-	if (copy_to_user(userbuf, buffer + offs, count) != 0)
+	if (copy_to_user(userbuf, buffer, count) != 0)
 		goto Done;
 
 	*off = offs + count;
@@ -84,7 +84,7 @@
 	}
 
 	ret = -EFAULT;
-	if (copy_from_user(buffer + offs, userbuf, count))
+	if (copy_from_user(buffer, userbuf, count))
 		goto Done;
 
 	count = flush_write(dentry, buffer, offs, count);
diff -u linux-2.5.mine/fs/sysfs/inode.c linux-2.5.mine/fs/sysfs/inode.c
--- linux-2.5.mine/fs/sysfs/inode.c	2003-05-17 20:30:34.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/inode.c	2003-05-22 16:53:59.000000000 +0200
@@ -60,7 +60,7 @@
  Proceed:
 	if (init)
 		error = init(inode);
-	if (!error){
+	if (!error) {
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
 	} else

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="firmware-class.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWTK4yk8AD3XfgHowf////3//3/6////+YBT/eAOnL7Ol1IHnrCPbu7eulz3u
8KE9uHNKNRW8y4BgqdsUbdxrlWQKk7YdaNDEk00KYCepmp6aJ6NU8iaDT1NNAxGg0ANAGhoa
DTQmgEQ1BT9RhEaaGjQAANAAAAGhoHA0aMQaNMmEGIDEYmjRo0AaaaAAAAJNKFNI0xCmyBTy
Tam0mmmnqaGg0NNGg0GhoBoACKRNATSmaT2piaU9R6Mk2o9I0DQxGmhpo9IGmgabRqCJIggA
JppMmQaTU9JHmqep6j1B6QYg8iZA/VMh6h6mWMjEO0SgeQWJ+EBswtFr7qGoCkIKCodxSxe4
cOIqs9m35P0/Lv+Uzc53Gt5NkUmAsqEqjB6biMRMCKqxQSMgKAUSiMGCwqUBEBAUEGSoAIgV
IHyH1urv5fyz54aYT/jF7JMej3cTTDOLhqUg4ixaU16Pn8B+3W/mcujoWOhYsyaLhmRMn/rR
tbVVVEFMtiLBZWLHWcYcjgbEitzgzmjG9GMGIwQRRPSUuLr8tzvKaYBXekWEWKqx5fapDHD6
VmBFWaH2zwqdSL4rQSeK75/zz8ifgq1sBYobeFRuZw0ebkTNJSZAGMElcY28nZ0/i7M4O4TK
d/ohrW5gIoo9VK8p2JFVx6w5j20yaH/PfN02VbRV3uJtfMEHOL0CYtlkhZPZZsa18i3Nem+k
ZI3QKKUHOlTEhyJGgk7dTOKUzDp3pxYSpx4Up6dNTxGLSMEUHF+uA2iffd6ToYTZV7yEmU5I
KHR/uyX0ie1PNy2+rPaBQtEmPfZIFV4n+lpU1LSPPyVUbsTfBGU8PDDYm82mx6NBG6a4mHQM
ZQHMRl7IEHuPEUGk2mMiQEbV1wDuMSoKWWIRrgGPknhnRA6QsnOLLK+gxgf0vkAO9o6+40xV
Eagm3Hus5/0n1KDXNZHM0fWtazCltRWbI0yDW5dt7+rmhDQtWdbw3AxN8PfdQ5HiAXKs7xYd
7Q1ukQuKNuJ18R3ZiMuCnNXG6IyJnPZ3FkkWGNmdkhglrNYPpGPA/YByVFCGIUa29FhWJKEX
crAOCOVUQ13bzEJaoC8ts77vhrS9d8OwOhTebw6ego3e5p1AF1F1OrVCW9xbm457LqgvtCka
LHAogrVfGG2Vzcg9D0dfXpC8udzCUthx2ovW2mtvrlvOlxSxHZKGtcNpv7r8zDceLd9R8QdI
vPHb2YHK2mNTIhUHOwZ18XH3jI6HoNuv8ySSSYTs9DsBeZ2TXzuG3JAF4qOC1PO69Gl99hHu
g0a1gNQwcbqjsi24REhbqlJlWdIWXnhqawqyDGtHJxXhFzEuPYYEHbna/bpIQlEAq68q0EcU
SQ9MigAu5SYrijBuZVFgx0fB12WMDZWYsaDxouKzGJ4so6JU1RzuQHNDae7WtX0Kk4IeiFxE
LntBEmdQe+3oO2+pPxchBIerV4XG5JD2+eHVNm+k4QyzkIHkgeJX9iQOb+chyoT813MIESSM
U6+vZt+kxTbN5F6v5PD7toYMOuC4ibZ557C8fKRReTtHYMKFt+6MokSDf7L43H2OT5ZFXKwp
rP3WthTMJRb2nO5zvjYNAFBo9QO9ZB5K6rORGSkSxR4UN9fd9Wmx5dnYZONCu2NxDchVnnWT
T16H6Z1ycWxpsQXVs0mnSbvMzd7Ov+dIObqhDxR59UorT21fj9xby3XdapR9OG6b7t7TBuo8
QvvxbNFM8rmzhmzlcu/cKOWIYRnDye8mq+Dh7elFPf2jQSVEIyRGLACkkIgc4nrLWbIFFiUE
gtpJaAHxVEGD86RpApInxglgC5KEvAUdXF/i7eNc0wqLyvvI1Qxb9bxGcTZh2sQuDHcNpwxy
zVC1awV3BMRATC2tguKpLt9YxSSxymJvG8XHjzqaCJKFFE7V9GBsOZNrMHBgqewfN34lLu+0
wkJrJDlwpxUSqGxubln35j+IJYbG0U5m4SqgLCUBBoshq1DpzREXasevg2aIoknuYYkJzPze
ShqHxAEUTEITJCUjqqljBVFNiaxNEzoi2zVbz1XnRVMg1GAlz7wVQhoPe9w0Kye/DdA1CfD6
O3IiIjYNDluxgiqUojPIK2o0BB8+QJs8DTV5jYzDjfvbWuBKVCD9rYT7xLAWcR5ubFxAvdZd
LOGVkJsyVKpFbR55smMLWSWRr32c4itukN4XUBLrrFrtWKLfceUrqqkBSxrLbiZxkREiZWuI
JV9lbDAMw9jPEJxY6ZhPV3fDut5+sfC1wM8yvIEKIbiDy861+2J79PLrukljGNtX+ZgEt/nY
JH9oSIJYe9uiTYecKDU0SRYkNSNtDutM4iqWDoKJmBqQuoOU9h1+nRRki890nNzZskNleFuq
tpwNeRUscXj5nsfWTqTbnrhnghrusY72QqZTZNk3DgS9DmW0TzF6xX4RfmgB7oVek/VAC0ZB
9H01xTmqYjbphaLLmUE8wk07yZpRHjIkREbPSf8dPkT1qbRqT630xal18kjqmdLvnkMqjETg
STeH5EHQkGhvM1Y9za4SZcwa/UEZw0DJejNQ/NTOsl3kpvmBFySTpOse36zOdd6MTVrtItC5
NhWLhO4+ViTR/8d5MTqOzvyy48vLM2GVzdpU59pipz8AxaXhpX9hMOLamITcoNhiGlvYGCLS
wZTTqS4bkja4qb3WzhGUEd1LC9MBLQma8UPZcllTWtYmBoNbl1JA67bsiQnl5N9JFZndqcUz
0JtpYXcBtmQGWldN5Ow2qblJqVCEkmZ0zC/HiGZE9J3G46kMeuSGG/WJajYbixvTfq1JpO3x
dg5zgJctZ4DtTuU45BiGCTgcU3HW8BzH43xwBxGVA8Iz5LwIpvXE1ITO2hhJgOQSAis2FhaE
usXEhKGwkcI4CV+xIH4h8R4iQeggk+c+2fEeTKowPw+TomF0YBrbUsZggTICST5p3ZwJwBho
3CWVttA+MuiCb6Km2MG4PjGYk/YfBsYDUZCwFFgSP4yl2HJTBsXJS4Dp5D1muNW21xlV2OKQ
+RH/OXdMzJVk/R7dG1yMTENjCQgkLvZiBkUNApntJ+8L7Nxo6MIbD40q229E5Ga+o4AVvONE
P7gHMY3DWZ0m03ATNMtLZD4y0qy3moxDEEyJrFtBEkBA/H5Wzvz9N3N1ySfIWD/fO1AAxxMd
Z1E84gm81w16R4amyB6NIZvcEjXBbqMr0kQPg8KNfHAtLCRcHCD5OgmMTye8+0IZGdrBRUDd
M2G8NNkqL5RLDWMoDBPI0tEudmQpIIa4rVuY4gfjEMjPM3uRprE2bqg7iDU/6KLNiHrm8WRR
NXqwmI63arEoRBzEomQpZGbCUWKIaVfNLlWauYJWk/SH1QbHw/PRsNDFad/6unnM4zbgy4Yz
SQPEclfAHMjJzPqyAGp45FId6+PXrzVjm0+Mu4TGrpyViitLEmDU9Gjz8es7Xk47fX+77gGd
bmIse4xgWWAad3FDxoooiGoyu8en/ZNWldUBJByiEWQVJzeWAyONOFOm9eLqE6f1w5k72BGj
UEDYGiAJm6gZRZq3zLl7eaku5XEcllXP0+/ImXAhACgE0knWhEwBZVIlFYZ5zWH1FFm9K1F4
DC91hl1yydRqlwonSwa0YVBRni7MkgLqptJLgbwxfeKbdJtcJo5Z464OE5G0LqPVlzMSUg40
3XOswJd2LizFMCMxsLmauWTJ02jWJIKFXMMxDoBYIQCA4FqzgIohq2FZg0TNpz3SWFhELFFJ
nctCGhLYEsYClWCGYtksRtEdBSFLMzwZmfgXtlVXqaZvvceGhA4WLlBCwvqNG8vcTLt2pZSO
u8PL7/fliEPD0kOXMDAU6OtA19Hsra9b1I5MfoAtbtqxcL04tuhq1m49xHhCSSTSj8e73cD0
eOHxG+OABzXxiEWWR+qgwRTwQGES8A1xUbelPBO8Pfj0B3gb2MgsDqkrwqiN3eBgaslysjkm
RijVI21KYGM0sgELIeYSeFAfTfZ3QPVgs3X0wXEvl9VZUzMLfoZcDWqoqmgYSqyU52Be3zyT
B4gOyE0d3bxPb7LxwK2t5WXpyFQr20rks54sTAGXsd2UrmZtMm0C51owIabYWjTUxLl2w1ri
bt2nVK7jrO7hKMbYqJbSQ6FDULKVAq0YdhQnvHeBjjgDhpXrng9qMvmxUQOJQh4dED33Hl9O
BmC5Fs22Da593lDOBkasrn3T3nPH1qZlnBA81R9YJsIRcLZR8vZzAdjSfD4YKa1NZ3lgCD0Q
nBclFHr5yYaB7bghkFVnZzGmwTcAp2u3MOGCVJL4Q4cO4fZRGiNSnqbgZe+E4ySdxsQOXXBe
m84gq3N+nVwKIRljWaNPgDfH48q3OmF7ySqZJO7QECKCb4gaRU6g6Cw3ZFiuvMqRheBPVqB6
Nl8z5j3tjJDs8zgB7Gb6cjkzDS5pHJ6IABsa8gbzQWHZW9V0poC6VC8SEzQyyMsh5GPbmjn5
p4mmPWgT67BB189uxD6TgcYAaE0OXKWSqZ2VaWiUdL1qVhcrdnqqcXsBL8ROe0/W91snNPaO
JtKsyYDfAtHcXI1l6joKalIYiXXlsMiPY8Lw1ykPNOHJOcJmeCSAFcWhjJcM+JNaVfCAkgA8
BQjlkAO2+xB741C6qF3swc+vMZ8GXNaGsibDKsEk+bOiGJdHE4/T037MgcgJAJBTLRSFjBdF
G4NY1jATFJYpwgl4MuXCMZGXob2BjRBKuXIaMnBVuBkKdni7rPalonqq2C5pxwURZ5mewEDz
r37CiyuHz+zTQh5bwO3QGZxokQ+Apu2mqjNJHQ4QLPyFQt5WFJoJn04WVstiEhiEMAsg3geM
Rp2TlYIiIDB+k/DA5l4H7YGuAxEOTxudXDOge8lEGehSHIMAxDpu6dfI01UaTlxBe8dXOYtU
IGwTBM5U2pHDGh9oTOgJYOW+DzsXob6Noh61CxslpGEkLSmRgoREh00r1Qt0BQsbKFlKJ7pv
DU2m5gHBgVHBSTYYjIKqhAPPwOfg0bdI6z0q9pgwkO7HlPfMC9c8KLqRtLy8qVKjwJdSQSQJ
EulL2PHe8CbGhOuCO5b+Q2QE9aBio6wVewBxNJplcTA8DuENIZl8gA0JoiTQKBbnaau4vJLm
ViFoOcMsbVa/8EAx60lTHhW4NqOQlmxBVMINEGuOg5nu7LmodwZcCnbETA04OoPBiHih1gbu
LgNjswc+zx7hTytFHSVWrsRHPhT9FBRt3VjK7+VgwuloiryLjXaJdwoDmmAl2gCSXqJ8JxKP
R1GziJFH4Mz/qYREjrUoC20tChucyPyHHHvAmTwcTk5jQZeO/H1HBtZx9stL5VhenRyzLHMS
kDUEAtalMaptBDEvLS/LAq7THE8M7D6ruKGOCiV8qZCmBcZIhRk3Vw4EmVKBUVTDBVkjODNz
pxuSiZm4RpgxrdcOQdYA6QlxB6QR+u4hawy+EI06y695i0QTMAq+DxHjAbFVbabMUDI2j6JC
dKazgHZWs47uUWDK0CZOIbkkIBrMxsJvFov/HZ4XM4iB9Grs58zkgXQHI4Q4bDUcjeoBzBMS
f+AHKiSE3pTkHIoY+IsDDsO+NghMyDJN9KmiwDwLGwxc5bj9lOEMYqUzUq9ih2EgiRVBVIsi
wVWEQYLCDEJBkIJuNSJptIBe+KlMtKFpUaCYmAeROj0pKlixcdoZEEhBXJIAD6ci4Z+4FX7L
hciPGBgc1PGEi2hPdTR4Ku7iqb/enTcdmRtnWah1HDdus6pIVmsVMFDuhFkEkJ/6kTmLYEh+
EpP/xdyRThQkDK4yk8A=

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="firmware-class-sample-driver.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWZT55ncAAyXfgH4we//+/3/v346////6UAWe5ltsmDVZhQAohJImjQmmUyan
iT1NDTRkyD0gPUMBA8oGnmlDQOaNGhphANMCaaAMhoYgDRiNDBGQASmiBQnpTamn6o02EJp6
gGjQAGmgADQNBkOaNGhphANMCaaAMhoYgDRiNDBGQASJI0mCaaZCap5kyppo9TT1GgaaAaPU
BoDTQNNNFSYjcQgyQNoGhtoX1jSIBppgtgY/A1eMOi3IU9vFwxQwpGK0L4J1tImLuO5REp6C
AgS1HDlbrwYcD0dpFsMVbs60So7WSEsTNZ5NgLr88l5IvsJGfZvCqTneVOw0jeRykwqVW6or
qZUyOO2WY8XRw6eKgnDQUu81l8aPjHtVK007QJNUYPweiTl1wB6jx5lGAVLipAqrC84IMRwk
NxKe3irgacolOV2zTv+6ZXVFcQrtPLwRVi2eqzQecrnOzOInlPCk88sjOrf3ipa5nVVumoJJ
2x3ahTX+AzbWzxfm+LPcde8HWns1GOM49MzPTPoGM0QhKy1Sxt73WC5uZRQEVz3Za4HonahY
m1pSonA1emSvbJWUQUbHZRRsOjLP3BYNjaF8Qkg2MQ3CrhITzshrdhAX8iKVrvy9n1i68lR9
PZ/wWxiwWrTgDevDGa+49CaNcBwNIY9NBO4JsQacO5pNXdo1+TZg4CIobN6pCnJ5I1LUySnA
PFqxaJn89AP6Ot17EbjCpJ4ZHbqINxbfS8OFMszBusRYpDk5HBzFmUMYZiG/4l+FpWdalrFo
TLjct7SbauUrmbVIuZfZVaQqCK+CrUFQ9QU6pMhccS1rqUy08oYJdlbCtJmodlrW89SWUwC6
rStdjArZQlWJWKhI2o2KZQCW5VaTVp9KxWJ67nQO93BzwY3zbhJrbLiWEVgbCcD5KFcTD7Rn
zoYB3IebJcGR3JqCQaZUsSUT9yk2g0Il/uFXB8aqPTUAD8qJgEfwI1hGBjNQFyosPKEYIPLB
yfd5A1jaWttsoJyBtEmlKcFingj5QtvGjct6VGi7UOGyVjkXXJyJAtIiwFrjidnTCC++48ky
YBMLm2jHlyaM09aHQiAfUzyqEkzxDRDDlHqQOciE46cE7ClUzhKt0OdYpJBSxVUogBgqBkc1
HWW0BWKiwHbkRqRfukiw5gmwtPMG3jtpDJLZvR+x489czSGaDsYvJmGs6zjsIMGYBiqFIUQx
VNMXOOLk2iA7QJYOgPqntof+uJW8C4oCx1BdBadiOagyMxJ3303jygSnmnegEOAa14NzjOdQ
6BGNsxZ37Wr79CKOJMhXh1Pp0I0swVwEdaCswsR8rbEl3ptvqWzX4JQ4bGrQRbklolcBjNZ1
6OHSD4v149iACGhsRRQr+WkPRDVhI3qyViuFbgbr5wdFnI19pMAMxINT0a/MgpypVf4hMWOk
hUgxK8yLZJjBjGTgCbaGgr1G17UWIHv4rhXzBblVYWnQKWpms8NVyDDgQQXYlyMAAxuVdPqA
SzAwrRtNkRENgnVCJDYmxAbKsqzKXIZIKy4DaCIqEgtC0KUHXYqKEE2sAKpvW14ik7aw9BZp
yBcAjF4jiITbayRMvX0RQcMFAe8eMg1NYD0mdbLRimjmBZUF4Nwsr0fYRacCkbDyObQwkWun
IrNVNMJ2szFhAWKSGWiWicwKN5VdJA6iLq1CKxZ1K4XpR3wjRwV66rld4cAwspXp1IK8QRRi
ANLpRchaTkjBpDYkU7kFSUsaXYcs0ZIvA2HiLt6Uk0mv+LuSKcKEhKfPM7g=

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="class-casts+release.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWSsZv5UAAhVfgAowSX//+14hCxq////6UAM7bPHbuAAwyk0gZAYjQNAxADQA
PKAANFTyniahkyMQAAAAAAAA00EhJ5QDTamTT1DQDJoBo0zU0AHMAmAmRgBGJiYTCYIaYmmA
VJIKbSPSaGEU/RGU0DamTRo9QNoQep6j7ATKsUlirDAPAdpB7rTE1s4DHcxFlvf1KOdUK1c6
UsEf5Bk1sBG0OrJZGg33zWgxRYoRAEYgujdFMhOEMDe+yGUCwDhjjhbNkCQwxFA9N4mpTT9E
IQ5TSWEkVnlTf9yeBhAVGmDgVceEyK8neSS9CYpm1LURrGmHmAoFgsswCh6wwfbIj7hWtBMl
VtcQxLzpzXFRSiddMxtSpZFIx0unL2fTT29lrYmDiaOiUqVNM9SU8iV3JXOxmq6anaxtykwM
xeTomxS4vFHGV8apSqqqo9aGhKT3JZNqXJYOgtBXkFNsmFqQpKTCXlEuNIBOAngUhhgnFNUC
QA0Q4cOihK6QEe44nEpFQUUG6G51EGVQZxUEzKuVWe+gIBcLoeLozABIFsBUR5KXJCVlK+fQ
zdq53j9ve9fsm6PfFYQlTK2spxKstf7fBzUeC9PiT+gaWCYzvquFilT3k1RLp8490oqiO7xz
wcRWzKW2cVXLvkqWqS/+DwlxlPIOROa/R34SfNdIaiowfZLFw4cM93wqlV/t3HUxjHFiuUqq
qhemcl0cVOzz4Jf6Ji0yYmg0rC5ekn3zW6PGdhruNzmWTsHOzv5IyuTODTGzq5ZloTabGlXk
nUc5cGzu0E190THu9NWTMG5MpcTUXybUw0m6Q30bSg3p2+TVUpR0nVHIWYuRN2zzbc2e9zMl
Kk1yxZg0/9yVzWcGMYpwJkyReHozztaNoxsida3KhrZ4dl4Or5KldGN3U57dbGl66pji6Y66
SZLHGmceplglTfVYNgUF4bWnr2B6ZPPt49s410nKGmJw+gloN7RL+cL40Nbix3oShT/F3JFO
FCQKxm/lQA==

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="sysfs-bin-flexible-size.diff.bz2"
Content-Transfer-Encoding: quoted-printable

BZh91AY&SYV=86=B3N=00=01=BF=DF=80=020`=7F=FF=BFo=AF=DF=10=BF=EF=DF=FA@=02=
=BC=03 =00=E6=04=C4=D0a2d=C9=91=84=C14=D3#=13=00C=00=D4=06=88@=0D=1A=1A=00=
=00=00=00=00=00=E6=04=C4=D0a2d=C9=91=84=C14=D3#=13=00C=00T=92=13@=D1O*x=99=
=3DI=E4=9BP=C9=93&!=8D&ji=E9=1BML=9A=0C)=A9=82=E2=E2=CB=95w=B1e=94U=F7=DC]k=
=AA=ADK=97)K=AERZ=D6=B8=AB4=CF=0D\=B5sE=96=9C=D7N=EA=AA=8C=12=9D=CA=B2=A64j=
=B8=B4b=ADX=E1}=F5=91&jS=DD!=CE=ECN=C6=E7>=9A=E8=EA3=EF4O_M=9D?5=A9=E2=D3=
=F4=DA=A6=DAN=A6=B5=91z=94=C1=D3=F9q=F6=1E6=D6=C5=8E=05%=AC=A2=B8t{/d=C32=
=B0/=BD=BE=C6q=99=E0p=D6=F1=D6=B7=12=D2s|m"=E7=85=9F=BF=98=F4.=BE=E2=B6=AC=
=A7=B2=95=F8=B42=88=A4=FB=A9V=B2h=C7=C0=FB2=E1r=96=95=AD=E2=F3=F3=F9=DF=AED=
=E1=B0=AB[=A1]=1Fb=AD;=D3e=A65=9BLs=98=9BO=EFB=ACw=8D=9A=07=02C=80=E3=10@[=
=E1C=04P=B6=98JeE=A1=A9Z=90Mb=80@=80=12J;=08=CAm=94<=12=EB=C4"=00=B5=12=DD=
=078b=1F=92O:=A8M=00#Bc=9C,*X=A2=9B-=ED=F8/fq'=A5RM=15#q=E6=16>=F3=AA?=97=
=96=F8=F9F/3e=BA=9E=F8=DC=A7=B63=BDQ=D6=C1=F2W=C7=CB=F2]=96w=AE=9B=97=BA=F4=
=C7=EC=C9=F1=EB=8EF1=CD=3Do=A7=8Dg=FA=F7=BB?	=8D=EFt=ED=9C_=E1=CAr]R=BDF=A7=
=BA=E3=F8=150=89=D5=CB;oy;=8D=D5#=8E|$=DD|=DBg#=D2QF=CB=E4=9EO=AC=86=13"=91=
m=E9rQ=19=9E=8D=ED=CCCI=C6X=D0=C4=BE=A45=EB`}NV=0D=C6=062MK=B4K=15=C6=B9=99=
=D7=A7k=B5=CC=D5=1A=12=F8=DF$=B2=A1=C1c=8D5>=A5<=06=D2=8A=1A=1D=B1=B0=B6=B7=
=CC=B8N=C9=B0=C9T5=EC=B1=CB=AF|dTb=EE=EE=99=E3=89=B7N=A5=C4=97=8E=92=B4=93S=
=2E=06s=9DJ=89=B5B=D2=AA=9C=B3=BFS=BC`=CB=05=F9=A3=93=821=13=9F=18=CEkd=C7I=
=AAa=B0=D5=B9=BC=E0f=92hq=AB=FF=17rE8P=90V=86=B3N
--OgqxwSJOaUobr8KG
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

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="sysfs-bin-lost-dget.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWXU+4F4AAIJfgAIwYH//uk4BSQCv595qMAE1tsQ0JqjQe1TQ0aaZHqBoADQe
oNTTJTJ4ptQ0D0EBpoABoCUKR6U/KeptUz1BlDIxGRkegjeqYAl8huDA8iRDJf11sRRUaTvY
HrXMpXBUkBV7R1ksdNj5qD885YujXCmfRyOSnUGGZkQsQcTVWqiYGhLMHB6qzbT3oC1YVwar
giDgtdfgF7gRDf8jDxTgMYgYsgEpeZkAwWhDNUJOJhoBht54dL4wtbNPSqJQk3hKNaC2fjqy
wsnA+wuhs6kUV2hZdIf8bARVkb+F+8qLzKtsPWafi2BwBiFhiRvAhSg0xVeHegPmOCZO4ljV
LVELb60qDC9E/mB7xYOgEJtFSqjwiDk0ASLwllBXPiacsnalSuErrLXBEK6ZExhGf8XckU4U
JB1PuBeA

--OgqxwSJOaUobr8KG--
