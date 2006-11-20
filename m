Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933936AbWKTFvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933936AbWKTFvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 00:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933934AbWKTFvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 00:51:53 -0500
Received: from rex.snapgear.com ([203.143.235.140]:28625 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S933930AbWKTFvw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 00:51:52 -0500
Message-ID: <4561412E.5050106@snapgear.com>
Date: Mon, 20 Nov 2006 15:46:22 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-m68k@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       uClinux list <uclinux-dev@uclinux.org>
Subject: Re: m68knommu doesn't build upstream
References: <1163739105.5940.431.camel@localhost.localdomain> <Pine.LNX.4.62.0611170615420.16998@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0611170615420.16998@pademelon.sonytel.be>
Content-Type: multipart/mixed;
 boundary="------------060304090400020907050009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060304090400020907050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Geert Uytterhoeven wrote:
> On Fri, 17 Nov 2006, Benjamin Herrenschmidt wrote:
>> While looking into getting rid of the old compat dma-mapping stuff,
>> which is only used by a handful of archs, I've built some cross
>> toolchains for those archs in order to at least test build my changes.
>>
>> It looks however that one of them, m68knommu, doesn't build with
>> upstream git and a defconfig
>>
>>  In file included from arch/m68knommu/kernel/asm-offsets.c:18:
>> include/asm/irqnode.h:26: error: conflicting types for 'irq_handler_t'
>> include/linux/interrupt.h:67: error: previous declaration of 'irq_handler_t' was here
>>
>> Is this arch bitrotting ?
> 
> Maybe, although Greg announces updated versions on a regular basis.
> 
> BTW, m68knommu is not really handled by linux-m68k. Please use uclinux-dev
> instead.

I hadn't fixed up the irq_handler_t changes yet. So this is a good a
time as any :-)

Here is a patch that cleans this up for 2.6.19-rc6.
There is a few more cleanups on this I'll do post 2.6.19, but
this gets it compiling/working again.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a Secure Computing Company      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

--------------060304090400020907050009
Content-Type: text/x-patch;
 name="linux-2.6.19-rc6-uc0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.19-rc6-uc0.patch"

Switch to using irq_handler_t for interrupt function handler pointers.
Change name of m68knommu's irq_hanlder_t data structure so it doesn't
clash with the common type (include/linux/interrupt.h).

Signed-off-by: Greg Ungerer <gerg@uclinux.org>


diff -Naur linux-2.6.19-rc6/arch/m68knommu/kernel/setup.c linux-2.6.19-rc6-uc0/arch/m68knommu/kernel/setup.c
--- linux-2.6.19-rc6/arch/m68knommu/kernel/setup.c	2006-09-20 13:42:06.000000000 +1000
+++ linux-2.6.19-rc6-uc0/arch/m68knommu/kernel/setup.c	2006-11-20 11:04:25.000000000 +1000
@@ -62,7 +62,7 @@
 void (*mach_kbd_leds) (unsigned int);
 /* machine dependent irq functions */
 void (*mach_init_IRQ) (void);
-irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
+irq_handler_t mach_default_handler;
 int (*mach_get_irq_list) (struct seq_file *, void *);
 void (*mach_process_int) (int irq, struct pt_regs *fp);
 void (*mach_trap_init) (void);
diff -Naur linux-2.6.19-rc6/arch/m68knommu/kernel/time.c linux-2.6.19-rc6-uc0/arch/m68knommu/kernel/time.c
--- linux-2.6.19-rc6/arch/m68knommu/kernel/time.c	2006-11-20 09:48:44.000000000 +1000
+++ linux-2.6.19-rc6-uc0/arch/m68knommu/kernel/time.c	2006-11-20 10:51:40.000000000 +1000
@@ -54,7 +54,7 @@
 	update_process_times(user_mode(regs));
 #endif
 	if (current->pid)
-		profile_tick(CPU_PROFILING, regs);
+		profile_tick(CPU_PROFILING);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -Naur linux-2.6.19-rc6/arch/m68knommu/platform/5307/ints.c linux-2.6.19-rc6-uc0/arch/m68knommu/platform/5307/ints.c
--- linux-2.6.19-rc6/arch/m68knommu/platform/5307/ints.c	2006-09-20 13:42:06.000000000 +1000
+++ linux-2.6.19-rc6-uc0/arch/m68knommu/platform/5307/ints.c	2006-11-20 11:06:51.000000000 +1000
@@ -33,7 +33,7 @@
 /*
  *	This table stores the address info for each vector handler.
  */
-irq_handler_t irq_list[SYS_IRQS];
+struct irq_entry irq_list[SYS_IRQS];
 
 #define NUM_IRQ_NODES 16
 static irq_node_t nodes[NUM_IRQ_NODES];
@@ -44,7 +44,7 @@
 unsigned int local_bh_count[NR_CPUS];
 unsigned int local_irq_count[NR_CPUS];
 
