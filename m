Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUFAWRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUFAWRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUFAWRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:17:45 -0400
Received: from homepage-center.de ([216.121.32.142]:24849 "EHLO
	homepage-center.de") by vger.kernel.org with ESMTP id S265255AbUFAWRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:17:31 -0400
Message-ID: <011701c44826$8f79d560$0600a8c0@blackbox>
From: "Christian Gmeiner" <christian@visual-page.de>
To: <linux-kernel@vger.kernel.org>
Subject: Coding problem with sysfs
Date: Wed, 2 Jun 2004 00:19:04 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0114_01C44837.363DFDD0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0114_01C44837.363DFDD0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Mailling list.

i have tried to wirte a sysfs patch for the dvb-driver. It seems very nice,
but i am _not_ able
to access and work with the devices.

Now i have run some tests:

1. Only register the adapter, the other functions are commented out

vdr root # ls -R /sys/class/dvb
/sys/class/dvb:
adapter0

/sys/class/dvb/adapter0:
frontend  name

And i can access the infos:
vdr root # cat /sys/class/dvb/adapter0/frontend
STV0299/TSA5059/SL1935 based
vdr root # cat /sys/class/dvb/adapter0/name
KNC1 DVB-S

Looks nice....

2. Enabled full sysfs support

vdr root # ls -R /sys/class/dvb
/sys/class/dvb:
adapter0

/sys/class/dvb/adapter0:
demux0  dvr0  frontend  frontend0  name  net0

/sys/class/dvb/adapter0/demux0:
adap  dev

/sys/class/dvb/adapter0/dvr0:
adap  dev

/sys/class/dvb/adapter0/frontend0:
adap  dev

/sys/class/dvb/adapter0/net0:
adap  dev


vdr root # ls -Rl /dev/dvb
/dev/dvb:
total 0
drwxr-xr-x  2 root root 0 Jun  1 00:10 adapter0

/dev/dvb/adapter0:
total 0
crw-rw----  1 root video 250, 7 Jun  1 00:10 adapter0
crw-rw----  1 root video 250, 4 Jun  1 00:10 demux0
crw-rw----  1 root video 250, 5 Jun  1 00:10 dvr0
crw-rw----  1 root video 250, 3 Jun  1 00:10 frontend0
crw-rw----  1 root video 250, 7 Jun  1 00:10 net0


Ok... /dev/dvb/adapter0/adapter0 shouldn't exist and i have an other problem

vdr root # ls /dev/dvb/adapter0/frontend0
/dev/dvb/adapter0/frontend0
vdr root # cat /dev/dvb/adapter0/frontend0
cat: /dev/dvb/adapter0/frontend0: No such device or address


If i am using devfs i get here:

vdr root # cat /dev/dvb/adapter0/frontend0
cat: /dev/dvb/adapter0/frontend0: invalid arguments

Maybe somebody can help me.
Atteched are the needed sysfs files.

Thanks,
Christian Gmeiner

------=_NextPart_000_0114_01C44837.363DFDD0
Content-Type: application/octet-stream;
	name="dvbdev.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dvbdev.h"

/* =0A=
 * dvbdev.h=0A=
 *=0A=
 * Copyright (C) 2000 Ralph Metzler & Marcus Metzler=0A=
 *                    for convergence integrated media GmbH=0A=
 * Copyright (C) 2004 Christian Gmeiner <christian@visual-page.de>=0A=
 *=0A=
 * This program is free software; you can redistribute it and/or=0A=
 * modify it under the terms of the GNU General Lesser Public License=0A=
 * as published by the Free Software Foundation; either version 2.1=0A=
 * of the License, or (at your option) any later version.=0A=
 *=0A=
 * This program is distributed in the hope that it will be useful,=0A=
 * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
 * GNU General Public License for more details.=0A=
 *=0A=
 * You should have received a copy of the GNU Lesser General Public =
License=0A=
 * along with this program; if not, write to the Free Software=0A=
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  =
02111-1307, USA.=0A=
 *=0A=
 */=0A=
=0A=
#ifndef _DVBDEV_H_=0A=
#define _DVBDEV_H_=0A=
=0A=
#include <linux/types.h>=0A=
#include <linux/fs.h>=0A=
#include <linux/poll.h>=0A=
#include <linux/device.h>=0A=
=0A=
#define DVB_MAJOR 250=0A=
=0A=
#define DVB_DEVICE_VIDEO      0=0A=
#define DVB_DEVICE_AUDIO      1=0A=
#define DVB_DEVICE_SEC        2=0A=
#define DVB_DEVICE_FRONTEND   3=0A=
#define DVB_DEVICE_DEMUX      4=0A=
#define DVB_DEVICE_DVR        5=0A=
#define DVB_DEVICE_CA         6=0A=
#define DVB_DEVICE_NET        7=0A=
#define DVB_DEVICE_OSD        8=0A=
=0A=
=0A=
struct dvb_adapter {=0A=
	int num;=0A=
	struct list_head list_head;=0A=
	struct list_head device_list;=0A=
	const char *name;=0A=
	char frontend[64];=0A=
	u8 proposed_mac [6];=0A=
=0A=
	struct module *module;=0A=
=0A=
	// SysFs=0A=
	struct class_device class_dev;=0A=
};=0A=
=0A=
=0A=
struct dvb_device {=0A=
	struct list_head list_head;=0A=
	struct file_operations *fops;=0A=
	struct dvb_adapter *adapter;=0A=
	int type;=0A=
	u32 id;=0A=
=0A=
	/* in theory, 'users' can vanish now,=0A=
	   but I don't want to change too much now... */=0A=
	int readers;=0A=
	int writers;=0A=
	int users;=0A=
=0A=
        /* don't really need those !? -- FIXME: use video_usercopy  */=0A=
        int (*kernel_ioctl)(struct inode *inode, struct file *file,=0A=
			    unsigned int cmd, void *arg);=0A=
=0A=
	void *priv;=0A=
=0A=
	// SysFs=0A=
	struct class_device class_dev;=0A=
};=0A=
=0A=
#include "dvb_registration.h"=0A=
=0A=
// generic functions=0A=
extern int dvb_generic_open (struct inode *inode, struct file *file);=0A=
extern int dvb_generic_release (struct inode *inode, struct file *file);=0A=
extern int dvb_generic_ioctl (struct inode *inode, struct file *file,=0A=
			      unsigned int cmd, unsigned long arg);=0A=
=0A=
#endif /* _DVBDEV_H_ */=0A=

------=_NextPart_000_0114_01C44837.363DFDD0
Content-Type: application/octet-stream;
	name="dvb_sysfs.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dvb_sysfs.c"

/*=0A=
*=0A=
* dvb_sysfs.c -- interface to the sysfs filesystem=0A=
* Copyright (C) 2004 Christian Gmeiner <christian@visual-page.de>=0A=
* Copyright (C) 2004 Eric Donohue <epd3j@hotmail.com>=0A=
*=0A=
*  This program is free software; you can redistribute it and/or=0A=
*  modify it under the terms of the GNU General Public License=0A=
*  as published by the Free Software Foundation; either version 2=0A=
*  of the License, or (at your option) any later version.=0A=
*=0A=
*  This program is distributed in the hope that it will be useful,=0A=
*  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
*  GNU General Public License for more details.=0A=
*=0A=
*  You should have received a copy of the GNU General Public License=0A=
*  along with this program; if not, write to the Free Software=0A=
*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  =
02111-1307, USA.=0A=
*/=0A=
=0A=
#include <linux/version.h>=0A=
=0A=
#include "dvb_sysfs.h"=0A=
=0A=
#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,5,46)=0A=
=0A=
#ifndef DVB_SYSFS_DIR=0A=
#define DVB_SYSFS_DIR "dvb"	//-> /sys/class/dvb/...=0A=
#endif=0A=
=0A=
static struct class dvb_class =3D {=0A=
	.name =3D DVB_SYSFS_DIR=0A=
};=0A=
=0A=
static ssize_t show_name(struct class_device *cd, char *buf)=0A=
{=0A=
	struct dvb_adapter *adap =3D container_of(cd, struct dvb_adapter, =
class_dev);=0A=
	sprintf(buf, "%s\n", adap->name);=0A=
	return strlen(buf) + 1;=0A=
}=0A=
=0A=
static CLASS_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);=0A=
=0A=
static ssize_t show_frontend(struct class_device *cd, char *buf)=0A=
{=0A=
	struct dvb_adapter *adap =3D container_of(cd, struct dvb_adapter, =
class_dev);=0A=
	sprintf(buf, "%s\n", adap->frontend);=0A=
	return strlen(buf) + 1;=0A=
}=0A=
=0A=
static CLASS_DEVICE_ATTR(frontend, S_IRUGO, show_frontend, NULL);=0A=
=0A=
static ssize_t show_devnum(struct class_device *cd, char *buf)=0A=
{=0A=
	struct dvb_device *dvbdev =3D container_of(cd, struct dvb_device, =
class_dev);=0A=
=0A=
	dev_t dev =3D MKDEV(DVB_MAJOR, nums2minor(dvbdev->adapter->num, =
dvbdev->type, dvbdev->id));=0A=
	return print_dev_t(buf, dev);=0A=
}=0A=
=0A=
static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_devnum, NULL);=0A=
=0A=
static ssize_t show_adap(struct class_device *cd, char *buf)=0A=
{=0A=
	struct dvb_device *dvbdev =3D container_of(cd, struct dvb_device, =
class_dev);=0A=
	sprintf(buf, "adapter%d\n", dvbdev->adapter->num);=0A=
	return strlen(buf) + 1;=0A=
}=0A=
=0A=
static CLASS_DEVICE_ATTR(adap, S_IRUGO, show_adap, NULL);=0A=
=0A=
=0A=
static struct class_device_attribute *dvb_adapter_attrs[] =3D {=0A=
	&class_device_attr_name,=0A=
	&class_device_attr_frontend,=0A=
	NULL=0A=
};=0A=
=0A=
static struct class_device_attribute *dvb_device_attrs[] =3D {=0A=
	&class_device_attr_dev,=0A=
	&class_device_attr_adap,=0A=
	NULL=0A=
};=0A=
=0A=
static void dvb_sysfs_register_adapter(struct dvb_adapter *adap)=0A=
{=0A=
	char name[64] =3D "";=0A=
	int i;=0A=
=0A=
	adap->class_dev.class =3D &dvb_class;=0A=
	adap->class_dev.dev =3D NULL;=0A=
	adap->class_dev.class_data =3D adap;=0A=
=0A=
	sprintf(name,"adapter%d", adap->num);=0A=
	strcpy(adap->class_dev.class_id, name);=0A=
=0A=
	if(class_device_register(&adap->class_dev))=0A=
		printk(KERN_ERR "Unable to register dvb class device\n");=0A=
=0A=
	for(i =3D 0; dvb_adapter_attrs[i]; i++)=0A=
		class_device_create_file(&(adap->class_dev), dvb_adapter_attrs[i]);=0A=
}=0A=
=0A=
static void dvb_sysfs_unregister_adapter(struct dvb_adapter *adap)=0A=
{=0A=
	class_device_unregister(&(adap->class_dev));=0A=
}=0A=
=0A=
static void dvb_sysfs_register_device(struct dvb_device *dvbdev)=0A=
{=0A=
	int i;=0A=
	char name[64] =3D "";=0A=
	struct class_device *class_dev =3D &(dvbdev->class_dev);=0A=
=0A=
	sprintf(name,"%s%d", dnames[dvbdev->type], dvbdev->adapter->num);=0A=
=0A=
	class_dev->class =3D &dvb_class;=0A=
	class_dev->class_data =3D dvbdev;=0A=
	strcpy(class_dev->class_id, name);=0A=
=0A=
	kobject_init(&class_dev->kobj);=0A=
	strcpy(class_dev->kobj.name, name);=0A=
	class_dev->kobj.parent =3D &dvbdev->adapter->class_dev.kobj;=0A=
	class_dev->kobj.kset =3D dvbdev->adapter->class_dev.kobj.kset;=0A=
	class_dev->kobj.ktype =3D dvbdev->adapter->class_dev.kobj.ktype;=0A=
	class_dev->kobj.dentry =3D dvbdev->adapter->class_dev.kobj.dentry;=0A=
	kobject_register(&class_dev->kobj);=0A=
=0A=
	for (i =3D 0; dvb_device_attrs[i]; i++)=0A=
		class_device_create_file(class_dev, dvb_device_attrs[i]);=0A=
=0A=
}=0A=
=0A=
static void dvb_sysfs_unregister_device(struct dvb_device *dvbdev)=0A=
{=0A=
	kobject_unregister(&dvbdev->class_dev.kobj);=0A=
}=0A=
=0A=
static int dvb_sysfs_init(void)=0A=
{=0A=
	printk("DVB: Using sysfs funtions\n");=0A=
=0A=
	if (class_register(&dvb_class) !=3D 0) {=0A=
		printk("DVB: adapter class failed to register properly");=0A=
		return -1;=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static void dvb_sysfs_exit(void)=0A=
{=0A=
	class_unregister(&dvb_class);=0A=
}=0A=
=0A=
struct dvb_registrar_s dvb_sysfs_registrar =3D=0A=
{=0A=
	.register_adapter	=3D &dvb_sysfs_register_adapter,=0A=
	.unregister_adapter	=3D &dvb_sysfs_unregister_adapter,=0A=
	.register_device	=3D &dvb_sysfs_register_device,=0A=
	.unregister_device	=3D &dvb_sysfs_unregister_device,=0A=
	.dvbdev_init		=3D &dvb_sysfs_init,=0A=
	.dvbdev_exit		=3D &dvb_sysfs_exit,=0A=
};=0A=
=0A=
#else /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,5,46) */=0A=
=0A=
struct dvb_registrar_s dvb_sysfs_registrar =3D=0A=
{=0A=
	.register_adapter	=3D NULL,=0A=
	.unregister_adapter	=3D NULL,=0A=
	.register_device	=3D NULL,=0A=
	.unregister_device	=3D NULL,=0A=
	.dvbdev_init		=3D NULL,=0A=
	.dvbdev_exit		=3D NULL,=0A=
};=0A=
=0A=
#endif /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,5,46) */=0A=

------=_NextPart_000_0114_01C44837.363DFDD0--


