Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276750AbRJHBsV>; Sun, 7 Oct 2001 21:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276751AbRJHBsM>; Sun, 7 Oct 2001 21:48:12 -0400
Received: from sushi.toad.net ([162.33.130.105]:24530 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276750AbRJHBsB>;
	Sun, 7 Oct 2001 21:48:01 -0400
Subject: [PATCH] 2.4.10-ac8 PnP BIOS fix #1
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 21:47:59 -0400
Message-Id: <1002505680.829.85.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the first patch to 2.4.10-ac8 PnP BIOS driver.
It's the same one I described earlier, now against -ac8:

*  Clean up code formatting a bit more.
*  Move the pnpid32_to_pnpid() function earlier in the file,
      eliminating the need to declare it.
*  Break out of loops that scan nodes if an error is returned by
      get_dev_node.  This should be safer than ignoring the error
      or continuing on to the next node.
*  Fix bug in reporting of reserved resources (end of range too
      large by 1)
*  Fix bug in naming of requested regions that results in
      incorrect output from /proc/ioports
*  Allocate memory using pnp_bios_kmalloc() function ... so that
      error message is printed on failure
*  Cast args to u32 in call_pnp_bios() ... just to make sure.

// Thomas

The patch:
--- linux-2.4.10-ac8/drivers/pnp/pnp_bios.c	Sun Oct  7 14:38:45 2001
+++ linux-2.4.10-ac8-fix/drivers/pnp/pnp_bios.c	Sun Oct  7 15:37:29 2001
@@ -196,10 +196,10 @@
 		"popl %%edi\n\t"
 		"popl %%ebp\n\t"
 		: "=a" (status)
-		: "0" ((func) | (arg1 << 16)),
-		  "b" ((arg2) | (arg3 << 16)),
-		  "c" ((arg4) | (arg5 << 16)),
-		  "d" ((arg6) | (arg7 << 16)),
+		: "0" ((func) | (((u32)arg1) << 16)),
+		  "b" ((arg2) | (((u32)arg3) << 16)),
+		  "c" ((arg4) | (((u32)arg5) << 16)),
+		  "d" ((arg6) | (((u32)arg7) << 16)),
 		  "i" (PNP_CS32),
 		  "i" (0)
 		: "memory"
@@ -209,14 +209,24 @@
 	/* If we got here and this is set the pnp bios faulted on us.. */
 	if(pnp_bios_is_utter_crap)
 	{
-		printk(KERN_ERR "*** Warning: your PnP BIOS caused a fatal error. Attempting to continue\n");
-		printk(KERN_ERR "*** You may need to reboot with the \"nobiospnp\" option to operate stably\n");
-		printk(KERN_ERR "*** Check with your vendor for an updated BIOS\n");
+		printk(KERN_ERR "PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue.\n");
+		printk(KERN_ERR "PnPBIOS: You may need to reboot with the \"nobiospnp\" option to operate stably.\n");
+		printk(KERN_ERR "PnPBIOS: Check with your vendor for an updated BIOS\n");
 	}
+
+//	if ( status ) printk(KERN_WARNING "PnPBIOS: BIOS returned error 0x%x from function 0x%x.\n", status, func);
 		
 	return status;
 }
 
+static void *pnp_bios_kmalloc(size_t size, int f)
+{
+	void *p = kmalloc( size, f );
+	if ( p == NULL )
+		printk(KERN_ERR "PnPBIOS: kmalloc() failed.\n");
+	return p;
+}
+
 /*
  *
  * PnP BIOS ACCESS FUNCTIONS
@@ -226,7 +236,6 @@
 /*
  * Call PnP BIOS with function 0x00, "get number of system device nodes"
  */
-
 int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
 	u16 status;
@@ -252,7 +261,6 @@
  *               or volatile current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
-
 int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
@@ -270,7 +278,6 @@
  *        boot = whether to set nonvolatile boot (!=0)
  *               or volatile current (0) config
  */
-
 int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
@@ -314,7 +321,6 @@
 /*
  * Call PnP BIOS with function 0x05, "get docking station information"
  */
