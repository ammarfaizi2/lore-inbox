Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbULJFCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbULJFCy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbULJFCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:02:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4582 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261700AbULJFAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:00:20 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][AGPGART]Allow multiple backends to be initialized
Date: Thu, 9 Dec 2004 21:02:01 -0800
User-Agent: KMail/1.6.2
References: <200412061740.52337.werner@sgi.com> <20041207090244.GA13591@infradead.org>
In-Reply-To: <20041207090244.GA13591@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412092102.01033.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a modified patch which is much simpler.
Please comment for further improvements.
# This is a BitKeeper generated diff -Nru style patch.
#
#   Allow multiple agpgart backends to be initialized and addressed.
# 
diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	2004-12-09 20:46:37 -08:00
+++ b/drivers/char/agp/agp.h	2004-12-09 20:46:37 -08:00
@@ -1,5 +1,6 @@
 /*
  * AGPGART
+ * Copyright (C) 2004 Silicon Graphics, Inc.
  * Copyright (C) 2002-2004 Dave Jones
  * Copyright (C) 1999 Jeff Hartmann
  * Copyright (C) 1999 Precision Insight, Inc.
@@ -139,6 +140,7 @@
 	int capndx;
 	char major_version;
 	char minor_version;
+	struct list_head list;
 };
 
 #define OUTREG64(mmap, addr, val)	__raw_writeq((val), (mmap)+(addr))
@@ -271,6 +273,7 @@
 void global_cache_flush(void);
 void get_agp_version(struct agp_bridge_data *bridge);
 unsigned long agp_generic_mask_memory(unsigned long addr, int type);
+struct agp_bridge_data *agp_generic_find_bridge(struct pci_dev *pdev);
 
 /* generic routines for agp>=3 */
 int agp3_generic_fetch_size(void);
diff -Nru a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
--- a/drivers/char/agp/backend.c	2004-12-09 20:46:37 -08:00
+++ b/drivers/char/agp/backend.c	2004-12-09 20:46:37 -08:00
@@ -1,5 +1,6 @@
 /*
  * AGPGART driver backend routines.
+ * Copyright (C) 2004 Silicon Graphics, Inc.
  * Copyright (C) 2002-2003 Dave Jones.
  * Copyright (C) 1999 Jeff Hartmann.
  * Copyright (C) 1999 Precision Insight, Inc.
@@ -42,34 +43,36 @@
  * fix some real stupidity. It's only by chance we can bump
  * past 0.99 at all due to some boolean logic error. */
 #define AGPGART_VERSION_MAJOR 0
-#define AGPGART_VERSION_MINOR 100
+#define AGPGART_VERSION_MINOR 101
 static struct agp_version agp_current_version =
 {
 	.major = AGPGART_VERSION_MAJOR,
 	.minor = AGPGART_VERSION_MINOR,
 };
 
-static int agp_count=0;
-
-struct agp_bridge_data agp_bridge_dummy = { .type = NOT_SUPPORTED };
-struct agp_bridge_data *agp_bridge = &agp_bridge_dummy;
+struct agp_bridge_data *agp_bridge;
+LIST_HEAD(agp_bridges);
+struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *) = &agp_generic_find_bridge;
 EXPORT_SYMBOL(agp_bridge);
-
+EXPORT_SYMBOL(agp_bridges);
 
 /**
- *	agp_backend_acquire  -  attempt to acquire the agp backend.
+ *	agp_backend_acquire  -  attempt to acquire an agp backend.
  *
- *	returns -EBUSY if agp is in use,
- *	returns 0 if the caller owns the agp backend
  */
-int agp_backend_acquire(void)
+struct agp_bridge_data *agp_backend_acquire(struct pci_dev *pdev)
 {
-	if (agp_bridge->type == NOT_SUPPORTED)
-		return -EINVAL;
-	if (atomic_read(&agp_bridge->agp_in_use))
-		return -EBUSY;
-	atomic_inc(&agp_bridge->agp_in_use);
-	return 0;
+	struct agp_bridge_data *bridge;
+
+	bridge = agp_find_bridge(pdev);
+
+	if (!bridge)
+		return NULL;
+	
+	if (atomic_read(&bridge->agp_in_use))
+		return NULL;
+	atomic_inc(&bridge->agp_in_use);
+	return bridge;
 }
 EXPORT_SYMBOL(agp_backend_acquire);
 
