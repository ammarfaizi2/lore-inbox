Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUFDJyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUFDJyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUFDJyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:54:38 -0400
Received: from holomorphy.com ([207.189.100.168]:41892 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263772AbUFDJyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:54:08 -0400
Date: Fri, 4 Jun 2004 02:54:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@sgi.com>, Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604095403.GW21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@sgi.com>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@sgi.com>, Joe Korty <joe.korty@ccur.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Simon Derr <Simon.Derr@bull.net>
References: <20040604081906.GR21007@holomorphy.com> <17995.1086338623@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17995.1086338623@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 01:19:06 -0700, 
>> This is an improvement?

On Fri, Jun 04, 2004 at 06:43:43PM +1000, Keith Owens wrote:
> The existing code assumes that cpumask_t fits in a long; struct
> irqaction->mask is defined as a long.  Paul marked such suspect code
> with cpus_addr(), it needs to be reviewed and corrected.

I'd rather just do it.


Index: irqaction-2.6.7-rc2/include/linux/interrupt.h
===================================================================
--- irqaction-2.6.7-rc2.orig/include/linux/interrupt.h	2004-05-29 23:26:11.000000000 -0700
+++ irqaction-2.6.7-rc2/include/linux/interrupt.h	2004-06-04 02:24:12.348627000 -0700
@@ -7,6 +7,7 @@
 #include <linux/linkage.h>
 #include <linux/bitops.h>
 #include <linux/preempt.h>
+#include <linux/cpumask.h>
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/ptrace.h>
@@ -35,7 +36,7 @@
 struct irqaction {
 	irqreturn_t (*handler)(int, void *, struct pt_regs *);
 	unsigned long flags;
-	unsigned long mask;
+	cpumask_t mask;
 	const char *name;
 	void *dev_id;
 	struct irqaction *next;
Index: irqaction-2.6.7-rc2/arch/ppc/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/ppc/kernel/irq.c	2004-05-29 23:26:35.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/ppc/kernel/irq.c	2004-06-04 02:24:12.374623000 -0700
@@ -241,7 +241,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;			
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->dev_id = dev_id;
 	action->next = NULL;
Index: irqaction-2.6.7-rc2/arch/alpha/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/alpha/kernel/irq.c	2004-05-29 23:26:27.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/alpha/kernel/irq.c	2004-06-04 02:24:12.393620000 -0700
@@ -457,7 +457,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/arm/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/arm/kernel/irq.c	2004-05-29 23:25:40.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/arm/kernel/irq.c	2004-06-04 02:24:12.419616000 -0700
@@ -674,7 +674,7 @@
 
 	action->handler = handler;
 	action->flags = irq_flags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/arm26/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/arm26/kernel/irq.c	2004-05-29 23:26:43.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/arm26/kernel/irq.c	2004-06-04 02:24:12.442612000 -0700
@@ -549,7 +549,7 @@
 
 	action->handler = handler;
 	action->flags = irq_flags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/cris/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/cris/kernel/irq.c	2004-06-01 03:11:16.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/cris/kernel/irq.c	2004-06-04 02:24:12.465609000 -0700
@@ -240,7 +240,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/i386/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/i386/kernel/irq.c	2004-06-01 03:11:16.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/i386/kernel/irq.c	2004-06-04 02:24:12.499604000 -0700
@@ -654,7 +654,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/ia64/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/ia64/kernel/irq.c	2004-06-01 03:11:17.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/ia64/kernel/irq.c	2004-06-04 02:24:12.523600000 -0700
@@ -608,7 +608,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/mips/baget/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/mips/baget/irq.c	2004-05-29 23:26:19.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/mips/baget/irq.c	2004-06-04 02:24:12.543597000 -0700
@@ -325,7 +325,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/mips/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/mips/kernel/irq.c	2004-05-29 23:25:45.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/mips/kernel/irq.c	2004-06-04 02:24:12.568593000 -0700
@@ -487,7 +487,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/parisc/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/parisc/kernel/irq.c	2004-05-29 23:26:04.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/parisc/kernel/irq.c	2004-06-04 02:24:12.590590000 -0700
@@ -644,7 +644,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/ppc64/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/ppc64/kernel/irq.c	2004-05-29 23:26:09.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/ppc64/kernel/irq.c	2004-06-04 02:24:12.617586000 -0700
@@ -206,7 +206,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->dev_id = dev_id;
 	action->next = NULL;
Index: irqaction-2.6.7-rc2/arch/sh/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/sh/kernel/irq.c	2004-05-29 23:26:03.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/sh/kernel/irq.c	2004-06-04 02:24:12.638583000 -0700
@@ -436,7 +436,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/sparc/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/sparc/kernel/irq.c	2004-05-29 23:25:43.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/sparc/kernel/irq.c	2004-06-04 02:24:12.668578000 -0700
@@ -448,7 +448,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->dev_id = NULL;
 	action->next = NULL;
@@ -528,7 +528,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/sparc/kernel/sun4d_irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/sparc/kernel/sun4d_irq.c	2004-05-29 23:25:40.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/sparc/kernel/sun4d_irq.c	2004-06-04 02:24:12.682576000 -0700
@@ -336,7 +336,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/sparc64/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/sparc64/kernel/irq.c	2004-05-29 23:26:43.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/sparc64/kernel/irq.c	2004-06-04 02:45:41.266681000 -0700
@@ -118,10 +118,6 @@
 		action->flags |= __irq_ino(irq) << 48;
 #define get_ino_in_irqaction(action)	(action->flags >> 48)
 
-#if NR_CPUS > 64
-#error irqaction embedded smp affinity does not work with > 64 cpus, FIXME
-#endif
-
 #define put_smpaff_in_irqaction(action, smpaff)	(action)->mask = (smpaff)
 #define get_smpaff_in_irqaction(action) 	((action)->mask)
 
@@ -454,7 +450,7 @@
 	action->next = NULL;
 	action->dev_id = dev_id;
 	put_ino_in_irqaction(action, irq);
-	put_smpaff_in_irqaction(action, 0);
+	put_smpaff_in_irqaction(action, CPU_MASK_NONE);
 
 	if (tmp)
 		tmp->next = action;
@@ -710,7 +706,7 @@
 		if (++buddy >= NR_CPUS)
 			buddy = 0;
 		if (++ticks > NR_CPUS) {
-			put_smpaff_in_irqaction(ap, 0);
+			put_smpaff_in_irqaction(ap, CPU_MASK_NONE);
 			goto out;
 		}
 	}
@@ -944,7 +940,7 @@
 	action->name = name;
 	action->next = NULL;
 	put_ino_in_irqaction(action, irq);
-	put_smpaff_in_irqaction(action, 0);
+	put_smpaff_in_irqaction(action, CPU_MASK_NONE);
 
 	*(bucket->pil + irq_action) = action;
 	enable_irq(irq);
@@ -1162,45 +1158,6 @@
 
 #ifdef CONFIG_SMP
 
-#define HEX_DIGITS 16
-
-static unsigned int parse_hex_value (const char *buffer,
-		unsigned long count, unsigned long *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	value = 0;
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		value = (value << 4) | c;
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
@@ -1219,7 +1176,7 @@
 	return len;
 }
 
-static inline void set_intr_affinity(int irq, unsigned long hw_aff)
+static inline void set_intr_affinity(int irq, cpumask_t hw_aff)
 {
 	struct ino_bucket *bp = ivector_table + irq;
 
@@ -1237,22 +1194,17 @@
 					unsigned long count, void *data)
 {
 	int irq = (long) data, full_count = count, err;
-	unsigned long new_value, i;
+	cpumask_t new_value;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	for (i = 0; i < NR_CPUS; i++) {
-		if ((new_value & (1UL << i)) != 0 &&
-		    !cpu_online(i))
-			new_value &= ~(1UL << i);
-	}
-
-	if (!new_value)
+	cpus_and(new_value, new_value, cpu_online_map);
+	if (cpus_empty(new_value))
 		return -EINVAL;
 
 	set_intr_affinity(irq, new_value);
Index: irqaction-2.6.7-rc2/arch/sparc64/kernel/smp.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/sparc64/kernel/smp.c	2004-05-29 23:25:41.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/sparc64/kernel/smp.c	2004-06-04 02:46:31.379063000 -0700
@@ -420,9 +420,6 @@
  * packet, but we have no use for that.  However we do take advantage of
  * the new pipelining feature (ie. dispatch to multiple cpus simultaneously).
  */
-#if NR_CPUS > 32
-#error Fixup cheetah_xcall_deliver Dave...
-#endif
 static void cheetah_xcall_deliver(u64 data0, u64 data1, u64 data2, cpumask_t mask)
 {
 	u64 pstate, ver;
Index: irqaction-2.6.7-rc2/arch/um/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/um/kernel/irq.c	2004-05-29 23:26:27.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/um/kernel/irq.c	2004-06-04 02:24:12.746566000 -0700
@@ -419,7 +419,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/v850/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/v850/kernel/irq.c	2004-05-29 23:26:27.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/v850/kernel/irq.c	2004-06-04 02:24:12.772562000 -0700
@@ -392,7 +392,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: irqaction-2.6.7-rc2/arch/x86_64/kernel/irq.c
===================================================================
--- irqaction-2.6.7-rc2.orig/arch/x86_64/kernel/irq.c	2004-06-01 03:11:21.000000000 -0700
+++ irqaction-2.6.7-rc2/arch/x86_64/kernel/irq.c	2004-06-04 02:24:12.795559000 -0700
@@ -491,7 +491,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
