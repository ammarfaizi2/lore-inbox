Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWB1ORA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWB1ORA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWB1ORA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:17:00 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:3566 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1750927AbWB1OQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:16:59 -0500
Message-ID: <44045B98.8010405@metro.cx>
Date: Tue, 28 Feb 2006 15:18:00 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk
CC: linux-kernel@vger.kernel.org, ben@simtec.co.uk
Subject: [patch] s3c2412 support
Content-Type: multipart/mixed;
 boundary="------------070900030203090209040109"
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070900030203090209040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Koen Martens <kmartens@sonologic.nl>

Changes are:
- Added s3c2412-specific files to arch/arm/mach-s3c2410
- Added s3c2412 detection to arch/arm/mach-s3c2410/cpu.c
- Added CONFIG_CPU_S3C2412
- Added s3c2412 specific registers and register addresses to
  various regs-*.h files in include/asm-arm/arch-s3c2410

All changes are preliminary, final documentation is not yet available
from samsung. We did test on actual hardware, but outside the linux
kernel (due to limited number of actual chips we have available and
lack of proper PCB with serial lines exported).

Signed-off-by: Koen Martens <kmartens@sonologic.nl>

Have fun,

Koen Martens

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/



--------------070900030203090209040109
Content-Type: text/x-patch;
 name="Kconfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kconfig.diff"

--- linux-2.6.15.4/arch/arm/mach-s3c2410/Kconfig	2006-02-10 08:22:48.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/Kconfig	2006-02-27 16:23:34.000000000 +0100
+config CPU_S3C2412
+	bool
+	depends on ARCH_S3C2410
+	help
+	  Support for S3C2412 and S3C2413 family from the S3C24XX line
+	  of Samsung Mobile CPUs.
+
 config CPU_S3C2440
 	bool
 	depends on ARCH_S3C2410

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="Makefile.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile.diff"

--- linux-2.6.15.4/arch/arm/mach-s3c2410/Makefile	2006-02-10 08:22:48.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/Makefile	2006-02-27 17:10:25.000000000 +0100
@@ -20,24 +20,26 @@
 obj-$(CONFIG_PM)	   += pm.o sleep.o
 obj-$(CONFIG_PM_SIMTEC)	   += pm-simtec.o
 
+# S3C2412 support
+
+obj-$(CONFIG_CPU_S3C2412)  += s3c2412.o s3c2440-dsc.o
+# obj-$(CONFIG_CPU_S3C2412)  += s3c2412-irq.o
+# obj-$(CONFIG_CPU_S3C2412)  += s3c2412-clock.o
+
 # S3C2440 support
 
 obj-$(CONFIG_CPU_S3C2440)  += s3c2440.o s3c2440-dsc.o
 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-irq.o
 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-clock.o
 

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="cpu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu.diff"

--- linux-2.6.15.4/arch/arm/mach-s3c2410/cpu.c	2006-02-10 08:22:48.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/cpu.c	2006-02-28 10:59:03.000000000 +0100
@@ -41,6 +41,7 @@
 #include "cpu.h"
 #include "clock.h"
 #include "s3c2410.h"
+#include "s3c2412.h"
 #include "s3c2440.h"
 
 struct cpu_table {
@@ -58,7 +59,9 @@
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2410a[] = "S3C2410A";
+static const char name_s3c2412[] = "S3C2412";
 static const char name_s3c2440a[] = "S3C2440A";
+static const char name_s3c2442x[] = "S3C2442X";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -96,6 +99,27 @@
 		.init_uarts	= s3c2440_init_uarts,
 		.init		= s3c2440_init,
 		.name		= name_s3c2440a
+	},
+	{
+		.idcode		= 0x32440aaa,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2440_map_io,
+		.init_clocks	= s3c2440_init_clocks,
+		.init_uarts	= s3c2440_init_uarts,
+		.init		= s3c2440_init,
+		.name		= name_s3c2442x
+	}
+};
+
+static struct cpu_table alternative_cpu_ids[] __initdata = {
+	{
+		.idcode		= 0x32410002,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2412_map_io,
+		.init_clocks	= s3c2412_init_clocks,
+		.init_uarts	= s3c2412_init_uarts,
+		.init		= s3c2412_init,
+		.name		= name_s3c2412
 	}
 };
 
@@ -110,13 +134,16 @@
 
 
 static struct cpu_table *
