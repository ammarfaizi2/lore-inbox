Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271367AbRHUCz6>; Mon, 20 Aug 2001 22:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271350AbRHUCzs>; Mon, 20 Aug 2001 22:55:48 -0400
Received: from rj.SGI.COM ([204.94.215.100]:49344 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271367AbRHUCzg>;
	Mon, 20 Aug 2001 22:55:36 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Samium Gromoff" <_deepfire@mail.ru>
cc: linux-kernel@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
        Dag Brattli <dag@brattli.net>, Thomas Davis <tadavis@jps.net>
Subject: Re: 2.4.9-irda - compilation failure 
In-Reply-To: Your message of "Fri, 17 Aug 2001 13:51:46 +0400."
             <E15XgI6-0003rC-00@f12.port.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 12:55:36 +1000
Message-ID: <18654.998362536@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001 13:51:46 +0400, 
"Samium Gromoff" <_deepfire@mail.ru> wrote:
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586    -c -o smc-ircc.o smc-ircc.c
>smc-ircc.c: In function `smc_access':
>smc-ircc.c:171: smc_access causes a section type conflict

Data must be __initdata, not __init, and cannot be const.  Also cleaned
up the MODULE tests, there is no need to wrap #ifdef MODULE around
module_author etc., the macros are no-op when built into the kernel.


diff -ur 2.4.9-pristine/drivers/net/irda/smc-ircc.c 2.4.9/drivers/net/irda/smc-ircc.c
--- 2.4.9-pristine/drivers/net/irda/smc-ircc.c	Tue Aug 21 11:51:06 2001
+++ 2.4.9/drivers/net/irda/smc-ircc.c	Tue Aug 21 12:45:08 2001
@@ -99,7 +99,7 @@
 #define	SERx4	8	/* SuperIO Chip supports 115,2 KBaud * 4=460,8 KBaud */
 
 /* These are the currently known SMC SuperIO chipsets */
-static const smc_chip_t __init fdc_chips_flat[]=
+static smc_chip_t __initdata fdc_chips_flat[]=
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37C44",	KEY55_1|NoIRDA,		0x00, 0x00 }, /* This chip can not detected */
@@ -113,7 +113,7 @@
 	{ NULL }
 };
 
-static const smc_chip_t __init fdc_chips_paged[]=
+static smc_chip_t __initdata fdc_chips_paged[]=
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37B72X",	KEY55_1|SIR|SERx4,	0x4c, 0x00 },
@@ -132,7 +132,7 @@
 	{ NULL }
 };
 
-static const smc_chip_t __init lpc_chips_flat[]=
+static smc_chip_t __initdata lpc_chips_flat[]=
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47N227",	KEY55_1|FIR|SERx4,	0x5a, 0x00 },
@@ -140,7 +140,7 @@
 	{ NULL }
 };
 
-static const smc_chip_t __init lpc_chips_paged[]=
+static smc_chip_t __initdata lpc_chips_paged[]=
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47B27X",	KEY55_1|SIR|SERx4,	0x51, 0x00 },
@@ -1147,17 +1147,15 @@
 	return 0;
 }
 
-#ifdef MODULE
-
 /*
  * Function ircc_close (self)
  *
  *    Close driver instance
  *
  */
-#ifdef MODULE
 static int __exit ircc_close(struct ircc_cb *self)
 {
+#ifdef MODULE
 	int iobase;
 
 	IRDA_DEBUG(0, __FUNCTION__ "\n");
@@ -1193,16 +1191,16 @@
 
 	kfree(self);
 
+#endif /* MODULE */
 	return 0;
 }
-#endif /* MODULE */
 
-int __init smc_init(void)
+static int __init smc_init(void)
 {
 	return ircc_init();
 }
 
-void __exit smc_cleanup(void)
+static void __exit smc_cleanup(void)
 {
 	int i;
 
@@ -1227,5 +1225,3 @@
 MODULE_PARM_DESC(ircc_fir, "FIR Base Address");
 MODULE_PARM(ircc_sir, "1-4i");
 MODULE_PARM_DESC(ircc_sir, "SIR Base Address");
-
-#endif /* MODULE */

