Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRJKHhu>; Thu, 11 Oct 2001 03:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRJKHhk>; Thu, 11 Oct 2001 03:37:40 -0400
Received: from ns.itep.ru ([193.124.224.35]:54023 "EHLO ns.itep.ru")
	by vger.kernel.org with ESMTP id <S273385AbRJKHhc>;
	Thu, 11 Oct 2001 03:37:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15301.19500.30733.197896@jaguar.itep.ru>
Date: Thu, 11 Oct 2001 11:37:16 +0400
From: Roman Kagan <Roman.Kagan@itep.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 APIC problems
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had exactly the same problem on my HP e800.  I've tried to identify
what had changed between 2.4.10 and 2.4.11 in IO-APIC code, and I've
found out that probably the only change relevant to my uniprocessor
case is the change of the initial value of dest_mode field in struct
IO_APIC_route_entry in setup_IO_APIC_irqs() and
setup_ExtINT_IRQ0_pin() in arch/i386/kernel/io_apic.c from 1 to macro
INT_DELIVERY_MODE, which for uniprocessors was defined to be 0.

I don't claim I understand whether it is right or wrong, but the
following patch can fix _my_ problem:

--- linux/include/asm-i386/smp.h.int_delivery	Wed Oct 10 13:36:11 2001
+++ linux/include/asm-i386/smp.h	Wed Oct 10 18:17:06 2001
@@ -31,7 +31,7 @@
 #  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
 # endif
 #else
-# define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
+# define INT_DELIVERY_MODE 1     /* logical delivery */
 # define TARGET_CPUS 0x01
 #endif
 

Cheers,
	Roman.
