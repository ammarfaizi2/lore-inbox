Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTAEVdB>; Sun, 5 Jan 2003 16:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbTAEVdB>; Sun, 5 Jan 2003 16:33:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265270AbTAEVc5>;
	Sun, 5 Jan 2003 16:32:57 -0500
Date: Sun, 5 Jan 2003 20:34:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amd756 and amd8111 sensors support
Message-ID: <20030105193450.GA260@elf.ucw.cz>
References: <200212280303.gBS33o628113@hera.kernel.org> <1041076002.1485.2.camel@laptop.fenrus.com> <20021228123655.A31843@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228123655.A31843@infradead.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please add them inside drivers/i2c/, not at the toplevel.

Done.

>  obj-$(CONFIG_PHONE)		+= telephony/
>  obj-$(CONFIG_MD)		+= md/
>  obj-$(CONFIG_BT)		+= bluetooth/
> +#include <linux/version.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <asm/io.h>
> +#include <linux/kernel.h>
> +#include <linux/stddef.h>
> +#include <linux/sched.h>
> +#include <linux/ioport.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> 
> <asm/*.h> after <linux/*.h>, please

Fixed.

> +static struct i2c_adapter amd756_adapter = {
> +	"unset",
> +	I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
> +	&smbus_algorithm,
> +	NULL,
> +	amd756_inc,
> +	amd756_dec,
> +	NULL,
> +	NULL,
> +};
> 
> Please use named initializers for such sparse method vectors.

Fixed.

> +static int __initdata amd756_initialized;
> 
> __initdata for function used in cleanup code is bogus.  But this whole
> flag is crap, see below.

Killed.

> +static unsigned short amd756_smba = 0;
> 
> This is in .bss, no need to initialize to zero.

Ok.

> +	if (check_region(amd756_smba, SMB_IOSIZE)) {
> +		printk
> +		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
> +		     amd756_smba);
> +		return -ENODEV;
> +	}
> +
> +	/* Everything is happy, let's grab the memory and set things up. */
> +	request_region(amd756_smba, SMB_IOSIZE, "amd756-smbus");
> 
> Don't use check_region.

Fixed.

> +	amd756_initialized = 0;
> 
> It's in .bss and thus already zero.

Killed.

> +EXPORT_NO_SYMBOLS;
> 
> Remove it, it's a noop for 2.5.
> 
> +#ifdef MODULE
> +
> +MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
> +MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
> +
> +#ifdef MODULE_LICENSE
> +MODULE_LICENSE("GPL");
> +#endif
> +
> +#endif				/* MODULE */
> 
> Please get rid of that ifdef mess, you can just always use it.

Killed.

Okay, I see lot more cleaning up is needed. I actually saved it as a
"TODO" file... Thanks for your comments.

								Pavel

--- linux-sensors.mid/drivers/Makefile	2002-12-18 22:28:25.000000000 +0100
+++ linux-sensors/drivers/Makefile	2003-01-05 20:06:17.000000000 +0100
@@ -38,8 +38,6 @@
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
-obj-$(CONFIG_I2C_MAINBOARD)	+= i2c/busses/
-obj-$(CONFIG_SENSORS)		+= i2c/chips/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
--- linux-sensors.mid/drivers/i2c/Makefile	2002-12-18 22:28:30.000000000 +0100
+++ linux-sensors/drivers/i2c/Makefile	2003-01-05 20:06:13.000000000 +0100
@@ -6,6 +6,8 @@
 		   i2c-algo-ite.o i2c-proc.o i2c-algo-ibm_ocp.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
+obj-$(CONFIG_I2C_MAINBOARD)	+= busses/
+obj-$(CONFIG_SENSORS)		+= chips/
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
--- linux-sensors.mid/drivers/i2c/busses/i2c-amd756.c	2002-12-02 01:47:11.000000000 +0100
+++ linux-sensors/drivers/i2c/busses/i2c-amd756.c	2003-01-05 20:23:25.000000000 +0100
@@ -37,13 +37,13 @@
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
 
 struct sd {
     const unsigned short vendor;
@@ -116,30 +116,24 @@
 static u32 amd756_func(struct i2c_adapter *adapter);
 
 static struct i2c_algorithm smbus_algorithm = {
-	/* name */ "Non-I2C SMBus adapter",
-	/* id */ I2C_ALGO_SMBUS,
-	/* master_xfer */ NULL,
-	/* smbus_access */ amd756_access,
-	/* slave;_send */ NULL,
-	/* slave_rcv */ NULL,
-	/* algo_control */ NULL,
-	/* functionality */ amd756_func,
+	.name = "Non-I2C SMBus adapter",
+	.id = I2C_ALGO_SMBUS,
+	.smbus_xfer = amd756_access,
+	.functionality =  amd756_func,
 };
 
 static struct i2c_adapter amd756_adapter = {
-	"unset",
-	I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
-	&smbus_algorithm,
-	NULL,
-	amd756_inc,
-	amd756_dec,
-	NULL,
-	NULL,
+	.name = "unset",
+	.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
+	.algo_data = &smbus_algorithm,
+	.inc_use = amd756_inc,
+	.dec_use = amd756_dec,
 };
 
-static int __initdata amd756_initialized;
-static struct sd *amd756_sd = NULL;
-static unsigned short amd756_smba = 0;
+static struct sd *amd756_sd;
+static unsigned short amd756_smba;
+static int amd756_initialized;
+
 
 int amd756_setup(void)
 {
@@ -191,16 +185,12 @@
 		printk(KERN_ERR "i2c-amd756.o: Error: SMB base address uninitialized\n");
 		return -ENODEV;
 	}
-	if (check_region(amd756_smba, SMB_IOSIZE)) {
-		printk
-		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
-		     amd756_smba);
+	if (!request_region(amd756_smba, SMB_IOSIZE, "amd756-smbus")) {
+		printk("i2c-amd756.o: SMB region 0x%x already in use!\n",
+		       amd756_smba);
 		return -ENODEV;
 	}
 
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(amd756_smba, SMB_IOSIZE, "amd756-smbus");
-
 #ifdef DEBUG
 	pci_read_config_byte(AMD756_dev, SMBREV, &temp);
 	printk("i2c-amd756.o: SMBREV = 0x%X\n", temp);
@@ -456,15 +446,6 @@
 int __init i2c_amd756_init(void)
 {
 	int res;
-#ifdef DEBUG
-/* PE- It might be good to make this a permanent part of the code! */
-	if (amd756_initialized) {
-		printk
-		    ("i2c-amd756.o: Oops, amd756_init called a second time!\n");
-		return -EBUSY;
-	}
-#endif
-	amd756_initialized = 0;
 	if ((res = amd756_setup())) {
 		printk
 		    ("i2c-amd756.o: AMD756 or compatible device not detected, module not inserted.\n");
@@ -509,18 +490,10 @@
 			return 0;
 }
 
-EXPORT_NO_SYMBOLS;
-
-#ifdef MODULE
-
 MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
 MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
 
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
-#endif
-
-#endif				/* MODULE */
 
 module_init(i2c_amd756_init)
 module_exit(i2c_amd756_exit)
--- linux-sensors.mid/include/linux/i2c.h	2002-12-14 12:53:19.000000000 +0100
+++ linux-sensors/include/linux/i2c.h	2003-01-05 20:11:00.000000000 +0100
@@ -223,10 +223,6 @@
 	u32 (*functionality) (struct i2c_adapter *);
 };
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-struct proc_dir_entry;
-#endif
-
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
