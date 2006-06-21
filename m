Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751933AbWFUCdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbWFUCdK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWFUCdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:33:09 -0400
Received: from mga05.intel.com ([192.55.52.89]:31143 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751933AbWFUCdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:33:05 -0400
X-IronPort-AV: i="4.06,158,1149490800"; 
   d="scan'208"; a="55977908:sNHT72225181"
Date: Tue, 20 Jun 2006 19:27:34 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 11/25] i386 irq:  Dynamic irq support
Message-ID: <20060620192734.G10402@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <20060620185015.F10402@unix-os.sc.intel.com> <m1mzc79rlf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1mzc79rlf.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Tue, Jun 20, 2006 at 08:21:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 08:21:00PM -0600, Eric W. Biederman wrote:
> Rajesh Shah <rajesh.shah@intel.com> writes:
> 
> > It would be really good to decouple MSI implementation from IO
> > APICs, since there's really no real hardware dependence here.
> > This code can actually go to arch/xxx/pci/msi-apic.c
> 
> I agree in theory.  In practice however msi interrupts look like io_apics.
> with a different register set and the use all of the same support facilities.
> So until that part of the architecture is refactored it doesn't make much
> sense.  There is a slightly better case for moving the code into a separate
> file.  Namely I think I know of a second common implementation for x86_64.
> At which point the files will probably be named msi-intel.c and msi-amd.c
> Or something like that.  
> 
Actually, I meant just the vector tracking code could be in a
separate file and the ioapic and msi code could both assign
vectors from a common routine. I had the patch below in my
patchkit, plus another patch for x86_64 to do the same thing
in io_apic.c and share the same intrvec.c file between the 
two archs. Once you have this, the MSI callbacks in arch
code can be moved out of io_apic.c


 arch/i386/kernel/Makefile                   |    2 
 arch/i386/kernel/intrvec.c                  |   94 ++++++++++++++++++++++++++++
 arch/i386/kernel/io_apic.c                  |   26 ++-----
 include/asm-i386/mach-default/irq_vectors.h |    1 
 4 files changed, 105 insertions(+), 18 deletions(-)

Index: linux-2.6.17-rc6-mm2/arch/i386/kernel/intrvec.c
===================================================================
--- /dev/null
+++ linux-2.6.17-rc6-mm2/arch/i386/kernel/intrvec.c
@@ -0,0 +1,94 @@
+
+/*
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
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) 2006 Intel Corporation (rajesh.shah@intel.com)
+ *
+ */
+
+#include <linux/irq.h>
+
+/*
+ * Code to manage interrupt vectors to program for IO-APIC and PCI
+ * Message Signalled Interrupts (MSI/MSI-X)
+ */
+#define VECTOR_STRIDE 		8
+#define NUM_VECTORS		(FIRST_SYSTEM_VECTOR-FIRST_DEVICE_VECTOR)
+
+static DEFINE_SPINLOCK(intr_vector_lock);
+static DECLARE_BITMAP(vectors_used, NUM_VECTORS);
+int current_vector = FIRST_DEVICE_VECTOR;
+int offset = 0;
+
+static inline void mark_vector_used(int vector)
+{
+	if ((vector >= FIRST_DEVICE_VECTOR) && (vector < FIRST_SYSTEM_VECTOR))
+		set_bit((vector - FIRST_DEVICE_VECTOR), vectors_used);
+}
+
+static inline void mark_vector_free(int vector)
+{
+	if ((vector >= FIRST_DEVICE_VECTOR) && (vector < FIRST_SYSTEM_VECTOR))
+		clear_bit((vector - FIRST_DEVICE_VECTOR), vectors_used);
+}
+
+static inline int is_used(int vector)
+{
+	if ((vector < FIRST_DEVICE_VECTOR) || (vector >= FIRST_SYSTEM_VECTOR))
+		return 1;
+	return (test_bit((vector - FIRST_DEVICE_VECTOR), vectors_used));
+}
+
+int assign_vector(void)
+{
+	unsigned long flags;
+	int vector;
+
+	spin_lock_irqsave(&intr_vector_lock, flags);
+	if (bitmap_full(vectors_used, NUM_VECTORS)) {
+		spin_unlock_irqrestore(&intr_vector_lock, flags);
+		return -1;
+	}
+	vector = current_vector;
+	while (is_used(vector)) {
+		vector += VECTOR_STRIDE;
+		if (vector >= FIRST_SYSTEM_VECTOR)
+			vector = FIRST_DEVICE_VECTOR +
+				(++offset % VECTOR_STRIDE);
+	}
+	mark_vector_used(vector);
+	current_vector = vector;
+	spin_unlock_irqrestore(&intr_vector_lock, flags);
+	return vector;
+}
+
+void free_vector(int vector)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&intr_vector_lock, flags);
+	mark_vector_free(vector);
+	current_vector = vector; /* use this vector at next request */
+	spin_unlock_irqrestore(&intr_vector_lock, flags);
+}
+
+static int __init init_vector_array(void)
+{
+	mark_vector_used(IA32_SYSCALL_VECTOR);
+	return 0;
+}
+
+core_initcall(init_vector_array);
+
Index: linux-2.6.17-rc6-mm2/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/Makefile
+++ linux-2.6.17-rc6-mm2/arch/i386/kernel/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.
 obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
-obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o intrvec.o
 obj-$(CONFIG_X86_REBOOTFIXUPS)	+= reboot_fixups.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
Index: linux-2.6.17-rc6-mm2/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.17-rc6-mm2/arch/i386/kernel/io_apic.c
@@ -95,6 +95,8 @@ int vector_irq[NR_VECTORS] __read_mostly
 #define vector_to_irq(vector)	(vector)
 #endif
 
+extern int assign_vector(void);
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -1163,38 +1165,28 @@ u8 irq_vector[NR_IRQ_VECTORS] __read_mos
 
 int assign_irq_vector(int irq)
 {
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	unsigned long flags;
 	int vector;
 
 	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
 
-	spin_lock_irqsave(&vector_lock, flags);
+	spin_lock(&vector_lock);
 
 	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0) {
-		spin_unlock_irqrestore(&vector_lock, flags);
+		spin_unlock(&vector_lock);
 		return IO_APIC_VECTOR(irq);
 	}
-next:
-	current_vector += 8;
-	if (current_vector == SYSCALL_VECTOR)
-		goto next;
 
-	if (current_vector >= FIRST_SYSTEM_VECTOR) {
-		offset++;
-		if (!(offset%8)) {
-			spin_unlock_irqrestore(&vector_lock, flags);
-			return -ENOSPC;
-		}
-		current_vector = FIRST_DEVICE_VECTOR + offset;
+	vector = assign_vector();
+	if (vector < 0) {
+		spin_unlock(&vector_lock);
+		return -1;
 	}
 
-	vector = current_vector;
 	vector_irq[vector] = irq;
 	if (irq != AUTO_ASSIGN)
 		IO_APIC_VECTOR(irq) = vector;
 
-	spin_unlock_irqrestore(&vector_lock, flags);
+	spin_unlock(&vector_lock);
 
 	return vector;
 }
Index: linux-2.6.17-rc6-mm2/include/asm-i386/mach-default/irq_vectors.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/asm-i386/mach-default/irq_vectors.h
+++ linux-2.6.17-rc6-mm2/include/asm-i386/mach-default/irq_vectors.h
@@ -29,6 +29,7 @@
 #define FIRST_EXTERNAL_VECTOR	0x20
 
 #define SYSCALL_VECTOR		0x80
+#define IA32_SYSCALL_VECTOR	SYSCALL_VECTOR
 
 /*
  * Vectors 0x20-0x2f are used for ISA interrupts.
