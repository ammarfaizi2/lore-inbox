Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTEOTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264220AbTEOTvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:51:23 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:45515 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264196AbTEOTut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:50:49 -0400
Date: Thu, 15 May 2003 22:03:24 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
Subject: request_firmware() hotplug interface, third round.
Message-ID: <20030515200324.GB12949@ranty.ddts.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi all,

 This time, as Greg suggested, it is implemented on top of 'struct
 class' and 'struct class_device' but the driver interface is the same
 as last time.
 
 Attached:
 	firmware.h
	firmware_class.c:
		The firmware support itself.
	firmware_sample_driver.c:
		Sample code on how to use from drivers.
	hotplug:
		A simple hotplug replacement for testing.
	Makefile:
		The obvious.
	README:
		Still pertinent pieces from the previous round.

 How it works:
	- Driver calls request_firmware()
	- 'hotplug firmware' gets called with ACCTION=add
	- /sysfs/class/firmware/dev_name/{data,loading} show up.
	
	- echo 1 > /sysfs/class/firmware/dev_name/loading
	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
	- echo 0 > /sysfs/class/firmware/dev_name/loading

	- The call to request_firmware() returns with the firmware in a
	  memory buffer and the driver can finish loading.
	- Driver loads the firmware.
	- Driver calls release_firmware().

 Notes:
	- Drivers can use request_firmware() or register their own
	  'firmware' class_device and implement the same interface for
	  themselfs. If this code has better acceptance I'll also
	  provide a sample of the later, and make it actually possible.
	  
 	- There is a race, the hotplug event gets generated on
	  class_device_register and before 'data' and 'loading' creation
	  takes place. Maybe the hotplug support could wait for
	  'loading' to show up.
	  
 	- register_firmware can not be implemented without some form of
	  in-kernel firmware caching. And that is not implemented.
	  
	- fwfs could be used for firmware caching behind the scene
	  allowing register_firmware to be implemented and the other
	  uses. I could call it blobfs and make a subdirectory within
	  for firmware purposes.

 Hope you like it

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--7qSK/uQB79J36Y4o
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: inline; filename="firmware.h"

#ifndef _LINUX_FIRMWARE_H
#define _LINUX_FIRMWARE_H
#include <linux/module.h>
#include <linux/types.h>
#define FIRMWARE_NAME_MAX 30 
struct firmware {
	size_t size;
	u8 *data;
};
int request_firmware (const struct firmware **fw, const char *name,
		      const char *device);
/* Maybe 'device' should be 'struct device *' */

void release_firmware (const struct firmware *fw);
void register_firmware (const char *name, const u8 *data, size_t size);
#endif

--7qSK/uQB79J36Y4o
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: inline; filename="firmware_class.c"

#include <linux/device.h>
#include <linux/module.h>
#include <linux/init.h>
#include "firmware.h"

MODULE_AUTHOR("Manuel Estrada Sainz <ranty@debian.org>");
MODULE_DESCRIPTION("Hotplug Firmware Loading Support");
MODULE_LICENSE("GPL");

#define MAX( a, b ) ( ( ( a ) > ( b ) ) ? ( a ) : ( b ) )

static inline struct class_device *to_class_dev(struct kobject *obj)
{
	return container_of(obj,struct class_device,kobj);
}
static inline
struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
{
	return container_of(_attr,struct class_device_attribute,attr);
}

int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);

struct firmware_priv {
	char fw_id[FIRMWARE_NAME_MAX];
	struct completion completion;
	struct bin_attribute attr_data;
	struct firmware *fw;
	u8 loading;
	int alloc_size; 
};

int firmware_class_hotplug(struct class_device *dev, char **envp,
			   int num_envp, char *buffer, int buffer_size);

struct class firmware_class = {
        .name           = "firmware",
	.hotplug        = firmware_class_hotplug,
};


int firmware_class_hotplug(struct class_device *class_dev, char **envp,
			   int num_envp, char *buffer, int buffer_size)
{
	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
	int i=0;
	char *scratch=buffer;

	if (buffer_size < (FIRMWARE_NAME_MAX+10))
		return -ENOMEM;

	envp [i++] = scratch;
	scratch += sprintf(scratch, "FIRMWARE=%s", fw_priv->fw_id) + 1;
	return 0;
}

