Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSGYNeK>; Thu, 25 Jul 2002 09:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGYNdD>; Thu, 25 Jul 2002 09:33:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2813 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314325AbSGYNaI>; Thu, 25 Jul 2002 09:30:08 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251447.g6PElEhU010437@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) Update i2o core functionality to 2.5
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:47:14 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/message/i2o/i2o_config.c linux-2.5.28-ac1/drivers/message/i2o/i2o_config.c
--- linux-2.5.28/drivers/message/i2o/i2o_config.c	Thu Jul 25 10:49:25 2002
+++ linux-2.5.28-ac1/drivers/message/i2o/i2o_config.c	Sun Jul 21 19:56:10 2002
@@ -1,7 +1,7 @@
 /*
  * I2O Configuration Interface Driver
  *
- * (C) Copyright 1999   Red Hat Software
+ * (C) Copyright 1999-2002  Red Hat
  *	
  * Written by Alan Cox, Building Number Three Ltd
  *
@@ -16,17 +16,17 @@
  *   - Fixed ioctl_swdl()
  * Modified 10/04/1999 by Taneli Vähäkangas
  *   - Changed ioctl_swdl(), implemented ioctl_swul() and ioctl_swdel()
- * Modified 11/18/199 by Deepak Saxena
+ * Modified 11/18/1999 by Deepak Saxena
  *   - Added event managmenet support
  *
+ * 2.4 rewrite ported to 2.5 - Alan Cox <alan@redhat.com>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -47,7 +47,7 @@
 static spinlock_t i2o_config_lock = SPIN_LOCK_UNLOCKED;
 struct wait_queue *i2o_wait_queue;
 
-#define MODINC(x,y) (x = x++ % y)
+#define MODINC(x,y) ((x) = ((x) + 1) % (y))
 
 struct i2o_cfg_info
 {
@@ -279,7 +279,14 @@
 		if(c)
 		{
 			foo[i] = 1;
-			i2o_unlock_controller(c);
+			if(pci_set_dma_mask(c->pdev, 0xffffffff))
+			{
+				printk(KERN_WARNING "i2o_config : No suitable DMA available on controller %d\n", i);
+				i2o_unlock_controller(c);
+				continue;
+			}
+		
+				i2o_unlock_controller(c);
 		}
 		else
 		{
@@ -445,11 +452,12 @@
 	struct i2o_controller *c;
 	u8 *res = NULL;
 	void *query = NULL;
+	dma_addr_t query_phys, res_phys;
 	int ret = 0;
 	int token;
 	u32 len;
 	u32 reslen;
-	u32 msg[MSG_FRAME_SIZE/4];
+	u32 msg[MSG_FRAME_SIZE];
 
 	if(copy_from_user(&kcmd, cmd, sizeof(struct i2o_html)))
 	{
@@ -475,7 +483,7 @@
 
 	if(kcmd.qlen) /* Check for post data */
 	{
-		query = kmalloc(kcmd.qlen, GFP_KERNEL);
+		query = pci_alloc_consistent(c->pdev, kcmd.qlen, &query_phys);
 		if(!query)
 		{
 			i2o_unlock_controller(c);
@@ -485,16 +493,16 @@
 		{
 			i2o_unlock_controller(c);
 			printk(KERN_INFO "i2o_config: could not get query\n");
-			kfree(query);
+			pci_free_consistent(c->pdev, kcmd.qlen, query, query_phys);
 			return -EFAULT;
 		}
 	}
 
-	res = kmalloc(65536, GFP_KERNEL);
+	res = pci_alloc_consistent(c->pdev, 65536, &res_phys);
 	if(!res)
 	{
 		i2o_unlock_controller(c);
-		kfree(query);
+		pci_free_consistent(c->pdev, kcmd.qlen, query, query_phys);
 		return -ENOMEM;
 	}
 
@@ -503,7 +511,7 @@
 	msg[3] = 0;
 	msg[4] = kcmd.page;
 	msg[5] = 0xD0000000|65536;
-	msg[6] = virt_to_bus(res);
+	msg[6] = res_phys;
 	if(!kcmd.qlen) /* Check for post data */
 		msg[0] = SEVEN_WORD_MSG_SIZE|SGL_OFFSET_5;
 	else
@@ -511,7 +519,7 @@
 		msg[0] = NINE_WORD_MSG_SIZE|SGL_OFFSET_5;
 		msg[5] = 0x50000000|65536;
 		msg[7] = 0xD4000000|(kcmd.qlen);
-		msg[8] = virt_to_bus(query);
+		msg[8] = query_phys;
 	}
 	/*
 	Wait for a considerable time till the Controller 
@@ -519,7 +527,7 @@
 	take more time to process this request if there are
 	many devices connected to it.
 	*/
-	token = i2o_post_wait_mem(c, msg, 9*4, 400, query, res);
+	token = i2o_post_wait_mem(c, msg, 9*4, 400, query, res, query_phys, res_phys, kcmd.qlen, 65536);
 	if(token < 0)
 	{
 		printk(KERN_DEBUG "token = %#10x\n", token);
@@ -527,10 +535,10 @@
 		
 		if(token != -ETIMEDOUT)
 		{
-			kfree(res);
-			if(kcmd.qlen) kfree(query);
+			pci_free_consistent(c->pdev, 65536, res, res_phys);
+			if(kcmd.qlen)
+				pci_free_consistent(c->pdev, kcmd.qlen, query, query_phys);
 		}
-
 		return token;
 	}
 	i2o_unlock_controller(c);
@@ -542,9 +550,9 @@
 	if(copy_to_user(kcmd.resbuf, res, len))
 		ret = -EFAULT;
 
-	kfree(res);
-	if(kcmd.qlen) 
-		kfree(query);
+	pci_free_consistent(c->pdev, 65536, res, res_phys);
+	if(kcmd.qlen)
+		pci_free_consistent(c->pdev, kcmd.qlen, query, query_phys);
 
 	return ret;
 }
@@ -558,6 +566,7 @@
 	u32 msg[9];
 	unsigned int status = 0, swlen = 0, fragsize = 8192;
 	struct i2o_controller *c;
+	dma_addr_t buffer_phys;
 
 	if(copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer)))
 		return -EFAULT;
@@ -580,7 +589,7 @@
 	if(!c)
 		return -ENXIO;
 
-	buffer=kmalloc(fragsize, GFP_KERNEL);
+	buffer=pci_alloc_consistent(c->pdev, fragsize, &buffer_phys);
 	if (buffer==NULL)
 	{
 		i2o_unlock_controller(c);
@@ -597,14 +606,14 @@
 	msg[5]= swlen;
 	msg[6]= kxfer.sw_id;
 	msg[7]= (0xD0000000 | fragsize);
-	msg[8]= virt_to_bus(buffer);
+	msg[8]= buffer_phys;
 
 //	printk("i2o_config: swdl frag %d/%d (size %d)\n", curfrag, maxfrag, fragsize);
-	status = i2o_post_wait_mem(c, msg, sizeof(msg), 60, buffer, NULL);
+	status = i2o_post_wait_mem(c, msg, sizeof(msg), 60, buffer, NULL, buffer_phys, 0, fragsize, 0);
 
 	i2o_unlock_controller(c);
 	if(status != -ETIMEDOUT)
-		kfree(buffer);
+		pci_free_consistent(c->pdev, fragsize, buffer, buffer_phys);
 	
 	if (status != I2O_POST_WAIT_OK)
 	{
@@ -626,7 +635,8 @@
 	u32 msg[9];
 	unsigned int status = 0, swlen = 0, fragsize = 8192;
 	struct i2o_controller *c;
-	
+	dma_addr_t buffer_phys;
+		
 	if(copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer)))
 		return -EFAULT;
 		
