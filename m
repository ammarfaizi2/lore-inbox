Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWDKAXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWDKAXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWDKAXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:23:33 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:65197 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932205AbWDKAXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:23:31 -0400
Date: Tue, 11 Apr 2006 09:20:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, mochel@linux.intel.com, len.brown@intel.com,
       linux-acpi@vger.kernel.org, haveblue@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH] memory hotplug : change phys_device to symbolic [1/2]
Message-Id: <20060411092000.62c2a5a9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060410144149.GA15186@kroah.com>
References: <20060410182052.f5c0a444.kamezawa.hiroyu@jp.fujitsu.com>
	<20060410144149.GA15186@kroah.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006 07:41:49 -0700
Greg KH <greg@kroah.com> wrote:
> mem->phys_device = kobject_get(kobj);

> kobject_put(mem->phys_device);
> mem->phys_device = NULL;
> 
> is a better way to do this.
> 

Thank you for comments. increment refcnt is sane.
This is fixed one.

Regards,
-Kame
==
Now, memory device 's sysfs entry (/sys/devices/system/memory/memoryX)
has phys_device file. Now, it contains just an integer.
But it is always 0.

The purpose of phys_device is to show relationship between memory section
and physical ram device. But to show relationship, we have to maintain
a table phys_device number <-> device.

This patch changes phys_device file to symbolic link to the device.
By this, phys_device directly points to a physical device to which it
belongs to.


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.17-rc1-mm2/drivers/base/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/drivers/base/memory.c	2006-04-10 15:48:17.000000000 +0900
+++ linux-2.6.17-rc1-mm2/drivers/base/memory.c	2006-04-11 08:48:10.000000000 +0900
@@ -252,31 +252,36 @@
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
+	if (mem->phys_device)
+		return 0;
+	ret = sysfs_create_link(&mem->sysdev.kobj, kobj, "phys_device");
+	if (ret)
+		return ret;
+	mem->phys_device = kobject_get(kobj);
+	return 0;
+}
+
+static void remove_phys_device(struct memory_block *mem)
+{
+	if (mem->phys_device) {
+		sysfs_remove_link(&mem->sysdev.kobj, "phys_device");
+		kobject_put(mem->phys_device);
+		mem->phys_device = NULL;
+	}
+}
+
 /*
  * Block size attribute stuff
  */
@@ -330,13 +335,13 @@
 #endif
 
 /*
- * Note that phys_device is optional.  It is here to allow for
- * differentiation between which *physical* devices each
- * section belongs to...
+ * kobj is a kobject of physical memory device to which this section
+ * belongs. If kobj != NULL, symbolic link to device from mem section is
+ * created
  */
 
 static int add_memory_block(unsigned long node_id, struct mem_section *section,
-		     unsigned long state, int phys_device)
+		     unsigned long state, struct kobject *kobj)
 {
 	struct memory_block *mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	int ret = 0;
@@ -346,16 +351,17 @@
 
 	mem->phys_index = __section_nr(section);
 	mem->state = state;
+	mem->phys_device = NULL;
 	init_MUTEX(&mem->state_sem);
-	mem->phys_device = phys_device;
+
 
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
@@ -391,27 +397,54 @@
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
+int remove_memory_block(unsigned long node_id, struct mem_section *section)
 {
 	struct memory_block *mem;
 
 	mem = find_memory_block(section);
 	mem_remove_simple_file(mem, phys_index);
 	mem_remove_simple_file(mem, state);
-	mem_remove_simple_file(mem, phys_device);
+	remove_phys_device(mem);
 	unregister_memory(mem, section, NULL);
 
 	return 0;
 }
 
 /*
+ * attach device's kobject to memory section.
+ * This is called after add_memory().
+ */
+int attach_device_to_memsection(u64 start_addr, u64 end_addr,
+				struct kobject *kobj)
+{
+	unsigned long pfn = start_addr >> PAGE_SHIFT;
+	unsigned long end_pfn = end_addr >> PAGE_SHIFT;
+	struct memory_block *mem;
+	int ret = 0;
+
+	for (; !ret && (pfn < end_pfn); pfn += PAGES_PER_SECTION) {
+		mem = pfn_to_memory_block(pfn);
+		if (mem)
+			ret = attach_phys_device(mem, kobj);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(attach_device_to_memsection);
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
@@ -419,7 +452,7 @@
 	if (!valid_section(section))
 		return -EINVAL;
 
-	return remove_memory_block(0, section, 0);
+	return remove_memory_block(0, section);
 }
 
 /*
Index: linux-2.6.17-rc1-mm2/include/linux/memory.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/memory.h	2006-04-10 15:48:30.000000000 +0900
+++ linux-2.6.17-rc1-mm2/include/linux/memory.h	2006-04-10 15:50:19.000000000 +0900
@@ -31,7 +31,7 @@
 	 * initialization.
 	 */
 	struct semaphore state_sem;
-	int phys_device;		/* to which fru does this belong? */
+	struct kobject *phys_device;	/* to which kobj does this belong? */
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
 	struct sys_device sysdev;
@@ -73,7 +73,9 @@
 extern int register_new_memory(struct mem_section *);
 extern int unregister_memory_section(struct mem_section *);
 extern int memory_dev_init(void);
-extern int remove_memory_block(unsigned long, struct mem_section *, int);
+extern int remove_memory_block(unsigned long, struct mem_section *);
+extern int attach_device_to_memsection(u64 start_addr, u64 end_addr,
+				      struct kobject *kobj);
 
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 


