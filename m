Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSHQSDn>; Sat, 17 Aug 2002 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSHQSDn>; Sat, 17 Aug 2002 14:03:43 -0400
Received: from imo-d05.mx.aol.com ([205.188.157.37]:57495 "EHLO
	imo-d05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S318059AbSHQSDl>; Sat, 17 Aug 2002 14:03:41 -0400
Message-ID: <3D5E595A.7090106@netscape.net>
Date: Sat, 17 Aug 2002 14:10:34 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------060903070703000207000504"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------060903070703000207000504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



greg@kroah.com wrote:

 >
 >Um, your email client mangled the patch, dropping tabs and wrapped
 >lines.
 >
Thanks for pointing this out.  I'll send it as an attachment this time.
  My current client has been causing me a lot of trouble, is there one
you would suggest I use?

 >
 >Isn't this info already in the "name" file of a driver?
 >

I'm probably just confused but I'm not sure what you mean.  This patch 
does the following, as shown previously:

example:
#cd /driverfs/root/pci0/00:00.0
#cat driver
agpgart

 >
 >Not that I agree with this patch at all, but you might want to go read
 >Documentation/CodingStyle to fix up your brace placement properly.
 >

Ok I'll read it.

 >

Thanks,
Adam


--------------060903070703000207000504
Content-Type: text/plain;
 name="driver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driver.patch"

diff -ur --new-file a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c  Wed Aug 14 17:09:28 2002
+++ b/drivers/base/interface.c  Fri Aug 16 22:03:18 2002
@@ -88,8 +88,20 @@
 static DEVICE_ATTR(power,"power",S_IWUSR | S_IRUGO,
           device_read_power,device_write_power);
 
+
+static ssize_t device_read_driver(struct device * dev, char * buf, size_t count, loff_t off)
+{
+   if (dev->driver)
+       return off ? 0 : sprintf(buf,"%s\n",dev->driver->name);
+   else
+       return 0;
+}
+
+static DEVICE_ATTR(driver,"driver",S_IRUGO,device_read_driver,NULL);
+
 struct device_attribute * device_default_files[] = {
    &dev_attr_name,
    &dev_attr_power,
+   &dev_attr_driver,
    NULL,
 };

--------------060903070703000207000504
Content-Type: text/plain;
 name="driver2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driver2.patch"

diff -ur --new-file a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h   Fri Aug 16 12:20:18 2002
+++ b/drivers/base/base.h   Fri Aug 16 22:17:26 2002
@@ -26,3 +26,5 @@
 
 extern int driver_attach(struct device_driver * drv);
 extern void driver_detach(struct device_driver * drv);
+extern int do_driver_detach(struct device * dev, struct device_driver * drv);
+extern int do_driver_attach(struct device * dev, void * data);
diff -ur --new-file a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c   Wed Aug 14 17:09:28 2002
+++ b/drivers/base/core.c   Fri Aug 16 22:16:30 2002
@@ -98,7 +98,7 @@
 
 static void device_detach(struct device * dev)
 {
-   struct device_driver * drv; 
+   struct device_driver * drv;
 
    if (dev->driver) {
        lock_device(dev);
@@ -117,7 +117,7 @@
    }
 }
 
-static int do_driver_attach(struct device * dev, void * data)
+int do_driver_attach(struct device * dev, void * data)
 {
    struct device_driver * drv = (struct device_driver *)data;
    int error = 0;
@@ -134,7 +134,7 @@
    return bus_for_each_dev(drv->bus,drv,do_driver_attach);
 }
 
-static int do_driver_detach(struct device * dev, struct device_driver * drv)
+int do_driver_detach(struct device * dev, struct device_driver * drv)
 {
    lock_device(dev);
    if (dev->driver == drv) {
diff -ur --new-file a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c  Fri Aug 16 22:06:41 2002
+++ b/drivers/base/interface.c  Fri Aug 16 22:15:29 2002
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/stat.h>
+#include "base.h"
 
 static ssize_t device_read_name(struct device * dev, char * buf, size_t count, loff_t off)
 {
@@ -97,7 +98,44 @@
        return 0;
 }
 
-static DEVICE_ATTR(driver,"driver",S_IRUGO,device_read_driver,NULL);
+struct device_driver * find_driver_by_name(struct bus_type * bus, char * name)
+{
+   struct list_head * pos;
+   struct device_driver * drv;
+   list_for_each (pos, &bus->drivers)
+   {
+       drv = list_entry(pos, struct device_driver, bus_list);
+       if (!strncmp(drv->name,name,strlen(name) - 1))
+           return drv;
+
+   }
+   return NULL;
+
+}
+
+static ssize_t device_write_driver(struct device * dev, char * buf, size_t count, loff_t off)
+{
+   struct device_driver * drv = NULL;
+   int error = 0;
+   if (off)
+       return 0;
+   if (!dev->bus)
+       return count;
+   if (!dev->driver)
+   {
+       drv = find_driver_by_name(dev->bus, buf);
+       if (drv)
+           error = do_driver_attach(dev,drv);
+
+   } else if (!strnicmp(buf,"remove",6))
+   {
+       error = do_driver_detach(dev, dev->driver);
+   }
+   return error < 0 ? error : count;
+}
+
+static DEVICE_ATTR(driver,"driver",S_IWUSR | S_IRUGO,
+          device_read_driver,device_write_driver);
 
 struct device_attribute * device_default_files[] = {
    &dev_attr_name,

--------------060903070703000207000504--
