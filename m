Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUFDUyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUFDUyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUFDUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:54:16 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:44212 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266021AbUFDUxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:53:31 -0400
Message-ID: <40C0E144.9070107@acm.org>
Date: Fri, 04 Jun 2004 15:53:24 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ipmi compile failure
References: <Pine.GSO.4.58.0404152013240.10525@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0404152013240.10525@waterleaf.sonytel.be>
Content-Type: multipart/mixed;
 boundary="------------010503020907000005040801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010503020907000005040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I believe the given defines should always be defined.  The attached 
patch should fix these problems.

-Corey

Geert Uytterhoeven wrote:

>	Hi Corey,
>
>While compiling drivers/char/ipmi/ipmi_si_intf.c in 2.6.6-rc1 on m68k, I
>noticed a missing include (needed for disable_irq_nosync() and enable_irq()):
>
>--- linux-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c.orig	2004-04-15 11:44:09.000000000 +0200
>+++ linux-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c	2004-04-15 20:18:51.000000000 +0200
>@@ -51,6 +51,7 @@
> #include <linux/list.h>
> #include <linux/pci.h>
> #include <linux/ioport.h>
>+#include <linux/irq.h>
> #ifdef CONFIG_HIGH_RES_TIMERS
> #include <linux/hrtime.h>
> # if defined(schedule_next_int)
>
>Furthermore none of CONFIG_ACPI_INTERPETER, CONFIG_X86, and CONFIG_PCI were
>set, and thus IPMI_MEM_ADDR_SPACE and IPMI_IO_ADDR_SPACE are not defined, but
>they are used:
>
>|   CC      drivers/char/ipmi/ipmi_si_intf.o
>| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c: In function `try_init_port':
>| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: warning: implicit declaration of function `is_new_interface'
>| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: `IPMI_IO_ADDR_SPACE' undeclared (first use in this function)
>| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: (Each undeclared identifier is reported only once
>| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1011: for each function it appears in.)
>| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c: In function `try_init_mem':
>| /home/geert/linux/testing/linux-m68k-2.6.6-rc1/drivers/char/ipmi/ipmi_si_intf.c:1087: `IPMI_MEM_ADDR_SPACE' undeclared (first use in this function)
>| make[3]: *** [drivers/char/ipmi/ipmi_si_intf.o] Error 1
>
>Either something is wrong with the #ifdef logic, or that driver should be
>disabled completely on non-supported architectures.
>
>Gr{oetje,eeting}s,
>
>	
>


--------------010503020907000005040801
Content-Type: text/plain;
 name="linux-ipmi-defines.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-defines.diff"

--- linux-v31/drivers/char/ipmi/ipmi_si_intf.c	2004-03-04 14:24:49.000000000 -0600
+++ linux/drivers/char/ipmi/ipmi_si_intf.c	2004-06-04 15:48:23.000000000 -0500
@@ -51,6 +51,7 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/irq.h>
 #ifdef CONFIG_HIGH_RES_TIMERS
 #include <linux/hrtime.h>
 # if defined(schedule_next_int)
@@ -904,10 +905,10 @@
 		 " has an interrupt.  Otherwise, set it to zero or leave"
 		 " it blank.");
 
-
-#if defined(CONFIG_ACPI_INTERPETER) || defined(CONFIG_X86) || defined(CONFIG_PCI)
 #define IPMI_MEM_ADDR_SPACE 1
 #define IPMI_IO_ADDR_SPACE  2
+
+#if defined(CONFIG_ACPI_INTERPETER) || defined(CONFIG_X86) || defined(CONFIG_PCI)
 static int is_new_interface(int intf, u8 addr_space, unsigned long base_addr)
 {
 	int i;

--------------010503020907000005040801--

