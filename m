Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263788AbTCUSrs>; Fri, 21 Mar 2003 13:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263787AbTCUSqk>; Fri, 21 Mar 2003 13:46:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18052
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263771AbTCUSoB>; Fri, 21 Mar 2003 13:44:01 -0500
Date: Fri, 21 Mar 2003 19:59:15 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211959.h2LJxFjB026157@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Remove i2o pci abstractions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/linux/i2o.h linux-2.5.65-ac2/include/linux/i2o.h
--- linux-2.5.65/include/linux/i2o.h	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.65-ac2/include/linux/i2o.h	2003-03-13 20:35:36.000000000 +0000
@@ -23,7 +23,7 @@
 #include <linux/i2o-dev.h>
 
 /* How many different OSM's are we allowing */
-#define MAX_I2O_MODULES		64
+#define MAX_I2O_MODULES		4
 
 /* How many OSMs can register themselves for device status updates? */
 #define I2O_MAX_MANAGERS	4
@@ -76,10 +76,16 @@
 };
 
 /*
- *	Resource data for each PCI I2O controller
+ * Each I2O controller has one of these objects
  */
-struct i2o_pci
+struct i2o_controller
 {
+	char name[16];
+	int unit;
+	int type;
+	int enabled;
+	
+	struct pci_dev *pdev;		/* PCI device */
 	int		irq;
 	int		short_req:1;	/* Use small block sizes        */
 	int		dpt:1;		/* Don't quiesce                */
@@ -88,25 +94,6 @@
 	int		mtrr_reg0;
 	int		mtrr_reg1;
 #endif
-};
-
-/*
- * Transport types supported by I2O stack
- */
-#define I2O_TYPE_PCI		0x01		/* PCI I2O controller */
-
-
-/*
- * Each I2O controller has one of these objects
- */
-struct i2o_controller
-{
-	struct pci_dev *pdev;		/* PCI device */
-
-	char name[16];
-	int unit;
-	int type;
-	int enabled;
 
 	struct notifier_block *event_notifer;	/* Events */
 	atomic_t users;
@@ -143,22 +130,6 @@
 
 	struct proc_dir_entry *proc_entry;	/* /proc dir */
 
-	union {					/* Bus information */
-		struct i2o_pci pci;
-	} bus;
-
-	/* Bus specific destructor */
-	void (*destructor)(struct i2o_controller *);
-
-	/* Bus specific attach/detach */
-	int (*bind)(struct i2o_controller *, struct i2o_device *);
-
-	/* Bus specific initiator */
-	int (*unbind)(struct i2o_controller *, struct i2o_device *);
-
-	/* Bus specific enable/disable */
-	void (*bus_enable)(struct i2o_controller *);
-	void (*bus_disable)(struct i2o_controller *);
 
 	void *page_frame;			/* Message buffers */
 	dma_addr_t page_frame_map;		/* Cache map */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/message/i2o/i2o_block.c linux-2.5.65-ac2/drivers/message/i2o/i2o_block.c
--- linux-2.5.65/drivers/message/i2o/i2o_block.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/message/i2o/i2o_block.c	2003-03-18 17:00:38.000000000 +0000
@@ -754,7 +754,7 @@
 				 * hit the fan big time. The card seems to recover but loses
 				 * the pending writes. Deeply ungood except for testing fsck
 				 */
-				if(i2ob_dev[unit].i2odev->controller->bus.pci.promise)
+				if(i2ob_dev[unit].i2odev->controller->promise)
 					panic("I2O controller firmware failed. Reboot and force a filesystem check.\n");
 			default:
 				printk(KERN_INFO "%s: Received event 0x%X we didn't register for\n"
@@ -1140,10 +1140,10 @@
 		if(d->controller->battery == 0)
 			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
 
-		if(d->controller->type == I2O_TYPE_PCI && d->controller->bus.pci.promise)
+		if(d->controller->promise)
 			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
 
-		if(d->controller->type == I2O_TYPE_PCI && d->controller->bus.pci.short_req)
+		if(d->controller->short_req)
 		{
 			blk_queue_max_sectors(q, 8);
 			blk_queue_max_phys_segments(q, 8);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/message/i2o/i2o_core.c linux-2.5.65-ac2/drivers/message/i2o/i2o_core.c
--- linux-2.5.65/drivers/message/i2o/i2o_core.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/message/i2o/i2o_core.c	2003-03-13 20:42:11.000000000 +0000
@@ -50,6 +50,9 @@
 
 #include <asm/io.h>
 #include <linux/reboot.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif // CONFIG_MTRR
 
 #include "i2o_lan.h"
 
@@ -103,6 +106,8 @@
 
 void i2o_report_controller_unit(struct i2o_controller *, struct i2o_device *);
 
+static void i2o_pci_dispose(struct i2o_controller *c);
+
 /*
  * I2O System Table.  Contains information about
  * all the IOPs in the system.  Used to inform IOPs
@@ -206,7 +211,6 @@
  */
 
 static int verbose;
-MODULE_PARM(verbose, "i");
 
 /*
  * I2O Core reply handler
@@ -549,7 +553,8 @@
 		if(__i2o_delete_device(c->devices)<0)
 		{
 			/* Shouldnt happen */
-			c->bus_disable(c);
+			I2O_IRQ_WRITE32(c, 0xFFFFFFFF);
+			c->enabled = 0;
 			up(&i2o_configuration_lock);
 			return -EBUSY;
 		}
@@ -584,7 +589,7 @@
 			i2o_reset_controller(c);
 
 			/* Release IRQ */
-			c->destructor(c);
+			i2o_pci_dispose(c);
 
 			*p=c->next;
 			up(&i2o_configuration_lock);
@@ -1651,7 +1656,7 @@
 
 	for (iop = i2o_controller_chain; iop; iop = iop->next)
 	{
-		if(iop->type != I2O_TYPE_PCI || !iop->bus.pci.dpt)
+		if(!iop->dpt)
 			i2o_quiesce_controller(iop);
 	}
 
@@ -1911,65 +1916,62 @@
 	u32 msg[12];
 	dma_addr_t sys_tbl_phys;
 	int ret;
+	struct resource *root;
 	u32 *privbuf = kmalloc(16, GFP_KERNEL);
 	if(privbuf == NULL)
 		return -ENOMEM;
 	
-	if(iop->type == I2O_TYPE_PCI)
-	{
-		struct resource *root;
 		
-		if(iop->status_block->current_mem_size < iop->status_block->desired_mem_size)
-		{
-			struct resource *res = &iop->mem_resource;
-			res->name = iop->pdev->bus->name;
-			res->flags = IORESOURCE_MEM;
-			res->start = 0;
-			res->end = 0;
-			printk("%s: requires private memory resources.\n", iop->name);
-			root = pci_find_parent_resource(iop->pdev, res);
-			if(root==NULL)
-				printk("Can't find parent resource!\n");
-			if(root && allocate_resource(root, res, 
-					iop->status_block->desired_mem_size,
-					iop->status_block->desired_mem_size,
-					iop->status_block->desired_mem_size,
-					1<<20,	/* Unspecified, so use 1Mb and play safe */
-					NULL,
-					NULL)>=0)
-			{
-				iop->mem_alloc = 1;
-				iop->status_block->current_mem_size = 1 + res->end - res->start;
-				iop->status_block->current_mem_base = res->start;
-				printk(KERN_INFO "%s: allocated %ld bytes of PCI memory at 0x%08lX.\n", 
-					iop->name, 1+res->end-res->start, res->start);
-			}
-		}
-		if(iop->status_block->current_io_size < iop->status_block->desired_io_size)
-		{
-			struct resource *res = &iop->io_resource;
-			res->name = iop->pdev->bus->name;
-			res->flags = IORESOURCE_IO;
-			res->start = 0;
-			res->end = 0;
-			printk("%s: requires private memory resources.\n", iop->name);
-			root = pci_find_parent_resource(iop->pdev, res);
-			if(root==NULL)
-				printk("Can't find parent resource!\n");
-			if(root &&  allocate_resource(root, res, 
-					iop->status_block->desired_io_size,
-					iop->status_block->desired_io_size,
-					iop->status_block->desired_io_size,
-					1<<20,	/* Unspecified, so use 1Mb and play safe */
-					NULL,
-					NULL)>=0)
-			{
-				iop->io_alloc = 1;
-				iop->status_block->current_io_size = 1 + res->end - res->start;
-				iop->status_block->current_mem_base = res->start;
-				printk(KERN_INFO "%s: allocated %ld bytes of PCI I/O at 0x%08lX.\n", 
-					iop->name, 1+res->end-res->start, res->start);
-			}
+	if(iop->status_block->current_mem_size < iop->status_block->desired_mem_size)
+	{
+		struct resource *res = &iop->mem_resource;
+		res->name = iop->pdev->bus->name;
+		res->flags = IORESOURCE_MEM;
+		res->start = 0;
+		res->end = 0;
+		printk("%s: requires private memory resources.\n", iop->name);
+		root = pci_find_parent_resource(iop->pdev, res);
+		if(root==NULL)
+			printk("Can't find parent resource!\n");
+		if(root && allocate_resource(root, res, 
+				iop->status_block->desired_mem_size,
+				iop->status_block->desired_mem_size,
+				iop->status_block->desired_mem_size,
+				1<<20,	/* Unspecified, so use 1Mb and play safe */
+				NULL,
+				NULL)>=0)
+		{
+			iop->mem_alloc = 1;
+			iop->status_block->current_mem_size = 1 + res->end - res->start;
+			iop->status_block->current_mem_base = res->start;
+			printk(KERN_INFO "%s: allocated %ld bytes of PCI memory at 0x%08lX.\n", 
+				iop->name, 1+res->end-res->start, res->start);
+		}
+	}
+	if(iop->status_block->current_io_size < iop->status_block->desired_io_size)
+	{
+		struct resource *res = &iop->io_resource;
+		res->name = iop->pdev->bus->name;
+		res->flags = IORESOURCE_IO;
+		res->start = 0;
+		res->end = 0;
+		printk("%s: requires private memory resources.\n", iop->name);
+		root = pci_find_parent_resource(iop->pdev, res);
+		if(root==NULL)
+			printk("Can't find parent resource!\n");
+		if(root &&  allocate_resource(root, res, 
+				iop->status_block->desired_io_size,
+				iop->status_block->desired_io_size,
+				iop->status_block->desired_io_size,
+				1<<20,	/* Unspecified, so use 1Mb and play safe */
+				NULL,
+				NULL)>=0)
+		{
+			iop->io_alloc = 1;
+			iop->status_block->current_io_size = 1 + res->end - res->start;
+			iop->status_block->current_mem_base = res->start;
+			printk(KERN_INFO "%s: allocated %ld bytes of PCI I/O at 0x%08lX.\n", 
+				iop->name, 1+res->end-res->start, res->start);
 		}
 	}
 	else
@@ -3427,48 +3429,256 @@
 }
 
 
-EXPORT_SYMBOL(i2o_controller_chain);
-EXPORT_SYMBOL(i2o_num_controllers);
-EXPORT_SYMBOL(i2o_find_controller);
-EXPORT_SYMBOL(i2o_unlock_controller);
-EXPORT_SYMBOL(i2o_status_get);
 
-EXPORT_SYMBOL(i2o_install_handler);
-EXPORT_SYMBOL(i2o_remove_handler);
 
-EXPORT_SYMBOL(i2o_install_controller);
-EXPORT_SYMBOL(i2o_delete_controller);
-EXPORT_SYMBOL(i2o_run_queue);
+/**
+ *	i2o_pci_dispose		-	Free bus specific resources
+ *	@c: I2O controller
+ *
+ *	Disable interrupts and then free interrupt, I/O and mtrr resources 
+ *	used by this controller. Called by the I2O core on unload.
+ */
+ 
+static void i2o_pci_dispose(struct i2o_controller *c)
+{
+	I2O_IRQ_WRITE32(c,0xFFFFFFFF);
+	if(c->irq > 0)
+		free_irq(c->irq, c);
+	iounmap(((u8 *)c->post_port)-0x40);
 
-EXPORT_SYMBOL(i2o_claim_device);
-EXPORT_SYMBOL(i2o_release_device);
-EXPORT_SYMBOL(i2o_device_notify_on);
-EXPORT_SYMBOL(i2o_device_notify_off);
+#ifdef CONFIG_MTRR
+	if(c->mtrr_reg0 > 0)
+		mtrr_del(c->mtrr_reg0, 0, 0);
+	if(c->mtrr_reg1 > 0)
+		mtrr_del(c->mtrr_reg1, 0, 0);
+#endif
+}
 
-EXPORT_SYMBOL(i2o_post_this);
-EXPORT_SYMBOL(i2o_post_wait);
-EXPORT_SYMBOL(i2o_post_wait_mem);
+/**
+ *	i2o_pci_interrupt	-	Bus specific interrupt handler
+ *	@irq: interrupt line
+ *	@dev_id: cookie
+ *
+ *	Handle an interrupt from a PCI based I2O controller. This turns out
+ *	to be rather simple. We keep the controller pointer in the cookie.
+ */
+ 
+static void i2o_pci_interrupt(int irq, void *dev_id, struct pt_regs *r)
+{
+	struct i2o_controller *c = dev_id;
+	i2o_run_queue(c);
+}	
 
-EXPORT_SYMBOL(i2o_query_scalar);
-EXPORT_SYMBOL(i2o_set_scalar);
-EXPORT_SYMBOL(i2o_query_table);
-EXPORT_SYMBOL(i2o_clear_table);
-EXPORT_SYMBOL(i2o_row_add_table);
-EXPORT_SYMBOL(i2o_issue_params);
+/**
+ *	i2o_pci_install		-	Install a PCI i2o controller
+ *	@dev: PCI device of the I2O controller
+ *
+ *	Install a PCI (or in theory AGP) i2o controller. Devices are
+ *	initialized, configured and registered with the i2o core subsystem. Be
+ *	very careful with ordering. There may be pending interrupts.
+ *
+ *	To Do: Add support for polled controllers
+ */
 
-EXPORT_SYMBOL(i2o_event_register);
-EXPORT_SYMBOL(i2o_event_ack);
+int __init i2o_pci_install(struct pci_dev *dev)
+{
+	struct i2o_controller *c=kmalloc(sizeof(struct i2o_controller),
+						GFP_KERNEL);
+	unsigned long mem;
+	u32 memptr = 0;
+	u32 size;
+	
+	int i;
 
-EXPORT_SYMBOL(i2o_report_status);
-EXPORT_SYMBOL(i2o_dump_message);
+	if(c==NULL)
+	{
+		printk(KERN_ERR "i2o: Insufficient memory to add controller.\n");
+		return -ENOMEM;
+	}
+	memset(c, 0, sizeof(*c));
 
-EXPORT_SYMBOL(i2o_get_class_name);
+	for(i=0; i<6; i++)
+	{
+		/* Skip I/O spaces */
+		if(!(pci_resource_flags(dev, i) & IORESOURCE_IO))
+		{
+			memptr = pci_resource_start(dev, i);
+			break;
+		}
+	}
+	
+	if(i==6)
+	{
+		printk(KERN_ERR "i2o: I2O controller has no memory regions defined.\n");
+		kfree(c);
+		return -EINVAL;
+	}
+	
+	size = dev->resource[i].end-dev->resource[i].start+1;	
+	/* Map the I2O controller */
+	
+	printk(KERN_INFO "i2o: PCI I2O controller at 0x%08X size=%d\n", memptr, size);
+	mem = (unsigned long)ioremap(memptr, size);
+	if(mem==0)
+	{
+		printk(KERN_ERR "i2o: Unable to map controller.\n");
+		kfree(c);
+		return -EINVAL;
+	}
 
-EXPORT_SYMBOL_GPL(i2o_sys_init);
+	c->irq = -1;
+	c->dpt = 0;
+	c->short_req = 0;
+	c->pdev = dev;
+
+	c->irq_mask = mem+0x34;
+	c->post_port = mem+0x40;
+	c->reply_port = mem+0x44;
 
-MODULE_AUTHOR("Red Hat Software");
-MODULE_DESCRIPTION("I2O Core");
-MODULE_LICENSE("GPL");
+	c->mem_phys = memptr;
+	c->mem_offset = mem;
+	
+	/*
+	 *	Cards that fall apart if you hit them with large I/O
+	 *	loads...
+	 */
+	 
+	if(dev->vendor == PCI_VENDOR_ID_NCR && dev->device == 0x0630)
+	{
+		c->short_req = 1;
+		printk(KERN_INFO "I2O: Symbios FC920 workarounds activated.\n");
+	}
+	if(dev->subsystem_vendor == PCI_VENDOR_ID_PROMISE)
+	{
+		c->promise = 1;
+		printk(KERN_INFO "I2O: Promise workarounds activated.\n");
+	}
+
+	/*
+	 *	Cards that go bananas if you quiesce them before you reset
+	 *	them
+	 */
+	 
+	if(dev->vendor == PCI_VENDOR_ID_DPT)
+		c->dpt=1;
+	
+	/* 
+	 * Enable Write Combining MTRR for IOP's memory region
+	 */
+#ifdef CONFIG_MTRR
+	c->mtrr_reg0 =
+		mtrr_add(c->mem_phys, size, MTRR_TYPE_WRCOMB, 1);
+	/*
+	 * If it is an INTEL i960 I/O processor then set the first 64K to
+	 * Uncacheable since the region contains the Messaging unit which
+	 * shouldn't be cached.
+	 */
+	c->mtrr_reg1 = -1;
+	if(dev->vendor == PCI_VENDOR_ID_INTEL || dev->vendor == PCI_VENDOR_ID_DPT)
+	{
+		printk(KERN_INFO "I2O: MTRR workaround for Intel i960 processor\n"); 
+		c->mtrr_reg1 =	mtrr_add(c->mem_phys, 65536, MTRR_TYPE_UNCACHABLE, 1);
+		if(c->mtrr_reg1< 0)
+		{
+			printk(KERN_INFO "i2o_pci: Error in setting MTRR_TYPE_UNCACHABLE\n");
+			mtrr_del(c->mtrr_reg0, c->mem_phys, size);
+			c->mtrr_reg0 = -1;
+		}
+	}
+
+#endif
+
+	I2O_IRQ_WRITE32(c,0xFFFFFFFF);
+
+	i = i2o_install_controller(c);
+	
+	if(i<0)
+	{
+		printk(KERN_ERR "i2o: Unable to install controller.\n");
+		kfree(c);
+		iounmap((void *)mem);
+		return i;
+	}
+
+	c->irq = dev->irq;
+	if(c->irq)
+	{
+		i=request_irq(dev->irq, i2o_pci_interrupt, SA_SHIRQ,
+			c->name, c);
+		if(i<0)
+		{
+			printk(KERN_ERR "%s: unable to allocate interrupt %d.\n",
+				c->name, dev->irq);
+			c->irq = -1;
+			i2o_delete_controller(c);
+			iounmap((void *)mem);
+			return -EBUSY;
+		}
+	}
+
+	printk(KERN_INFO "%s: Installed at IRQ%d\n", c->name, dev->irq);
+	I2O_IRQ_WRITE32(c,0x0);
+	c->enabled = 1;
+	return 0;	
+}
+
+static int dpt;
+
+/**
+ *	i2o_pci_scan	-	Scan the pci bus for controllers
+ *	
+ *	Scan the PCI devices on the system looking for any device which is a 
+ *	memory of the Intelligent, I2O class. We attempt to set up each such device
+ *	and register it with the core.
+ *
+ *	Returns the number of controllers registered
+ *
+ *	Note; Do not change this to a hot plug interface. I2O 1.5 itself
+ *	does not support hot plugging.
+ */
+ 
+int __init i2o_pci_scan(void)
+{
+	struct pci_dev *dev;
+	int count=0;
+	
+	printk(KERN_INFO "i2o: Checking for PCI I2O controllers...\n");
+
+	pci_for_each_dev(dev)	
+	{
+		if((dev->class>>8)!=PCI_CLASS_INTELLIGENT_I2O)
+			continue;
+		if(dev->vendor == PCI_VENDOR_ID_DPT && !dpt)
+		{
+			if(dev->device == 0xA501 || dev->device == 0xA511)
+			{
+				printk(KERN_INFO "i2o: Skipping Adaptec/DPT I2O raid with preferred native driver.\n");
+				continue;
+			}
+		}
+		if((dev->class&0xFF)>1)
+		{
+			printk(KERN_INFO "i2o: I2O Controller found but does not support I2O 1.5 (skipping).\n");
+			continue;
+		}
+		if (pci_enable_device(dev))
+			continue;
+		printk(KERN_INFO "i2o: I2O controller on bus %d at %d.\n",
+			dev->bus->number, dev->devfn);
+		if(pci_set_dma_mask(dev, 0xffffffff))
+		{
+			printk(KERN_WARNING "I2O controller on bus %d at %d : No suitable DMA available\n", dev->bus->number, dev->devfn);
+		 	continue;
+		}
+		pci_set_master(dev);
+		if(i2o_pci_install(dev)==0)
+			count++;
+	}
+	if(count)
+		printk(KERN_INFO "i2o: %d I2O controller%s found and installed.\n", count,
+			count==1?"":"s");
+	return count?count:-ENODEV;
+}
 
 static int i2o_core_init(void)
 {
@@ -3496,6 +3706,7 @@
 	else
 		printk(KERN_INFO "I2O: Event thread created as pid %d\n", evt_pid);
 
+	i2o_pci_scan();
 	if(i2o_num_controllers)
 		i2o_sys_init();
 
@@ -3532,3 +3743,40 @@
 module_init(i2o_core_init);
 module_exit(i2o_core_exit);
 
+MODULE_PARM(dpt, "i");
+MODULE_PARM_DESC(dpt, "Set this if you want to drive DPT cards normally handled by dpt_i2o");
+MODULE_PARM(verbose, "i");
+MODULE_PARM_DESC(verbose, "Verbose diagnostics");
+
+MODULE_AUTHOR("Red Hat Software");
+MODULE_DESCRIPTION("I2O Core");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(i2o_controller_chain);
+EXPORT_SYMBOL(i2o_num_controllers);
+EXPORT_SYMBOL(i2o_find_controller);
+EXPORT_SYMBOL(i2o_unlock_controller);
+EXPORT_SYMBOL(i2o_status_get);
+EXPORT_SYMBOL(i2o_install_handler);
+EXPORT_SYMBOL(i2o_remove_handler);
+EXPORT_SYMBOL(i2o_install_controller);
+EXPORT_SYMBOL(i2o_delete_controller);
+EXPORT_SYMBOL(i2o_run_queue);
+EXPORT_SYMBOL(i2o_claim_device);
+EXPORT_SYMBOL(i2o_release_device);
+EXPORT_SYMBOL(i2o_device_notify_on);
+EXPORT_SYMBOL(i2o_device_notify_off);
+EXPORT_SYMBOL(i2o_post_this);
+EXPORT_SYMBOL(i2o_post_wait);
+EXPORT_SYMBOL(i2o_post_wait_mem);
+EXPORT_SYMBOL(i2o_query_scalar);
+EXPORT_SYMBOL(i2o_set_scalar);
+EXPORT_SYMBOL(i2o_query_table);
+EXPORT_SYMBOL(i2o_clear_table);
+EXPORT_SYMBOL(i2o_row_add_table);
+EXPORT_SYMBOL(i2o_issue_params);
+EXPORT_SYMBOL(i2o_event_register);
+EXPORT_SYMBOL(i2o_event_ack);
+EXPORT_SYMBOL(i2o_report_status);
+EXPORT_SYMBOL(i2o_dump_message);
+EXPORT_SYMBOL(i2o_get_class_name);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/message/i2o/i2o_pci.c linux-2.5.65-ac2/drivers/message/i2o/i2o_pci.c
--- linux-2.5.65/drivers/message/i2o/i2o_pci.c	2003-02-10 18:38:00.000000000 +0000
+++ linux-2.5.65-ac2/drivers/message/i2o/i2o_pci.c	2003-03-13 20:41:36.000000000 +0000
@@ -32,9 +32,6 @@
 
 #include <asm/io.h>
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif // CONFIG_MTRR
 
 static int dpt;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/message/i2o/i2o_proc.c linux-2.5.65-ac2/drivers/message/i2o/i2o_proc.c
--- linux-2.5.65/drivers/message/i2o/i2o_proc.c	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.65-ac2/drivers/message/i2o/i2o_proc.c	2003-03-14 00:46:20.000000000 +0000
@@ -836,10 +836,14 @@
 		u16 row_count;
 		u16 more_flag;
 		i2o_exec_execute_ddm_table ddm_table[MAX_I2O_MODULES];
-	} result;
+	} *result;
 
 	i2o_exec_execute_ddm_table ddm_table;
 
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
+
 	spin_lock(&i2o_proc_lock);
 	len = 0;
 
@@ -847,18 +851,17 @@
 				c, ADAPTER_TID, 
 				0x0003, -1,
 				NULL, 0,
-				&result, sizeof(result));
+				result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token,"0x0003 Executing DDM List");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
 	len += sprintf(buf+len, "Tid   Module_type     Vendor Mod_id  Module_name             Vrs  Data_size Code_size\n");