-
 static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
 {
 	u16 status;
@@ -469,10 +475,10 @@
 	if (!current->fs->root) {
 		return -EAGAIN;
 	}
-	if (!(envp = (char **) kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
+	if (!(envp = (char **) pnp_bios_kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
-	if (!(buf = kmalloc (256, GFP_KERNEL))) {
+	if (!(buf = pnp_bios_kmalloc (256, GFP_KERNEL))) {
 		kfree (envp);
 		return -ENOMEM;
 	}
@@ -514,7 +520,6 @@
 /*
  * Poll the PnP docking at a regular interval
  */
- 
 static int pnp_dock_thread(void * unused)
 {
 	static struct pnp_docking_station_info now;
@@ -536,7 +541,6 @@
 
 		err = pnp_bios_dock_station_info(&now);
 
-
 		switch(err)
 		{
 			/*
@@ -551,7 +555,7 @@
 				d = 1;
 				break;
 			default:
-				printk(KERN_WARNING "dock: unexpected pnpbios error %d,\n", err);
+				printk(KERN_WARNING "PnPBIOS: Unexpected error 0x%x returned by BIOS.\n", err);
 				continue;
 		}
 		if(d != docked)
@@ -559,7 +563,7 @@
 			if(pnp_dock_event(d, &now)==0)
 			{
 				docked = d;
-//				printk(KERN_INFO "Docking station %stached.\n", docked?"at":"de");
+//				printk(KERN_INFO "PnPBIOS: Docking station %stached.\n", docked?"at":"de");
 			}
 		}
 	}	
@@ -596,7 +600,7 @@
 	}
 }
 
-static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io, int len)
+static void inline pnpbios_add_ioresource(struct pci_dev *dev, int io, int len)
 {
 	int i = 0;
 	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
@@ -607,19 +611,17 @@
 	}
 }
 
-static void __init pnpbios_add_memresource(struct pci_dev *dev, int io, int len)
+static void inline pnpbios_add_memresource(struct pci_dev *dev, int mem, int len)
 {
 	int i = 0;
 	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
 	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->resource[i].start = io;
-		dev->resource[i].end = io + len;
+		dev->resource[i].start = mem;
+		dev->resource[i].end = mem + len;
 		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 	}
 }
 
-static char * __init pnpid32_to_pnpid(u32 id);
-
 /*
  * request I/O ports which are used according to the PnP BIOS
  * to avoid I/O conflicts.
@@ -627,6 +629,7 @@
 static void mboard_request(char *pnpid, int io, int len)
 {
 	struct resource *res;
+	char *regionid;
     
 	if (
 		0 != strcmp(pnpid,"PNP0c01") &&  /* memory controller */
@@ -637,7 +640,7 @@
 
 	if (io < 0x100) {
 		/*
-		 * below 0x100 is only standard PC hardware
+		 * Below 0x100 is only standard PC hardware
 		 * (pics, kbd, timer, dma, ...)
 		 *
 		 * We should not get resource conflicts there,
@@ -648,22 +651,59 @@
 	}
 
 	/*
-	 * anything else we'll try reserve to avoid these ranges are
+	 * Anything else we'll try reserve to avoid these ranges are
 	 * assigned to someone (CardBus bridges for example) and thus are
 	 * triggering resource conflicts.
 	 *
-	 * failures at this point are usually harmless. pci quirks for
+	 * Failures at this point are usually harmless. pci quirks for
 	 * example do reserve stuff they know about too, so we might have
 	 * double reservations here.
+	 *
+	 * We really shouldn't just reserve these regions, though, since
+	 * that prevents the device drivers from claiming them.
 	 */
-	res = request_region(io,len,pnpid);
-	printk("PnPBIOS: %s: request 0x%x-0x%x%s\n",
-		pnpid,io,io+len,NULL != res ? " ok" : "");
+	regionid = pnp_bios_kmalloc(8, GFP_KERNEL);
+	if ( regionid == NULL )
+		return;
+	memcpy(regionid,pnpid,8);
+	res = request_region(io,len,regionid);
+	if ( res == NULL )
+		kfree( regionid );
+	printk(
+		"PnPBIOS: %s: 0x%x-0x%x %s reserved\n",
+		pnpid, io, io+len-1,
+		NULL != res ? "has been" : "was already"
+	);
 
 	return;
 }
 
-/* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev */
+
+#define HEX(id,a) hex[((id)>>a) & 15]
+#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
+
+static char * __init pnpid32_to_pnpid(u32 id)
+{
+	const char *hex = "0123456789abcdef";
+	static char str[8];
+	id = be32_to_cpu(id);
+	str[0] = CHAR(id, 26);
+	str[1] = CHAR(id, 21);
+	str[2] = CHAR(id,16);
+	str[3] = HEX(id, 12);
+	str[4] = HEX(id, 8);
+	str[5] = HEX(id, 4);
+	str[6] = HEX(id, 0);
+	str[7] = '\0';
+	return str;
+}                                              
+
+#undef CHAR
+#undef HEX  
+
+/*
+ * parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev
+ */
 static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
@@ -771,28 +811,6 @@
         return;
 }
 
-#define HEX(id,a) hex[((id)>>a) & 15]
-#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
-
-static char * __init pnpid32_to_pnpid(u32 id)
-{
-	const char *hex = "0123456789abcdef";
-	static char str[8];
-	id = be32_to_cpu(id);
-	str[0] = CHAR(id, 26);
-	str[1] = CHAR(id, 21);
-	str[2] = CHAR(id,16);
-	str[3] = HEX(id, 12);
-	str[4] = HEX(id, 8);
-	str[5] = HEX(id, 4);
-	str[6] = HEX(id, 0);
-	str[7] = '\0';
-	return str;
-}                                              
-
-#undef CHAR
-#undef HEX  
-
 /*
  *
  * PnP BIOS PUBLIC DEVICE MANAGEMENT LAYER FUNCTIONS
@@ -836,16 +854,20 @@
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return;
 
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnp_bios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return;
 
 	for(i=0,nodenum=0;i<0xff && nodenum!=0xff;i++) {
 		int thisnodenum = nodenum;
+		/* For now we build the list from the "boot" config
+		 * because asking for the "current" config causes
+		 * some BIOSes to crash.
+		 */
 		if (pnp_bios_get_dev_node((u8 *)&nodenum, (char )1 , node))
-			continue;
+			break;
 		nodes_got++;
-		dev =  kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
+		dev =  pnp_bios_kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
 			break;
 		pnpbios_rawdata_2_pci_dev(node,dev);
@@ -1042,7 +1064,7 @@
 	spin_lock_init(&pnp_bios_lock);
 
 	if(pnp_bios_disabled) {
-		printk(KERN_INFO "PnPBIOS: driver disabled.\n");
+		printk(KERN_INFO "PnPBIOS: Disabled.\n");
 		return;
 	}
 
@@ -1062,14 +1084,13 @@
 		if (sum)
 			continue;
 		if (check->fields.version < 0x10) {
-			printk(KERN_WARNING "PnPBIOS: unsupported version %d.%d",
+			printk(KERN_WARNING "PnPBIOS: PnP BIOS version %d.%d is not supported.\n",
 			       check->fields.version >> 4,
 			       check->fields.version & 15);
 			continue;
 		}
-		printk(KERN_INFO "PnPBIOS: PnP BIOS installation structure at 0x%p\n",
-		       check);
-		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry at 0x%x:0x%x, dseg at 0x%x\n",
+		printk(KERN_INFO "PnPBIOS: Found PnP BIOS installation structure at 0x%p.\n", check);
+		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry 0x%x:0x%x, dseg 0x%x.\n",
                        check->fields.version >> 4, check->fields.version & 15,
 		       check->fields.pm16cseg, check->fields.pm16offset,
 		       check->fields.pm16dseg);
--- linux-2.4.10-ac8/drivers/pnp/pnp_proc.c	Sun Oct  7 14:38:45 2001
+++ linux-2.4.10-ac8-fix/drivers/pnp/pnp_proc.c	Sun Oct  7 15:37:29 2001
@@ -34,7 +34,8 @@
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	for (i=0,nodenum=0;i<0xff && nodenum!=0xff; i++) {
-		pnp_bios_get_dev_node(&nodenum, 1, node);
+		if ( pnp_bios_get_dev_node(&nodenum, 1, node) )
+			break;
 		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
 			     node->handle, node->eisa_id,
 			     node->type_code[0], node->type_code[1],
@@ -58,7 +59,8 @@
 	}
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	pnp_bios_get_dev_node(&nodenum, boot, node);
+	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
+		return -EIO;
 	len = node->size - sizeof(struct pnp_bios_node);
 	memcpy(buf, node->data, len);
 	kfree(node);
@@ -74,7 +76,8 @@
 
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	pnp_bios_get_dev_node(&nodenum, boot, node);
+	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
+		return -EIO;
 	if (count != node->size - sizeof(struct pnp_bios_node))
 		return -EINVAL;
 	memcpy(node->data, buf, count);

