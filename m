Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752084AbWCGHAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbWCGHAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWCGHAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:00:45 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2717 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752078AbWCGHAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:00:42 -0500
Date: Tue, 7 Mar 2006 16:00:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, LHMS <lhms-devel@lists.sourceforge.net>,
       ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH] naming memory hotplug's phys_device take2 [1/3] naming
 memory.
Message-Id: <20060307160004.d2d2a0c8.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currenty phys_device in memory hotplug sysfs tree is not used.

2 weeks ago, I posted changing phys_device to symlink from memory hotplug sysfs
to acpi namespace. Because I was afraid and warned that my change was harmful
for future acpi tree, I asked list. but no respose. This is 2nd trial.

For writing memory hotplug script with ACPI, kernel must export one of 
following information.
(1). name of hot-added memory.
(2). physical address range of hot-added memory.

(2) looks sane but...
Because memory section is logical entitiy and has no dependency to physical
memory layout, script using information (2) tend to be *very* complicated.
We have to do hex arithmetic in script....and there is no place to show (2).
And, considering container hotplug (NUMA node hotplug), we have to show 
which memory is beloging to which node.

This patch implements (1) and show information like this:
==
[kamezawa@casares ~]$ cat /sys/devices/system/memory/memory1/phys_device
\_SB_.LSB0.MEM0
==
here, LSB0 is a container.(in my emulation environ)
This shows "memory1 belongs to device MEM0."

This has less influence than previous symbolic link version.
Changing memory->phys_device from "int" to "string".

==
For writing hotplug script for memory hotplug / container hotplug, 
we need information of relationship between memory blocks (logical entity)
and physical ram modules.

For this purpose, memory block has phys_device member. But it is just an "int"
value and someone have to maintain relationship between int value and ram.
And....this phys_device is not used by anyone, now.

This patch changes phys_device from "int" to "char*". This allows phys_device
to show more useful information. like this
==
[kamezawa@casares ~]$ cat /sys/devices/system/memory/memory1/phys_device
\_SB_.LSB0.MEM0
==
This is an example of working with ACPI. A user can know memory configuration
based on ram module easily.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc5-mm2/include/linux/memory.h
===================================================================
--- linux-2.6.16-rc5-mm2.orig/include/linux/memory.h	2006-03-07 13:42:15.000000000 +0900
+++ linux-2.6.16-rc5-mm2/include/linux/memory.h	2006-03-07 13:42:34.000000000 +0900
@@ -31,7 +31,7 @@
 	 * initialization.
 	 */
 	struct semaphore state_sem;
-	int phys_device;		/* to which fru does this belong? */
+	char *phys_device;              /* name of physical device */
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
 	struct sys_device sysdev;
@@ -73,8 +73,8 @@
 extern int register_new_memory(struct mem_section *);
 extern int unregister_memory_section(struct mem_section *);
 extern int memory_dev_init(void);
-extern int remove_memory_block(unsigned long, struct mem_section *, int);
-
+extern int remove_memory_block(unsigned long, struct mem_section *);
+extern int memory_device_export_name(u64, u64, char *);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 
 
Index: linux-2.6.16-rc5-mm2/drivers/base/memory.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/base/memory.c	2006-03-07 13:42:09.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/base/memory.c	2006-03-07 15:13:47.000000000 +0900
@@ -265,7 +265,9 @@
 {
 	struct memory_block *mem =
 		container_of(dev, struct memory_block, sysdev);
-	return sprintf(buf, "%d\n", mem->phys_device);
+	if (!mem->phys_device)
+		return 0;
+	return sprintf(buf, "%s\n", mem->phys_device);
 }
 
 static SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
@@ -329,14 +331,9 @@
 #define memory_probe_init(...)	do {} while (0)
 #endif
 
-/*
- * Note that phys_device is optional.  It is here to allow for
- * differentiation between which *physical* devices each
- * section belongs to...
- */
 
 static int add_memory_block(unsigned long node_id, struct mem_section *section,
-		     unsigned long state, int phys_device)
+		     unsigned long state)
 {
 	struct memory_block *mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	int ret = 0;
@@ -347,7 +344,7 @@
 	mem->phys_index = __section_nr(section);
 	mem->state = state;
 	init_MUTEX(&mem->state_sem);
-	mem->phys_device = phys_device;
+	mem->phys_device = NULL;
 
 	ret = register_memory(mem, section, NULL);
 	if (!ret)
@@ -391,8 +388,44 @@
 	return mem;
 }
 
-int remove_memory_block(unsigned long node_id, struct mem_section *section,
-		int phys_device)
+static struct memory_block *pfn_to_memory_block(unsigned long pfn)
+{
+	struct mem_section *section;
+
+	section = __nr_to_section(pfn_to_section_nr(pfn));
+	return find_memory_block(section);
+}
+
+int memory_device_export_name(u64 start_addr, u64 end_addr, char *name)
+{
+	unsigned long pfn = start_addr >> PAGE_SHIFT;
+	unsigned long end_pfn = end_addr >> PAGE_SHIFT;
+	struct memory_block *mem;
+	char *copied;
+	int ret = 0;
+	int len;
+
+	len = strlen(name);
+	if  (len <= 0)
+		return len;
+
+	for (; pfn < end_pfn ; pfn += PAGES_PER_SECTION) {
+		mem = pfn_to_memory_block(pfn);
+
+		if (mem && !mem->phys_device) {
+			copied = kmalloc(len, GFP_KERNEL);
+			strcpy(copied, name);
+			if (copied)
+				mem->phys_device = copied;
+			else
+				return -ENOMEM;
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL(memory_device_export_name);
+
+int remove_memory_block(unsigned long node_id, struct mem_section *section)
 {
 	struct memory_block *mem;
 
@@ -411,7 +444,7 @@
  */
 int register_new_memory(struct mem_section *section)
 {
-	return add_memory_block(0, section, MEM_OFFLINE, 0);
+	return add_memory_block(0, section, MEM_OFFLINE);
 }
 
 int unregister_memory_section(struct mem_section *section)
@@ -419,7 +452,7 @@
 	if (!valid_section(section))
 		return -EINVAL;
 
-	return remove_memory_block(0, section, 0);
+	return remove_memory_block(0, section);
 }
 
 /*
@@ -440,7 +473,7 @@
 	for (i = 0; i < NR_MEM_SECTIONS; i++) {
 		if (!valid_section_nr(i))
 			continue;
-		add_memory_block(0, __nr_to_section(i), MEM_ONLINE, 0);
+		add_memory_block(0, __nr_to_section(i), MEM_ONLINE);
 	}
 
 	memory_probe_init();