-	ddm_table=result.ddm_table[0];
+	ddm_table=result->ddm_table[0];
 
-	for(i=0; i < result.row_count; ddm_table=result.ddm_table[++i])
+	for(i=0; i < result->row_count; ddm_table=result->ddm_table[++i])
 	{
 		len += sprintf(buf+len, "0x%03x ", ddm_table.ddm_tid & 0xFFF);
 
@@ -882,9 +885,9 @@
 
 		len += sprintf(buf+len, "\n");
 	}
-
+out:
 	spin_unlock(&i2o_proc_lock);
-
+	kfree(result);
 	return len;
 }
 
@@ -1047,7 +1050,11 @@
 		u16 row_count;
 		u16 more_flag;
 		i2o_group_info group[256];
-	} result;
+	} *result;
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);
 
@@ -1055,24 +1062,23 @@
 
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid, 0xF000, -1, NULL, 0,
-				&result, sizeof(result));
+				result, sizeof(*result));
 
 	if (token < 0) {
 		len = i2o_report_query_status(buf+len, token, "0xF000 Params Descriptor");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
 	len += sprintf(buf+len, "#  Group   FieldCount RowCount Type   Add Del Clear\n");
 
-	for (i=0; i < result.row_count; i++)
+	for (i=0; i < result->row_count; i++)
 	{
 		len += sprintf(buf+len, "%-3d", i);
-		len += sprintf(buf+len, "0x%04X ", result.group[i].group_number);
-		len += sprintf(buf+len, "%10d ", result.group[i].field_count);
-		len += sprintf(buf+len, "%8d ",  result.group[i].row_count);
+		len += sprintf(buf+len, "0x%04X ", result->group[i].group_number);
+		len += sprintf(buf+len, "%10d ", result->group[i].field_count);
+		len += sprintf(buf+len, "%8d ",  result->group[i].row_count);
 
-		properties = result.group[i].properties;
+		properties = result->group[i].properties;
 		if (properties & 0x1)	len += sprintf(buf+len, "Table  ");
 				else	len += sprintf(buf+len, "Scalar ");
 		if (properties & 0x2)	len += sprintf(buf+len, " + ");
@@ -1085,11 +1091,11 @@
 		len += sprintf(buf+len, "\n");
 	}
 
-	if (result.more_flag)
+	if (result->more_flag)
 		len += sprintf(buf+len, "There is more...\n");
-
+out:
 	spin_unlock(&i2o_proc_lock);
-
+	kfree(result);
 	return len;
 }
 
