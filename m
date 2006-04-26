Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWDZOHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWDZOHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWDZOHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:07:13 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2361
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932442AbWDZOHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:07:11 -0400
Message-Id: <444F9AD9.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 16:07:53 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Cc: <discuss@x86-64.org>
Subject: [PATCH] serialize assign_irq_vector() use of static variables
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since assign_irq_vector() can be called at runtime, its access of static
variables should be protected by a lock.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/io_apic.c
2.6.17-rc2-x86-assign_irq_vector-lock/arch/i386/kernel/io_apic.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/io_apic.c	2006-04-26 10:55:11.000000000 +0200
+++ 2.6.17-rc2-x86-assign_irq_vector-lock/arch/i386/kernel/io_apic.c	2006-04-25 15:38:32.000000000 +0200
@@ -50,6 +50,7 @@ atomic_t irq_mis_count;
 static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
 
 static DEFINE_SPINLOCK(ioapic_lock);
+static DEFINE_SPINLOCK(vector_lock);
 
 int timer_over_8254 __initdata = 1;
 
@@ -1152,10 +1153,16 @@ u8 irq_vector[NR_IRQ_VECTORS] __read_mos
 int assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	int vector;
+
+	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
+
+	spin_lock(&vector_lock);
 
-	BUG_ON(irq >= NR_IRQ_VECTORS);
-	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
+	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0) {
+		spin_unlock(&vector_lock);
 		return IO_APIC_VECTOR(irq);
+	}
 next:
 	current_vector += 8;
 	if (current_vector == SYSCALL_VECTOR)
@@ -1163,16 +1170,21 @@ next:
 
 	if (current_vector >= FIRST_SYSTEM_VECTOR) {
 		offset++;
-		if (!(offset%8))
+		if (!(offset%8)) {
+			spin_unlock(&vector_lock);
 			return -ENOSPC;
+		}
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-	vector_irq[current_vector] = irq;
+	vector = current_vector;
+	vector_irq[vector] = irq;
 	if (irq != AUTO_ASSIGN)
-		IO_APIC_VECTOR(irq) = current_vector;
+		IO_APIC_VECTOR(irq) = vector;
+
+	spin_unlock(&vector_lock);
 
-	return current_vector;
+	return vector;
 }
 
 static struct hw_interrupt_type ioapic_level_type;
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/x86_64/kernel/io_apic.c
2.6.17-rc2-x86-assign_irq_vector-lock/arch/x86_64/kernel/io_apic.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/x86_64/kernel/io_apic.c	2006-04-26 10:55:24.000000000 +0200
+++ 2.6.17-rc2-x86-assign_irq_vector-lock/arch/x86_64/kernel/io_apic.c	2006-04-25 15:38:32.000000000 +0200
@@ -56,6 +56,7 @@ int timer_over_8254 __initdata = 0;
 static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
 
 static DEFINE_SPINLOCK(ioapic_lock);
+static DEFINE_SPINLOCK(vector_lock);
 
 /*
  * # of IRQ routing registers
@@ -814,10 +815,16 @@ u8 irq_vector[NR_IRQ_VECTORS] __read_mos
 int assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	int vector;
 
 	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
-	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
+
+	spin_lock(&vector_lock);
+
+	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0) {
+		spin_unlock(&vector_lock);
 		return IO_APIC_VECTOR(irq);
+	}
 next:
 	current_vector += 8;
 	if (current_vector == IA32_SYSCALL_VECTOR)
@@ -829,11 +836,14 @@ next:
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-	vector_irq[current_vector] = irq;
+	vector = current_vector;
+	vector_irq[vector] = irq;
 	if (irq != AUTO_ASSIGN)
-		IO_APIC_VECTOR(irq) = current_vector;
+		IO_APIC_VECTOR(irq) = vector;
+
+	spin_unlock(&vector_lock);
 
-	return current_vector;
+	return vector;
 }
 
 extern void (*interrupt[NR_IRQS])(void);


