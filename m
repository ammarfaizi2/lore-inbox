Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUEaQ0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUEaQ0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 12:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264688AbUEaQ0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 12:26:03 -0400
Received: from homepage-center.de ([216.121.32.142]:24330 "EHLO
	homepage-center.de") by vger.kernel.org with ESMTP id S264686AbUEaQZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 12:25:54 -0400
Message-ID: <008501c4472c$44596960$0600a8c0@blackbox>
From: "Christian Gmeiner" <christian@visual-page.de>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with dvb-sysfs patch
Date: Mon, 31 May 2004 18:20:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mailinglist.

I am writing a sysfs patch for the dvb driver (linuxtv.org). I get some very
nice stuff runnning:

vdr root # ls -Rl /sys/class/dvb
/sys/class/dvb:
total 0
drwxr-xr-x  6 root root 0 May 31 17:11 adapter0

/sys/class/dvb/adapter0:
total 0
drwxr-xr-x  2 root root    0 May 31 17:11 demux0
drwxr-xr-x  2 root root    0 May 31 17:11 dvr0
-r--r--r--  1 root root 4096 May 31 17:11 frontend
drwxr-xr-x  2 root root    0 May 31 17:11 frontend0
-r--r--r--  1 root root 4096 May 31 17:11 name
drwxr-xr-x  2 root root    0 May 31 17:11 net0

/sys/class/dvb/adapter0/demux0:
total 0
-r--r--r--  1 root root 4096 May 31 17:11 adap
-r--r--r--  1 root root 4096 May 31 17:11 dev

/sys/class/dvb/adapter0/dvr0:
total 0
-r--r--r--  1 root root 4096 May 31 17:11 adap
-r--r--r--  1 root root 4096 May 31 17:11 dev

/sys/class/dvb/adapter0/frontend0:
total 0
-r--r--r--  1 root root 4096 May 31 17:11 adap
-r--r--r--  1 root root 4096 May 31 17:11 dev

/sys/class/dvb/adapter0/net0:
total 0
-r--r--r--  1 root root 4096 May 31 17:11 adap
-r--r--r--  1 root root 4096 May 31 17:11 dev

vdr root # ls -Rl /dev/dvb
/dev/dvb:
total 0
drwxr-xr-x  2 root root 0 May 31 17:11 adapter0

/dev/dvb/adapter0:
total 0
crw-rw----  1 root video 250, 7 May 31 17:11 adapter0
crw-rw----  1 root video 250, 4 May 31 17:11 demux0
crw-rw----  1 root video 250, 5 May 31 17:11 dvr0
crw-rw----  1 root video 250, 3 May 31 17:11 frontend0
crw-rw----  1 root video 250, 7 May 31 17:11 net0


But it is not possible for me to acces the device:

vdr root # ls /dev/dvb/adapter0/frontend0
/dev/dvb/adapter0/frontend0
vdr root # cat /dev/dvb/adapter0/frontend0
cat: /dev/dvb/adapter0/frontend0: No such device or address

I am using a 2.6.6 Kernel.

So here are now the programming stuff:

I have written an abstract interface to support devfs, sysfs and procfs. So
i have functions to un/register
adapters and devices

#ifndef DVB_SYSFS_DIR
#define DVB_SYSFS_DIR "dvb" //-> /sys/class/dvb/...
#endif

static struct class dvb_class = {
 .name = DVB_SYSFS_DIR
};

static ssize_t show_name(struct class_device *cd, char *buf)
{
 struct dvb_adapter *adap = container_of(cd, struct dvb_adapter, class_dev);
 sprintf(buf, "%s\n", adap->name);
 return strlen(buf) + 1;
}

static CLASS_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

static ssize_t show_frontend(struct class_device *cd, char *buf)
{
 struct dvb_adapter *adap = container_of(cd, struct dvb_adapter, class_dev);
 sprintf(buf, "%s\n", adap->frontend);
 return strlen(buf) + 1;
}

static CLASS_DEVICE_ATTR(frontend, S_IRUGO, show_frontend, NULL);

static ssize_t show_devnum(struct class_device *cd, char *buf)
{
 struct dvb_device *dvbdev = container_of(cd, struct dvb_device, class_dev);

 sprintf(buf, "%d:%d\n", DVB_MAJOR, nums2minor(dvbdev->adapter->num,
dvbdev->type, dvbdev->id));
 return strlen(buf) + 1;
}

static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_devnum, NULL);