@@ -1220,7 +1226,11 @@
 		u16 row_count;
 		u16 more_flag;
 		i2o_user_table user[64];
-	} result;
+	} *result;
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);
 	len = 0;
@@ -1228,28 +1238,28 @@
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid,
 				0xF003, -1, NULL, 0,
-				&result, sizeof(result));
+				result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token,"0xF003 User Table");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
 	len += sprintf(buf+len, "#  Instance UserTid ClaimType\n");
 
-	for(i=0; i < result.row_count; i++)
+	for(i=0; i < result->row_count; i++)
 	{
 		len += sprintf(buf+len, "%-3d", i);
-		len += sprintf(buf+len, "%#8x ", result.user[i].instance);
-		len += sprintf(buf+len, "%#7x ", result.user[i].user_tid);
-		len += sprintf(buf+len, "%#9x\n", result.user[i].claim_type);
+		len += sprintf(buf+len, "%#8x ", result->user[i].instance);
+		len += sprintf(buf+len, "%#7x ", result->user[i].user_tid);
+		len += sprintf(buf+len, "%#9x\n", result->user[i].claim_type);
 	}
 
-	if (result.more_flag)
+	if (result->more_flag)
 		len += sprintf(buf+len, "There is more...\n");
-
+out:
 	spin_unlock(&i2o_proc_lock);