@@ -82,10 +85,11 @@
  *
  *	(Ensure that all memory it bound is unbound.)
  */
-void agp_backend_release(void)
+void agp_backend_release(struct agp_bridge_data *bridge)
 {
-	if (agp_bridge->type != NOT_SUPPORTED)
-		atomic_dec(&agp_bridge->agp_in_use);
+
+	if (bridge)
+		atomic_dec(&bridge->agp_in_use);
 }
 EXPORT_SYMBOL(agp_backend_release);
 
@@ -121,7 +125,6 @@
 	     (maxes_table[index].agp - maxes_table[index - 1].agp)) /
 	   (maxes_table[index].mem - maxes_table[index - 1].mem);
 
-	printk(KERN_INFO PFX "Maximum main memory to use for agp memory: %ldM\n", result);
 	result = result << (20 - PAGE_SHIFT);
 	return result;
 }
@@ -178,9 +181,6 @@
 		goto err_out;
 	}
 
-	printk(KERN_INFO PFX "AGP aperture is %dM @ 0x%lx\n",
-	       size_value, bridge->gart_bus_addr);
-
 	return 0;
 
 err_out:
@@ -225,16 +225,31 @@
 	&agp_copy_info
 };
 
-/* XXX Kludge alert: agpgart isn't ready for multiple bridges yet */
+/* When we remove the global variable agp_bridge from all drivers
+ * then agp_alloc_bridge and agp_generic_find_bridge need to be updated
+ */
+
 struct agp_bridge_data *agp_alloc_bridge(void)
 {
-	return agp_bridge;
+	struct agp_bridge_data *bridge = kmalloc(sizeof(*bridge), GFP_KERNEL);
+
+	if (!bridge)
+		return NULL;
+
+	if (list_empty(&agp_bridges))
+		agp_bridge = bridge;
+
+	return bridge;
 }
 EXPORT_SYMBOL(agp_alloc_bridge);
 
 
 void agp_put_bridge(struct agp_bridge_data *bridge)
 {
+        kfree(bridge);
+
+        if (list_empty(&agp_bridges))
+                agp_bridge = NULL;
 }
 EXPORT_SYMBOL(agp_put_bridge);
 
@@ -251,43 +266,41 @@
 		return -EINVAL;
 	}
 
-	if (agp_count) {
-		printk (KERN_INFO PFX
-		       "Only one agpgart device currently supported.\n");
-		return -ENODEV;
-	}
-
 	/* Grab reference on the chipset driver. */
 	if (!try_module_get(bridge->driver->owner)) {
 		printk (KERN_INFO PFX "Couldn't lock chipset driver.\n");
 		return -EINVAL;
 	}
 
-	bridge->type = SUPPORTED;
-
-	error = agp_backend_initialize(agp_bridge);
+	error = agp_backend_initialize(bridge);
 	if (error) {
 		printk (KERN_INFO PFX "agp_backend_initialize() failed.\n");
 		goto err_out;
 	}
 
-	error = agp_frontend_initialize();
-	if (error) {
-		printk (KERN_INFO PFX "agp_frontend_initialize() failed.\n");
-		goto frontend_err;
-	}
+	if (list_empty(&agp_bridges)) {
+		error = agp_frontend_initialize();
+		if (error) {
+			printk (KERN_INFO PFX "agp_frontend_initialize() failed.\n");
+			goto frontend_err;
+		}
+
+		/* FIXME: What to do with this? */
+		inter_module_register("drm_agp", THIS_MODULE, &drm_agp);
+
+		printk(KERN_INFO PFX "AGP aperture is %dM @ 0x%lx\n",
+			bridge->driver->fetch_size(), bridge->gart_bus_addr);
 
-	/* FIXME: What to do with this? */
-	inter_module_register("drm_agp", THIS_MODULE, &drm_agp);
+	}
 
-	agp_count++;
+	list_add(&bridge->list, &agp_bridges);
 	return 0;
 
 frontend_err:
-	agp_backend_cleanup(agp_bridge);
+	agp_backend_cleanup(bridge);
 err_out:
-	bridge->type = NOT_SUPPORTED;
 	module_put(bridge->driver->owner);
+	agp_put_bridge(bridge);
 	return error;
 }
 EXPORT_SYMBOL_GPL(agp_add_bridge);
