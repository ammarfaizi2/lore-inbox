Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUDOSWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUDOSWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:22:32 -0400
Received: from witte.sonytel.be ([80.88.33.193]:53969 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264355AbUDOSWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:22:13 -0400
Date: Thu, 15 Apr 2004 20:21:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Corey Minyard <minyard@mvista.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: ipmi compile failure
Message-ID: <Pine.GSO.4.58.0404152013240.10525@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Corey,

While compiling drivers/char/ipmi/ipmi_si_intf.c in 2.6.6-rc1 on m68k, I
noticed a missing include (needed for disable_irq_nosync() and enable_irq()):

--- linux-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c.orig	2004-04-15 11:44:09.000000000 +0200
+++ linux-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c	2004-04-15 20:18:51.000000000 +0200
@@ -51,6 +51,7 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/irq.h>
 #ifdef CONFIG_HIGH_RES_TIMERS
 #include <linux/hrtime.h>
 # if defined(schedule_next_int)

Furthermore none of CONFIG_ACPI_INTERPETER, CONFIG_X86, and CONFIG_PCI were
set, and thus IPMI_MEM_ADDR_SPACE and IPMI_IO_ADDR_SPACE are not defined, but
they are used:

|   CC      drivers/char/ipmi/ipmi_si_intf.o
| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c: In function `try_init_port':
| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: warning: implicit declaration of function `is_new_interface'
| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: `IPMI_IO_ADDR_SPACE' undeclared (first use in this function)
| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: (Each undeclared identifier is reported only once
| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: for each function it appears in.)
| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c: In function `try_init_mem':
| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1087: `IPMI_MEM_ADDR_SPACE' undeclared (first use in this function)
| make[3]: *** [drivers/char/ipmi/ipmi_si_intf.o] Error 1

Either something is wrong with the #ifdef logic, or that driver should be
disabled completely on non-supported architectures.

Gr{oetje,eeting}s,

				    Geert, let's compile as much as possible

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