ssize_t firmware_loading_show(struct class_device *class_dev, char *buf)
{
	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
	return sprintf(buf, "%d\n", fw_priv->loading);
}
static ssize_t firmware_loading_store(struct class_device *class_dev,
				      const char *buf, size_t count)
{
	int loading = simple_strtol(buf, NULL, 10);
	struct firmware_priv *fw_priv = class_get_devdata(class_dev);

	if(fw_priv->loading && !loading)
		complete(&fw_priv->completion);
	fw_priv->loading = loading;
	return count;
}
CLASS_DEVICE_ATTR(loading, 0644,
		  firmware_loading_show, firmware_loading_store);

static ssize_t firmware_data_read(struct kobject *kobj,
			   struct sysfs_bin_buffer *buffer)
{
	struct class_device *class_dev = to_class_dev(kobj);
	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
	struct firmware *fw = fw_priv->fw;

	printk("%s: size:%d count:%d offset:%lld\n", __FUNCTION__, 
	       buffer->size, buffer->count, buffer->offset);

	buffer->data = kmalloc(fw->size, GFP_KERNEL);
	if(!buffer->data)
		return -ENOMEM;
	buffer->size = fw->size;
	memcpy(buffer->data, fw->data, fw->size);
	return buffer->count;
}
static int fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
{
	u8 *new_data;

	if (min_size <= fw_priv->alloc_size)
		return 0;

	new_data = kmalloc(fw_priv->alloc_size+PAGE_SIZE, GFP_KERNEL);
	if(!new_data){
		printk(KERN_ERR "%s: unable to alloc buffer\n",
		       __FUNCTION__);
		/* Make sure that we don't keep incomplete data */
		kfree(fw_priv->fw->data);
		fw_priv->fw->data=NULL;
		fw_priv->fw->size=0;
		return -ENOMEM;
	}
	fw_priv->alloc_size += PAGE_SIZE;
	if(fw_priv->fw->data){
		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
		kfree(fw_priv->fw->data);
	}
	fw_priv->fw->data=new_data;
	BUG_ON(min_size > fw_priv->alloc_size);
	return 0;
}
static ssize_t firmware_data_write(struct kobject *kobj,
				   struct sysfs_bin_buffer *buffer)
{
	struct class_device *class_dev = to_class_dev(kobj);
	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
	struct firmware *fw = fw_priv->fw;
	int retval;

	printk("%s: size:%d count:%d offset:%lld\n", __FUNCTION__, 
	       buffer->size, buffer->count, buffer->offset);
	retval = fw_realloc_buffer(fw_priv, buffer->offset+buffer->count);
	if(retval)
		return retval;

	memcpy(fw->data+buffer->offset, buffer->data, buffer->count);

	buffer->offset += buffer->count;
	buffer->size = MAX(buffer->offset, buffer->size);
	fw->size=buffer->size;
	return buffer->count;
}
static struct bin_attribute firmware_attr_data_tmpl = {
	.attr = {.name = "data", .mode = 0644},
	.size = 0,
	.read = firmware_data_read,
	.write = firmware_data_write,
};

static int fw_setup_class_device(struct class_device *class_dev,
				 struct firmware_priv *fw_priv,
				 const char *fw_name,
				 const char *dev_name)
{
	int retval = 0;

	memset(fw_priv, 0, sizeof(*fw_priv));

	init_completion(&fw_priv->completion);
	memcpy(&fw_priv->attr_data, &firmware_attr_data_tmpl,
	       sizeof(firmware_attr_data_tmpl));

	strncpy(fw_priv->fw_id, fw_name, FIRMWARE_NAME_MAX);
	fw_priv->fw_id[FIRMWARE_NAME_MAX-1] = '\0';

	strncpy(class_dev->class_id, dev_name, BUS_ID_SIZE);
	class_dev->class_id[BUS_ID_SIZE-1] = '\0';

	class_set_devdata(class_dev, fw_priv);
	retval = class_device_register(class_dev);
	if (retval){
		printk(KERN_ERR "%s: class_device_register failed\n",
		       __FUNCTION__);
		goto out;
	}

	retval = sysfs_create_bin_file(&class_dev->kobj,
				       &fw_priv->attr_data);
	if (retval){
		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
		       __FUNCTION__);
		goto error_unreg_class_dev;
	}

	retval = class_device_create_file(class_dev,
					  &class_device_attr_loading);
	if (retval){
		printk(KERN_ERR "%s: class_device_create_file failed\n",
		       __FUNCTION__);
		goto error_remove_data;
	}

	fw_priv->fw=kmalloc(sizeof(struct firmware), GFP_KERNEL);
	if(!fw_priv->fw){
		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
		       __FUNCTION__);
		retval = -ENOMEM;
		goto error_remove_loading;
	}
	memset(fw_priv->fw, 0, sizeof(*fw_priv->fw));

	goto out;