@@ -295,11 +308,12 @@
 
 void agp_remove_bridge(struct agp_bridge_data *bridge)
 {
-	bridge->type = NOT_SUPPORTED;
-	agp_frontend_cleanup();
 	agp_backend_cleanup(bridge);
-	inter_module_unregister("drm_agp");
-	agp_count--;
+	list_del(&bridge->list);
+	if (list_empty(&agp_bridges)) {
+		agp_frontend_cleanup();
+		inter_module_unregister("drm_agp");
+	}
 	module_put(bridge->driver->owner);
 }
 EXPORT_SYMBOL_GPL(agp_remove_bridge);
diff -Nru a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
--- a/drivers/char/agp/frontend.c	2004-12-09 20:46:37 -08:00
+++ b/drivers/char/agp/frontend.c	2004-12-09 20:46:37 -08:00
@@ -1,5 +1,6 @@
 /*
  * AGPGART driver frontend
+ * Copyright (C) 2004 Silicon Graphics, Inc.
  * Copyright (C) 2002-2003 Dave Jones
  * Copyright (C) 1999 Jeff Hartmann
  * Copyright (C) 1999 Precision Insight, Inc.
@@ -292,14 +293,14 @@
 static void agp_free_memory_wrap(struct agp_memory *memory)
 {
 	agp_remove_from_pool(memory);
-	agp_free_memory(memory);
+	agp_free_memory(agp_bridge, memory);
 }
 
 static struct agp_memory *agp_allocate_memory_wrap(size_t pg_count, u32 type)
 {
 	struct agp_memory *memory;
 
-	memory = agp_allocate_memory(pg_count, type);
+	memory = agp_allocate_memory(agp_bridge, pg_count, type);
 	if (memory == NULL)
 		return NULL;
 
@@ -420,7 +421,7 @@
 	if (agp_fe.current_controller == controller) {
 		agp_fe.current_controller = NULL;
 		agp_fe.backend_acquired = FALSE;
-		agp_backend_release();
+		agp_backend_release(agp_bridge);
 	}
 	kfree(controller);
 	return 0;
@@ -468,7 +469,7 @@
 
 	agp_fe.current_controller = NULL;
 	agp_fe.used_by_controller = FALSE;
-	agp_backend_release();
+	agp_backend_release(agp_bridge);
 }
 
 /* 
@@ -605,7 +606,7 @@
 	if (!(test_bit(AGP_FF_IS_VALID, &priv->access_flags)))
 		goto out_eperm;
 
-	agp_copy_info(&kerninfo);
+	agp_copy_info(agp_bridge, &kerninfo);
 	size = vma->vm_end - vma->vm_start;
 	current_size = kerninfo.aper_size;
 	current_size = current_size * 0x100000;
@@ -757,7 +758,7 @@
 	struct agp_info userinfo;
 	struct agp_kern_info kerninfo;
 
-	agp_copy_info(&kerninfo);
+	agp_copy_info(agp_bridge, &kerninfo);
 
 	userinfo.version.major = kerninfo.version.major;
 	userinfo.version.minor = kerninfo.version.minor;
@@ -777,7 +778,6 @@
 
 static int agpioc_acquire_wrap(struct agp_file_private *priv)
 {
-	int ret;
 	struct agp_controller *controller;
 
 	DBG("");
@@ -788,11 +788,15 @@
 	if (agp_fe.current_controller != NULL)
 		return -EBUSY;
 
-	ret = agp_backend_acquire();
-	if (ret == 0)
-		agp_fe.backend_acquired = TRUE;
-	else
-		return ret;
+	if(!agp_bridge)
+		return -ENODEV;
+
+        if (atomic_read(&agp_bridge->agp_in_use))
+                return -EBUSY;
+
+	atomic_inc(&agp_bridge->agp_in_use);
+
+	agp_fe.backend_acquired = TRUE;
 
 	controller = agp_find_controller_by_pid(priv->my_pid);
 
@@ -803,7 +807,7 @@
 
 		if (controller == NULL) {
 			agp_fe.backend_acquired = FALSE;
-			agp_backend_release();
+			agp_backend_release(agp_bridge);
 			return -ENOMEM;
 		}
 		agp_insert_controller(controller);
@@ -830,7 +834,7 @@
 	if (copy_from_user(&mode, arg, sizeof(struct agp_setup)))
 		return -EFAULT;
 
-	agp_enable(mode.agp_mode);
+	agp_enable(agp_bridge, mode.agp_mode);
 	return 0;
 }
 
@@ -961,7 +965,7 @@
 	if (memory == NULL)
 		return -EINVAL;
 
-	return agp_bind_memory(memory, bind_info.pg_start);
+	return agp_bind_memory(agp_bridge, memory, bind_info.pg_start);
 }
 
 static int agpioc_unbind_wrap(struct agp_file_private *priv, void __user *arg)
@@ -978,7 +982,7 @@
 	if (memory == NULL)
 		return -EINVAL;
 
-	return agp_unbind_memory(memory);
+	return agp_unbind_memory(agp_bridge, memory);
 }
 
 static int agp_ioctl(struct inode *inode, struct file *file,
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	2004-12-09 20:46:37 -08:00
+++ b/drivers/char/agp/generic.c	2004-12-09 20:46:37 -08:00
@@ -1,5 +1,6 @@
 /*
  * AGPGART driver.
+ * Copyright (C) 2004 Silicon Graphics, Inc.
  * Copyright (C) 2002-2004 Dave Jones.
  * Copyright (C) 1999 Jeff Hartmann.
  * Copyright (C) 1999 Precision Insight, Inc.
@@ -112,23 +113,23 @@
  *	It is the only function that can be called when the backend is not owned
  *	by the caller.  (So it can free memory on client death.)
  */
