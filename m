Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWBQGng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWBQGng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 01:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWBQGnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 01:43:35 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:20962 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932511AbWBQGnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 01:43:35 -0500
Message-ID: <43F570B1.7050302@jp.fujitsu.com>
Date: Fri, 17 Feb 2006 15:44:01 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, Yasunori Goto <y-goto@jp.fujitsu.com>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: [PATCH] change memoryX->phys_device from number to symlink [1/2]
 generic func
Content-Type: multipart/mixed;
 boundary="------------090906070003020100020200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090906070003020100020200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch is from memory hotplug tree in lhms.
This patch changes memory_device's phys_device member from just a number
to symbolic link to the device. AFAIK, phys_device is not used now.

example)
$readlink /sys/devices/system/memory/memory10/phys_device
../../../../firmware/acpi/namespace/ACPI/_SB/LSB1/MEM3

This will help memory hotplug shell script.

-- Kame


--------------090906070003020100020200
Content-Type: text/x-patch;
 name="physdevice_symlink_01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="physdevice_symlink_01.patch"

struct memory_block is a struct for memory hotplug and creates sysfs
entry like this.
/sys/device/system/memory/memory10/
This struct has a member phys_device and this is just a number.
A user can read this member like this.
%cat /sys/devices/system/memory/memory10/state
0

AFAIK, there is no table to match this number and a real device.
And this is always 0 now.

This patch changes memory_block->phys_device from a number
to symbolic link to the device to which the memory block 
belongs to.
ex)
% readlink /sys/devices/system/memory/memory10/phys_device
../../../../firmware/acpi/namespace/ACPI/_SB/LSB1/MEM3

This is usefull for memory hotplug shell script and we don't
have to maintain a table phys_device_number <-> device.

A patch making acpi-memory-hotplug use this will follow this patch.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/drivers/base/memory.c
===================================================================
--- testtree.orig/drivers/base/memory.c	2006-02-17 15:07:56.000000000 +0900
+++ testtree/drivers/base/memory.c	2006-02-17 15:08:16.000000000 +0900
@@ -252,31 +252,30 @@
 	return count;
 }
 
-/*
- * phys_device is a bad name for this.  What I really want
- * is a way to differentiate between memory ranges that
- * are part of physical devices that constitute
- * a complete removable unit or fru.
- * i.e. do these ranges belong to the same physical device,
- * s.t. if I offline all of these sections I can then
- * remove the physical device?
- */
-static ssize_t show_phys_device(struct sys_device *dev, char *buf)
-{
-	struct memory_block *mem =
-		container_of(dev, struct memory_block, sysdev);
-	return sprintf(buf, "%d\n", mem->phys_device);
-}
 
 static SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
 static SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
-static SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
 
 #define mem_create_simple_file(mem, attr_name)	\
 	sysdev_create_file(&mem->sysdev, &attr_##attr_name)
 #define mem_remove_simple_file(mem, attr_name)	\
 	sysdev_remove_file(&mem->sysdev, &attr_##attr_name)
 
+static int attach_phys_device(struct memory_block *mem, struct kobject *kobj)
+{
+	int ret;
+	ret = sysfs_create_link(&mem->sysdev.kobj, kobj, "phys_device");
+	if (ret)
+		return ret;
+	mem->phys_device = kobj;
+	return 0;
+}
+
+static void remove_phys_device(struct memory_block *mem)
+{
+	sysfs_remove_link(&mem->sysdev.kobj, "phys_device");
+	mem->phys_device = NULL;
+}
 /*
  * Block size attribute stuff
  */
@@ -330,13 +329,14 @@
 #endif
 
 /*
- * Note that phys_device is optional.  It is here to allow for
- * differentiation between which *physical* devices each
+ * kobj is a kobject of physical memory device which includes the specified range
+ * It is here to allow for differentiation between which *physical* devices each
  * section belongs to...
+ * If kobj != NULL, symbolic link to device from mem_section is created.
  */
 
 static int add_memory_block(unsigned long node_id, struct mem_section *section,
-		     unsigned long state, int phys_device)
+		     unsigned long state, struct kobject *kobj)
 {
 	struct memory_block *mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	int ret = 0;
@@ -346,16 +346,16 @@
 
 	mem->phys_index = __section_nr(section);
 	mem->state = state;
+	mem->phys_device = 0;
 	init_MUTEX(&mem->state_sem);
-	mem->phys_device = phys_device;
 
 	ret = register_memory(mem, section, NULL);
 	if (!ret)
 		ret = mem_create_simple_file(mem, phys_index);
 	if (!ret)
 		ret = mem_create_simple_file(mem, state);
-	if (!ret)
-		ret = mem_create_simple_file(mem, phys_device);
+	if (!ret && kobj)
+		ret = attach_phys_device(mem, kobj);
 
 	return ret;
 }
@@ -391,27 +391,58 @@
 	return mem;
 }
 