-static irqreturn_t default_irq_handler(int irq, void *ptr, struct pt_regs *regs)
+static irqreturn_t default_irq_handler(int irq, void *ptr)
 {
 #if 1
 	printk(KERN_INFO "%s(%d): default irq handler vec=%d [0x%x]\n",
@@ -70,7 +70,7 @@
 
 	for (i = 0; i < SYS_IRQS; i++) {
 		if (mach_default_handler)
-			irq_list[i].handler = (*mach_default_handler)[i];
+			irq_list[i].handler = mach_default_handler;
 		else
 			irq_list[i].handler = default_irq_handler;
 		irq_list[i].flags   = IRQ_FLG_STD;
@@ -100,7 +100,7 @@
 
 int request_irq(
 	unsigned int irq,
-	irqreturn_t (*handler)(int, void *, struct pt_regs *),
+	irq_handler_t handler,
 	unsigned long flags,
 	const char *devname,
 	void *dev_id)
@@ -157,7 +157,7 @@
 	}
 
 	if (mach_default_handler)
-		irq_list[irq].handler = (*mach_default_handler)[irq];
+		irq_list[irq].handler = mach_default_handler;
 	else
 		irq_list[irq].handler = default_irq_handler;
 	irq_list[irq].flags   = IRQ_FLG_STD;
@@ -168,8 +168,7 @@
 EXPORT_SYMBOL(free_irq);
 
 
-int sys_request_irq(unsigned int irq, 
-                    irqreturn_t (*handler)(int, void *, struct pt_regs *), 
+int sys_request_irq(unsigned int irq, irq_handler_t handler, 
                     unsigned long flags, const char *devname, void *dev_id)
 {
 	if (irq > IRQ7) {
@@ -211,7 +210,7 @@
 		printk(KERN_WARNING "%s: Removing probably wrong IRQ %d from %s\n",
 		       __FUNCTION__, irq, irq_list[irq].devname);
 
-	irq_list[irq].handler = (*mach_default_handler)[irq];
+	irq_list[irq].handler = mach_default_handler;
 	irq_list[irq].flags   = 0;
 	irq_list[irq].dev_id  = NULL;
 	irq_list[irq].devname = NULL;
@@ -241,7 +240,7 @@
 	if (vec >= VEC_INT1 && vec <= VEC_INT7) {
 		vec -= VEC_SPUR;
 		kstat_cpu(0).irqs[vec]++;
-		irq_list[vec].handler(vec, irq_list[vec].dev_id, fp);
+		irq_list[vec].handler(vec, irq_list[vec].dev_id);
 	} else {
 		if (mach_process_int)
 			mach_process_int(vec, fp);
diff -Naur linux-2.6.19-rc6/include/asm-m68knommu/irqnode.h linux-2.6.19-rc6-uc0/include/asm-m68knommu/irqnode.h
--- linux-2.6.19-rc6/include/asm-m68knommu/irqnode.h	2006-09-20 13:42:06.000000000 +1000
+++ linux-2.6.19-rc6-uc0/include/asm-m68knommu/irqnode.h	2006-11-20 10:54:40.000000000 +1000
@@ -8,7 +8,7 @@
  * interrupt source (if it supports chaining).
  */
 typedef struct irq_node {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
+	irq_handler_t	handler;
 	unsigned long	flags;
 	void		*dev_id;
 	const char	*devname;
@@ -18,12 +18,12 @@
 /*
  * This structure has only 4 elements for speed reasons
  */
-typedef struct irq_handler {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
+struct irq_entry {
+	irq_handler_t	handler;
 	unsigned long	flags;
 	void		*dev_id;
 	const char	*devname;
-} irq_handler_t;
+};
 
 /* count of spurious interrupts */
 extern volatile unsigned int num_spurious;
diff -Naur linux-2.6.19-rc6/include/asm-m68knommu/irq_regs.h linux-2.6.19-rc6-uc0/include/asm-m68knommu/irq_regs.h
--- linux-2.6.19-rc6/include/asm-m68knommu/irq_regs.h	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.19-rc6-uc0/include/asm-m68knommu/irq_regs.h	2006-11-20 11:08:08.000000000 +1000
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
diff -Naur linux-2.6.19-rc6/include/asm-m68knommu/machdep.h linux-2.6.19-rc6-uc0/include/asm-m68knommu/machdep.h
--- linux-2.6.19-rc6/include/asm-m68knommu/machdep.h	2006-09-20 13:42:06.000000000 +1000
+++ linux-2.6.19-rc6-uc0/include/asm-m68knommu/machdep.h	2006-11-20 11:04:09.000000000 +1000
@@ -18,7 +18,7 @@
 extern void (*mach_kbd_leds) (unsigned int);
 /* machine dependent irq functions */
 extern void (*mach_init_IRQ) (void);
-extern irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
+extern irq_handler_t mach_default_handler;
 extern int (*mach_request_irq) (unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
                                 unsigned long flags, const char *devname, void *dev_id);
 extern void (*mach_free_irq) (unsigned int irq, void *dev_id);

--------------060304090400020907050009--