-void agp_free_memory(struct agp_memory *curr)
+void agp_free_memory(struct agp_bridge_data *bridge, struct agp_memory *curr)
 {
 	size_t i;
 
-	if ((agp_bridge->type == NOT_SUPPORTED) || (curr == NULL))
+	if ((bridge == NULL) || (curr == NULL))
 		return;
 
 	if (curr->is_bound == TRUE)
-		agp_unbind_memory(curr);
+		agp_unbind_memory(bridge, curr);
 
 	if (curr->type != 0) {
-		agp_bridge->driver->free_by_type(curr);
+		bridge->driver->free_by_type(curr);
 		return;
 	}
 	if (curr->page_count != 0) {
 		for (i = 0; i < curr->page_count; i++) {
-			agp_bridge->driver->agp_destroy_page(phys_to_virt(curr->memory[i]));
+			bridge->driver->agp_destroy_page(phys_to_virt(curr->memory[i]));
 		}
 	}
 	agp_free_key(curr->key);
@@ -150,20 +151,20 @@
  *
  *	It returns NULL whenever memory is unavailable.
  */
-struct agp_memory *agp_allocate_memory(size_t page_count, u32 type)
+struct agp_memory *agp_allocate_memory(struct agp_bridge_data *bridge, size_t page_count, u32 type)
 {
 	int scratch_pages;
 	struct agp_memory *new;
 	size_t i;
 
-	if (agp_bridge->type == NOT_SUPPORTED)
+	if (!bridge)
 		return NULL;
 
-	if ((atomic_read(&agp_bridge->current_memory_agp) + page_count) > agp_bridge->max_memory_agp)
+	if ((atomic_read(&bridge->current_memory_agp) + page_count) > bridge->max_memory_agp)
 		return NULL;
 
 	if (type != 0) {
-		new = agp_bridge->driver->alloc_by_type(page_count, type);
+		new = bridge->driver->alloc_by_type(page_count, type);
 		return new;
 	}
 
@@ -175,14 +176,14 @@
 		return NULL;
 
 	for (i = 0; i < page_count; i++) {
-		void *addr = agp_bridge->driver->agp_alloc_page();
+		void *addr = bridge->driver->agp_alloc_page();
 
 		if (addr == NULL) {
-			agp_free_memory(new);
+			agp_free_memory(bridge, new);
 			return NULL;
 		}
 		new->memory[i] =
-			agp_bridge->driver->mask_memory(virt_to_phys(addr), type);
+			bridge->driver->mask_memory(virt_to_phys(addr), type);
 		new->page_count++;
 	}
 
@@ -196,14 +197,14 @@
 /* End - Generic routines for handling agp_memory structures */
 
 
-static int agp_return_size(void)
+static int agp_return_size(struct agp_bridge_data *bridge)
 {
 	int current_size;
 	void *temp;
 
-	temp = agp_bridge->current_size;
+	temp = bridge->current_size;
 
-	switch (agp_bridge->driver->size_type) {
+	switch (bridge->driver->size_type) {
 	case U8_APER_SIZE:
 		current_size = A_SIZE_8(temp)->size;
 		break;
@@ -275,26 +276,25 @@
  *	This function copies information about the agp bridge device and the state of
  *	the agp backend into an agp_kern_info pointer.
  */
-int agp_copy_info(struct agp_kern_info *info)
+int agp_copy_info(struct agp_bridge_data *bridge, struct agp_kern_info *info)
 {
 	memset(info, 0, sizeof(struct agp_kern_info));
-	if (!agp_bridge || agp_bridge->type == NOT_SUPPORTED ||
-	    !agp_bridge->version) {
+	if (!bridge) {
 		info->chipset = NOT_SUPPORTED;
 		return -EIO;
 	}
 
-	info->version.major = agp_bridge->version->major;
-	info->version.minor = agp_bridge->version->minor;
-	info->chipset = agp_bridge->type;
-	info->device = agp_bridge->dev;
-	info->mode = agp_bridge->mode;
-	info->aper_base = agp_bridge->gart_bus_addr;
-	info->aper_size = agp_return_size();
-	info->max_memory = agp_bridge->max_memory_agp;
-	info->current_memory = atomic_read(&agp_bridge->current_memory_agp);
-	info->cant_use_aperture = agp_bridge->driver->cant_use_aperture;
-	info->vm_ops = agp_bridge->vm_ops;
+	info->version.major = bridge->version->major;
+	info->version.minor = bridge->version->minor;
+	info->chipset = SUPPORTED;
+	info->device = bridge->dev;
+	info->mode = bridge->mode;
+	info->aper_base = bridge->gart_bus_addr;
+	info->aper_size = agp_return_size(bridge);
+	info->max_memory = bridge->max_memory_agp;
+	info->current_memory = atomic_read(&bridge->current_memory_agp);
+	info->cant_use_aperture = bridge->driver->cant_use_aperture;
+	info->vm_ops = bridge->vm_ops;
 	info->page_mask = ~0UL;
 	return 0;
 }
@@ -319,11 +319,11 @@
  *	It returns -EINVAL if the pointer == NULL.
  *	It returns -EBUSY if the area of the table requested is already in use.
  */
-int agp_bind_memory(struct agp_memory *curr, off_t pg_start)
+int agp_bind_memory(struct agp_bridge_data *bridge, struct agp_memory *curr, off_t pg_start)
 {
 	int ret_val;
 
-	if ((agp_bridge->type == NOT_SUPPORTED) || (curr == NULL))
+	if ((bridge == NULL) || (curr == NULL))
 		return -EINVAL;
 
 	if (curr->is_bound == TRUE) {
@@ -331,10 +331,10 @@
 		return -EINVAL;
 	}
 	if (curr->is_flushed == FALSE) {
-		agp_bridge->driver->cache_flush();
+		bridge->driver->cache_flush();
 		curr->is_flushed = TRUE;
 	}
-	ret_val = agp_bridge->driver->insert_memory(curr, pg_start, curr->type);
+	ret_val = bridge->driver->insert_memory(curr, pg_start, curr->type);
 
 	if (ret_val != 0)
 		return ret_val;
@@ -354,11 +354,11 @@
  * It returns -EINVAL if this piece of agp_memory is not currently bound to
  * the graphics aperture translation table or if the agp_memory pointer == NULL
  */
-int agp_unbind_memory(struct agp_memory *curr)
+int agp_unbind_memory(struct agp_bridge_data *bridge, struct agp_memory *curr)
 {
 	int ret_val;
 
-	if ((agp_bridge->type == NOT_SUPPORTED) || (curr == NULL))
+	if ((bridge == NULL) || (curr == NULL))
 		return -EINVAL;
 
 	if (curr->is_bound != TRUE) {
@@ -366,7 +366,7 @@
 		return -EINVAL;
 	}
 
-	ret_val = agp_bridge->driver->remove_memory(curr, curr->pg_start, curr->type);
+	ret_val = bridge->driver->remove_memory(curr, curr->pg_start, curr->type);
 
 	if (ret_val != 0)
 		return ret_val;
@@ -949,14 +949,25 @@
  *
  * @mode:	agp mode register value to configure with.
  */
-void agp_enable(u32 mode)
+void agp_enable(struct agp_bridge_data *bridge, u32 mode)
 {
-	if (agp_bridge->type == NOT_SUPPORTED)
+	if (!bridge)
 		return;
-	agp_bridge->driver->agp_enable(mode);
+	bridge->driver->agp_enable(mode);
 }
 EXPORT_SYMBOL(agp_enable);
 
+/* When we remove the global variable agp_bridge from all drivers 
+ * then agp_alloc_bridge and agp_generic_find_bridge need to be updated
+ */
+
+struct agp_bridge_data *agp_generic_find_bridge(struct pci_dev *pdev)
+{
+	if (list_empty(&agp_bridges))
+		return NULL;
+
+	return agp_bridge;
+}
 
 #ifdef CONFIG_SMP
 static void ipi_handler(void *null)
diff -Nru a/include/linux/agp_backend.h b/include/linux/agp_backend.h
--- a/include/linux/agp_backend.h	2004-12-09 20:46:37 -08:00
+++ b/include/linux/agp_backend.h	2004-12-09 20:46:37 -08:00
@@ -1,6 +1,7 @@
 /*
  * AGPGART backend specific includes. Not for userspace consumption.
  *
+ * Copyright (C) 2004 Silicon Graphics, Inc.
  * Copyright (C) 2002-2003 Dave Jones
  * Copyright (C) 1999 Jeff Hartmann
  * Copyright (C) 1999 Precision Insight, Inc.
@@ -87,14 +88,17 @@
 
 #define AGP_NORMAL_MEMORY 0
 
-extern void agp_free_memory(struct agp_memory *);
-extern struct agp_memory *agp_allocate_memory(size_t, u32);
-extern int agp_copy_info(struct agp_kern_info *);
-extern int agp_bind_memory(struct agp_memory *, off_t);
-extern int agp_unbind_memory(struct agp_memory *);
-extern void agp_enable(u32);
-extern int agp_backend_acquire(void);
-extern void agp_backend_release(void);
+extern struct agp_bridge_data *agp_bridge;
+extern struct list_head agp_bridges;
+
+extern void agp_free_memory(struct agp_bridge_data *, struct agp_memory *);
+extern struct agp_memory *agp_allocate_memory(struct agp_bridge_data *, size_t, u32);
+extern int agp_copy_info(struct agp_bridge_data *, struct agp_kern_info *);
+extern int agp_bind_memory(struct agp_bridge_data *, struct agp_memory *, off_t);
+extern int agp_unbind_memory(struct agp_bridge_data *, struct agp_memory *);
+extern void agp_enable(struct agp_bridge_data *, u32);
+extern struct agp_bridge_data *agp_backend_acquire(struct pci_dev *);
+extern void agp_backend_release(struct agp_bridge_data *);
 
 /*
  * Interface between drm and agp code.  When agp initializes, it makes
@@ -102,14 +106,14 @@
  * use it.  Keith Owens <kaos@ocs.com.au> 28 Oct 2000.
  */
 typedef struct {
-	void			(*free_memory)(struct agp_memory *);
-	struct agp_memory *	(*allocate_memory)(size_t, u32);
-	int			(*bind_memory)(struct agp_memory *, off_t);
-	int			(*unbind_memory)(struct agp_memory *);
-	void			(*enable)(u32);
-	int			(*acquire)(void);
-	void			(*release)(void);
-	int			(*copy_info)(struct agp_kern_info *);
+	void			(*free_memory)(struct agp_bridge_data *, struct agp_memory *);
+	struct agp_memory *	(*allocate_memory)(struct agp_bridge_data *, size_t, u32);
+	int			(*bind_memory)(struct agp_bridge_data *, struct agp_memory *, off_t);
+	int			(*unbind_memory)(struct agp_bridge_data *, struct agp_memory *);
+	void			(*enable)(struct agp_bridge_data *, u32);
+	struct agp_bridge_data *(*acquire)(struct pci_dev *);
+	void			(*release)(struct agp_bridge_data *);
+	int			(*copy_info)(struct agp_bridge_data *, struct agp_kern_info *);
 } drm_agp_t;
 
 extern const drm_agp_t *drm_agp_p;