+	kfree(result);
 	return len;
 }
 
@@ -2264,24 +2274,27 @@
 		u16 row_count;
 		u16 more_flag;
 		u8  mc_addr[256][8];
-	} result;	
+	} *result;	
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);	
 	len = 0;
 
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid, 0x0002, -1, 
-				NULL, 0, &result, sizeof(result));
+				NULL, 0, result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token,"0x002 LAN Multicast MAC Address");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
-	for (i = 0; i < result.row_count; i++)
+	for (i = 0; i < result->row_count; i++)
 	{
-		memcpy(mc_addr, result.mc_addr[i], 8);
+		memcpy(mc_addr, result->mc_addr[i], 8);
 
 		len += sprintf(buf+len, "MC MAC address[%d]: "
 			       "%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X\n",
@@ -2289,8 +2302,9 @@
 			       mc_addr[3], mc_addr[4], mc_addr[5],
 			       mc_addr[6], mc_addr[7]);
 	}
-
+out:
 	spin_unlock(&i2o_proc_lock);
+	kfree(result);
 	return len;
 }
 
@@ -2495,32 +2509,36 @@
 		u16 row_count;
 		u16 more_flag;
 		u8  alt_addr[256][8];
-	} result;	
+	} *result;	
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);	
 	len = 0;
 
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid,
-				0x0006, -1, NULL, 0, &result, sizeof(result));
+				0x0006, -1, NULL, 0, result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token, "0x0006 LAN Alternate Address (optional)");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
-	for (i=0; i < result.row_count; i++)
+	for (i=0; i < result->row_count; i++)
 	{
-		memcpy(alt_addr,result.alt_addr[i],8);
+		memcpy(alt_addr,result->alt_addr[i],8);
 		len += sprintf(buf+len, "Alternate address[%d]: "
 			       "%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X\n",
 			       i, alt_addr[0], alt_addr[1], alt_addr[2],
 			       alt_addr[3], alt_addr[4], alt_addr[5],
 			       alt_addr[6], alt_addr[7]);
 	}
-
+out:
 	spin_unlock(&i2o_proc_lock);
+	kfree(result);
 	return len;
 }
 
