Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318109AbSG2A5z>; Sun, 28 Jul 2002 20:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318112AbSG2A5y>; Sun, 28 Jul 2002 20:57:54 -0400
Received: from imo-r08.mx.aol.com ([152.163.225.104]:41937 "EHLO
	imo-r08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S318109AbSG2A5r>; Sun, 28 Jul 2002 20:57:47 -0400
Message-ID: <3D445C2F.20603@netscape.net>
Date: Sun, 28 Jul 2002 21:03:43 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: mochel@osdl.org, rgooch@atnf.csiro.au
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] integrate driverfs and devfs (2.5.28)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch integrates driverfs and devfs.  A summary is as follows:
- create new interface directory and move interface.c
       * I intend to add more to this directory later
- add devfs entry list
- add devfs related functions
- create devfs interface
    This patch is intended to be as non intrusive as possible.  Therefore
it doesn't modify devfs directly but instead creates a layer above it.
This is due to the fact that if devfs was modified it would break
every driver.  Eventually we have to decide when and how to
integrate it directly,  This patch will provide the necessary
infrastructure.  Please Apply.
cheers,
Adam Belay

diff -ur --new-file a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile    Sun Jul 28 20:28:33 2002
+++ b/drivers/base/Makefile    Sat Jul 27 21:09:41 2002
@@ -1,7 +1,7 @@
 # Makefile for the Linux device tree

-obj-y        := core.o sys.o interface.o fs.o power.o bus.o \
-            driver.o
+obj-y        := core.o sys.o fs.o power.o bus.o \
+            driver.o interfaces/

 export-objs    := core.o fs.o power.o sys.o bus.o driver.o
 
diff -ur --new-file a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c    Fri Jun 21 09:15:52 2002
+++ b/drivers/base/core.c    Sun Jul 28 16:06:39 2002
@@ -199,6 +199,7 @@
     INIT_LIST_HEAD(&dev->node);
     INIT_LIST_HEAD(&dev->children);
     INIT_LIST_HEAD(&dev->g_list);
+    INIT_LIST_HEAD(&dev->devfs_handles);
     spin_lock_init(&dev->lock);
     atomic_set(&dev->refcount,2);
 