error_remove_loading:
	class_device_remove_file(class_dev, &class_device_attr_loading);
error_remove_data:
	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
error_unreg_class_dev:
	class_device_unregister(class_dev);
out:
	return retval;
}
static void fw_remove_class_device(struct class_device *class_dev)
{
	struct firmware_priv *fw_priv = class_get_devdata(class_dev);

	class_device_remove_file(class_dev, &class_device_attr_loading);
	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
	class_device_unregister(class_dev);
}

int request_firmware (const struct firmware **firmware, const char *name,
		      const char *device)
/* Maybe 'device' should be 'struct device *' */
{
	static struct class_device class_dev = {
		.class          = &firmware_class,
	};
	struct firmware_priv fw_priv;
	int retval;

	if(!firmware){
		retval = -EINVAL;
		goto out;
	}
	*firmware=NULL;

	retval = fw_setup_class_device(&class_dev, &fw_priv,
				       name, device);
	if(retval)
		goto out;

	wait_for_completion(&fw_priv.completion);

	fw_remove_class_device(&class_dev);

	if(fw_priv.fw->size)
		*firmware = fw_priv.fw;
	else {
		retval = -ENOENT;
		kfree(fw_priv.fw->data);
		kfree(fw_priv.fw);
	}
out:
	return retval;
}
void release_firmware (const struct firmware *fw)
{
	kfree(fw->data);
	kfree(fw);
}

void register_firmware (const char *name, const u8 *data, size_t size)
{
	/* This is meaningless without firmware caching, so until we
	 * decide if firmware caching is reasonable just leave it as a
	 * noop */
}

static int __init firmware_class_init(void)
{
	int error;
        error = class_register(&firmware_class);
        if (error) {
		printk(KERN_ERR "class_register failed\n");
	}

        return error;

}
static void __exit firmware_class_exit(void)
{
	class_unregister(&firmware_class);
}
module_init(firmware_class_init);
module_exit(firmware_class_exit);

EXPORT_SYMBOL(release_firmware);
EXPORT_SYMBOL(request_firmware);
EXPORT_SYMBOL(register_firmware);
EXPORT_SYMBOL(firmware_class);

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hotplug

#!/bin/dash
sleep 1
OUTPUT=/dev/console
exec  > $OUTPUT 2> $OUTPUT

TYPE="$1"
echo "TYPE: $TYPE"
if [ "$TYPE" != "firmware" ]; then
	echo wrong param
	exit 1
fi
if [ "$ACTION" = "add" ]; then
	echo 1 > /sysfs/$DEVPATH/loading
	echo "Hi there" > /sysfs/$DEVPATH/data
	echo 0 > /sysfs/$DEVPATH/loading
	ls -lR /sysfs/$DEVPATH