-s3c_lookup_cpu(unsigned long idcode)
+s3c_lookup_cpu(unsigned long idcode,int alt)
 {
 	struct cpu_table *tab;
 	int count;
+	int size;
 
-	tab = cpu_ids;
-	for (count = 0; count < ARRAY_SIZE(cpu_ids); count++, tab++) {
+	tab = alt?alternative_cpu_ids:cpu_ids;
+	size = alt?ARRAY_SIZE(alternative_cpu_ids):ARRAY_SIZE(cpu_ids);
+
+	for (count = 0; count < size; count++, tab++) {
 		if ((idcode & tab->idmask) == tab->idcode)
 			return tab;
 	}
@@ -154,7 +181,12 @@
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 
 	idcode = __raw_readl(S3C2410_GSTATUS1);
-	cpu = s3c_lookup_cpu(idcode);
+	cpu = s3c_lookup_cpu(idcode,0);
+
+	if (cpu == NULL) {
+	  idcode = __raw_readl(S3C2412_GSTATUS1);
+	  cpu = s3c_lookup_cpu(idcode,1);
+	}
 
 	if (cpu == NULL) {
 		printk(KERN_ERR "Unknown CPU type 0x%08lx\n", idcode);

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="hardware.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hardware.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/hardware.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/hardware.h	2006-02-28 12:51:47.000000000 +0100
@@ -86,18 +86,17 @@
 
 extern void s3c2410_gpio_pullup(unsigned int pin, unsigned int to);
 
 extern void s3c2410_gpio_setpin(unsigned int pin, unsigned int to);
 
 extern unsigned int s3c2410_gpio_getpin(unsigned int pin);
 
 extern unsigned int s3c2410_modify_misccr(unsigned int clr, unsigned int chg);
 
+#ifdef CONFIG_CPU_S3C2412
+extern unsigned int s3c2412_modify_misccr(unsigned int clr, unsigned int chg);
+#endif
 
 #endif /* __ASSEMBLY__ */
 

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="regs-clock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regs-clock.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-clock.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-clock.h	2006-02-28 12:55:19.000000000 +0100
@@ -112,6 +112,25 @@
 	return (unsigned int)fvco;
 }
 
+#ifdef CONFIG_CPU_S3C2412
+static inline unsigned int
+s3c2412_get_pll(int pllval, int baseclk)
+{
+       int mdiv, pdiv, sdiv;
+
+       mdiv = pllval >> S3C2410_PLLCON_MDIVSHIFT;
+       pdiv = pllval >> S3C2410_PLLCON_PDIVSHIFT;
+       sdiv = pllval >> S3C2410_PLLCON_SDIVSHIFT;
+
+       mdiv &= S3C2410_PLLCON_MDIVMASK;
+       pdiv &= S3C2410_PLLCON_PDIVMASK;
+       sdiv &= S3C2410_PLLCON_SDIVMASK;
+
+       return (baseclk * ((mdiv + 8)<<1) ) / ((pdiv + 2) << sdiv);
+ }
+#endif /* CONFIG_CPU_S3C2412 */
+
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_CPU_S3C2440
@@ -138,5 +157,21 @@
 
 #endif /* CONFIG_CPU_S3C2440 */
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_CLKDIVN_HCLKDIV_MASK (3<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_1_2  (0<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_2_4  (1<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_3_6  (2<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_4_8  (3<<0)
+#define S3C2412_CLKDIVN_PCLKDIV      (1<<2)
+#define S3C2412_CLKDIVN_ARMDIV       (1<<3)
+#define S3C2412_CLKDIVN_DVSEN        (1<<4)
+#define S3C2412_CLKDIVN_HALFHCLK     (1<<5)
+#define S3C2412_CLKDIVN_USB48DIV     (1<<6)
+#define S3C2412_CLKDIVN_UARTCLK_MASK (15<<8)
+#define S3C2412_CLKDIVN_I2SCLK_MASK  (15<<12)
+
+#endif /* CONFIG_CPU_S3C2412 */
 
 #endif /* __ASM_ARM_REGS_CLOCK */

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="regs-dsc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regs-dsc.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-dsc.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-dsc.h	2006-02-27 16:34:02.000000000 +0100
@@ -12,6 +12,7 @@
  *  Changelog:
  *    11-Aug-2004     BJD     Created file
  *    25-Aug-2004     BJD     Added the _SELECT_* defs for using with functions
+ *    27-Feb-2006     KM      Added changes for S3C2412 / S3C2413
 */
 
 
@@ -179,5 +181,174 @@
 
 #endif /* CONFIG_CPU_S3C2440 */
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_DSC0	   S3C2410_GPIOREG(0xdc)
+#define S3C2412_DSC1	   S3C2410_GPIOREG(0xe0)
+
+#define S3C2412_SELECT_DSC0 (0)
+#define S3C2412_SELECT_DSC1 (1<<31)
+
+#define S3C2412_DSC_GETSHIFT(x) ((x) & 31)
+
+#define S3C2412_DSC0_DISABLE	(1<<31)
+
+/* D0..D7 */
+#define S3C2412_DSC0_DATA0      (S3C2412_SELECT_DSC0 | 0)
+#define S3C2412_DSC0_DATA0_10mA (0<<0)
+#define S3C2412_DSC0_DATA0_6mA  (1<<0)
+#define S3C2412_DSC0_DATA0_8mA  (2<<0)
+#define S3C2412_DSC0_DATA0_4mA  (3<<0)
+#define S3C2412_DSC0_DATA0_MASK (3<<0)
+
+/* D8..D15 */
+#define S3C2412_DSC0_DATA1      (S3C2412_SELECT_DSC0 | 2)
+#define S3C2412_DSC0_DATA1_10mA (0<<2)
+#define S3C2412_DSC0_DATA1_6mA  (1<<2)
+#define S3C2412_DSC0_DATA1_8mA  (2<<2)
+#define S3C2412_DSC0_DATA1_4mA  (3<<2)
+#define S3C2412_DSC0_DATA1_MASK (3<<2)
+
+/* D16..D23 */
+#define S3C2412_DSC0_DATA2      (S3C2412_SELECT_DSC0 | 4)
+#define S3C2412_DSC0_DATA2_10mA (0<<4)
+#define S3C2412_DSC0_DATA2_6mA  (1<<4)
+#define S3C2412_DSC0_DATA2_8mA  (2<<4)
+#define S3C2412_DSC0_DATA2_4mA  (3<<4)
+#define S3C2412_DSC0_DATA2_MASK (3<<4)
+
+/* D24..D31 */
+#define S3C2412_DSC0_DATA3      (S3C2412_SELECT_DSC0 | 6)
+#define S3C2412_DSC0_DATA3_10mA (0<<6)
+#define S3C2412_DSC0_DATA3_6mA  (1<<6)
+#define S3C2412_DSC0_DATA3_8mA  (2<<6)
+#define S3C2412_DSC0_DATA3_4mA  (3<<6)
+#define S3C2412_DSC0_DATA3_MASK (3<<6)
+
+/* ADDRESS BUS */
+#define S3C2412_DSC0_ADDR      (S3C2412_SELECT_DSC0 | 8)
+#define S3C2412_DSC0_ADDR_10mA (0<<8)
+#define S3C2412_DSC0_ADDR_6mA  (1<<8)
+#define S3C2412_DSC0_ADDR_8mA  (2<<8)
+#define S3C2412_DSC0_ADDR_4mA  (3<<8)
+#define S3C2412_DSC0_ADDR_MASK (3<<8)
+
+/* nGCS0 */
+#define S3C2412_DSC0_CS0       (S3C2412_SELECT_DSC0 | 10)
+#define S3C2412_DSC0_CS0_10mA  (0<<10)
+#define S3C2412_DSC0_CS0_6mA   (1<<10)
+#define S3C2412_DSC0_CS0_8mA   (2<<10)
+#define S3C2412_DSC0_CS0_4mA   (3<<10)
+#define S3C2412_DSC0_CS0_MASK  (3<<10)
+
+/* nGCS1 */
+#define S3C2412_DSC0_CS1       (S3C2412_SELECT_DSC0 | 12)
+#define S3C2412_DSC0_CS1_10mA  (0<<12)
+#define S3C2412_DSC0_CS1_6mA   (1<<12)
+#define S3C2412_DSC0_CS1_8mA   (2<<12)
+#define S3C2412_DSC0_CS1_4mA   (3<<12)
+#define S3C2412_DSC0_CS1_MASK  (3<<12)
+
+/* nGCS2 */
+#define S3C2412_DSC0_CS2       (S3C2412_SELECT_DSC0 | 14)
+#define S3C2412_DSC0_CS2_10mA  (0<<14)
+#define S3C2412_DSC0_CS2_6mA   (1<<14)
+#define S3C2412_DSC0_CS2_8mA   (2<<14)
+#define S3C2412_DSC0_CS2_4mA   (3<<14)
+#define S3C2412_DSC0_CS2_MASK  (3<<14)
+
+/* nGCS3 */
+#define S3C2412_DSC0_CS3       (S3C2412_SELECT_DSC0 | 16)
+#define S3C2412_DSC0_CS3_10mA  (0<<16)
+#define S3C2412_DSC0_CS3_6mA   (1<<16)
+#define S3C2412_DSC0_CS3_8mA   (2<<16)
+#define S3C2412_DSC0_CS3_4mA   (3<<16)
+#define S3C2412_DSC0_CS3_MASK  (3<<16)
+
+/* nGCS4 */
+#define S3C2412_DSC0_CS4       (S3C2412_SELECT_DSC0 | 18)
+#define S3C2412_DSC0_CS4_10mA  (0<<18)
+#define S3C2412_DSC0_CS4_6mA   (1<<18)
+#define S3C2412_DSC0_CS4_8mA   (2<<18)
+#define S3C2412_DSC0_CS4_4mA   (3<<18)
+#define S3C2412_DSC0_CS4_MASK  (3<<18)
+
+/* nGCS5 */
+#define S3C2412_DSC0_CS5       (S3C2412_SELECT_DSC0 | 20)
+#define S3C2412_DSC0_CS5_10mA  (0<<20)
+#define S3C2412_DSC0_CS5_6mA   (1<<20)
+#define S3C2412_DSC0_CS5_8mA   (2<<20)
+#define S3C2412_DSC0_CS5_4mA   (3<<20)
+#define S3C2412_DSC0_CS5_MASK  (3<<20)
+
+/* nGCS6 */
+#define S3C2412_DSC0_CS6       (S3C2412_SELECT_DSC0 | 22)
+#define S3C2412_DSC0_CS6_10mA  (0<<22)
+#define S3C2412_DSC0_CS6_6mA   (1<<22)
+#define S3C2412_DSC0_CS6_8mA   (2<<22)
+#define S3C2412_DSC0_CS6_4mA   (3<<22)
+#define S3C2412_DSC0_CS6_MASK  (3<<22)
+
+/* nGCS7 */
+#define S3C2412_DSC0_CS7       (S3C2412_SELECT_DSC0 | 24)
+#define S3C2412_DSC0_CS7_10mA  (0<<24)
+#define S3C2412_DSC0_CS7_6mA   (1<<24)
+#define S3C2412_DSC0_CS7_8mA   (2<<24)
+#define S3C2412_DSC0_CS7_4mA   (3<<24)
+#define S3C2412_DSC0_CS7_MASK  (3<<24)
+
+
+
+/* SCLK */
+#define S3C2412_DSC0_SCK       (S3C2412_SELECT_DSC1 | 0)
+#define S3C2412_DSC0_SCK_10mA  (0<<0)
+#define S3C2412_DSC0_SCK_6mA   (1<<0)
+#define S3C2412_DSC0_SCK_8mA   (2<<0)
+#define S3C2412_DSC0_SCK_4mA   (3<<0)
+#define S3C2412_DSC0_SCK_MASK  (3<<0)
+
+/* SCKE */
+#define S3C2412_DSC0_SCKE      (S3C2412_SELECT_DSC1 | 6)
+#define S3C2412_DSC0_SCKE_10mA (0<<6)
+#define S3C2412_DSC0_SCKE_6mA  (1<<6)
+#define S3C2412_DSC0_SCKE_8mA  (2<<6)
+#define S3C2412_DSC0_SCKE_4mA  (3<<6)
+#define S3C2412_DSC0_SCKE_MASK (3<<6)
+
+/* SDR */
+#define S3C2412_DSC0_SDR       (S3C2412_SELECT_DSC1 | 8)
+#define S3C2412_DSC0_SDR_10mA  (0<<8)
+#define S3C2412_DSC0_SDR_6mA   (1<<8)
+#define S3C2412_DSC0_SDR_8mA   (2<<8)
+#define S3C2412_DSC0_SDR_4mA   (3<<8)
+#define S3C2412_DSC0_SDR_MASK  (3<<8)
+
+/* Nand Flash */
+#define S3C2412_DSC0_NFC       (S3C2412_SELECT_DSC1 | 10)
+#define S3C2412_DSC0_NFC_10mA  (0<<10)
+#define S3C2412_DSC0_NFC_6mA   (1<<10)
+#define S3C2412_DSC0_NFC_8mA   (2<<10)
+#define S3C2412_DSC0_NFC_4mA   (3<<10)
+#define S3C2412_DSC0_NFC_MASK  (3<<10)
+
+/* nBE */
+#define S3C2412_DSC0_BE        (S3C2412_SELECT_DSC1 | 12)
+#define S3C2412_DSC0_BE_10mA   (0<<12)
+#define S3C2412_DSC0_BE_6mA    (1<<12)
+#define S3C2412_DSC0_BE_8mA    (2<<12)
+#define S3C2412_DSC0_BE_4mA    (3<<12)
+#define S3C2412_DSC0_BE_MASK   (3<<12)
+
+/* nWE/nOE */
+#define S3C2412_DSC0_WOE       (S3C2412_SELECT_DSC1 | 14)
+#define S3C2412_DSC0_WOE_10mA  (0<<14)
+#define S3C2412_DSC0_WOE_6mA   (1<<14)
+#define S3C2412_DSC0_WOE_8mA   (2<<14)
+#define S3C2412_DSC0_WOE_4mA   (3<<14)
+#define S3C2412_DSC0_WOE_MASK  (3<<14)
+
+#endif /* CONFIG_CPU_S3C2412 */
+
+
 #endif	/* __ASM_ARCH_REGS_DSC_H */
 

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="regs-gpio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regs-gpio.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-gpio.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-gpio.h	2006-02-28 13:05:07.000000000 +0100
@@ -22,6 +22,7 @@
  *    28-Mar-2005    LCVR    Fixed definition of GPB10
  *    26-Oct-2005    BJD     Added generic configuration types
  *    27-Nov-2005    LCVR    Added definitions to S3C2400 registers
+ *    27-Feb-2006    KM      Added definitions to S3C2412 registers
 */
 
 
@@ -183,10 +184,12 @@
 #define S3C2410_GPBCON	   S3C2410_GPIOREG(0x10)
 #define S3C2410_GPBDAT	   S3C2410_GPIOREG(0x14)
 #define S3C2410_GPBUP	   S3C2410_GPIOREG(0x18)

 #define S3C2400_GPBCON	   S3C2410_GPIOREG(0x08)
 #define S3C2400_GPBDAT	   S3C2410_GPIOREG(0x0C)
 #define S3C2400_GPBUP	   S3C2410_GPIOREG(0x10)
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2410_GPBSLPCON  S3C2410_GPIOREG(0x1c)
+#endif
 
 /* no i/o pin in port b can have value 3! */
 
@@ -306,6 +309,10 @@
 #define S3C2400_GPCDAT	   S3C2410_GPIOREG(0x18)
 #define S3C2400_GPCUP	   S3C2410_GPIOREG(0x1C)
 
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2410_GPCSLPCON  S3C2410_GPIOREG(0x2c)
+#endif
+
 #define S3C2410_GPC0            S3C2410_GPIONO(S3C2410_GPIO_BANKC, 0)
 #define S3C2410_GPC0_INP	(0x00 << 0)
 #define S3C2410_GPC0_OUTP	(0x01 << 0)
@@ -423,6 +430,10 @@
 #define S3C2400_GPDDAT	   S3C2410_GPIOREG(0x24)
 #define S3C2400_GPDUP	   S3C2410_GPIOREG(0x28)
 
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2410_GPDSLPCON  S3C2410_GPIOREG(0x3c)
+#endif
+
 #define S3C2410_GPD0            S3C2410_GPIONO(S3C2410_GPIO_BANKD, 0)
 #define S3C2410_GPD0_INP	(0x00 << 0)
 #define S3C2410_GPD0_OUTP	(0x01 << 0)
@@ -537,6 +548,10 @@
 #define S3C2400_GPEDAT	   S3C2410_GPIOREG(0x30)
 #define S3C2400_GPEUP	   S3C2410_GPIOREG(0x34)
 
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2410_GPESLPCON  S3C2410_GPIOREG(0x4c)
+#endif
+
 #define S3C2410_GPE0           S3C2410_GPIONO(S3C2410_GPIO_BANKE, 0)
 #define S3C2410_GPE0_INP       (0x00 << 0)
 #define S3C2410_GPE0_OUTP      (0x01 << 0)
@@ -870,6 +885,10 @@
 #define S3C2410_GPHDAT	   S3C2410_GPIOREG(0x74)
 #define S3C2410_GPHUP	   S3C2410_GPIOREG(0x78)
 
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2410_GPHSLPCON  S3C2410_GPIOREG(0x7c)
+#endif
+
 #define S3C2410_GPH0        S3C2410_GPIONO(S3C2410_GPIO_BANKH, 0)
 #define S3C2410_GPH0_INP    (0x00 << 0)
 #define S3C2410_GPH0_OUTP   (0x01 << 0)
@@ -932,6 +951,11 @@
 #define S3C2410_MISCCR	   S3C2410_GPIOREG(0x80)
 #define S3C2410_DCLKCON	   S3C2410_GPIOREG(0x84)
 
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2412_MISCCR     S3C2410_GPIOREG(0x90)
+#define S3C2412_DCLKCON    S3C2410_GPIOREG(0x94)
+#endif
+
 /* see clock.h for dclk definitions */
 
 /* pullup control on databus */
@@ -948,6 +972,18 @@
 #define S3C2400_MISCCR_HZ_STOPEN    (0<<2)
 #define S3C2400_MISCCR_HZ_STOPPREV  (1<<2)
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_MISCCR_SPUCR_HEN    (0)
+#define S3C2412_MISCCR_SPUCR_HDIS   (1<<1)
+#define S3C2412_MISCCR_SPUCR_LEN    (0)
+#define S3C2412_MISCCR_SPUCR_LDIS   (1<<0)
+  	 
+#define S3C2412_MISCCR_SPUCR2_EN    (0<<2)
+#define S3C2412_MISCCR_SPUCR2_DIS   (1<<2)
+
+#endif
+
 #define S3C2410_MISCCR_USBDEV	    (0<<3)
 #define S3C2410_MISCCR_USBHOST	    (1<<3)
 
@@ -989,6 +1025,12 @@
 #define S3C2410_EXTINT1	   S3C2410_GPIOREG(0x8C)
 #define S3C2410_EXTINT2	   S3C2410_GPIOREG(0x90)
 
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2412_EXTINT0    S3C2410_GPIOREG(0x98)
+#define S3C2412_EXTINT1    S3C2410_GPIOREG(0x9C)
+#define S3C2412_EXTINT2    S3C2410_GPIOREG(0xA0)
+#endif
+
 /* values for S3C2410_EXTINT0/1/2 */
 #define S3C2410_EXTINT_LOWLEV	 (0x00)
 #define S3C2410_EXTINT_HILEV	 (0x01)
@@ -1002,6 +1044,13 @@
 #define S3C2410_EINFLT2	   S3C2410_GPIOREG(0x9C)
 #define S3C2410_EINFLT3	   S3C2410_GPIOREG(0xA0)
 
+#ifdef CONFIG_CPU_S3C2412
+#define S3C2412_EINFLT0    S3C2410_GPIOREG(0xA4)
+#define S3C2412_EINFLT1    S3C2410_GPIOREG(0xA8)
+#define S3C2412_EINFLT2    S3C2410_GPIOREG(0xAc)
+#define S3C2412_EINFLT3    S3C2410_GPIOREG(0xB0)
+#endif
+
 /* values for interrupt filtering */
 #define S3C2410_EINTFLT_PCLK		(0x00)
 #define S3C2410_EINTFLT_EXTCLK		(1<<7)
@@ -1019,6 +1068,17 @@
 #define S3C2410_GSTATUS3   S3C2410_GPIOREG(0x0B8)
 #define S3C2410_GSTATUS4   S3C2410_GPIOREG(0x0BC)
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_GSTATUS0   S3C2410_GPIOREG(0x0BC)
+#define S3C2412_GSTATUS1   S3C2410_GPIOREG(0x0C0)
+#define S3C2412_GSTATUS2   S3C2410_GPIOREG(0x0C4)
+#define S3C2412_GSTATUS3   S3C2410_GPIOREG(0x0C8)
+#define S3C2412_GSTATUS4   S3C2410_GPIOREG(0x0CC)
+#define S3C2412_GSTATUS5   S3C2410_GPIOREG(0x0D0)
+
+#endif
+
 #define S3C2410_GSTATUS0_nWAIT	   (1<<3)
 #define S3C2410_GSTATUS0_NCON	   (1<<2)
 #define S3C2410_GSTATUS0_RnB	   (1<<1)

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="regs-iis.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regs-iis.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-iis.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-iis.h	2006-02-28 13:08:22.000000000 +0100
@@ -18,6 +18,7 @@
  *    18-07-2005     DA      Change IISCON_MPLL to IISMOD_MPLL
  *                           Correct IISMOD_256FS and IISMOD_384FS
  *                           Add IISCON_PSCEN
+ *    17-02-2006     KM      Added definitions for S3C2412/S3C2413
  */
 
 #ifndef __ASM_ARCH_REGS_IIS_H
@@ -84,4 +85,100 @@
 #define S3C2400_IISFCON_RXSHIFT	  (0)
 
 #define S3C2410_IISFIFO  (0x10)
+
+/*
+ * S3C2412/13 has different IIS architecture,
+ * this information should not be in this file
+ * but it is because we (TomTom) do (does) not
+ * wish to create a seperate kernel for just
+ * S3C2412/13 architecture - KM
+ */
+
+// TODO: check whether S3C24XX_VA_IIS is correct for
+//       S3C2412/S3C2413 (final documentation from 
+//       Samsung is not available yet) - KM
+
+#ifdef CONFIG_CPU_S3C2412
+
+//#define S3C2412_IISFCON  (0x00)
+#define S3C2412_IISCON   (S3C24XX_VA_IIS + 0x00)
+
+#define S3C2412_IISCON_LRI              (1<<11)
+#define S3C2412_IISCON_FTXEMPT          (1<<10)
+#define S3C2412_IISCON_FRXEMPT          (1<<9)
+#define S3C2412_IISCON_FTXFULL          (1<<8)
+#define S3C2412_IISCON_FRXFULL          (1<<7)
+#define S3C2412_IISCON_TXDMAPAUSE       (1<<6)
+#define S3C2412_IISCON_RXDMAPAUSE       (1<<5)
+#define S3C2412_IISCON_TXCHPAUSE        (1<<4)
+#define S3C2412_IISCON_RXCHPAUSE        (1<<3)
+#define S3C2412_IISCON_TXDMACTIVE       (1<<2)
+#define S3C2412_IISCON_RXDMACTIVE       (1<<1)
+#define S3C2412_IISCON_I2SACTIVE        (1<<0)
+
+//#define S3C2412_IISMOD   (0x04)
+#define S3C2412_IISMOD   (S3C24XX_VA_IIS + 0x04)
+
+#define S3C2412_IISMOD_IMSMASK          (3<<10)
+#define S3C2412_IISMOD_IMASTER          (0<<10)
+#define S3C2412_IISMOD_EMASTER          (1<<10)
+#define S3C2412_IISMOD_SLAVE            (2<<10)
+
+#define S3C2412_IISMOD_TXRMASK          (3<<8)
+#define S3C2412_IISMOD_XMIT             (0<<8)
+#define S3C2412_IISMOD_RECV             (1<<8)
+#define S3C2412_IISMOD_XMITRECV         (2<<8)
+
+#define S3C2412_IISMOD_LOCLKL           (0<<7)
+#define S3C2412_IISMOD_LOCLKR           (1<<7)
+
+#define S3C2412_IISMOD_SDFMASK          (3<<5)
+#define S3C2412_IISMOD_FMTI2S           (0<<5)
+#define S3C2412_IISMOD_FMTMSB           (1<<5)
+#define S3C2412_IISMOD_FMTLSB           (2<<5)
+
+#define S3C2412_IISMOD_RFSMASK          (3<<3)
+#define S3C2412_IISMOD_256FS            (0<<3)
+#define S3C2412_IISMOD_512FS            (1<<3)
+#define S3C2412_IISMOD_384FS            (2<<3)
+#define S3C2412_IISMOD_768FS            (3<<3)
+
+#define S3C2412_IISMOD_BFSMASK          (3<<1)
+#define S3C2412_IISMOD_BFS32FS          (0<<1)
+#define S3C2412_IISMOD_BFS48FS          (1<<1)
+#define S3C2412_IISMOD_BFS16FS          (2<<1)
+
+#define S3C2412_IISMOD_16BIT            (0<<0)
+#define S3C2412_IISMOD_8BIT             (1<<0)
+
+
+//#define S3C2412_IISFIC   (0x08)
+#define S3C2412_IISFIC   (S3C24XX_VA_IIS + 0x08)
+
+#define S3C2412_IISFIC_TFLUSH           (1<<15)
+#define S3C2412_IISFIC_FTXCNTMASK       (0x1f << 8)
+#define S3C2412_IISFIC_RFLUSH           (1<<7)
+#define S3C2412_IISFIC_FRXCNTMASK       (0x1f << 0)
+
+//#define S3C2412_IISPSR   (0x0c)
+#define S3C2412_IISPSR   (S3C24XX_VA_IIS + 0x0c)
+
+#define S3C2412_IISPSR_PSRAEN           (1<<15)
+#define S3C2412_IISPSR_PSVALAMASK       (0x3f << 15)
+
+//#define S3C2412_IISTXD   (0x10)
+#define S3C2412_IISTXD   (S3C24XX_VA_IIS + 0x10)
+
+
+//#define S3C2412_IISRXD   (0x14)
+#define S3C2412_IISRXD   (S3C24XX_VA_IIS + 0x14)
+
+
+#define S3C2412_DATA_L8MASK             (0xff << 16)
+#define S3C2412_DATA_R8MASK             (0xff << 0)
+#define S3C2412_DATA_L16MASK            (0xffff << 16)
+#define S3C2412_DATA_R16MASK            (0xffff << 0)
+
+#endif /* CONFIG_CPU_S3C2412 */
+
 #endif /* __ASM_ARCH_REGS_IIS_H */

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="regs-irq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regs-irq.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-irq.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-irq.h	2006-02-28 13:13:11.000000000 +0100
@@ -13,6 +13,7 @@
  *    19-06-2003     BJD     Created file
  *    12-03-2004     BJD     Updated include protection
  *    10-03-2005     LCVR    Changed S3C2410_VA to S3C24XX_VA
+ *    17-02-2006     KM      Added S3C2412/S3C2413 defines
  */
 
 
@@ -41,4 +42,11 @@
 #define S3C2410_EINTMASK       S3C2410_EINTREG(0x0A4)
 #define S3C2410_EINTPEND       S3C2410_EINTREG(0X0A8)
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_EINTMASK       S3C2410_EINTREG(0x0B4)
+#define S3C2412_EINTPEND       S3C2410_EINTREG(0X0B8)
+
+#endif /* CONFIG_CPU_S3C2412 */
+
 #endif /* ___ASM_ARCH_REGS_IRQ_H */

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="regs-rtc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regs-rtc.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-rtc.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-rtc.h	2006-02-28 12:21:46.000000000 +0100
@@ -13,6 +13,7 @@
  *    19-06-2003     BJD     Created file
  *    12-03-2004     BJD     Updated include protection
  *    15-01-2005     LCVR    Changed S3C2410_VA to S3C24XX_VA (s3c2400 support)
+ *    17-02-2006     KM      Added S3C2412 / S3C2413 registers
 */
 
 #ifndef __ASM_ARCH_REGS_RTC_H
@@ -25,11 +26,22 @@
 #define S3C2410_RTCCON_CLKSEL (1<<1)
 #define S3C2410_RTCCON_CNTSEL (1<<2)
 #define S3C2410_RTCCON_CLKRST (1<<3)
+#define S3C2410_RTCCON_TICSEL (1<<4)
 
 #define S3C2410_TICNT	      S3C2410_RTCREG(0x44)
 #define S3C2410_TICNT_ENABLE  (1<<7)
 
+#define S3C2410_TICNT0	      S3C2410_TICNT
+#define S3C2410_TICNT0_ENABLE (1<<7)
+
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2410_TICNT1        S3C2410_RTCREG(0x4C)	// S3C2412 & S3C2413
+
+#endif /* CONFIG_CPU_S3C2412 */
+
 #define S3C2410_RTCALM	      S3C2410_RTCREG(0x50)
+#define S3C2410_RTCALM_XTBSEL (1<<7)
 #define S3C2410_RTCALM_ALMEN  (1<<6)
 #define S3C2410_RTCALM_YEAREN (1<<5)
 #define S3C2410_RTCALM_MONEN  (1<<4)

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="s3c2412-dsc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s3c2412-dsc.diff"

--- linux-2.6.15.4/arch/arm/mach-s3c2410/s3c2412-dsc.c	1970-01-01 01:00:00.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/s3c2412-dsc.c	2006-02-27 17:12:40.000000000 +0100
@@ -0,0 +1,60 @@
+/* linux/arch/arm/mach-s3c2410/s3c2440-dsc.c
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *   Ben Dooks <ben@simtec.co.uk>
+ *
+ * Samsung S3C2412 Drive Strength Control support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Modifications:
+ *     29-Aug-2004 BJD  Start of drive-strength control
+ *     09-Nov-2004 BJD  Added symbol export
+ *     11-Jan-2005 BJD  Include fix
+ *     27-Feb-2006 KM   Start of S3C2412 support
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/regs-dsc.h>
+
+#include "cpu.h"
+#include "s3c2412.h"
+
+int s3c2412_set_dsc(unsigned int pin, unsigned int value)
+{
+	void __iomem *base;
+	unsigned long val;
+	unsigned long flags;
+	unsigned long mask;
+
+	base = (pin & S3C2412_SELECT_DSC1) ? S3C2412_DSC1 : S3C2412_DSC0;
+	mask = 3 << S3C2440_DSC_GETSHIFT(pin);
+
+	local_irq_save(flags);
+
+	val = __raw_readl(base);
+	val &= ~mask;
+	val |= value & mask;
+	__raw_writel(val, base);
+
+	local_irq_restore(flags);
+	return 0;
+}
+
+EXPORT_SYMBOL(s3c2412_set_dsc);

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="s3c2412_c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s3c2412_c.diff"

--- linux-2.6.15.4/arch/arm/mach-s3c2410/s3c2412.c	1970-01-01 01:00:00.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/s3c2412.c	2006-02-28 12:17:21.000000000 +0100
@@ -0,0 +1,276 @@
+/* linux/arch/arm/mach-s3c2410/s3c2440.c
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *   Ben Dooks <ben@simtec.co.uk>
+ *
+ * Samsung S3C2412 Mobile CPU support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Modifications:
+ *	24-Aug-2004 BJD  Start of s3c2440 support
+ *	12-Oct-2004 BJD	 Moved clock info out to clock.c
+ *	01-Nov-2004 BJD  Fixed clock build code
+ *	09-Nov-2004 BJD  Added sysdev for power management
+ *	04-Nov-2004 BJD  New serial registration
+ *	15-Nov-2004 BJD  Rename the i2c device for the s3c2440
+ *	14-Jan-2005 BJD  Moved clock init code into seperate function
+ *	14-Jan-2005 BJD  Removed un-used clock bits
+ *      27-Feb-2006 KM   Start of s3c2412 support
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/sysdev.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/hardware/clock.h>
+
+#include <asm/arch/regs-clock.h>
+#include <asm/arch/regs-serial.h>
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/regs-gpioj.h>
+#include <asm/arch/regs-dsc.h>
+
+#include "s3c2412.h"
+#include "clock.h"
+#include "devs.h"
+#include "cpu.h"
+#include "pm.h"
+
+
+static struct map_desc s3c2412_iodesc[] __initdata = {
+	IODESC_ENT(USBHOST),
+	IODESC_ENT(CLKPWR),
+	IODESC_ENT(LCD),
+	IODESC_ENT(TIMER),
+	IODESC_ENT(ADC),
+	IODESC_ENT(WATCHDOG),
+};
+
+static struct resource s3c_uart0_resource[] = {
+	[0] = {
+		.start = S3C2410_PA_UART0,
+		.end   = S3C2410_PA_UART0 + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_S3CUART_RX0,
+		.end   = IRQ_S3CUART_ERR0,
+		.flags = IORESOURCE_IRQ,
+	}
+
+};
+
+static struct resource s3c_uart1_resource[] = {
+	[0] = {
+		.start = S3C2410_PA_UART1,
+		.end   = S3C2410_PA_UART1 + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_S3CUART_RX1,
+		.end   = IRQ_S3CUART_ERR1,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct resource s3c_uart2_resource[] = {
+	[0] = {
+		.start = S3C2410_PA_UART2,
+		.end   = S3C2410_PA_UART2 + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_S3CUART_RX2,
+		.end   = IRQ_S3CUART_ERR2,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+/* our uart devices */
+
+static struct platform_device s3c_uart0 = {
+	.name		  = "s3c2412-uart",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s3c_uart0_resource),
+	.resource	  = s3c_uart0_resource,
+};
+
+static struct platform_device s3c_uart1 = {
+	.name		  = "s3c2412-uart",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s3c_uart1_resource),
+	.resource	  = s3c_uart1_resource,
+};
+
+static struct platform_device s3c_uart2 = {
+	.name		  = "s3c2412-uart",
+	.id		  = 2,
+	.num_resources	  = ARRAY_SIZE(s3c_uart2_resource),
+	.resource	  = s3c_uart2_resource,
+};
+
+static struct platform_device *uart_devices[] __initdata = {
+	&s3c_uart0,
+	&s3c_uart1,
+	&s3c_uart2
+};
+
+/* uart initialisation */
+
+static int __initdata s3c2412_uart_count;
+
+void __init s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct platform_device *platdev;
+	int uart;
+
+	for (uart = 0; uart < no; uart++, cfg++) {
+		platdev = uart_devices[cfg->hwport];
+
+		s3c24xx_uart_devs[uart] = platdev;
+		platdev->dev.platform_data = cfg;
+	}
+
+	s3c2412_uart_count = uart;
+}
+
+
+#ifdef CONFIG_PM
+
+struct sleep_save s3c2412_sleep[] = {
+	SAVE_ITEM(S3C2412_DSC0),
+	SAVE_ITEM(S3C2412_DSC1)
+};
+
+static int s3c2412_suspend(struct sys_device *dev, pm_message_t state)
+{
+	s3c2410_pm_do_save(s3c2412_sleep, ARRAY_SIZE(s3c2412_sleep));
+	return 0;
+}
+
+static int s3c2412_resume(struct sys_device *dev)
+{
+	s3c2410_pm_do_restore(s3c2412_sleep, ARRAY_SIZE(s3c2412_sleep));
+	return 0;
+}
+
+#else
+#define s3c2412_suspend NULL
+#define s3c2412_resume  NULL
+#endif
+
+struct sysdev_class s3c2412_sysclass = {
+	set_kset_name("s3c2412-core"),
+	.suspend	= s3c2412_suspend,
+	.resume		= s3c2412_resume
+};
+
+static struct sys_device s3c2412_sysdev = {
+	.cls		= &s3c2412_sysclass,
+};
+
+void __init s3c2412_map_io(struct map_desc *mach_desc, int size)
+{
+	/* register our io-tables */
+
+	iotable_init(s3c2412_iodesc, ARRAY_SIZE(s3c2412_iodesc));
+	iotable_init(mach_desc, size);
+
+	/* rename any peripherals used differing from the s3c2410 */
+
+	s3c_device_i2c.name  = "s3c2412-i2s";
+}
+
+void __init s3c2412_init_clocks(int xtal)
+{
+	unsigned long clkdiv;
+	unsigned long hclk, fclk, pclk;
+	int hdiv = 1;
+        int shift;
+
+	/* now we've got our machine bits initialised, work out what
+	 * clocks we've got */
+
+	fclk = s3c2412_get_pll(__raw_readl(S3C2410_MPLLCON), xtal) * 2;
+
+	clkdiv = __raw_readl(S3C2410_CLKDIVN);
+
+	/* work out clock scalings */
+
+	shift=(clkdiv & S3C2412_CLKDIVN_ARMDIV)?1:0;
+
+	switch (clkdiv & S3C2412_CLKDIVN_HCLKDIV_MASK) {
+	case S3C2412_CLKDIVN_HCLKDIV_1_2:
+		hdiv = 1 << shift;
+		break;
+
+	case S3C2412_CLKDIVN_HCLKDIV_2_4:
+		hdiv = 2 << shift;
+		break;
+
+	case S3C2412_CLKDIVN_HCLKDIV_3_6:
+		hdiv = 3 << shift;
+		break;
+
+	case S3C2412_CLKDIVN_HCLKDIV_4_8:
+		hdiv = 4 << shift;
+		break;
+	}
+
+	hclk = fclk / hdiv;
+	pclk = hclk / ((clkdiv & S3C2412_CLKDIVN_PCLKDIV)? 2:1);
+
+	/* print brief summary of clocks, etc */
+
+	printk("S3C2412: core %ld.%03ld MHz, memory %ld.%03ld MHz, peripheral %ld.%03ld MHz\n",
+	       print_mhz(fclk), print_mhz(hclk), print_mhz(pclk));
+
+	/* initialise the clocks here, to allow other things like the
+	 * console to use them, and to add new ones after the initialisation
+	 */
+
+	s3c24xx_setup_clocks(xtal, fclk, hclk, pclk);
+}
+
+/* need to register class before we actually register the device, and
+ * we also need to ensure that it has been initialised before any of the
+ * drivers even try to use it (even if not on an s3c2412 based system)
+ * as a driver which may support both 2410 and 2412 may try and use it.
+*/
+
+int __init s3c2412_core_init(void)
+{
+	return sysdev_class_register(&s3c2412_sysclass);
+}
+
+core_initcall(s3c2412_core_init);
+
+int __init s3c2412_init(void)
+{
+	int ret;
+
+	printk("S3C2412: Initialising architecture\n");
+
+	ret = sysdev_register(&s3c2412_sysdev);
+	if (ret != 0)
+		printk(KERN_ERR "failed to register sysdev for s3c2412\n");
+	else
+		ret = platform_add_devices(s3c24xx_uart_devs, s3c2412_uart_count);
+
+	return ret;
+}

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="s3c2412_h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s3c2412_h.diff"

--- linux-2.6.15.4/arch/arm/mach-s3c2410/s3c2412.h	1970-01-01 01:00:00.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/s3c2412.h	2006-02-27 17:02:10.000000000 +0100
@@ -0,0 +1,36 @@
+/* arch/arm/mach-s3c2410/s3c2440.h
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Header file for s3c2412 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Modifications:
+ *	24-Aug-2004 BJD  Start of S3C2440 CPU support
+ *	04-Nov-2004 BJD  Added s3c2440_init_uarts()
+ *	04-Jan-2005 BJD  Moved uart init to cpu code
+ *	10-Jan-2005 BJD  Moved 2440 specific init here
+ *	14-Jan-2005 BJD  Split the clock initialisation code
+ *      27-Feb-2006 KM   Start of S3C2412 CPU support
+*/
+
+#ifdef CONFIG_CPU_S3C2412
+
+extern  int s3c2412_init(void);
+
+extern void s3c2412_map_io(struct map_desc *mach_desc, int size);
+
+extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2412_init_clocks(int xtal);
+
+#else
+#define s3c2412_init_clocks NULL
+#define s3c2412_init_uarts NULL
+#define s3c2412_map_io NULL
+#define s3c2412_init NULL
+#endif

--------------070900030203090209040109
Content-Type: text/x-patch;
 name="uncompress_h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uncompress_h.diff"

--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/uncompress.h	2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/uncompress.h	2006-02-28 13:19:36.000000000 +0100
@@ -17,6 +17,7 @@
  *  15-Nov-2004 BJD  Fixed uart configuration
  *  22-Feb-2005 BJD  Added watchdog to uncompress
  *  04-Apr-2005 LCVR Added support to S3C2400 (no cpuid at GSTATUS1)
+ *  28-Feb-2006 KM   Added support for S3C2412/13 (cpuid moved to different addr)
 */
 
 #ifndef __ASM_ARCH_UNCOMPRESS_H
@@ -75,6 +76,14 @@
 #ifndef CONFIG_CPU_S3C2400
 	cpuid = *((volatile unsigned int *)S3C2410_GSTATUS1);
 	cpuid &= S3C2410_GSTATUS1_IDMASK;
+
+#ifdef CONFIG_CPU_S3C2412
+        if (cpuid!=S3C2410_GSTATUS1_2440 && cpuid!=S3C2410_GSTATUS1_2410) {
+          cpuid = *((volatile unsigned int *)S3C2412_GSTATUS1);
+          cpuid &= S3C2410_GSTATUS1_IDMASK;
+        }
+#endif
+
 #endif
 
 	if (ch == '\n')

--------------070900030203090209040109--
