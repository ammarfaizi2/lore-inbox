Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbTC0WC0>; Thu, 27 Mar 2003 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbTC0WC0>; Thu, 27 Mar 2003 17:02:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55269 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261405AbTC0WCY>; Thu, 27 Mar 2003 17:02:24 -0500
Date: Thu, 27 Mar 2003 23:13:31 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Stelian Pop <stelian@popies.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in sonypi.c
Message-ID: <20030327221331.GB24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following .text.exit error is present in 2.4.1-pre6 (it seems to be 
in 2.5.66, too):

<--  snip  -->

...
drivers/char/char.o(.text+0x9a891): In function `sonypi_pm_callback':
: undefined reference to `local symbols in discarded section .text.exit'
drivers/char/char.o(.text+0x9a898): In function `sonypi_pm_callback':
: undefined reference to `local symbols in discarded section .text.exit'
...

<--  snip  -->


In drivers/char/sonypi.c the __devexit funcitions sonypi_type1_dis and 
sonypi_type2_dis are called from the non-__devexit function 
sonypi_pm_callback.


The following patch removes the __devexit from these two functions:


--- linux-2.4.21-pre6-full-nohotplug/drivers/char/sonypi.c.old	2003-03-27 22:07:23.000000000 +0100
+++ linux-2.4.21-pre6-full-nohotplug/drivers/char/sonypi.c	2003-03-27 22:09:05.000000000 +0100
@@ -162,7 +162,7 @@
 }
 
 /* Disables the device - this comes from the AML code in the ACPI bios */
-static void __devexit sonypi_type1_dis(void) {
+static void sonypi_type1_dis(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -174,7 +174,7 @@
 	outl(v, SONYPI_IRQ_PORT);
 }
 
-static void __devexit sonypi_type2_dis(void) {
+static void sonypi_type2_dis(void) {
 	if (ec_write(SONYPI_SHIB, 0))
 		printk(KERN_WARNING "ec_write failed\n");
 	if (ec_write(SONYPI_SLOB, 0))



I've tested the compilation with 2.4.21-pre6.


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

