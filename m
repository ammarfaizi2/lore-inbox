Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWJHNpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWJHNpw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWJHNpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:45:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55778 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751164AbWJHNpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:45:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] i386/x86_64: Remove global IO_APIC_VECTOR
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
	<m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	<20061007175926.GN14186@rhun.haifa.ibm.com>
	<m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fydzudq8.fsf_-_@ebiederm.dsl.xmission.com>
Date: Sun, 08 Oct 2006 07:43:46 -0600
In-Reply-To: <m1fydzudq8.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Sun, 08 Oct 2006 07:41:19 -0600")
Message-ID: <m1bqomvs6l.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Which vector an irq is assigned to now varies dynamically and is
not needed outside of io_apic.c.  So remove the possibility
of accessing the information outside of io_apic.c and remove
the silly macro that makes looking for users of irq_vector
difficult.

The fact this compiles ensures there aren't any more pieces
of the old CONFIG_PCI_MSI weirdness that I failed to remove.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/io_apic.c   |   12 ++++++------
 arch/x86_64/kernel/io_apic.c |    8 ++++----
 include/asm-i386/hw_irq.h    |    3 ---
 include/asm-x86_64/hw_irq.h  |    2 --
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index b7287fb..cd082c3 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1184,8 +1184,8 @@ static int __assign_irq_vector(int irq)
 
 	BUG_ON((unsigned)irq >= NR_IRQ_VECTORS);
 
-	if (IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
+	if (irq_vector[irq] > 0)
+		return irq_vector[irq];
 
 	current_vector += 8;
 	if (current_vector == SYSCALL_VECTOR)
@@ -1199,7 +1199,7 @@ static int __assign_irq_vector(int irq)
 	}
 
 	vector = current_vector;
-	IO_APIC_VECTOR(irq) = vector;
+	irq_vector[irq] = vector;
 
 	return vector;
 }
@@ -1967,7 +1967,7 @@ static void ack_ioapic_quirk_irq(unsigne
  * operation to prevent an edge-triggered interrupt escaping meanwhile.
  * The idea is from Manfred Spraul.  --macro
  */
-	i = IO_APIC_VECTOR(irq);
+	i = irq_vector[irq];
 
 	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
 
@@ -1984,7 +1984,7 @@ static void ack_ioapic_quirk_irq(unsigne
 
 static int ioapic_retrigger_irq(unsigned int irq)
 {
-	send_IPI_self(IO_APIC_VECTOR(irq));
+	send_IPI_self(irq_vector[irq]);
 
 	return 1;
 }
@@ -2020,7 +2020,7 @@ static inline void init_IO_APIC_traps(vo
 	 */
 	for (irq = 0; irq < NR_IRQS ; irq++) {
 		int tmp = irq;
-		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
+		if (IO_APIC_IRQ(tmp) && !irq_vector[tmp]) {
 			/*
 			 * Hmm.. We don't have an entry for this,
 			 * so default to an old-fashioned 8259
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 91728d9..9c3b9b1 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -587,8 +587,8 @@ static int __assign_irq_vector(int irq, 
 
 	BUG_ON((unsigned)irq >= NR_IRQ_VECTORS);
 
-	if (IO_APIC_VECTOR(irq) > 0)
-		old_vector = IO_APIC_VECTOR(irq);
+	if (irq_vector[irq] > 0)
+		old_vector = irq_vector[irq];
 	if ((old_vector > 0) && cpu_isset(old_vector >> 8, mask)) {
 		return old_vector;
 	}
@@ -620,7 +620,7 @@ next:
 		}
 		per_cpu(vector_irq, cpu)[vector] = irq;
 		vector |= cpu << 8;
-		IO_APIC_VECTOR(irq) = vector;
+		irq_vector[irq] = vector;
 		return vector;
 	}
 	return -ENOSPC;
@@ -1289,7 +1289,7 @@ static inline void init_IO_APIC_traps(vo
 	 */
 	for (irq = 0; irq < NR_IRQS ; irq++) {
 		int tmp = irq;
-		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
+		if (IO_APIC_IRQ(tmp) && !irq_vector[tmp]) {
 			/*
 			 * Hmm.. We don't have an entry for this,
 			 * so default to an old-fashioned 8259
diff --git a/include/asm-i386/hw_irq.h b/include/asm-i386/hw_irq.h
index 8806c7e..0bedbdf 100644
--- a/include/asm-i386/hw_irq.h
+++ b/include/asm-i386/hw_irq.h
@@ -26,9 +26,6 @@ #define NMI_VECTOR		0x02
  * Interrupt entry/exit code at both C and assembly level
  */
 
-extern u8 irq_vector[NR_IRQ_VECTORS];
-#define IO_APIC_VECTOR(irq)	(irq_vector[irq])
-
 extern void (*interrupt[NR_IRQS])(void);
 
 #ifdef CONFIG_SMP
diff --git a/include/asm-x86_64/hw_irq.h b/include/asm-x86_64/hw_irq.h
index 53d0d9f..792dd52 100644
--- a/include/asm-x86_64/hw_irq.h
+++ b/include/asm-x86_64/hw_irq.h
@@ -74,10 +74,8 @@ #define FIRST_SYSTEM_VECTOR	0xef   /* du
 
 
 #ifndef __ASSEMBLY__
-extern unsigned int irq_vector[NR_IRQ_VECTORS];
 typedef int vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
-#define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
-- 
1.4.2.rc3.g7e18e-dirty