diff -ur --new-file a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c    Tue Jun  4 00:07:28 2002
+++ b/drivers/base/interface.c    Thu Jan  1 00:00:00 1970
@@ -1,103 +0,0 @@
-/*
- * drivers/base/interface.c - common driverfs interface that's exported to
- *     the world for all devices.
- * Copyright (c) 2002 Patrick Mochel
- *         2002 Open Source Development Lab
- */
-
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/stat.h>
-
-static ssize_t device_read_name(struct device * dev, char * buf, size_t 
count, loff_t off)
-{
-    return off ? 0 : sprintf(buf,"%s\n",dev->name);
-}
-
-static struct driver_file_entry device_name_entry = {
-    name:    "name",
-    mode:    S_IRUGO,
-    show:    device_read_name,
-};
-
-static ssize_t
-device_read_power(struct device * dev, char * page, size_t count, 
loff_t off)
-{
-    return off ? 0 : sprintf(page,"%d\n",dev->current_state);
-}
-
-static ssize_t
-device_write_power(struct device * dev, const char * buf, size_t count, 
loff_t off)
-{
-    char    str_command[20];
-    char    str_level[20];
-    int    num_args;
-    u32    state;
-    u32    int_level;
-    int    error = 0;
-
-    if (off)
-        return 0;
-
-    if (!dev->driver)
-        goto done;
-
-    num_args = sscanf(buf,"%10s %10s %u",str_command,str_level,&state);
-
-    error = -EINVAL;
-
-    if (!num_args)
-        goto done;
-
-    if (!strnicmp(str_command,"suspend",7)) {
-        if (num_args != 3)
-            goto done;
-        if (!strnicmp(str_level,"notify",6))
-            int_level = SUSPEND_NOTIFY;
-        else if (!strnicmp(str_level,"save",4))
-            int_level = SUSPEND_SAVE_STATE;
-        else if (!strnicmp(str_level,"disable",7))
-            int_level = SUSPEND_DISABLE;
-        else if (!strnicmp(str_level,"powerdown",8))
-            int_level = SUSPEND_POWER_DOWN;
-        else
-            goto done;
-
-        if (dev->driver->suspend)
-            error = dev->driver->suspend(dev,state,int_level);
-        else
-            error = 0;
-    } else if (!strnicmp(str_command,"resume",6)) {
-        if (num_args != 2)
-            goto done;
-
-        if (!strnicmp(str_level,"poweron",7))
-            int_level = RESUME_POWER_ON;
-        else if (!strnicmp(str_level,"restore",7))
-            int_level = RESUME_RESTORE_STATE;
-        else if (!strnicmp(str_level,"enable",6))
-            int_level = RESUME_ENABLE;
-        else
-            goto done;
-
-        if (dev->driver->resume)
-            error = dev->driver->resume(dev,int_level);
-        else
-            error = 0;
-    }
- done:
-    return error < 0 ? error : count;
-}
-
-static struct driver_file_entry device_power_entry = {
-    name:        "power",
-    mode:        S_IWUSR | S_IRUGO,
-    show:        device_read_power,
-    store:        device_write_power,
-};
-
-struct driver_file_entry * device_default_files[] = {
-    &device_name_entry,
-    &device_power_entry,
-    NULL,
-};
diff -ur --new-file a/drivers/base/interfaces/Makefile 
b/drivers/base/interfaces/Makefile
--- a/drivers/base/interfaces/Makefile    Thu Jan  1 00:00:00 1970
+++ b/drivers/base/interfaces/Makefile    Sat Jul 27 12:56:29 2002
@@ -0,0 +1,7 @@
+# Makefile for the Linux device tree
+
+obj-y        := interface.o devfs.o
+
+export-objs    := devfs.o
+
+include $(TOPDIR)/Rules.make
diff -ur --new-file a/drivers/base/interfaces/devfs.c 
b/drivers/base/interfaces/devfs.c
--- a/drivers/base/interfaces/devfs.c    Thu Jan  1 00:00:00 1970
+++ b/drivers/base/interfaces/devfs.c    Sun Jul 28 19:52:30 2002
@@ -0,0 +1,65 @@
+/*
+ * drivers/base/interfaces/dev.c - integrates devfs
+ *     into the Driver Model and exports an
+ *     interface to all devices.
+ * Copyright (c) 2002 Adam Belay (ambx1@netscape.net)
+ * 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/stat.h>
+#include <linux/module.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/slab.h>
+
+/**
+ * register_devfs_handle - registers a device handle into the driverfs
+ * @dhandle    the devfs to register
+ * @dev        the dev to register the handle under
+ */
+
+ldm_devfs_t register_devfs_handle(devfs_handle_t dhandle, struct device 
* dev)
+{
+    struct dev_handle * entry;
+    entry = kmalloc(sizeof(*entry),GFP_KERNEL);
+    entry->handle = dhandle;
+    list_add_tail(&entry->device_list,&dev->devfs_handles);
+    return entry;
+}
+
+/**
+ * register_devfs_handle - an all in one package, this is identical to
+ *                devfs_register except it includes dev
+ * @dev        the dev to register the handle under
+ */
+
+ldm_devfs_t ldm_devfs_register (devfs_handle_t dir, const char *name,
+                   unsigned int flags,
+                   unsigned int major, unsigned int minor,
+                   umode_t mode, void *ops, void *info,
+                   struct device * dev)
+{
+    return register_devfs_handle(devfs_register(dir,name,flags,major,minor,
+                            mode,ops,info),dev);
+}
+
+EXPORT_SYMBOL(register_devfs_handle);
+EXPORT_SYMBOL(ldm_devfs_register);
diff -ur --new-file a/drivers/base/interfaces/interface.c 
b/drivers/base/interfaces/interface.c
--- a/drivers/base/interfaces/interface.c    Thu Jan  1 00:00:00 1970
+++ b/drivers/base/interfaces/interface.c    Sun Jul 28 19:54:24 2002
@@ -0,0 +1,137 @@
+/*
+ * drivers/base/interfaces/interface.c - common driverfs interface 
that's exported to
+ *     the world for all devices.
+ * Copyright (c) 2002 Patrick Mochel
+ *         2002 Open Source Development Lab
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/stat.h>
+
+static ssize_t device_read_name(struct device * dev, char * buf, size_t 
count, loff_t off)
+{
+    return off ? 0 : sprintf(buf,"%s\n",dev->name);
+}
+
+static struct driver_file_entry device_name_entry = {
+    name:    "name",
+    mode:    S_IRUGO,
+    show:    device_read_name,
+};
+
+static ssize_t
+device_read_power(struct device * dev, char * page, size_t count, 
loff_t off)
+{
+    return off ? 0 : sprintf(page,"%d\n",dev->current_state);
+}
+
+static ssize_t
+device_write_power(struct device * dev, const char * buf, size_t count, 
loff_t off)
+{
+    char    str_command[20];
+    char    str_level[20];
+    int    num_args;
+    u32    state;
+    u32    int_level;
+    int    error = 0;
+
+    if (off)
+        return 0;
+
+    if (!dev->driver)
+        goto done;
+
+    num_args = sscanf(buf,"%10s %10s %u",str_command,str_level,&state);
+
+    error = -EINVAL;
+
+    if (!num_args)
+        goto done;
+
+    if (!strnicmp(str_command,"suspend",7)) {
+        if (num_args != 3)
+            goto done;
+        if (!strnicmp(str_level,"notify",6))
+            int_level = SUSPEND_NOTIFY;
+        else if (!strnicmp(str_level,"save",4))
+            int_level = SUSPEND_SAVE_STATE;
+        else if (!strnicmp(str_level,"disable",7))
+            int_level = SUSPEND_DISABLE;
+        else if (!strnicmp(str_level,"powerdown",8))
+            int_level = SUSPEND_POWER_DOWN;
+        else
+            goto done;
+
+        if (dev->driver->suspend)
+            error = dev->driver->suspend(dev,state,int_level);
+        else
+            error = 0;
+    } else if (!strnicmp(str_command,"resume",6)) {
+        if (num_args != 2)
+            goto done;
+
+        if (!strnicmp(str_level,"poweron",7))
+            int_level = RESUME_POWER_ON;
+        else if (!strnicmp(str_level,"restore",7))
+            int_level = RESUME_RESTORE_STATE;
+        else if (!strnicmp(str_level,"enable",6))
+            int_level = RESUME_ENABLE;
+        else
+            goto done;
+
+        if (dev->driver->resume)
+            error = dev->driver->resume(dev,int_level);
+        else
+            error = 0;
+    }
+ done:
+    return error < 0 ? error : count;
+}
+
+static struct driver_file_entry device_power_entry = {
+    name:        "power",
+    mode:        S_IWUSR | S_IRUGO,
+    show:        device_read_power,
+    store:        device_write_power,
+};
+
+/* device_read_devfs - Adam Belay (ambx1@netscape.net)*/
+static ssize_t device_read_devfs(struct device * dev, char * buf, 
size_t count,
+                 loff_t off)
+{
+    int offset, major, minor;
+    char * str = buf;
+    char pathbuf[64];
+    struct list_head * pos;
+    struct dev_handle * devfs;
+    if (off)
+        return 0;
+    list_for_each_prev(pos, &dev->devfs_handles)
+    {
+        devfs = list_entry(pos,struct dev_handle,device_list);
+        offset = devfs_generate_path (devfs->handle, pathbuf, sizeof 
pathbuf);
+        if (offset >= 0 && (0 == 
devfs_get_maj_min(devfs->handle,&major,&minor)))
+        {
+            str += sprintf(str,"%d,%d %s\n",major,minor,
+                        (pathbuf+offset));
+        }
+        else
+            return 0;
+    }
+    return (str - buf);
+}
+
+
+static struct driver_file_entry device_devfs_entry = {
+    name:        "dev",
+    mode:        S_IRUGO,
+    show:        device_read_devfs,
+};
+
+struct driver_file_entry * device_default_files[] = {
+    &device_name_entry,
+    &device_power_entry,
+    &device_devfs_entry,
+    NULL,
+};
diff -ur --new-file a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c    Wed Jul 24 18:37:14 2002
+++ b/drivers/block/floppy.c    Sat Jul 27 20:14:27 2002
@@ -3969,6 +3969,11 @@
     revalidate:        floppy_revalidate,
 };
 
