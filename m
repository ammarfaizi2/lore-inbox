Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWHZTJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWHZTJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWHZTJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 15:09:31 -0400
Received: from mail.bmts.com ([216.183.128.202]:32948 "EHLO mail.bmts.com")
	by vger.kernel.org with ESMTP id S1751650AbWHZTJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 15:09:31 -0400
Date: Sat, 26 Aug 2006 15:09:28 -0400
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4: sundance.c compile failure without CONFIG_HOTPLUG
Message-Id: <20060826150928.2e291f94.mikeserv@bmts.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In compiling 2.6.18-rc4 last night, I ran into a compile failure with
sundance.c, which is the driver my DLink 530TXS card uses.

gcc -m32 -Wp,-MD,drivers/net/.sundance.o.d  -nostdinc
-isystem /usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include -D__KERNEL__
-Iinclude  -include include/linux/autoconf.h -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-Os -fomit-frame-pointer -pipe -msoft-float
-mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i686
-mtune=pentium4 -mregparm=3 -ffreestanding
-Iinclude/asm-i386/mach-default -Wdeclaration-after-statement
-D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(sundance)"
-D"KBUILD_MODNAME=KBUILD_STR(sundance)" -c -o drivers/net/sundance.o
drivers/net/sundance.c drivers/net/sundance.c:226: error: pci_id_tbl
causes a section type conflict
make[2]: *** [drivers/net/sundance.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Compiler is gcc 3.4.6

I generally exclude support for all things I don't use (I maintain my
own old school style "from scratch" system and have no need for hot
plug). I don't think it is intended to have hotplug be a requirement
to compile a PCI NIC driver.

At the time, I didn't realize it had to do with CONFIG_HOTPLUG so I
did this to get it to compile. (works for me, with my card, though
I'm sure it's not correct to do this)

--- linux-2.6.18-rc4-orig/drivers/net/sundance.c
+++ linux-2.6.18-rc4/drivers/net/sundance.c
@@ -223,7 +223,7 @@
 struct pci_id_info {
         const char *name;
 };
-static const struct pci_id_info pci_id_tbl[] __devinitdata = {
+static const struct pci_id_info pci_id_tbl[] = {
 	{"D-Link DFE-550TX FAST Ethernet Adapter"},
 	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter"},
 	{"D-Link DFE-580TX 4 port Server Adapter"},
@@ -231,7 +231,7 @@
 	{"D-Link DL10050-based FAST Ethernet Adapter"},
 	{"Sundance Technology Alta"},
 	{"IC Plus Corporation IP100A FAST Ethernet Adapter"},
-	{ }	/* terminate list. */
+	{NULL,},	/* terminate list. */
 };

 /* This driver was written to use PCI memory space, however
x86-oriented

Anyhow, after further testing, with support for hot pluggable devices
enabled, the sundance driver compiles without messing with the above.

In case anyone wants to look at it, the .config for the failed build
is here:

http://www.mikeserv.com/temp/config-2.6.18-rc4

Mike Houston
