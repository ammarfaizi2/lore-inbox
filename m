Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281221AbRKLXts>; Mon, 12 Nov 2001 18:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281220AbRKLXtc>; Mon, 12 Nov 2001 18:49:32 -0500
Received: from jalon.able.es ([212.97.163.2]:7409 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281213AbRKLXs4>;
	Mon, 12 Nov 2001 18:48:56 -0500
Date: Tue, 13 Nov 2001 00:48:46 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113004846.G1531@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 12, 2001 at 20:01:56 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011112 Linus Torvalds wrote:
>
>Ok, this kernel hopefully contains all the high-priority merges with Alan,
>which means that as far as that is concerned, I'm done with 2.4.x and
>ready to pass it on to Marcelo.
>
>Which means that I'd also like people to double-check that there are no
>embarrassing missing pieces due to the merge (or other patches).
>

This is an update-cleanup of the i2c code to the current CVS. In short,
it adds version info printing and some CONFIG_ cleanups (there were
CONFIG_ vars defined in Config.in that had been renamed inside the code).
Please consider for next pre of 2.4.15.

--- linux-old/Documentation/i2c/writing-clients	Tue Nov 13 00:31:34 CET 2001
+++ linux/Documentation/i2c/writing-clients	Tue Nov 13 00:31:34 CET 2001
@@ -366,5 +366,5 @@
 The detect client function is called by i2c_probe or i2c_detect.
 The `kind' parameter contains 0 if this call is due to a `force'
-parameter, and 0 otherwise (for i2c_detect, it contains 0 if
+parameter, and -1 otherwise (for i2c_detect, it contains 0 if
 this call is due to the generic `force' parameter, and the chip type
 number if it is due to a specific `force' parameter).
--- linux-old/drivers/i2c/i2c-algo-bit.c	Tue Nov 13 00:31:36 CET 2001
+++ linux/drivers/i2c/i2c-algo-bit.c	Tue Nov 13 00:31:36 CET 2001
@@ -22,5 +22,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.c,v 1.30 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.33 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -610,5 +609,5 @@
 int __init i2c_algo_bit_init (void)
 {
-	printk("i2c-algo-bit.o: i2c bit algorithm module\n");
+	printk("i2c-algo-bit.o: i2c bit algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return 0;
 }
--- linux-old/drivers/i2c/i2c-algo-pcf.c	Tue Nov 13 00:31:37 CET 2001
+++ linux/drivers/i2c/i2c-algo-pcf.c	Tue Nov 13 00:31:37 CET 2001
@@ -151,6 +150,5 @@
 	/* check to see S1 now used as R/W ctrl -
 	   PCF8584 does that when ESO is zero */
-	/* PCF also resets PIN bit */
-	if ((temp = get_pcf(adap, 1)) != (0)) {
+	if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
 		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
 		return -ENXIO; /* definetly not PCF8584 */
@@ -168,5 +166,5 @@
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
 	/* check to see S2 now selected */
-	if ((temp = get_pcf(adap, 1)) != I2C_PCF_ES1) {
+	if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
 		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
 		return -ENXIO;
@@ -525,5 +523,5 @@
 int __init i2c_algo_pcf_init (void)
 {
-	printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module\n");
+	printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return 0;
 }
--- linux-old/drivers/i2c/i2c-core.c	Tue Nov 13 00:31:40 CET 2001
+++ linux/drivers/i2c/i2c-core.c	Tue Nov 13 00:31:40 CET 2001
@@ -21,5 +21,5 @@
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-core.c,v 1.64 2001/08/13 01:35:56 mds Exp $ */
+/* $Id: i2c-core.c,v 1.69 2001/10/28 20:41:47 mds Exp $ */
 
 #include <linux/module.h>
@@ -37,5 +36,5 @@
 #include <linux/init.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
@@ -1264,5 +1263,5 @@
 static int __init i2c_init(void)
 {
-	printk("i2c-core.o: i2c core module\n");
+	printk("i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
@@ -1285,11 +1284,11 @@
 	extern int i2c_algo_bit_init(void);
 #endif
-#ifdef CONFIG_I2C_PHILIPSPAR
+#ifdef CONFIG_I2C_BITLP
 	extern int i2c_bitlp_init(void);
 #endif
-#ifdef CONFIG_I2C_ELV
+#ifdef CONFIG_I2C_BITELV
 	extern int i2c_bitelv_init(void);
 #endif
-#ifdef CONFIG_I2C_VELLEMAN
+#ifdef CONFIG_I2C_BITVELLE
 	extern int i2c_bitvelle_init(void);
 #endif
@@ -1301,5 +1300,5 @@
 	extern int i2c_algo_pcf_init(void);	
 #endif
-#ifdef CONFIG_I2C_ELEKTOR
+#ifdef CONFIG_I2C_PCFISA
 	extern int i2c_pcfisa_init(void);
 #endif
@@ -1330,11 +1329,11 @@
 	i2c_algo_bit_init();
 #endif
-#ifdef CONFIG_I2C_PHILIPSPAR
+#ifdef CONFIG_I2C_BITLP
 	i2c_bitlp_init();
 #endif
-#ifdef CONFIG_I2C_ELV
+#ifdef CONFIG_I2C_BITELV
 	i2c_bitelv_init();
 #endif
-#ifdef CONFIG_I2C_VELLEMAN
+#ifdef CONFIG_I2C_BITVELLE
 	i2c_bitvelle_init();
 #endif
@@ -1344,5 +1343,5 @@
 	i2c_algo_pcf_init();	
 #endif
-#ifdef CONFIG_I2C_ELEKTOR
+#ifdef CONFIG_I2C_PCFISA
 	i2c_pcfisa_init();
 #endif
--- linux-old/drivers/i2c/i2c-dev.c	Tue Nov 13 00:31:41 CET 2001
+++ linux/drivers/i2c/i2c-dev.c	Tue Nov 13 00:31:41 CET 2001
@@ -29,5 +29,5 @@
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.40 2001/08/25 01:28:01 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.43 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/config.h>
@@ -488,5 +487,5 @@
 	int res;
 
-	printk("i2c-dev.o: i2c /dev entries driver module\n");
+	printk("i2c-dev.o: i2c /dev entries driver module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	i2cdev_initialized = 0;
--- linux-old/drivers/i2c/i2c-elektor.c	Tue Nov 13 00:31:42 CET 2001
+++ linux/drivers/i2c/i2c-elektor.c	Tue Nov 13 00:31:42 CET 2001
@@ -75,5 +74,6 @@
 	int address = ctl ? (base + 1) : base;
 
-	if (ctl && irq) {
+	/* enable irq if any specified for serial operation */
+	if (ctl && irq && (val & I2C_PCF_ESO)) {
 		val |= I2C_PCF_ENI;
 	}
@@ -274,5 +274,5 @@
 	}
 
-	printk("i2c-elektor.o: i2c pcf8584-isa adapter module\n");
+	printk("i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	if (base == 0) {
@@ -284,6 +284,8 @@
 #endif
 	if (pcf_isa_init() == 0) {
-		if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
+		if (i2c_pcf_add_bus(&pcf_isa_ops) < 0) {
+			pcf_isa_exit();
 			return -ENODEV;
+		}
 	} else {
 		return -ENODEV;
--- linux-old/drivers/i2c/i2c-elv.c	Tue Nov 13 00:31:43 CET 2001
+++ linux/drivers/i2c/i2c-elv.c	Tue Nov 13 00:31:43 CET 2001
@@ -22,5 +22,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elv.c,v 1.17 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-elv.c,v 1.20 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -171,5 +169,5 @@
 int __init i2c_bitelv_init(void)
 {
-	printk("i2c-elv.o: i2c ELV parallel port adapter module\n");
+	printk("i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
 		/* probe some values */
--- linux-old/include/linux/i2c-id.h	Tue Nov 13 00:31:43 CET 2001
+++ linux/include/linux/i2c-id.h	Tue Nov 13 00:31:43 CET 2001
@@ -21,5 +21,5 @@
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.35 2001/08/12 17:22:20 mds Exp $ */
+/* $Id: i2c-id.h,v 1.40 2001/11/11 22:16:33 mds Exp $ */
 
 #ifndef I2C_ID_H
@@ -128,4 +128,7 @@
 #define I2C_DRIVERID_IT87 1026
 #define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
+#define I2C_DRIVERID_FSCPOS 1028
+#define I2C_DRIVERID_FSCSCY 1029
+#define I2C_DRIVERID_PCF8591 1030
 
 /*
@@ -144,5 +147,6 @@
 #define I2C_ALGO_SAA7146 0x060000	/* SAA 7146 video decoder bus	*/
 #define I2C_ALGO_ACB 	0x070000	/* ACCESS.bus algorithm         */
-
+#define I2C_ALGO_IIC    0x080000 	/* ITE IIC bus */
+#define I2C_ALGO_SAA7134 0x090000
 #define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */
 
@@ -189,4 +193,7 @@
 /* --- MPC8xx PowerPC adapters						*/
 #define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
+
+/* --- ITE based algorithms						*/
+#define I2C_HW_I_IIC	0x00	/* controller on the ITE */
 
 /* --- SMBus only adapters						*/
--- linux-old/drivers/i2c/i2c-pcf8584.h	Tue Nov 13 00:31:43 CET 2001
+++ linux/drivers/i2c/i2c-pcf8584.h	Tue Nov 13 00:31:43 CET 2001
@@ -22,5 +22,5 @@
 /* With some changes from Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-pcf8584.h,v 1.3 2000/01/18 23:54:07 frodo Exp $ */
+/* $Id: i2c-pcf8584.h,v 1.4 2001/10/02 00:07:37 mds Exp $ */
 
 #ifndef I2C_PCF8584_H
--- linux-old/drivers/i2c/i2c-philips-par.c	Tue Nov 13 00:31:44 CET 2001
+++ linux/drivers/i2c/i2c-philips-par.c	Tue Nov 13 00:31:44 CET 2001
@@ -22,5 +22,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-philips-par.c,v 1.18 2000/07/06 19:21:49 frodo Exp $ */
+/* $Id: i2c-philips-par.c,v 1.21 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -265,5 +264,5 @@
 	struct parport *port;
 #endif
-	printk("i2c-philips-par.o: i2c Philips parallel port adapter module\n");
+	printk("i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
--- linux-old/drivers/i2c/i2c-proc.c	Tue Nov 13 00:31:46 CET 2001
+++ linux/drivers/i2c/i2c-proc.c	Tue Nov 13 00:31:46 CET 2001
@@ -39,8 +39,4 @@
 #include <linux/init.h>
 
-/* FIXME need i2c versioning */
-#define LM_DATE "20010825"
-#define LM_VERSION "2.6.1"
-
 #ifndef THIS_MODULE
 #define THIS_MODULE NULL
@@ -859,5 +853,5 @@
 int __init sensors_init(void)
 {
-	printk("i2c-proc.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk("i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	i2c_initialized = 0;
 	if (!
@@ -904,3 +900,4 @@
 	return i2c_cleanup();
 }
+
 #endif				/* MODULE */
--- linux-old/drivers/i2c/i2c-velleman.c	Tue Nov 13 00:31:47 CET 2001
+++ linux/drivers/i2c/i2c-velleman.c	Tue Nov 13 00:31:47 CET 2001
@@ -19,5 +19,5 @@
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-velleman.c,v 1.19 2000/01/24 02:06:33 mds Exp $ */
+/* $Id: i2c-velleman.c,v 1.22 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -161,5 +160,5 @@
 int __init  i2c_bitvelle_init(void)
 {
-	printk("i2c-velleman.o: i2c Velleman K8000 adapter module\n");
+	printk("i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
 		/* probe some values */
--- linux-old/drivers/i2c/Config.in	Tue Nov 13 00:31:48 CET 2001
+++ linux/drivers/i2c/Config.in	Tue Nov 13 00:31:48 CET 2001
@@ -11,20 +11,14 @@
    dep_tristate 'I2C bit-banging interfaces'  CONFIG_I2C_ALGOBIT $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
-      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
-      dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
-      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_BITLP $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
+      dep_tristate '  ELV adapter' CONFIG_I2C_BITELV $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_BITVELLE $CONFIG_I2C_ALGOBIT
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then
-      dep_tristate '  Elektor ISA card' CONFIG_I2C_ELEKTOR $CONFIG_I2C_ALGOPCF
+      dep_tristate '  Elektor ISA card' CONFIG_I2C_PCFISA $CONFIG_I2C_ALGOPCF
    fi
 
-   if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
-      dep_tristate 'ITE I2C Algorithm' CONFIG_ITE_I2C_ALGO $CONFIG_I2C
-      if [ "$CONFIG_ITE_I2C_ALGO" != "n" ]; then
-         dep_tristate '  ITE I2C Adapter' CONFIG_ITE_I2C_ADAP $CONFIG_ITE_I2C_ALGO
-      fi
-   fi
    if [ "$CONFIG_8xx" = "y" ]; then
       dep_tristate 'MPC8xx CPM I2C interface' CONFIG_I2C_ALGO8XX $CONFIG_I2C
@@ -33,4 +27,5 @@
       fi
    fi
+
    if [ "$CONFIG_405" = "y" ]; then
       dep_tristate 'PPC 405 I2C Algorithm' CONFIG_I2C_PPC405_ALGO $CONFIG_I2C
@@ -44,4 +39,5 @@
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
+
    dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
 
--- linux-old/drivers/i2c/Makefile	Tue Nov 13 00:31:48 CET 2001
+++ linux/drivers/i2c/Makefile	Tue Nov 13 00:31:48 CET 2001
@@ -5,17 +5,14 @@
 O_TARGET := i2c.o
 
-export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
-		   i2c-algo-ite.o i2c-proc.o
+export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o i2c-proc.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
-obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
-obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
-obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
+obj-$(CONFIG_I2C_BITLP)	+= i2c-philips-par.o
+obj-$(CONFIG_I2C_BITELV)	+= i2c-elv.o
+obj-$(CONFIG_I2C_BITVELLE)	+= i2c-velleman.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
-obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
-obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
-obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
+obj-$(CONFIG_I2C_PCFISA)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
 
--- linux-old/Documentation/Configure.help	Tue Nov 13 00:31:49 CET 2001
+++ linux/Documentation/Configure.help	Tue Nov 13 00:31:49 CET 2001
@@ -16041,14 +16041,32 @@
   unless you are absolutely sure.
 
+UltraSPARC-III bootbus i2c controller driver
+CONFIG_BBC_I2C
+  The BBC devices on the UltraSPARC III have two I2C controllers.  The
+  first I2C controller connects mainly to configuration PROMs (NVRAM,
+  CPU configuration, DIMM types, etc.).  The second I2C controller
+  connects to environmental control devices such as fans and
+  temperature sensors.  The second controller also connects to the
+  smartcard reader, if present.  Say Y to enable support for these.
+
+I2C /proc support
+CONFIG_I2C_PROC
+  This provides support for i2c device entries in the /proc filesystem.
+  The entries will be found in /proc/sys/dev/sensors.
+
+  This code is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
+  The module will be called i2c-proc.o.
+
 I2C support
 CONFIG_I2C
   I2C (pronounce: I-square-C) is a slow serial bus protocol used in
-  many micro controller applications and developed by Philips.  SMBus,
-  or System Management Bus is a subset of the I2C protocol.  More
+  many micro controller applications and developed by Philips. SMBus,
+  or System Management Bus is a subset of the I2C protocol. More
   information is contained in the directory <file:Documentation/i2c/>,
   especially in the file called "summary" there.
 
   Both I2C and SMBus are supported here. You will need this for
-  hardware sensors support, and also for Video For Linux support.
+  hardware sensors support, and also for Video for Linux support.
   Specifically, if you want to use a BT848 based frame grabber/overlay
   boards under Linux, say Y here and also to "I2C bit-banging
@@ -16056,41 +16074,29 @@
 
   If you want I2C support, you should say Y here and also to the
-  specific driver for your bus adapter(s) below.  If you say Y to
+  specific driver for your bus adapter(s) below. If you say Y to
   "/proc file system" below, you will then get a /proc interface which
   is documented in <file:Documentation/i2c/proc-interface>.
 
-  This I2C support is also available as a module.  If you want to
+  This I2C support is also available as a module. If you want to
   compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.
-  The module will be called i2c-core.o.
-
-UltraSPARC-III bootbus i2c controller driver
-CONFIG_BBC_I2C
-  The BBC devices on the UltraSPARC III have two I2C controllers.  The
-  first I2C controller connects mainly to configuration PROMs (NVRAM,
-  CPU configuration, DIMM types, etc.).  The second I2C controller
-  connects to environmental control devices such as fans and
-  temperature sensors.  The second controller also connects to the
-  smartcard reader, if present.  Say Y to enable support for these.
+  <file:Documentation/modules.txt>. The module will be called i2c-core.o.
 
 I2C bit-banging interfaces
 CONFIG_I2C_ALGOBIT
   This allows you to use a range of I2C adapters called bit-banging
-  adapters.  Say Y if you own an I2C adapter belonging to this class
+  adapters. Say Y if you own an I2C adapter belonging to this class
   and then say Y to the specific driver for you adapter below.
 
-  This support is also available as a module.  If you want to compile
-  it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+  This support is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-algo-bit.o.
 
 Philips style parallel port adapter
-CONFIG_I2C_PHILIPSPAR
-  This supports parallel-port I2C adapters made by Philips.  Say Y if
+CONFIG_I2C_BITLP
+  This supports parallel-port I2C adapters made by Philips. Say Y if
   you own such an adapter.
 
-  This driver is also available as a module.  If you want to compile
-  it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+  This driver is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-philips-par.o.
 
@@ -16099,21 +16105,19 @@
 
 ELV adapter
-CONFIG_I2C_ELV
-  This supports parallel-port I2C adapters called ELV.  Say Y if you
+CONFIG_I2C_BITELV
+  This supports parallel-port I2C adapters called ELV. Say Y if you
   own such an adapter.
 
-  This driver is also available as a module.  If you want to compile
-  it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+  This driver is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-elv.o.
 
 Velleman K9000 adapter
-CONFIG_I2C_VELLEMAN
-  This supports the Velleman K9000 parallel-port I2C adapter.  Say Y
-  if you own such an adapter.
-
-  This driver is also available as a module.  If you want to compile
-  it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+CONFIG_I2C_BITVELLE
+  This supports the Velleman K9000 parallel-port I2C adapter. Say Y if
+  you own such an adapter.
+
+  This driver is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-velleman.o.
 
@@ -16124,17 +16128,15 @@
   Y to the specific driver for you adapter below.
 
-  This support is also available as a module.  If you want to compile
-  it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+  This support is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-algo-pcf.o.
 
 Elektor ISA card
-CONFIG_I2C_ELEKTOR
-  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
-  such an adapter.
-
-  This driver is also available as a module.  If you want to compile
-  it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+CONFIG_I2C_PCFISA
+  This supports the PCF8584 ISA bus I2C adapter. Say Y if you own such
+  an adapter.
+
+  This driver is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-elektor.o.
 
@@ -16142,11 +16144,10 @@
 CONFIG_I2C_CHARDEV
   Say Y here to use i2c-* device files, usually found in the /dev
-  directory on your system.  They make it possible to have user-space
-  programs use the I2C bus.  Information on how to do this is
-  contained in the file <file:Documentation/i2c/dev-interface>.
-
-  This code is also available as a module.  If you want to compile
-  it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+  directory on your system. They make it possible to have user-space
+  programs use the I2C bus. Information on how to do this is contained
+  in the file <file:Documentation/i2c/dev-interface>.
+
+  This code is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-dev.o.
 


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre3-beo #1 SMP Mon Nov 12 00:04:41 CET 2001 i686