+static struct device device_floppy = {
+    name:        "floppy",
+    bus_id:        "03?0",
+};
+
 static void __init register_devfs_entries (int drive)
 {
     int base_minor, i;
@@ -3992,10 +3997,10 @@
         char name[16];
 
         sprintf (name, "%d%s", drive, table[table_sup[UDP->cmos][i]]);
-        devfs_register (devfs_handle, name, DEVFS_FL_DEFAULT, MAJOR_NR,
+        ldm_devfs_register (devfs_handle, name, DEVFS_FL_DEFAULT, MAJOR_NR,
                 base_minor + (table_sup[UDP->cmos][i] << 2),
                 S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
-                &floppy_fops, NULL);
+                &floppy_fops, NULL, &device_floppy);
     } while (table_sup[UDP->cmos][i++]);
     }
 }
@@ -4219,10 +4224,6 @@
 
 static int have_no_fdc= -ENODEV;
 
-static struct device device_floppy = {
-    name:        "floppy",
-    bus_id:        "03?0",
-};

 int __init floppy_init(void)
 {
diff -ur --new-file a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h    Wed Jul 24 18:37:32 2002
+++ b/include/linux/device.h    Sat Jul 27 20:58:25 2002
@@ -29,12 +29,12 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/driverfs_fs.h>
+#include <linux/devfs_fs_kernel.h>

 #define DEVICE_NAME_SIZE    80
 #define DEVICE_ID_SIZE        32
 #define BUS_ID_SIZE        16
 
-
 enum {
     SUSPEND_NOTIFY,
     SUSPEND_SAVE_STATE,
@@ -120,7 +120,7 @@
 extern void put_driver(struct device_driver * drv);
 extern void remove_driver(struct device_driver * drv);
 
-extern int driver_for_each_dev(struct device_driver * drv, void * data,
+extern int driver_for_each_dev(struct device_driver * drv, void * data,
                    int (*callback)(struct device * dev, void * data));
 
 
@@ -130,6 +130,7 @@
     struct list_head bus_list;    /* node in bus's list */
     struct list_head driver_list;
     struct list_head children;
+    struct list_head devfs_handles;   /* stores devfs entries */
     struct device     * parent;
 
     char    name[DEVICE_NAME_SIZE];    /* descriptive ascii string */
@@ -159,6 +160,21 @@
 
     void    (*release)(struct device * dev);
 };
+
+struct dev_handle {
+    devfs_handle_t handle;
+    struct list_head device_list;   /* node in device's list */
+};
+
+typedef struct dev_handle * ldm_devfs_t;
+
+extern ldm_devfs_t register_devfs_handle(devfs_handle_t dhandle, struct 
device * dev);
+extern ldm_devfs_t ldm_devfs_register (devfs_handle_t dir, const char 
*name,
+                   unsigned int flags,
+                   unsigned int major, unsigned int minor,
+                   umode_t mode, void *ops, void *info,
+                   struct device * dev);
+
 
 #define to_device(d) container_of(d, struct device, dir)
 


