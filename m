Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSL2VC2>; Sun, 29 Dec 2002 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSL2VC2>; Sun, 29 Dec 2002 16:02:28 -0500
Received: from verein.lst.de ([212.34.181.86]:22539 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261854AbSL2VCS>;
	Sun, 29 Dec 2002 16:02:18 -0500
Date: Sun, 29 Dec 2002 22:10:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rewrite i2c-amd756 to resemble a linux driver
Message-ID: <20021229221037.A11447@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a large rewrite of i2c-amd756 (added by Pavel post 2.5.53
although it's not his code) into a driver following linux driver
guide lines.  As a side-effect it shrinks the driver by almost one
fifth.  Tested with an early AMD756-based board.

 - use proper PCI API
 - use pr_debug instead of #ifdef DEBUG mess
 - use named initializers
 - completly restructure init/exit code
 - mark everything static

--- 1.1/drivers/i2c/busses/i2c-amd756.c	Sun Dec  1 19:47:11 2002
+++ edited/drivers/i2c/busses/i2c-amd756.c	Sun Dec 29 20:11:50 2002
@@ -27,6 +27,7 @@
 /*
     2002-04-08: Added nForce support. (Csaba Halasz)
     2002-10-03: Fixed nForce PnP I/O port. (Michael Steil)
+    2002-12-28: Rewritten into something that resembles a Linux driver (hch)
 */
 
 /*
@@ -37,43 +38,29 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <asm/io.h>
 
-struct sd {
-    const unsigned short vendor;
-    const unsigned short device;
-    const unsigned short function;
-    const char* name;
-    int amdsetup:1;
-};
-
-static struct sd supported[] = {
-    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B, 3, "AMD756", 1},
-    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413, 3, "AMD766", 1},
-    {PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", 1},
-    {PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", 0},
-    {0, 0, 0}
-};
+#define DRV_NAME	"i2c-amd756"
 
 /* AMD756 SMBus address offsets */
 #define SMB_ADDR_OFFSET        0xE0
 #define SMB_IOSIZE             16
-#define SMB_GLOBAL_STATUS      (0x0 + amd756_smba)
-#define SMB_GLOBAL_ENABLE      (0x2 + amd756_smba)
-#define SMB_HOST_ADDRESS       (0x4 + amd756_smba)
-#define SMB_HOST_DATA          (0x6 + amd756_smba)
-#define SMB_HOST_COMMAND       (0x8 + amd756_smba)
-#define SMB_HOST_BLOCK_DATA    (0x9 + amd756_smba)
-#define SMB_HAS_DATA           (0xA + amd756_smba)
-#define SMB_HAS_DEVICE_ADDRESS (0xC + amd756_smba)
-#define SMB_HAS_HOST_ADDRESS   (0xE + amd756_smba)
-#define SMB_SNOOP_ADDRESS      (0xF + amd756_smba)
+#define SMB_GLOBAL_STATUS      (0x0 + amd756_ioport)
+#define SMB_GLOBAL_ENABLE      (0x2 + amd756_ioport)
+#define SMB_HOST_ADDRESS       (0x4 + amd756_ioport)
+#define SMB_HOST_DATA          (0x6 + amd756_ioport)
+#define SMB_HOST_COMMAND       (0x8 + amd756_ioport)
+#define SMB_HOST_BLOCK_DATA    (0x9 + amd756_ioport)
+#define SMB_HAS_DATA           (0xA + amd756_ioport)
+#define SMB_HAS_DEVICE_ADDRESS (0xC + amd756_ioport)
+#define SMB_HAS_HOST_ADDRESS   (0xE + amd756_ioport)
+#define SMB_SNOOP_ADDRESS      (0xF + amd756_ioport)
 
 /* PCI Address Constants */
 
@@ -98,120 +85,8 @@
 #define AMD756_PROCESS_CALL 0x04
 #define AMD756_BLOCK_DATA   0x05
 
-/* insmod parameters */
-
-int __init i2c_amd756_init(void);
-void __exit i2c_amd756_exit(void);
-static int amd756_cleanup(void);
-
-static int amd756_setup(void);
-static s32 amd756_access(struct i2c_adapter *adap, u16 addr,
-			 unsigned short flags, char read_write,
-			 u8 command, int size, union i2c_smbus_data *data);
-static void amd756_do_pause(unsigned int amount);
-static void amd756_abort(void);
-static int amd756_transaction(void);
-static void amd756_inc(struct i2c_adapter *adapter);
-static void amd756_dec(struct i2c_adapter *adapter);
-static u32 amd756_func(struct i2c_adapter *adapter);
-
-static struct i2c_algorithm smbus_algorithm = {
-	/* name */ "Non-I2C SMBus adapter",
-	/* id */ I2C_ALGO_SMBUS,
-	/* master_xfer */ NULL,
-	/* smbus_access */ amd756_access,
-	/* slave;_send */ NULL,
-	/* slave_rcv */ NULL,
-	/* algo_control */ NULL,
-	/* functionality */ amd756_func,
-};
-
-static struct i2c_adapter amd756_adapter = {
-	"unset",
-	I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
-	&smbus_algorithm,
-	NULL,
-	amd756_inc,
-	amd756_dec,
-	NULL,
-	NULL,
-};
-
-static int __initdata amd756_initialized;
-static struct sd *amd756_sd = NULL;
-static unsigned short amd756_smba = 0;
-
-int amd756_setup(void)
-{
-	unsigned char temp;
-	struct sd *currdev;
-	struct pci_dev *AMD756_dev = NULL;
-
-	if (pci_present() == 0) {
-		return -ENODEV;
-	}
-
-	/* Look for a supported chip */
-	for(currdev = supported; currdev->vendor; ) {
-		AMD756_dev = pci_find_device(currdev->vendor,
-						currdev->device, AMD756_dev);
-		if (AMD756_dev != NULL)	{
-			if (PCI_FUNC(AMD756_dev->devfn) == currdev->function)
-				break;
-		} else {
-		    currdev++;
-		}
-	}
-
-	if (AMD756_dev == NULL) {
-		printk
-		    ("i2c-amd756.o: Error: No AMD756 or compatible device detected!\n");
-		return -ENODEV;
-	}
-	printk(KERN_INFO "i2c-amd756.o: Found %s SMBus controller.\n", currdev->name);
-
-	if (currdev->amdsetup)
-	{
-		pci_read_config_byte(AMD756_dev, SMBGCFG, &temp);
-		if ((temp & 128) == 0) {
-			printk("i2c-amd756.o: Error: SMBus controller I/O not enabled!\n");
-			return -ENODEV;
-		}
-
-		/* Determine the address of the SMBus areas */
-		/* Technically it is a dword but... */
-		pci_read_config_word(AMD756_dev, SMBBA, &amd756_smba);
-		amd756_smba &= 0xff00;
-		amd756_smba += SMB_ADDR_OFFSET;
-	} else {
-		pci_read_config_word(AMD756_dev, SMBBANFORCE, &amd756_smba);
-		amd756_smba &= 0xfffc;
-	}
-	if(amd756_smba == 0) {
-		printk(KERN_ERR "i2c-amd756.o: Error: SMB base address uninitialized\n");
-		return -ENODEV;
-	}
-	if (check_region(amd756_smba, SMB_IOSIZE)) {
-		printk
-		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
-		     amd756_smba);
-		return -ENODEV;
-	}
-
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(amd756_smba, SMB_IOSIZE, "amd756-smbus");
 
-#ifdef DEBUG
-	pci_read_config_byte(AMD756_dev, SMBREV, &temp);
-	printk("i2c-amd756.o: SMBREV = 0x%X\n", temp);
-	printk("i2c-amd756.o: AMD756_smba = 0x%X\n", amd756_smba);
-#endif				/* DEBUG */
-
-	/* store struct sd * for future reference */
-        amd756_sd = currdev;
-
-	return 0;
-}
+static unsigned short amd756_ioport = 0;
 
 /* 
   SMBUS event = I/O 28-29 bit 11
@@ -220,7 +95,7 @@
 */
 
 /* Internally used pause function */
-void amd756_do_pause(unsigned int amount)
+static void amd756_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
@@ -241,33 +116,21 @@
 #define GE_HOST_STC (1 << 3)
 #define GE_ABORT (1 << 5)
 
-void amd756_abort(void)
-{
-	printk("i2c-amd756.o: Sending abort.\n");
-	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
-	amd756_do_pause(100);
-	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
-}
 
-int amd756_transaction(void)
+static int amd756_transaction(void)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    ("i2c-amd756.o: Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
-	     inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
-	     inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
-#endif
+	pr_debug(DRV_NAME
+	       ": Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+	       inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
+	       inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
-#ifdef DEBUG
-		printk
-		    ("i2c-amd756.o: SMBus busy (%04x). Waiting... \n", temp);
-#endif
+		pr_debug(DRV_NAME ": SMBus busy (%04x). Waiting... \n", temp);
 		do {
 			amd756_do_pause(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
@@ -275,9 +138,8 @@
 		         (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
-			printk("i2c-amd756.o: Busy wait timeout! (%04x)\n", temp);
-			amd756_abort();
-			return -1;
+			pr_debug(DRV_NAME ": Busy wait timeout (%04x)\n", temp);
+			goto abort;
 		}
 		timeout = 0;
 	}
@@ -293,64 +155,63 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		printk("i2c-amd756.o: Completion timeout!\n");
-		amd756_abort ();
-		return -1;
+		pr_debug(DRV_NAME ": Completion timeout!\n");
+		goto abort;
 	}
 
 	if (temp & GS_PRERR_STS) {
 		result = -1;
-#ifdef DEBUG
-		printk("i2c-amd756.o: SMBus Protocol error (no response)!\n");
-#endif
+		pr_debug(DRV_NAME ": SMBus Protocol error (no response)!\n");
 	}
 
 	if (temp & GS_COL_STS) {
 		result = -1;
-		printk("i2c-amd756.o: SMBus collision!\n");
+		printk(KERN_WARNING DRV_NAME " SMBus collision!\n");
 	}
 
 	if (temp & GS_TO_STS) {
 		result = -1;
-#ifdef DEBUG
-		printk("i2c-amd756.o: SMBus protocol timeout!\n");
-#endif
-	}
-#ifdef DEBUG
-	if (temp & GS_HCYC_STS) {
-		printk("i2c-amd756.o: SMBus protocol success!\n");
+		pr_debug(DRV_NAME ": SMBus protocol timeout!\n");
 	}
-#endif
+
+	if (temp & GS_HCYC_STS)
+		pr_debug(DRV_NAME " SMBus protocol success!\n");
 
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 
 #ifdef DEBUG
 	if (((temp = inw_p(SMB_GLOBAL_STATUS)) & GS_CLEAR_STS) != 0x00) {
-		printk
-		    ("i2c-amd756.o: Failed reset at end of transaction (%04x)\n",
-		     temp);
-	}
-	printk
-	    ("i2c-amd756.o: Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
-	     inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
-	     inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
+		pr_debug(DRV_NAME
+		         ": Failed reset at end of transaction (%04x)\n", temp);
+	}
+
+	pr_debug(DRV_NAME
+		 ": Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+		 inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
+		 inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
 #endif
 
 	return result;
+
+ abort:
+	printk(KERN_WARNING DRV_NAME ": Sending abort.\n");
+	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
+	amd756_do_pause(100);
+	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
+	return -1;
 }
 
 /* Return -1 on error. */
-s32 amd756_access(struct i2c_adapter * adap, u16 addr,
+static s32 amd756_access(struct i2c_adapter * adap, u16 addr,
 		  unsigned short flags, char read_write,
 		  u8 command, int size, union i2c_smbus_data * data)
 {
 	int i, len;
 
-  /** TODO: Should I supporte the 10-bit transfers? */
+	/** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		printk
-		    ("i2c-amd756.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		pr_debug(DRV_NAME ": I2C_SMBUS_PROC_CALL not supported!\n");
 		/* TODO: Well... It is supported, I'm just not sure what to do here... */
 		return -1;
 	case I2C_SMBUS_QUICK:
@@ -435,92 +296,140 @@
 	return 0;
 }
 
-void amd756_inc(struct i2c_adapter *adapter)
+static void amd756_inc(struct i2c_adapter *adapter)
 {
 	MOD_INC_USE_COUNT;
 }
 
-void amd756_dec(struct i2c_adapter *adapter)
+static void amd756_dec(struct i2c_adapter *adapter)
 {
 
 	MOD_DEC_USE_COUNT;
 }
 
-u32 amd756_func(struct i2c_adapter *adapter)
+static u32 amd756_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL;
 }
 
-int __init i2c_amd756_init(void)
+static struct i2c_algorithm smbus_algorithm = {
+	.name		= "Non-I2C SMBus adapter",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= amd756_access,
+	.functionality	= amd756_func,
+};
+
+static struct i2c_adapter amd756_adapter = {
+	.name		= "unset",
+	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
+	.algo		= &smbus_algorithm,
+	.inc_use	= amd756_inc,
+	.dec_use	= amd756_dec,
+};
+
+enum chiptype { AMD756, AMD766, AMD768, NFORCE };
+
+static struct pci_device_id amd756_ids[] __devinitdata = {
+	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
+	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
+	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
+	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
+	{ 0, }
+};
+
+static int __devinit amd756_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *id)
 {
-	int res;
-#ifdef DEBUG
-/* PE- It might be good to make this a permanent part of the code! */
-	if (amd756_initialized) {
-		printk
-		    ("i2c-amd756.o: Oops, amd756_init called a second time!\n");
-		return -EBUSY;
+	int nforce = (id->driver_data == NFORCE), error;
+	u8 temp;
+	
+	if (amd756_ioport) {
+		printk(KERN_ERR DRV_NAME ": Only one device supported. "
+		       "(you have a strange motherboard, btw..)\n");
+		return -ENODEV;
+	}
+
+	if (nforce) {
+		if (PCI_FUNC(pdev->devfn) != 1)
+			return -ENODEV;
+
+		pci_read_config_word(pdev, SMBBANFORCE, &amd756_ioport);
+		amd756_ioport &= 0xfffc;
+	} else { /* amd */
+		if (PCI_FUNC(pdev->devfn) != 3)
+			return -ENODEV;
+
+		pci_read_config_byte(pdev, SMBGCFG, &temp);
+		if ((temp & 128) == 0) {
+			printk(KERN_ERR DRV_NAME
+			       ": Error: SMBus controller I/O not enabled!\n");
+			return -ENODEV;
+		}
+
+		/* Determine the address of the SMBus areas */
+		/* Technically it is a dword but... */
+		pci_read_config_word(pdev, SMBBA, &amd756_ioport);
+		amd756_ioport &= 0xff00;
+		amd756_ioport += SMB_ADDR_OFFSET;
+	}
+
+	if (!request_region(amd756_ioport, SMB_IOSIZE, "amd756-smbus")) {
+		printk(KERN_ERR DRV_NAME
+		       ": SMB region 0x%x already in use!\n", amd756_ioport);
+		return -ENODEV;
 	}
+
+#ifdef DEBUG
+	pci_read_config_byte(pdev, SMBREV, &temp);
+	printk(KERN_DEBUG DRV_NAME ": SMBREV = 0x%X\n", temp);
+	printk(KERN_DEBUG DRV_NAME ": AMD756_smba = 0x%X\n", amd756_ioport);
 #endif
-	amd756_initialized = 0;
-	if ((res = amd756_setup())) {
-		printk
-		    ("i2c-amd756.o: AMD756 or compatible device not detected, module not inserted.\n");
-		amd756_cleanup();
-		return res;
-	}
-	amd756_initialized++;
-	sprintf(amd756_adapter.name, "SMBus %s adapter at %04x",
-		amd756_sd->name, amd756_smba);
-	if ((res = i2c_add_adapter(&amd756_adapter))) {
-		printk
-		    ("i2c-amd756.o: Adapter registration failed, module not inserted.\n");
-		amd756_cleanup();
-		return res;
-	}
-	amd756_initialized++;
-	printk("i2c-amd756.o: %s bus detected and initialized\n",
-               amd756_sd->name);
+
+	sprintf(amd756_adapter.name,
+		"SMBus AMD75x adapter at %04x", amd756_ioport);
+
+	error = i2c_add_adapter(&amd756_adapter);
+	if (error) {
+		printk(KERN_ERR DRV_NAME
+		       ": Adapter registration failed, module not inserted.\n");
+		goto out_err;
+	}
+
 	return 0;
+
+ out_err:
+	release_region(amd756_ioport, SMB_IOSIZE);
+	return error;
 }
 
-void __exit i2c_amd756_exit(void)
+static void __devexit amd756_remove(struct pci_dev *dev)
 {
-	amd756_cleanup();
+	i2c_del_adapter(&amd756_adapter);
+	release_region(amd756_ioport, SMB_IOSIZE);
 }
 
-static int amd756_cleanup(void)
+static struct pci_driver amd756_driver = {
+	.name		= "amd75x smbus",
+	.id_table	= amd756_ids,
+	.probe		= amd756_probe,
+	.remove		= __devexit_p(amd756_remove),
+};
+
+static int __init amd756_init(void)
 {
-	int res;
-	if (amd756_initialized >= 2) {
-		if ((res = i2c_del_adapter(&amd756_adapter))) {
-			printk
-			    ("i2c-amd756.o: i2c_del_adapter failed, module not removed\n");
-			return res;
-		} else
-			amd756_initialized--;
-	}
-	if (amd756_initialized >= 1) {
-		release_region(amd756_smba, SMB_IOSIZE);
-		amd756_initialized--;
-	}
-			return 0;
+	return pci_module_init(&amd756_driver);
 }
 
-EXPORT_NO_SYMBOLS;
-
-#ifdef MODULE
+static void __exit amd756_exit(void)
+{
+	pci_unregister_driver(&amd756_driver);
+}
 
 MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
 MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
-
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
-#endif
-
-#endif				/* MODULE */
 
-module_init(i2c_amd756_init)
-module_exit(i2c_amd756_exit)
+module_init(amd756_init)
+module_exit(amd756_exit)