fi
set

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=README


 request_firmware() hotplug interface:
 ------------------------------------

 Why:
 ---

 Today, the most extended way to use firmware in the Linux kernel is linking
 it statically in a header file. Which has political and technical issues:

  1) Some firmware is not legal to redistribute.
  2) The firmware occupies memory permanently, even though it often is just
     used once.
  3) Some people, like the Debian crowd, don't consider some firmware free
     enough and remove entire drivers (e.g.: keyspan).

 Notes:
 -----

 - Why OPTIONALLY caching the firmware in-kernel may be a good idea sometimes:
 
	- If the device that needs the firmware is needed to access the
	  filesystem. When upon some error the device has to be reset and the
	  firmware reloaded, it won't be possible to get it from userspace.
	  e.g.:
		- A diskless client with a network card that needs firmware.
		- The filesystem is stored in a disk behind an scsi device
		  that needs firmware.
	- On embedded systems (like install floppies) where there is no
	  userspace hotplug support, 'cp firmware_file /firmware/' can be
	  handy.
	  
   And the same device can be needed to access the filesystem or not depending
   on the setup, so I think that the choice on what firmware to cache should
   be left to userspace.

 - Why register_firmware()+__init can be useful:
 	- For boot devices needing firmware.
	- To make the transition easier:
		The firmware can be declared __init and register_firmware()
		called on module_init. Then the firmware is warranted to be
		there even if "firmware hotplug userspace" is not there jet or
		it doesn't jet provide the needed firmware.
		Once the firmware is widely available in userspace, it can be
		removed from the kernel. Or made optional (CONFIG_.*_FIRMWARE).

	In either case, if firmware hotplug support is there, it can move the
	firmware out of kernel memory into the real filesystem for later
	usage (like the provided hotplug scripts do).

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

# Taken from orinoco-0.13d
VERSION = 0.13d

TOPDIR = $(shell pwd)
KERNEL_VERSION = $(shell uname -r)
#KERNEL_SRC = /lib/modules/$(KERNEL_VERSION)/build
KERNEL_SRC = /storage/pub/src/kernel/bk-cvs/linux-2.5

# if Rules.make exists in the kernel tree, we assume 2.4 style modules
# if it doesn't assume 2.5 style
OLDMAKE = $(wildcard $(KERNEL_SRC)/Rules.make)

MODULES = firmware_class.o firmware_sample_driver.o

all: modules

clean:
	rm -f core *.o *~ a.out *.d
	rm -f *.s *.i userhermes bufparse
	rm -f *.ko *.mod.c .*.o.cmd

ifeq (,$(OLDMAKE))
# 2.5 style modules, get the kernel makefiles to do the work
KBUILD_VERBOSE = 0	# default

obj-m := $(MODULES)

modules:
	$(MAKE) -C $(KERNEL_SRC) SUBDIRS=$(TOPDIR) KBUILD_VERBOSE=$(KBUILD_VERBOSE) modules

install: all 
	$(MAKE) -C $(KERNEL_SRC) SUBDIRS=$(TOPDIR) KBUILD_VERBOSE=$(KBUILD_VERBOSE) modules_install

else
# 2.4 style modules
KERNEL_HEADERS = -I$(KERNEL_SRC)/include

MODULE_DIR_TOP = /lib/modules/$(KERNEL_VERSION)
MODULE_DIR_WIRELESS = $(MODULE_DIR_TOP)/kernel/drivers/net/wireless
CPPFLAGS = -D__KERNEL__ -DPCMCIA_DEBUG=1 \
	-DMODULE -DEXPORT_SYMTAB \
	$(PCMCIA_HEADERS) $(KERNEL_HEADERS)
CFLAGS = -O2 -Wall -Wstrict-prototypes -fno-common -pipe $(EXTRACFLAGS)

MODVER = $(shell if cat $(KERNEL_SRC)/include/linux/autoconf.h 2>/dev/null | \
grep -q '^[[:space:]]*\#define[[:space:]]*CONFIG_MODVERSIONS[[:space:]]*1'; \
then echo 1; else echo 0; fi)

ifeq ($(MODVER),1)
MFLAG = -DMODVERSIONS -include $(KERNEL_SRC)/include/linux/modversions.h
endif

modules: $(MODULES)

%.o: %.c
	$(CC) -MD $(CFLAGS) $(CPPFLAGS) $(MFLAG) -c $<

%.s: %.c
	$(CC) -MD $(CFLAGS) $(CPPFLAGS) -S $<

%.i: %.c
	$(CC) -MD $(CPPFLAGS) -E $< -o $@

endif

--7qSK/uQB79J36Y4o--