@@ -648,7 +658,7 @@
 	if(!c)
 		return -ENXIO;
 		
-	buffer=kmalloc(fragsize, GFP_KERNEL);
+	buffer=pci_alloc_consistent(c->pdev, fragsize, &buffer_phys);
 	if (buffer==NULL)
 	{
 		i2o_unlock_controller(c);
@@ -663,22 +673,22 @@
 	msg[5]= swlen;
 	msg[6]= kxfer.sw_id;
 	msg[7]= (0xD0000000 | fragsize);
-	msg[8]= virt_to_bus(buffer);
+	msg[8]= buffer_phys;
 	
 //	printk("i2o_config: swul frag %d/%d (size %d)\n", curfrag, maxfrag, fragsize);
-	status = i2o_post_wait_mem(c, msg, sizeof(msg), 60, buffer, NULL);
+	status = i2o_post_wait_mem(c, msg, sizeof(msg), 60, buffer, NULL, buffer_phys, 0, fragsize, 0);
 	i2o_unlock_controller(c);
 	
 	if (status != I2O_POST_WAIT_OK)
 	{
 		if(status != -ETIMEDOUT)
-			kfree(buffer);
+			pci_free_consistent(c->pdev, fragsize, buffer, buffer_phys);
 		printk(KERN_INFO "i2o_config: swul failed, DetailedStatus = %d\n", status);
 		return status;
 	}
 	
 	__copy_to_user(kxfer.buf, buffer, fragsize);
-	kfree(buffer);
+	pci_free_consistent(c->pdev, fragsize, buffer, buffer_phys);
 	
 	return 0;
 }
@@ -849,6 +859,7 @@
 	struct i2o_cfg_info *p1, *p2;
 	unsigned long flags;
 
+	lock_kernel();
 	p1 = p2 = NULL;
 
 	spin_lock_irqsave(&i2o_config_lock, flags);
@@ -871,6 +882,7 @@
 		p1 = p1->next;
 	}
 	spin_unlock_irqrestore(&i2o_config_lock, flags);
+	unlock_kernel();
 
 	return 0;
 }
@@ -908,11 +920,7 @@
 	&config_fops
 };	
 
-#ifdef MODULE
-int init_module(void)
-#else
-int __init i2o_config_init(void)
-#endif
+static int __init i2o_config_init(void)
 {
 	printk(KERN_INFO "I2O configuration manager v 0.04.\n");
 	printk(KERN_INFO "  (C) Copyright 1999 Red Hat Software\n");
@@ -946,9 +954,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-
-void cleanup_module(void)
+static void i2o_config_exit(void)
 {
 	misc_deregister(&i2o_miscdev);
 	
@@ -958,8 +964,10 @@
 		i2o_remove_handler(&cfg_handler);
 }
  
+EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR("Red Hat Software");
 MODULE_DESCRIPTION("I2O Configuration");
 MODULE_LICENSE("GPL");
 
-#endif
+module_init(i2o_config_init);
+module_exit(i2o_config_exit);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/message/i2o/i2o_core.c linux-2.5.28-ac1/drivers/message/i2o/i2o_core.c
--- linux-2.5.28/drivers/message/i2o/i2o_core.c	Thu Jul 25 10:49:25 2002
+++ linux-2.5.28-ac1/drivers/message/i2o/i2o_core.c	Sun Jul 21 15:21:36 2002
@@ -1,7 +1,7 @@
 /*
  * Core I2O structure management 
  * 
- * (C) Copyright 1999   Red Hat Software 
+ * (C) Copyright 1999-2002   Red Hat Software 
  *
  * Written by Alan Cox, Building Number Three Ltd 
  * 
@@ -19,11 +19,12 @@
  *		Auvo Häkkinen <Auvo.Hakkinen@cs.Helsinki.FI> 
  *		Deepak Saxena <deepak@plexity.net> 
  *		Boji T Kannanthanam <boji.t.kannanthanam@intel.com>
+ *
+ * Ported to Linux 2.5 by
+ *		Alan Cox	<alan@redhat.com>
  * 
  */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -72,7 +73,7 @@
 static int core_context;
 
 /* Initialization && shutdown functions */
-static void i2o_sys_init(void);
+void i2o_sys_init(void);
 static void i2o_sys_shutdown(void);
 static int i2o_reset_controller(struct i2o_controller *);
 static int i2o_reboot_event(struct notifier_block *, unsigned long , void *);
@@ -122,28 +123,6 @@
  */
 static spinlock_t i2o_dev_lock = SPIN_LOCK_UNLOCKED;
 
-#ifdef MODULE
-/* 
- * Function table to send to bus specific layers
- * See <include/linux/i2o.h> for explanation of this
- */
-#ifdef CONFIG_I2O_PCI_MODULE
-static struct i2o_core_func_table i2o_core_functions =
-{
-	i2o_install_controller,
-	i2o_activate_controller,
-	i2o_find_controller,
-	i2o_unlock_controller,
-	i2o_run_queue,
-	i2o_delete_controller
-};
-
-extern int i2o_pci_core_attach(struct i2o_core_func_table *);
-extern void i2o_pci_core_detach(void);
-#endif /* CONFIG_I2O_PCI_MODULE */
-
-#endif /* MODULE */
-
 /*
  * Structures and definitions for synchronous message posting.
  * See i2o_post_wait() for description.
@@ -156,11 +135,14 @@
 	wait_queue_head_t *wq;	/* Wake up for caller (NULL for dead) */
 	struct i2o_post_wait_data *next;	/* Chain */
 	void *mem[2];		/* Memory blocks to recover on failure path */
+	dma_addr_t phys[2];	/* Physical address of blocks to recover */
+	u32 size[2];		/* Size of blocks to recover */
 };
+
 static struct i2o_post_wait_data *post_wait_queue;
 static u32 post_wait_id;	// Unique ID for each post_wait
 static spinlock_t post_wait_lock = SPIN_LOCK_UNLOCKED;
-static void i2o_post_wait_complete(u32, int);
+static void i2o_post_wait_complete(struct i2o_controller *, u32, int);
 
 /* OSM descriptor handler */ 
 static struct i2o_handler i2o_core_handler =
@@ -210,7 +192,7 @@
  
 static DECLARE_MUTEX(evt_sem);
 static DECLARE_COMPLETION(evt_dead);
-DECLARE_WAIT_QUEUE_HEAD(evt_wait);
+static DECLARE_WAIT_QUEUE_HEAD(evt_wait);
 
 static struct notifier_block i2o_reboot_notifier =
 {
@@ -269,7 +251,7 @@
 		else
 			status = I2O_POST_WAIT_OK;
 	
-		i2o_post_wait_complete(context, status);
+		i2o_post_wait_complete(c, context, status);
 		return;
 	}
 
