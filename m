Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271751AbTG2S4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271920AbTG2S4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:56:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3054 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271751AbTG2S4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:56:41 -0400
Date: Tue, 29 Jul 2003 20:56:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Corey Minyard <minyard@mvista.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch] fix IPMI build error #if CONFIG_ACPI_HT_ONLY
Message-ID: <20030729185631.GP28767@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following build error in 2.6.0-test2:

<--  snip  -->

...
  LD      .tmp_vmlinux1
...
drivers/built-in.o(.init.text+0xdff5): In function `init_ipmi_kcs':
: undefined reference to `acpi_find_bmc'
make: *** [.tmp_vmlinux1] Error 1
$ grep ACPI .config
# Power management options (ACPI, APM)
# ACPI Support
CONFIG_ACPI=y
CONFIG_ACPI_HT_ONLY=y
$ 

<--  snip  -->

acpi_find_bmc is only available #ifdef CONFIG_ACPI_INTERPRETER.

The following patch fixes it (the same problem does exist in
2.4.22-pre8, the patch applies with a few lines offset):

--- linux-2.6.0-test2-full/drivers/char/ipmi/ipmi_kcs_intf.c.tmp	2003-07-29 17:12:36.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/char/ipmi/ipmi_kcs_intf.c	2003-07-29 17:30:08.000000000 +0200
@@ -1016,7 +1016,7 @@
 	return rv;
 }
 
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_ACPI_INTERPRETER
 
 /* Retrieve the base physical address from ACPI tables.  Originally
    from Hewlett-Packard simple bmc.c, a GPL KCS driver. */
@@ -1072,7 +1072,7 @@
 	int		rv = 0;
 	int		pos = 0;
 	int		i = 0;
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_ACPI_INTERPRETER
 	unsigned long	physaddr = 0;
 #endif
 
@@ -1102,7 +1102,7 @@
 	   (because they weren't already specified above). */
 
 	if (kcs_trydefaults) {
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_ACPI_INTERPRETER
 		if ((physaddr = acpi_find_bmc())) {
 			if (!check_mem_region(physaddr, 2)) {
 				rv = init_one_kcs(0, 



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

