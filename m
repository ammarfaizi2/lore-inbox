Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269226AbTCBPFW>; Sun, 2 Mar 2003 10:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269227AbTCBPFW>; Sun, 2 Mar 2003 10:05:22 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:53715 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S269226AbTCBPFU>;
	Sun, 2 Mar 2003 10:05:20 -0500
Message-ID: <3E62200D.2010505@colorfullife.com>
Date: Sun, 02 Mar 2003 16:15:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
Content-Type: multipart/mixed;
 boundary="------------080705010004020700070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080705010004020700070902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan wrote:

>Unfortunately ten years ago someone created 'register_and_activate_irq'
>calling it 'register_irq', and it hasn't yet been fixed.
>  
>
Then it's time to fix that.

I would propose something like the attached patch - it handles all archs 
that support disable_irq on an unregistered interrupt. The remaining 
arch [which one, btw] must implement request_irq_disabled().

--
    Manfred

--------------080705010004020700070902
Content-Type: text/plain;
 name="patch-rqd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-rqd"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 63
//  EXTRAVERSION =
--- 2.5/include/linux/interrupt.h	2002-11-26 17:25:18.000000000 +0100
+++ build-2.5/include/linux/interrupt.h	2003-03-02 15:48:40.000000000 +0100
@@ -23,6 +23,9 @@
 extern int request_irq(unsigned int,
 		       void (*handler)(int, void *, struct pt_regs *),
 		       unsigned long, const char *, void *);
+extern int request_irq_disabled(unsigned int,
+		       void (*handler)(int, void *, struct pt_regs *),
+		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
 /*
--- 2.5/kernel/ksyms.c	2003-02-26 19:08:44.000000000 +0100
+++ build-2.5/kernel/ksyms.c	2003-03-02 15:54:06.000000000 +0100
@@ -404,6 +404,7 @@
 EXPORT_SYMBOL(add_timer);
 EXPORT_SYMBOL(del_timer);
 EXPORT_SYMBOL(request_irq);
+EXPORT_SYMBOL(request_irq_disabled);
 EXPORT_SYMBOL(free_irq);
 EXPORT_SYMBOL(irq_stat);
 
diff -urN --exclude='*.cmd' --exclude crc32table.h --exclude '*.orig' 2.5/lib/irq.c build-2.5/lib/irq.c
--- 2.5/lib/irq.c	1970-01-01 01:00:00.000000000 +0100
+++ build-2.5/lib/irq.c	2003-03-02 16:10:58.000000000 +0100
@@ -0,0 +1,39 @@
+/*
+ *  linux/lib/irq.c: arch independant helper functions for irq handling.
+ *
+ *  Copyright (C) 2003 Manfred Spraul
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/interrupt.h>
+
+#ifndef __HAVE_ARCH_REQUEST_IRQ_DISABLED
+int request_irq_disabled(unsigned int irq, 
+		void (*handler)(int, void *, struct pt_regs *),
+		unsigned long irqflags, 
+		const char * devname,
+		void *dev_id)
+{
+	int retval;
+	disable_irq(irq);
+	retval = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (retval < 0)
+		enable_irq(irq);
+	return retval;
+}
+#endif
diff -urN --exclude='*.cmd' --exclude crc32table.h --exclude '*.orig' 2.5/lib/Makefile build-2.5/lib/Makefile
--- 2.5/lib/Makefile	2003-02-26 19:08:44.000000000 +0100
+++ build-2.5/lib/Makefile	2003-03-02 15:54:30.000000000 +0100
@@ -10,7 +10,7 @@
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o
+	 kobject.o idr.o irq.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o

--------------080705010004020700070902--