@@ -503,7 +485,7 @@
 	{
 		if(i2o_controllers[i]==NULL)
 		{
-			c->dlct = (i2o_lct*)kmalloc(8192, GFP_KERNEL);
+			c->dlct = (i2o_lct*)pci_alloc_consistent(c->pdev, 8192, &c->dlct_phys);
 			if(c->dlct==NULL)
 			{
 				up(&i2o_configuration_lock);
@@ -613,13 +595,13 @@
 				kfree(c->page_frame);
 			}
 			if(c->hrt)
-				kfree(c->hrt);
+				pci_free_consistent(c->pdev, c->hrt_len, c->hrt, c->hrt_phys);
 			if(c->lct)
-				kfree(c->lct);
+				pci_free_consistent(c->pdev, c->lct->table_size << 2, c->lct, c->lct_phys);
 			if(c->status_block)
-				kfree(c->status_block);
+				pci_free_consistent(c->pdev, sizeof(i2o_status_block), c->status_block, c->status_block_phys);
 			if(c->dlct)
-				kfree(c->dlct);
+				pci_free_consistent(c->pdev, 8192, c->dlct, c->dlct_phys);
 
 			i2o_controllers[c->unit]=NULL;
 			memcpy(name, c->name, strlen(c->name)+1);
@@ -1145,15 +1127,17 @@
 		 */
 		if(c->lct->table_size < c->dlct->table_size)
 		{
+			dma_addr_t phys;
 			tmp = c->lct;
-			c->lct = kmalloc(c->dlct->table_size<<2, GFP_KERNEL);
+			c->lct = pci_alloc_consistent(c->pdev, c->dlct->table_size<<2, &phys);
 			if(!c->lct)
 			{
 				printk(KERN_ERR "%s: No memory for LCT!\n", c->name);
 				c->lct = tmp;
 				continue;
 			}
-			kfree(tmp);
+			pci_free_consistent(tmp, c->lct->table_size << 2, c->lct, c->lct_phys);
+			c->lct_phys = phys;
 		}
 		memcpy(c->lct, c->dlct, c->dlct->table_size<<2);
 	}
@@ -1186,7 +1170,8 @@
 	{
 		struct i2o_handler *i;
 		/* Map the message from the page frame map to kernel virtual */
-		m=(struct i2o_message *)(mv - (unsigned long)c->page_frame_map + (unsigned long)c->page_frame);
+		/* m=(struct i2o_message *)(mv - (unsigned long)c->page_frame_map + (unsigned long)c->page_frame); */
+		m=(struct i2o_message *)bus_to_virt(mv);
 		msg=(u32*)m;
 
 		/*
@@ -1665,6 +1650,7 @@
 	struct i2o_controller *iop;
 	u32 m;
 	u8 *status;
+	dma_addr_t status_phys;
 	u32 *msg;
 	long time;
 
@@ -1681,8 +1667,8 @@
 		return -ETIMEDOUT;
 	msg=(u32 *)(c->mem_offset+m);
 	
-	status=(void *)kmalloc(4, GFP_KERNEL);
-	if(status==NULL) {
+	status = pci_alloc_consistent(c->pdev, 4, &status_phys);
+	if(status == NULL) {
 		printk(KERN_ERR "IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
@@ -1694,7 +1680,7 @@
 	msg[3]=0;
 	msg[4]=0;
 	msg[5]=0;
-	msg[6]=virt_to_bus(status);
+	msg[6]=status_phys;
 	msg[7]=0;	/* 64bit host FIXME */
 
 	i2o_post_message(c,m);
@@ -1706,7 +1692,7 @@
 		if((jiffies-time)>=20*HZ)
 		{
 			printk(KERN_ERR "IOP reset timeout.\n");
-			// Better to leak this for safety: kfree(status);
+			// Better to leak this for safety: - status;
 			return -ETIMEDOUT;
 		}
 		schedule();
@@ -1762,7 +1748,7 @@
 		if (iop != c)
 			i2o_enable_controller(iop);
 
-	kfree(status);
+	pci_free_consistent(c->pdev, 4, status, status_phys);
 	return 0;
 }
 
@@ -1787,7 +1773,7 @@
 	if (c->status_block == NULL) 
 	{
 		c->status_block = (i2o_status_block *)
-			kmalloc(sizeof(i2o_status_block),GFP_KERNEL);
+			pci_alloc_consistent(c->pdev, sizeof(i2o_status_block), &c->status_block_phys);
 		if (c->status_block == NULL)
 		{
 			printk(KERN_CRIT "%s: Get Status Block failed; Out of memory.\n",
@@ -1810,7 +1796,7 @@
 	msg[3]=0;
 	msg[4]=0;
 	msg[5]=0;
-	msg[6]=virt_to_bus(c->status_block);
+	msg[6]=c->status_block_phys;
 	msg[7]=0;   /* 64bit host FIXME */
 	msg[8]=sizeof(i2o_status_block); /* always 88 bytes */
 
@@ -1826,7 +1812,7 @@
 			printk(KERN_ERR "%s: Get status timeout.\n",c->name);
 			return -ETIMEDOUT;
 		}
-		schedule();
+		yield();
 		barrier();
 	}
 
@@ -1876,7 +1862,7 @@
 
 	do  {
 		if (c->hrt == NULL) {
-			c->hrt=kmalloc(size, GFP_KERNEL);
+			c->hrt=pci_alloc_consistent(c->pdev, size, &c->hrt_phys);
 			if (c->hrt == NULL) {
 				printk(KERN_CRIT "%s: Hrt Get failed; Out of memory.\n", c->name);
 				return -ENOMEM;
@@ -1887,9 +1873,9 @@
 		msg[1]= I2O_CMD_HRT_GET<<24 | HOST_TID<<12 | ADAPTER_TID;
 		msg[3]= 0;
 		msg[4]= (0xD0000000 | size);	/* Simple transaction */
-		msg[5]= virt_to_bus(c->hrt);	/* Dump it here */
+		msg[5]= c->hrt_phys;		/* Dump it here */
 
-		ret = i2o_post_wait_mem(c, msg, sizeof(msg), 20, c->hrt, NULL);
+		ret = i2o_post_wait_mem(c, msg, sizeof(msg), 20, c->hrt, NULL, c->hrt_phys, 0, size, 0);
 		
 		if(ret == -ETIMEDOUT)
 		{
@@ -1907,8 +1893,9 @@
 		}
 
 		if (c->hrt->num_entries * c->hrt->entry_len << 2 > size) {
-			size = c->hrt->num_entries * c->hrt->entry_len << 2;
-			kfree(c->hrt);
+			int new_size = c->hrt->num_entries * c->hrt->entry_len << 2;
+			pci_free_consistent(c->pdev, size, c->hrt, c->hrt_phys);
+			size = new_size;
 			c->hrt = NULL;
 		}
 	} while (c->hrt == NULL);
@@ -1929,6 +1916,7 @@
 static int i2o_systab_send(struct i2o_controller *iop)
 {
 	u32 msg[12];
+	dma_addr_t sys_tbl_phys;
 	int ret;
 	u32 *privbuf = kmalloc(16, GFP_KERNEL);
 	if(privbuf == NULL)
@@ -2009,17 +1997,23 @@
  	 * Provide three SGL-elements:
  	 * System table (SysTab), Private memory space declaration and 
  	 * Private i/o space declaration  
- 	 *
- 	 * FIXME: provide these for controllers needing them
+ 	 * 
+ 	 * Nasty one here. We can't use pci_alloc_consistent to send the
+ 	 * same table to everyone. We have to go remap it for them all
  	 */
-	msg[6] = 0x54000000 | sys_tbl_len;
-	msg[7] = virt_to_bus(sys_tbl);
-	msg[8] = 0x54000000 | 8;
-	msg[9] = virt_to_bus(privbuf);
-	msg[10] = 0xD4000000 | 8;
-	msg[11] = virt_to_bus(privbuf+2);
+ 	 
+ 	sys_tbl_phys = pci_map_single(iop->pdev, sys_tbl, sys_tbl_len, PCI_DMA_TODEVICE);
+	msg[6] = 0x54000000 | sys_tbl_phys;
+
+	msg[7] = sys_tbl_phys;
+	msg[8] = 0x54000000 | privbuf[1];
+	msg[9] = privbuf[0];
+	msg[10] = 0xD4000000 | privbuf[3];
+	msg[11] = privbuf[2];
+
+	ret=i2o_post_wait(iop, msg, sizeof(msg), 120);
 
-	ret=i2o_post_wait_mem(iop, msg, sizeof(msg), 120, privbuf, NULL);
+	pci_unmap_single(iop->pdev, sys_tbl_phys, sys_tbl_len, PCI_DMA_TODEVICE);
 	
 	if(ret==-ETIMEDOUT)
 	{
@@ -2045,7 +2039,7 @@
 /*
  * Initialize I2O subsystem.
  */
-static void __init i2o_sys_init(void)
+void __init i2o_sys_init(void)
 {
 	struct i2o_controller *iop, *niop = NULL;
 
@@ -2198,6 +2192,7 @@
 int i2o_init_outbound_q(struct i2o_controller *c)
 {
 	u8 *status;
+	dma_addr_t status_phys;
 	u32 m;
 	u32 *msg;
 	u32 time;
@@ -2208,7 +2203,7 @@
 		return -ETIMEDOUT;
 	msg=(u32 *)(c->mem_offset+m);
 
-	status = kmalloc(4,GFP_KERNEL);
+	status = pci_alloc_consistent(c->pdev, 4, &status_phys);
 	if (status==NULL) {
 		printk(KERN_ERR "%s: Outbound Queue initialization failed - no free memory.\n",
 			c->name);
@@ -2221,11 +2216,10 @@
 	msg[2]= core_context;
 	msg[3]= 0x0106;				/* Transaction context */
 	msg[4]= 4096;				/* Host page frame size */
-	/* Frame size is in words. Pick 128, its what everyone elses uses and
-		other sizes break some adapters. */
-	msg[5]= MSG_FRAME_SIZE<<16|0x80;	/* Outbound msg frame size and Initcode */
+	/* Frame size is in words. 256 bytes a frame for now */
+	msg[5]= MSG_FRAME_SIZE<<16|0x80;	/* Outbound msg frame size in words and Initcode */
 	msg[6]= 0xD0000004;			/* Simple SG LE, EOB */
-	msg[7]= virt_to_bus(status);
+	msg[7]= status_phys;
 
 	i2o_post_message(c,m);
 	
@@ -2241,20 +2235,20 @@
 			else  
 				printk(KERN_ERR "%s: Outbound queue initialize timeout.\n",
 					c->name);
-			kfree(status);
+			pci_free_consistent(c->pdev, 4, status, status_phys);
 			return -ETIMEDOUT;
 		}  
-		schedule();
+		yield();
 		barrier();
 	}  
 
 	if(status[0] != I2O_CMD_COMPLETED)
 	{
 		printk(KERN_ERR "%s: IOP outbound initialise failed.\n", c->name);
-		kfree(status);
+		pci_free_consistent(c->pdev, 4, status, status_phys);
 		return -ETIMEDOUT;
 	}
-
+	pci_free_consistent(c->pdev, 4, status, status_phys);
 	return 0;
 }
 
@@ -2296,7 +2290,7 @@
 	for(i=0; i< NMBR_MSG_FRAMES; i++) {
 		I2O_REPLY_WRITE32(c,m);
 		mb();
-		m += MSG_FRAME_SIZE;
+		m += (MSG_FRAME_SIZE << 2);
 	}
 
 	return 0;
@@ -2312,7 +2306,7 @@
 
 	do {
 		if (c->lct == NULL) {
-			c->lct = kmalloc(size, GFP_KERNEL);
+			c->lct = pci_alloc_consistent(c->pdev, size, &c->lct_phys);
 			if(c->lct == NULL) {
 				printk(KERN_CRIT "%s: Lct Get failed. Out of memory.\n",
 					c->name);
@@ -2328,9 +2322,9 @@
 		msg[4] = 0xFFFFFFFF;	/* All devices */
 		msg[5] = 0x00000000;	/* Report now */
 		msg[6] = 0xD0000000|size;
-		msg[7] = virt_to_bus(c->lct);
+		msg[7] = c->lct_phys;
 
-		ret=i2o_post_wait_mem(c, msg, sizeof(msg), 120, c->lct, NULL);
+		ret=i2o_post_wait_mem(c, msg, sizeof(msg), 120, c->lct, NULL, c->lct_phys, 0, size, 0);
 		
 		if(ret == -ETIMEDOUT)
 		{
@@ -2346,8 +2340,9 @@
 		}
 
 		if (c->lct->table_size << 2 > size) {
-			size = c->lct->table_size << 2;
-			kfree(c->lct);
+			int new_size = c->lct->table_size << 2;
+			pci_free_consistent(c->pdev, size, c->lct, c->lct_phys);
+			size = new_size;
 			c->lct = NULL;
 		}
 	} while (c->lct == NULL);
@@ -2375,7 +2370,7 @@
 	msg[4] = 0xFFFFFFFF;	/* All devices */
 	msg[5] = c->dlct->change_ind+1;	/* Next change */
 	msg[6] = 0xD0000000|8192;
-	msg[7] = virt_to_bus(c->dlct);
+	msg[7] = c->dlct_phys;
 
 	return i2o_post_this(c, msg, sizeof(msg));
 }
@@ -2480,9 +2475,8 @@
 		sys_tbl->iops[count].last_changed = sys_tbl_ind - 1; // ??
 		sys_tbl->iops[count].iop_capabilities = 
 				iop->status_block->iop_capabilities;
-		sys_tbl->iops[count].inbound_low = 
-				(u32)virt_to_bus(iop->post_port);
-		sys_tbl->iops[count].inbound_high = 0;	// TODO: 64-bit support
+		sys_tbl->iops[count].inbound_low = iop->post_port;
+		sys_tbl->iops[count].inbound_high = 0;	// FIXME: 64-bit support
 
 		count++;
 	}
@@ -2543,6 +2537,10 @@
  *	@timeout: time in seconds to wait
  *	@mem1: attached memory buffer 1
  *	@mem2: attached memory buffer 2
+ *	@phys1: physical address of buffer 1
+ *	@phys2: physical address of buffer 2
+ *	@size1: size of buffer 1
+ *	@size2: size of buffer 2
  *
  * 	This core API allows an OSM to post a message and then be told whether
  *	or not the system received a successful reply. 
@@ -2557,9 +2555,10 @@
  *	Pass NULL for unneeded buffers.
  */
  
-int i2o_post_wait_mem(struct i2o_controller *c, u32 *msg, int len, int timeout, void *mem1, void *mem2)
+int i2o_post_wait_mem(struct i2o_controller *c, u32 *msg, int len, int timeout, void *mem1, void *mem2, dma_addr_t phys1, dma_addr_t phys2, int size1, int size2)
 {
 	DECLARE_WAIT_QUEUE_HEAD(wq_i2o_post);
+	DECLARE_WAITQUEUE(wait, current);
 	int complete = 0;
 	int status;
 	unsigned long flags = 0;
@@ -2576,6 +2575,11 @@
 	wait_data->complete = &complete;
 	wait_data->mem[0] = mem1;
 	wait_data->mem[1] = mem2;
+	wait_data->phys[0] = phys1;
+	wait_data->phys[1] = phys2;
+	wait_data->size[0] = size1;
+	wait_data->size[1] = size2;
+	
 	/* 
 	 *	Queue the event with its unique id
 	 */
@@ -2600,12 +2604,19 @@
 	 *	complete will be zero.  From the point post_this returns
 	 *	the wait_data may have been deleted.
 	 */
+
+	add_wait_queue(&wq_i2o_post, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
 	if ((status = i2o_post_this(c, msg, len))==0) {
-		sleep_on_timeout(&wq_i2o_post, HZ * timeout);
+		schedule_timeout(HZ * timeout);
 	}  
 	else
+	{
+		remove_wait_queue(&wq_i2o_post, &wait);
 		return -EIO;
-		
+	}
+	remove_wait_queue(&wq_i2o_post, &wait);
+
 	if(signal_pending(current))
 		status = -EINTR;
 		
@@ -2650,7 +2661,7 @@
  
 int i2o_post_wait(struct i2o_controller *c, u32 *msg, int len, int timeout)
 {
-	return i2o_post_wait_mem(c, msg, len, timeout, NULL, NULL);
+	return i2o_post_wait_mem(c, msg, len, timeout, NULL, NULL, 0, 0, 0, 0);
 }
 
 /*
@@ -2658,7 +2669,7 @@
  * sleeping proccess. Called by core's reply handler.
  */
 
-static void i2o_post_wait_complete(u32 context, int status)
+static void i2o_post_wait_complete(struct i2o_controller *c, u32 context, int status)
 {
 	struct i2o_post_wait_data **p1, *q;
 	unsigned long flags;
@@ -2704,10 +2715,12 @@
 				/*
 				 *	Free resources. Caller is dead
 				 */
+
 				if(q->mem[0])
-					kfree(q->mem[0]);
+					pci_free_consistent(c->pdev, q->size[0], q->mem[0], q->phys[0]);
 				if(q->mem[1])
-					kfree(q->mem[1]);
+					pci_free_consistent(c->pdev, q->size[1], q->mem[1], q->phys[1]);
+
 				printk(KERN_WARNING "i2o_post_wait event completed after timeout.\n");
 			}
 			kfree(q);
@@ -2728,6 +2741,7 @@
  *	Note that the minimum sized reslist is 8 bytes and contains
  *	ResultCount, ErrorInfoSize, BlockStatus and BlockSize.
  */
+
 int i2o_issue_params(int cmd, struct i2o_controller *iop, int tid, 
                 void *oplist, int oplen, void *reslist, int reslen)
 {
@@ -2738,17 +2752,18 @@
 	int i = 0;
 	int wait_status;
 	u32 *opmem, *resmem;
+	dma_addr_t opmem_phys, resmem_phys;
 	
 	/* Get DMAable memory */
-	opmem = kmalloc(oplen, GFP_KERNEL);
+	opmem = pci_alloc_consistent(iop->pdev, oplen, &opmem_phys);
 	if(opmem == NULL)
 		return -ENOMEM;
 	memcpy(opmem, oplist, oplen);
 	
-	resmem = kmalloc(reslen, GFP_KERNEL);
+	resmem = pci_alloc_consistent(iop->pdev, reslen, &resmem_phys);
 	if(resmem == NULL)
 	{
-		kfree(opmem);
+		pci_free_consistent(iop->pdev, oplen, opmem, opmem_phys);
 		return -ENOMEM;
 	}
 	
@@ -2757,11 +2772,11 @@
 	msg[3] = 0;
 	msg[4] = 0;
 	msg[5] = 0x54000000 | oplen;	/* OperationList */
-	msg[6] = virt_to_bus(opmem);
+	msg[6] = opmem_phys;
 	msg[7] = 0xD0000000 | reslen;	/* ResultList */
-	msg[8] = virt_to_bus(resmem);
+	msg[8] = resmem_phys;
 
-	wait_status = i2o_post_wait_mem(iop, msg, sizeof(msg), 10, opmem, resmem);
+	wait_status = i2o_post_wait_mem(iop, msg, sizeof(msg), 10, opmem, resmem, opmem_phys, resmem_phys, oplen, reslen);
 	
 	/*
 	 *	This only looks like a memory leak - don't "fix" it.	
@@ -2769,15 +2784,13 @@
 	if(wait_status == -ETIMEDOUT)
 		return wait_status;
 
+	memcpy(reslist, resmem, reslen);
+	pci_free_consistent(iop->pdev, reslen, resmem, resmem_phys);
+	pci_free_consistent(iop->pdev, oplen, opmem, opmem_phys);
+	
 	/* Query failed */
 	if(wait_status != 0)
-	{
-		kfree(resmem);
-		kfree(opmem);
-		return wait_status;
-	}
-	
-	memcpy(reslist, resmem, reslen);
+		return wait_status;		
 	/*
 	 * Calculate number of bytes of Result LIST
 	 * We need to loop through each Result BLOCK and grab the length
@@ -3407,8 +3420,9 @@
 	{
 		if(i2o_quiesce_controller(c))
 		{
-			printk(KERN_WARNING "i2o: Could not quiesce %s."  "
-				Verify setup on next system power up.\n", c->name);
+			printk(KERN_WARNING "i2o: Could not quiesce %s.\n"
+			       "Verify setup on next system power up.\n",
+			       c->name);
 		}
 	}
 
@@ -3426,6 +3440,10 @@
 EXPORT_SYMBOL(i2o_install_handler);
 EXPORT_SYMBOL(i2o_remove_handler);
 
+EXPORT_SYMBOL(i2o_install_controller);
+EXPORT_SYMBOL(i2o_delete_controller);
+EXPORT_SYMBOL(i2o_run_queue);
+
 EXPORT_SYMBOL(i2o_claim_device);
 EXPORT_SYMBOL(i2o_release_device);
 EXPORT_SYMBOL(i2o_device_notify_on);
@@ -3450,37 +3468,27 @@
 
 EXPORT_SYMBOL(i2o_get_class_name);
 
-#ifdef MODULE
+EXPORT_SYMBOL_GPL(i2o_sys_init);
 
 MODULE_AUTHOR("Red Hat Software");
 MODULE_DESCRIPTION("I2O Core");
 MODULE_LICENSE("GPL");
 
-
-
-int init_module(void)
+static int i2o_core_init(void)
 {
 	printk(KERN_INFO "I2O Core - (C) Copyright 1999 Red Hat Software\n");
 	if (i2o_install_handler(&i2o_core_handler) < 0)
 	{
-		printk(KERN_ERR 
-			"i2o_core: Unable to install core handler.\nI2O stack not loaded!");
+		printk(KERN_ERR "i2o_core: Unable to install core handler.\nI2O stack not loaded!");
 		return 0;
 	}
 
 	core_context = i2o_core_handler.context;
 
 	/*
-	 * Attach core to I2O PCI transport (and others as they are developed)
-	 */
-#ifdef CONFIG_I2O_PCI_MODULE
-	if(i2o_pci_core_attach(&i2o_core_functions) < 0)
-		printk(KERN_INFO "i2o: No PCI I2O controllers found\n");
-#endif
-
-	/*
 	 * Initialize event handling thread
 	 */	
+
 	init_MUTEX_LOCKED(&evt_sem);
 	evt_pid = kernel_thread(i2o_core_evt, &evt_reply, CLONE_SIGHAND);
 	if(evt_pid < 0)
@@ -3500,7 +3508,7 @@
 	return 0;
 }
 
-void cleanup_module(void)
+static void i2o_core_exit(void)
 {
 	int stat;
 
@@ -3521,73 +3529,10 @@
 		}
 		printk("done.\n");
 	}
-
-#ifdef CONFIG_I2O_PCI_MODULE
-	i2o_pci_core_detach();
-#endif
-
 	i2o_remove_handler(&i2o_core_handler);
-
 	unregister_reboot_notifier(&i2o_reboot_notifier);
 }
 
-#else
-
-extern int i2o_block_init(void);
-extern int i2o_config_init(void);
-extern int i2o_lan_init(void);
-extern int i2o_pci_init(void);
-extern int i2o_proc_init(void);
-extern int i2o_scsi_init(void);
-
-int __init i2o_init(void)
-{
-	printk(KERN_INFO "Loading I2O Core - (c) Copyright 1999 Red Hat Software\n");
-	
-	if (i2o_install_handler(&i2o_core_handler) < 0)
-	{
-		printk(KERN_ERR 
-			"i2o_core: Unable to install core handler.\nI2O stack not loaded!");
-		return 0;
-	}
-
-	core_context = i2o_core_handler.context;
+module_init(i2o_core_init);
+module_exit(i2o_core_exit);
 
-	/*
-	 * Initialize event handling thread
-	 * We may not find any controllers, but still want this as 
-	 * down the road we may have hot pluggable controllers that
-	 * need to be dealt with.
-	 */	
-	init_MUTEX_LOCKED(&evt_sem);
-	if((evt_pid = kernel_thread(i2o_core_evt, &evt_reply, CLONE_SIGHAND)) < 0)
-	{
-		printk(KERN_ERR "I2O: Could not create event handler kernel thread\n");
-		i2o_remove_handler(&i2o_core_handler);
-		return 0;
-	}
-
-
-#ifdef CONFIG_I2O_PCI
-	i2o_pci_init();
-#endif
-
-	if(i2o_num_controllers)
-		i2o_sys_init();
-
-	register_reboot_notifier(&i2o_reboot_notifier);
-
-	i2o_config_init();
-#ifdef CONFIG_I2O_BLOCK
-	i2o_block_init();
-#endif
-#ifdef CONFIG_I2O_LAN
-	i2o_lan_init();
-#endif
-#ifdef CONFIG_I2O_PROC
-	i2o_proc_init();
-#endif
-	return 0;
-}
-
-#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/message/i2o/i2o_pci.c linux-2.5.28-ac1/drivers/message/i2o/i2o_pci.c
--- linux-2.5.28/drivers/message/i2o/i2o_pci.c	Thu Jul 25 10:49:25 2002
+++ linux-2.5.28-ac1/drivers/message/i2o/i2o_pci.c	Sun Jul 21 13:27:21 2002
@@ -2,7 +2,7 @@
  *	Find I2O capable controllers on the PCI bus, and register/install
  *	them with the I2O layer
  *
- *	(C) Copyright 1999   Red Hat Software
+ *	(C) Copyright 1999-2002   Red Hat Software
  *	
  *	Written by Alan Cox, Building Number Three Ltd
  * 	Modified by Deepak Saxena <deepak@plexity.net>
@@ -13,8 +13,11 @@
  * 	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  *
+ *	Ported to Linux 2.5 by Alan Cox <alan@redhat.com>
+ *
  *	TODO:
  *		Support polled I2O PCI controllers. 
+ *		Finish verifying 64bit/bigendian clean
  */
 
 #include <linux/config.h>
@@ -31,21 +34,17 @@
 #include <asm/mtrr.h>
 #endif // CONFIG_MTRR
 
-#ifdef MODULE
-/*
- * Core function table
- * See <include/linux/i2o.h> for an explanation
- */
-static struct i2o_core_func_table *core;
-
-/* Core attach function */
-extern int i2o_pci_core_attach(struct i2o_core_func_table *);
-extern void i2o_pci_core_detach(void);
-#endif /* MODULE */
+static int dpt = 0;
+
 
-/*
- *	Free bus specific resources
+/**
+ *	i2o_pci_dispose		-	Free bus specific resources
+ *	@c: I2O controller
+ *
+ *	Disable interrupts and then free interrupt, I/O and mtrr resources 
+ *	used by this controller. Called by the I2O core on unload.
  */
+ 
 static void i2o_pci_dispose(struct i2o_controller *c)
 {
 	I2O_IRQ_WRITE32(c,0xFFFFFFFF);
@@ -61,9 +60,13 @@
 #endif
 }
 
-/*
- *	No real bus specific handling yet (note that later we will
- *	need to 'steal' PCI devices on i960 mainboards)
+/**
+ *	i2o_pci_bind		-	Bind controller and devices
+ *	@c: i2o controller
+ *	@dev: i2o device
+ *
+ *	Bind a device driver to a controller. In the case of PCI all we need to do
+ *	is module housekeeping.
  */
  
 static int i2o_pci_bind(struct i2o_controller *c, struct i2o_device *dev)
@@ -72,51 +75,83 @@
 	return 0;
 }
 
+/**
+ *	i2o_pci_unbind		-	Bind controller and devices
+ *	@c: i2o controller
+ *	@dev: i2o device
+ *
+ *	Unbind a device driver from a controller. In the case of PCI all we need to do
+ *	is module housekeeping.
+ */
+ 
+
 static int i2o_pci_unbind(struct i2o_controller *c, struct i2o_device *dev)
 {
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-/*
- * Bus specific enable/disable functions
+/**
+ *	i2o_pci_enable		-	Enable controller
+ *	@c: controller
+ *
+ *	Called by the I2O core code in order to enable bus specific
+ *	resources for this controller. In our case that means unmasking the 
+ *	interrupt line.
  */
+
 static void i2o_pci_enable(struct i2o_controller *c)
 {
 	I2O_IRQ_WRITE32(c, 0);
 	c->enabled = 1;
 }
 
+/**
+ *	i2o_pci_disable		-	Enable controller
+ *	@c: controller
+ *
+ *	Called by the I2O core code in order to enable bus specific
+ *	resources for this controller. In our case that means masking the 
+ *	interrupt line.
+ */
+
 static void i2o_pci_disable(struct i2o_controller *c)
 {
 	I2O_IRQ_WRITE32(c, 0xFFFFFFFF);
 	c->enabled = 0;
 }
 
-/*
- *	Bus specific interrupt handler
+/**
+ *	i2o_pci_interrupt	-	Bus specific interrupt handler
+ *	@irq: interrupt line
+ *	@dev_id: cookie
+ *
+ *	Handle an interrupt from a PCI based I2O controller. This turns out
+ *	to be rather simple. We keep the controller pointer in the cookie.
  */
  
 static void i2o_pci_interrupt(int irq, void *dev_id, struct pt_regs *r)
 {
 	struct i2o_controller *c = dev_id;
-#ifdef MODULE
-	core->run_queue(c);
-#else
 	i2o_run_queue(c);
-#endif /* MODULE */
 }	
 
-/*
- *	Install a PCI (or in theory AGP) i2o controller
+/**
+ *	i2o_pci_install		-	Install a PCI i2o controller
+ *	@dev: PCI device of the I2O controller
  *
- * TODO: Add support for polled controllers
+ *	Install a PCI (or in theory AGP) i2o controller. Devices are
+ *	initialized, configured and registered with the i2o core subsystem. Be
+ *	very careful with ordering. There may be pending interrupts.
+ *
+ *	To Do: Add support for polled controllers
  */
+
 int __init i2o_pci_install(struct pci_dev *dev)
 {
 	struct i2o_controller *c=kmalloc(sizeof(struct i2o_controller),
 						GFP_KERNEL);
-	u8 *mem;
+	unsigned long mem;
 	u32 memptr = 0;
 	u32 size;
 	
@@ -150,8 +185,8 @@
 	/* Map the I2O controller */
 	
 	printk(KERN_INFO "i2o: PCI I2O controller at 0x%08X size=%d\n", memptr, size);
-	mem = ioremap(memptr, size);
-	if(mem==NULL)
+	mem = (unsigned long)ioremap(memptr, size);
+	if(mem==0)
 	{
 		printk(KERN_ERR "i2o: Unable to map controller.\n");
 		kfree(c);
@@ -159,17 +194,16 @@
 	}
 
 	c->bus.pci.irq = -1;
-	c->bus.pci.queue_buggy = 0;
 	c->bus.pci.dpt = 0;
 	c->bus.pci.short_req = 0;
 	c->pdev = dev;
 
-	c->irq_mask = (volatile u32 *)(mem+0x34);
-	c->post_port = (volatile u32 *)(mem+0x40);
-	c->reply_port = (volatile u32 *)(mem+0x44);
+	c->irq_mask = mem+0x34;
+	c->post_port = mem+0x40;
+	c->reply_port = mem+0x44;
 
 	c->mem_phys = memptr;
-	c->mem_offset = (u32)mem;
+	c->mem_offset = mem;
 	c->destructor = i2o_pci_dispose;
 	
 	c->bind = i2o_pci_bind;
@@ -186,14 +220,12 @@
 	 
 	if(dev->vendor == PCI_VENDOR_ID_NCR && dev->device == 0x0630)
 	{
-		c->bus.pci.short_req=1;
+		c->bus.pci.short_req = 1;
 		printk(KERN_INFO "I2O: Symbios FC920 workarounds activated.\n");
 	}
 	if(dev->subsystem_vendor == PCI_VENDOR_ID_PROMISE)
 	{
-		c->bus.pci.queue_buggy=1;
-		if (dev->subsystem_device == 0x0000) /* SX6000 ???? */
-			c->bus.pci.queue_buggy=2;
+		c->bus.pci.promise = 1;
 		printk(KERN_INFO "I2O: Promise workarounds activated.\n");
 	}
 
@@ -211,10 +243,11 @@
 #ifdef CONFIG_MTRR
 	c->bus.pci.mtrr_reg0 =
 		mtrr_add(c->mem_phys, size, MTRR_TYPE_WRCOMB, 1);
-/*
-* If it is an INTEL i960 I/O processor then set the first 64K to Uncacheable
-* since the region contains the Messaging unit which shouldn't be cached.
-*/
+	/*
+	 * If it is an INTEL i960 I/O processor then set the first 64K to
+	 * Uncacheable since the region contains the Messaging unit which
+	 * shouldn't be cached.
+	 */
 	c->bus.pci.mtrr_reg1 = -1;
 	if(dev->vendor == PCI_VENDOR_ID_INTEL || dev->vendor == PCI_VENDOR_ID_DPT)
 	{
@@ -232,17 +265,13 @@
 
 	I2O_IRQ_WRITE32(c,0xFFFFFFFF);
 
-#ifdef MODULE
-	i = core->install(c);
-#else
 	i = i2o_install_controller(c);
-#endif /* MODULE */
 	
 	if(i<0)
 	{
 		printk(KERN_ERR "i2o: Unable to install controller.\n");
 		kfree(c);
-		iounmap(mem);
+		iounmap((void *)mem);
 		return i;
 	}
 
@@ -256,12 +285,8 @@
 			printk(KERN_ERR "%s: unable to allocate interrupt %d.\n",
 				c->name, dev->irq);
 			c->bus.pci.irq = -1;
-#ifdef MODULE
-			core->delete(c);
-#else
 			i2o_delete_controller(c);
-#endif /* MODULE */	
-			iounmap(mem);
+			iounmap((void *)mem);
 			return -EBUSY;
 		}
 	}
@@ -272,6 +297,19 @@
 	return 0;	
 }
 
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
 int __init i2o_pci_scan(void)
 {
 	struct pci_dev *dev;
@@ -283,7 +321,7 @@
 	{
 		if((dev->class>>8)!=PCI_CLASS_INTELLIGENT_I2O)
 			continue;
-		if(dev->vendor == PCI_VENDOR_ID_DPT)
+		if(dev->vendor == PCI_VENDOR_ID_DPT && !dpt)
 		{
 			if(dev->device == 0xA501 || dev->device == 0xA511)
 			{
@@ -300,6 +338,11 @@
 			continue;
 		printk(KERN_INFO "i2o: I2O controller on bus %d at %d.\n",
 			dev->bus->number, dev->devfn);
+		if(pci_set_dma_mask(dev, 0xffffffff))
+		{
+			printk(KERN_WARNING "I2O controller on bus %d at %d : No suitable DMA available\n", dev->bus->number, dev->devfn);
+		 	continue;
+		}
 		pci_set_master(dev);
 		if(i2o_pci_install(dev)==0)
 			count++;
@@ -310,84 +353,43 @@
 	return count?count:-ENODEV;
 }
 
-#ifdef I2O_HOTPLUG_SUPPORT
-/*
- * Activate a newly found PCI I2O controller
- * Not used now, but will be needed in future for
- * hot plug PCI support
+
+/**
+ *	i2o_pci_core_attach	-	PCI initialisation for I2O
+ *
+ *	Find any I2O controllers and if present initialise them and bring up
+ *	the I2O subsystem.
+ *
+ *	Returns 0 on success or an error code
  */
-static void i2o_pci_activate(i2o_controller * c)
+ 
+static int i2o_pci_core_attach(void)
 {
-	int i=0;
-	struct i2o_controller *c;
-	
-	if(c->type == I2O_TYPE_PCI)
+	printk(KERN_INFO "Linux I2O PCI support (c) 1999-2002 Red Hat.\n");
+	if(i2o_pci_scan()>0)
 	{
-		I2O_IRQ_WRITE32(c,0);
-#ifdef MODULE
-		if(core->activate(c))
-#else
-		if(i2o_activate_controller(c))
-#endif /* MODULE */
-		{
-			printk("%s: Failed to initialize.\n", c->name);
-#ifdef MODULE
-			core->unlock(c);
-			core->delete(c);
-#else
-			i2o_unlock_controller(c);
-			i2o_delete_controller(c);
-#endif
-			continue;
-		}
+		i2o_sys_init();
+		return 0;
 	}
+	return -ENODEV;
 }
-#endif // I2O_HOTPLUG_SUPPORT
-
-#ifdef MODULE
-
-int i2o_pci_core_attach(struct i2o_core_func_table *table)
-{
-	MOD_INC_USE_COUNT;
-
-	core = table;
-
-	return i2o_pci_scan();
-}
-
-void i2o_pci_core_detach(void)
-{
-	core = NULL;
-
-	MOD_DEC_USE_COUNT;
-}
-
-int init_module(void)
-{
-	printk(KERN_INFO "Linux I2O PCI support (c) 1999 Red Hat Software.\n");
-	
-	core = NULL;
 
- 	return 0;
+/**
+ *	i2o_pci_core_detach	-	PCI unload for I2O
+ *
+ *	Free up any resources not released when the controllers themselves were
+ *	shutdown and unbound from the bus and drivers
+ */
  
-}
-
-void cleanup_module(void)
+static void i2o_pci_core_detach(void)
 {
 }
 
-EXPORT_SYMBOL(i2o_pci_core_attach);
-EXPORT_SYMBOL(i2o_pci_core_detach);
-
-MODULE_AUTHOR("Red Hat Software");
+MODULE_AUTHOR("Red Hat");
 MODULE_DESCRIPTION("I2O PCI Interface");
 MODULE_LICENSE("GPL");
 
-
-#else
-void __init i2o_pci_init(void)
-{
-	printk(KERN_INFO "Linux I2O PCI support (c) 1999 Red Hat Software.\n");
-	i2o_pci_scan();
-}
-#endif
+MODULE_PARM(dpt, "i");
+MODULE_PARM_DESC(dpt, "Set this if you want to drive DPT cards normally handled by dpt_i2o");
+module_init(i2o_pci_core_attach);
+module_exit(i2o_pci_core_detach);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/message/i2o/i2o_proc.c linux-2.5.28-ac1/drivers/message/i2o/i2o_proc.c
--- linux-2.5.28/drivers/message/i2o/i2o_proc.c	Thu Jul 25 10:49:25 2002
+++ linux-2.5.28-ac1/drivers/message/i2o/i2o_proc.c	Sun Jul 21 15:53:10 2002
@@ -45,6 +45,7 @@
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/tqueue.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/include/linux/i2o.h linux-2.5.28-ac1/include/linux/i2o.h
--- linux-2.5.28/include/linux/i2o.h	Thu Jul 25 10:50:19 2002
+++ linux-2.5.28-ac1/include/linux/i2o.h	Sun Jul 21 15:20:20 2002
@@ -81,9 +81,9 @@
 struct i2o_pci
 {
 	int		irq;
-	int		queue_buggy:3;	/* Don't send a lot of messages */
 	int		short_req:1;	/* Use small block sizes        */
 	int		dpt:1;		/* Don't quiesce                */
+	int		promise:1;	/* Promise controller		*/
 #ifdef CONFIG_MTRR
 	int		mtrr_reg0;
 	int		mtrr_reg1;
@@ -112,9 +112,9 @@
 	atomic_t users;
 	struct i2o_device *devices;		/* I2O device chain */
 	struct i2o_controller *next;		/* Controller chain */
-	volatile u32 *post_port;		/* Inbout port */
-	volatile u32 *reply_port;		/* Outbound port */
-	volatile u32 *irq_mask;			/* Interrupt register */
+	unsigned long post_port;		/* Inbout port address */
+	unsigned long reply_port;		/* Outbound port address */
+	unsigned long irq_mask;			/* Interrupt register address */
 
 	/* Dynamic LCT related data */
 	struct semaphore lct_sem;
@@ -122,12 +122,17 @@
 	int lct_running;
 
 	i2o_status_block *status_block;		/* IOP status block */
+	dma_addr_t status_block_phys;
 	i2o_lct *lct;				/* Logical Config Table */
+	dma_addr_t lct_phys;
 	i2o_lct *dlct;				/* Temp LCT */
+	dma_addr_t dlct_phys;
 	i2o_hrt *hrt;				/* HW Resource Table */
+	dma_addr_t hrt_phys;
+	u32 hrt_len;
 
-	u32 mem_offset;				/* MFA offset */
-	u32 mem_phys;				/* MFA physical */
+	unsigned long mem_offset;		/* MFA offset */
+	unsigned long mem_phys;			/* MFA physical */
 
 	int battery:1;				/* Has a battery backup */
 	int io_alloc:1;				/* An I/O resource was allocated */
@@ -252,34 +257,34 @@
  */
 static inline u32 I2O_POST_READ32(struct i2o_controller *c)
 {
-	return *c->post_port;
+	return readl(c->post_port);
 }
 
-static inline void I2O_POST_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_POST_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->post_port = Val;
+	writel(val, c->post_port);
 }
 
 
 static inline u32 I2O_REPLY_READ32(struct i2o_controller *c)
 {
-	return *c->reply_port;
+	return readl(c->reply_port);
 }
 
-static inline void I2O_REPLY_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_REPLY_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->reply_port = Val;
+	writel(val, c->reply_port);
 }
 
 
 static inline u32 I2O_IRQ_READ32(struct i2o_controller *c)
 {
-	return *c->irq_mask;
+	return readl(c->irq_mask);
 }
 
-static inline void I2O_IRQ_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_IRQ_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->irq_mask = Val;
+	writel(val, c->irq_mask);
 }
 
 
@@ -295,6 +300,13 @@
 	I2O_REPLY_WRITE32(c, m);
 }
 
+/*
+ *	Endian handling wrapped into the macro - keeps the core code
+ *	cleaner.
+ */
+ 
+#define i2o_raw_writel(val, mem)	__raw_writel(cpu_to_le32(val), mem)
+
 extern struct i2o_controller *i2o_find_controller(int);
 extern void i2o_unlock_controller(struct i2o_controller *);
 extern struct i2o_controller *i2o_controller_chain;
@@ -313,7 +325,7 @@
 extern int i2o_post_this(struct i2o_controller *, u32 *, int);
 extern int i2o_post_wait(struct i2o_controller *, u32 *, int, int);
 extern int i2o_post_wait_mem(struct i2o_controller *, u32 *, int, int,
-			     void *, void *);
+			     void *, void *, dma_addr_t, dma_addr_t, int, int);
 
 extern int i2o_query_scalar(struct i2o_controller *, int, int, int, void *,
 			    int);
@@ -339,13 +351,66 @@
 extern void i2o_run_queue(struct i2o_controller *);
 extern int i2o_delete_controller(struct i2o_controller *);
 
+/*
+ *	Cache strategies
+ */
+ 
+ 
+/*	The NULL strategy leaves everything up to the controller. This tends to be a
+ *	pessimal but functional choice.
+ */
+#define CACHE_NULL		0
+/*	Prefetch data when reading. We continually attempt to load the next 32 sectors
+ *	into the controller cache. 
+ */
+#define CACHE_PREFETCH		1
+/*	Prefetch data when reading. We sometimes attempt to load the next 32 sectors
+ *	into the controller cache. When an I/O is less <= 8K we assume its probably
+ *	not sequential and don't prefetch (default)
+ */
+#define CACHE_SMARTFETCH	2
+/*	Data is written to the cache and then out on to the disk. The I/O must be
+ *	physically on the medium before the write is acknowledged (default without
+ *	NVRAM)
+ */
+#define CACHE_WRITETHROUGH	17
+/*	Data is written to the cache and then out on to the disk. The controller
+ *	is permitted to write back the cache any way it wants. (default if battery
+ *	backed NVRAM is present). It can be useful to set this for swap regardless of
+ *	battery state.
+ */
+#define CACHE_WRITEBACK		18
+/*	Optimise for under powered controllers, especially on RAID1 and RAID0. We
+ *	write large I/O's directly to disk bypassing the cache to avoid the extra
+ *	memory copy hits. Small writes are writeback cached
+ */
+#define CACHE_SMARTBACK		19
+/*	Optimise for under powered controllers, especially on RAID1 and RAID0. We
+ *	write large I/O's directly to disk bypassing the cache to avoid the extra
+ *	memory copy hits. Small writes are writethrough cached. Suitable for devices
+ *	lacking battery backup
+ */
+#define CACHE_SMARTTHROUGH	20
+
+/*
+ *	Ioctl structures
+ */
+ 
+
+#define 	BLKI2OGRSTRAT	_IOR('2', 1, int) 
+#define 	BLKI2OGWSTRAT	_IOR('2', 2, int) 
+#define 	BLKI2OSRSTRAT	_IOW('2', 3, int) 
+#define 	BLKI2OSWSTRAT	_IOW('2', 4, int) 
+
+
+
 
 /*
- * I2O Function codes
+ *	I2O Function codes
  */
 
 /*
- * Executive Class
+ *	Executive Class
  */
 #define	I2O_CMD_ADAPTER_ASSIGN		0xB3
 #define	I2O_CMD_ADAPTER_READ		0xB2
@@ -416,6 +481,7 @@
 #define I2O_CMD_BLOCK_MUNLOCK		0x4B
 #define I2O_CMD_BLOCK_MMOUNT		0x41
 #define I2O_CMD_BLOCK_MEJECT		0x43
+#define I2O_CMD_BLOCK_POWER		0x70
 
 #define I2O_PRIVATE_MSG			0xFF
 
@@ -574,6 +640,7 @@
 #define EIGHT_WORD_MSG_SIZE	0x00080000
 #define NINE_WORD_MSG_SIZE	0x00090000
 #define TEN_WORD_MSG_SIZE	0x000A0000
+#define ELEVEN_WORD_MSG_SIZE	0x000B0000
 #define I2O_MESSAGE_SIZE(x)	((x)<<16)
 
 
@@ -582,10 +649,10 @@
 #define ADAPTER_TID		0
 #define HOST_TID		1
 
-#define MSG_FRAME_SIZE		128
+#define MSG_FRAME_SIZE		64	/* i2o_scsi assumes >= 32 */
 #define NMBR_MSG_FRAMES		128
 
-#define MSG_POOL_SIZE		16384
+#define MSG_POOL_SIZE		(MSG_FRAME_SIZE*NMBR_MSG_FRAMES*sizeof(u32))
 
 #define I2O_POST_WAIT_OK	0
 #define I2O_POST_WAIT_TIMEOUT	-ETIMEDOUT