-int remove_memory_block(unsigned long node_id, struct mem_section *section,
-		int phys_device)
+static struct memory_block *pfn_to_memory_block(unsigned long pfn)
+{
+	struct mem_section *section;
+	section = __nr_to_section(pfn_to_section_nr(pfn));
+	return find_memory_block(section);
+}
+
+
+int remove_memory_block(unsigned long node_id, struct mem_section *section)
 {
 	struct memory_block *mem;
 
 	mem = find_memory_block(section);
 	mem_remove_simple_file(mem, phys_index);
 	mem_remove_simple_file(mem, state);
-	mem_remove_simple_file(mem, phys_device);
+	if (mem->phys_device)
+		remove_phys_device(mem);
 	unregister_memory(mem, section, NULL);
 
 	return 0;
 }
 
 /*
+ * creating symbolic link from mem_section[] in specified address range
+ * to specified device. This device here is expected to be physical memory device.
+ * This symbolic link will be used to show relationship between mem_section and device.
+ */
+int attach_device_to_memsection(u64 start_addr, u64 end_addr, struct kobject *kobj)
+{
+	unsigned long pfn = start_addr >> PAGE_SHIFT;
+	unsigned long end_pfn = end_addr >> PAGE_SHIFT;
+	struct memory_block *mem;
+	int ret = 0;
+	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		mem = pfn_to_memory_block(pfn);
+		if (mem) {
+			ret = attach_phys_device(mem, kobj);
+			if (ret)
+				break;
+		}
+	}
+	return ret;
+}
+
+
+/*
  * need an interface for the VM to add new memory regions,
  * but without onlining it.
  */
 int register_new_memory(struct mem_section *section)
 {
-	return add_memory_block(0, section, MEM_OFFLINE, 0);
+	return add_memory_block(0, section, MEM_OFFLINE, NULL);
 }
 
 int unregister_memory_section(struct mem_section *section)
@@ -419,7 +450,7 @@
 	if (!valid_section(section))
 		return -EINVAL;
 
-	return remove_memory_block(0, section, 0);
+	return remove_memory_block(0, section);
 }
 
 /*
Index: testtree/include/linux/memory.h
===================================================================
--- testtree.orig/include/linux/memory.h	2006-02-17 15:07:56.000000000 +0900
+++ testtree/include/linux/memory.h	2006-02-17 15:08:16.000000000 +0900
@@ -31,7 +31,9 @@
 	 * initialization.
 	 */
 	struct semaphore state_sem;
-	int phys_device;		/* to which fru does this belong? */
+
+	/* information related to hardware */
+	struct kobject *phys_device;	/* a device includes this memory. */
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
 	struct sys_device sysdev;
@@ -73,7 +75,10 @@
 extern int register_new_memory(struct mem_section *);
 extern int unregister_memory_section(struct mem_section *);
 extern int memory_dev_init(void);
-extern int remove_memory_block(unsigned long, struct mem_section *, int);
+extern int remove_memory_block(unsigned long, struct mem_section *);
+/* creating symbolic link between memory device and memory section */
+extern int attach_device_to_memsection(u64 start_addr, u64 end_addr, struct kobject *kobj);
+
 
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 

--------------090906070003020100020200--