static ssize_t show_adap(struct class_device *cd, char *buf)
{
 struct dvb_device *dvbdev = container_of(cd, struct dvb_device, class_dev);
 sprintf(buf, "adapter%d\n", dvbdev->adapter->num);
 return strlen(buf) + 1;
}

static CLASS_DEVICE_ATTR(adap, S_IRUGO, show_adap, NULL);


static struct class_device_attribute *dvb_adapter_attrs[] = {
 &class_device_attr_name,
 &class_device_attr_frontend,
 NULL
};

static struct class_device_attribute *dvb_device_attrs[] = {
 &class_device_attr_dev,
 &class_device_attr_adap,
 NULL
};

static void dvb_sysfs_register_adapter(struct dvb_adapter *adap)
{
 char name[64] = "";
 int i;

 adap->class_dev.class = &dvb_class;
 adap->class_dev.dev = NULL;
 adap->class_dev.class_data = adap;

 sprintf(name,"adapter%d", adap->num);
 strcpy(adap->class_dev.class_id, name);

 if (class_device_register(&adap->class_dev))
  printk(KERN_ERR "Unable to register dvb class device\n");

 for (i = 0; dvb_adapter_attrs[i]; i++)
  class_device_create_file(&(adap->class_dev), dvb_adapter_attrs[i]);
}

static void dvb_sysfs_unregister_adapter(struct dvb_adapter *adap)
{
 class_device_unregister(&(adap->class_dev));
}

static void dvb_sysfs_register_device(struct dvb_device *dvbdev)
{
 int i;
 char name[64] = "";
 struct class_device *class_dev = &(dvbdev->class_dev);

 sprintf(name,"%s%d", dnames[dvbdev->type], dvbdev->adapter->num);

 class_dev->class = &dvb_class;
 class_dev->class_data = dvbdev;
 strcpy(class_dev->class_id, name);

 kobject_init(&class_dev->kobj);
 strcpy(class_dev->kobj.name, name);
 class_dev->kobj.parent = &dvbdev->adapter->class_dev.kobj;
 class_dev->kobj.kset = dvbdev->adapter->class_dev.kobj.kset;
 class_dev->kobj.ktype = dvbdev->adapter->class_dev.kobj.ktype;
 class_dev->kobj.dentry = dvbdev->adapter->class_dev.kobj.dentry;
 kobject_register(&class_dev->kobj);

 for (i = 0; dvb_device_attrs[i]; i++)
  class_device_create_file(class_dev, dvb_device_attrs[i]);

 printk("DVB: register device %s\n", name);
}

static void dvb_sysfs_unregister_device(struct dvb_device *dvbdev)
{
 kobject_unregister(&dvbdev->class_dev.kobj);
}

static int dvb_sysfs_init(void)
{
 printk("DVB: Using sysfs funtions2\n");

 if (class_register(&dvb_class) != 0) {
  printk("DVB: adapter class failed to register properly");
  return -1;
 }

 return 0;
}

static void dvb_sysfs_exit(void)
{
 class_unregister(&dvb_class);
}

struct dvb_registrar_s dvb_sysfs_registrar =
{
 .register_adapter = &dvb_sysfs_register_adapter,
 .unregister_adapter = &dvb_sysfs_unregister_adapter,
 .register_device = &dvb_sysfs_register_device,
 .unregister_device = &dvb_sysfs_unregister_device,
 .dvbdev_init  = &dvb_sysfs_init,
 .dvbdev_exit  = &dvb_sysfs_exit,
};


So.. how are the functions called?

register_adapter -> /sys/class/adapter0

register_devices -> /sys/class/adapter0/DEVICENAME(ID)

But why can't i access the devices?

I hope you got enough infos about my programming problem, and maybe somebody
can help me out.

Greets, Christian


