Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWEBKkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWEBKkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWEBKkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:40:11 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:35457 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932076AbWEBKkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:40:08 -0400
Date: Tue, 2 May 2006 12:44:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.6.17-rc3-mm1] fix vector_lock deadlock in io_apic.c
Message-ID: <20060502104459.GA24851@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch below fixes a potential deadlock scenario introduced by 
io_apic.c's new vector_lock on i386 and x86_64.

Found by the locking correctness validator. The patch was boot-tested on 
x86. For details of the deadlock scenario, see the validator output:

======================================================
[ BUG: hard-safe -> hard-unsafe lock order detected! ]
------------------------------------------------------
idle/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (msi_lock){....}, at: [<c04ff8d2>] startup_msi_irq_wo_maskbit+0x10/0x35

and this task is already holding:
 (&irq_desc[i].lock){++..}, at: [<c015b924>] probe_irq_on+0x36/0x107
which would create a new lock dependency:
 (&irq_desc[i].lock){++..} -> (msi_lock){....}

but this new dependency connects a hard-irq-safe lock:
 (&irq_desc[i].lock){++..}
... which became hard-irq-safe at:
  [<c01468c4>] lockdep_acquire+0x68/0x84
  [<c10485e9>] _spin_lock+0x21/0x2f
  [<c015aff5>] __do_IRQ+0x3d/0x113
  [<c01062d3>] do_IRQ+0x8c/0xad

to a hard-irq-unsafe lock:
 (vector_lock){--..}
... which became hard-irq-unsafe at:
...  [<c01468c4>] lockdep_acquire+0x68/0x84
  [<c10485e9>] _spin_lock+0x21/0x2f
  [<c011b5e8>] assign_irq_vector+0x34/0xc8
  [<c1aa82fa>] setup_IO_APIC+0x45a/0xcff
  [<c1aa56e3>] smp_prepare_cpus+0x5ea/0x8aa
  [<c010033f>] init+0x32/0x2cb
  [<c0102005>] kernel_thread_helper+0x5/0xb

which could potentially lead to deadlocks!

other info that might help us debug this:

3 locks held by idle/1:
 #0:  (port_mutex){--..}, at: [<c067070d>] uart_add_one_port+0x61/0x289
 #1:  (&state->mutex){--..}, at: [<c067071f>] uart_add_one_port+0x73/0x289
 #2:  (&irq_desc[i].lock){++..}, at: [<c015b924>] probe_irq_on+0x36/0x107

the hard-irq-safe lock's dependencies:
-> (&irq_desc[i].lock){++..} ops: 9861 {
   initial-use  at:
                        [<c01468c4>] lockdep_acquire+0x68/0x84
                        [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                        [<c015b415>] setup_irq+0x9b/0x14d
                        [<c1aaa4c4>] time_init_hook+0xf/0x11
                        [<c1a9f320>] time_init+0x44/0x46
                        [<c1a9955f>] start_kernel+0x191/0x38f
                        [<c0100210>] 0xc0100210
   in-hardirq-W at:
                        [<c01468c4>] lockdep_acquire+0x68/0x84
                        [<c10485e9>] _spin_lock+0x21/0x2f
                        [<c015aff5>] __do_IRQ+0x3d/0x113
                        [<c01062d3>] do_IRQ+0x8c/0xad
   in-softirq-W at:
                        [<c01468c4>] lockdep_acquire+0x68/0x84
                        [<c10485e9>] _spin_lock+0x21/0x2f
                        [<c015aff5>] __do_IRQ+0x3d/0x113
                        [<c01062d3>] do_IRQ+0x8c/0xad
 }
 ... key      at: [<c1ea31e0>] irq_desc_lock_type+0x0/0x20
  -> (i8259A_lock){++..} ops: 5149 {
     initial-use  at:
                      [<c01468c4>] lockdep_acquire+0x68/0x84
                      [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                      [<c0108090>] init_8259A+0x11/0x8f
                      [<c1aa0d22>] init_ISA_irqs+0x12/0x4d
                      [<c1aaa4f0>] pre_intr_init_hook+0x8/0xa
                      [<c1aa0cb9>] init_IRQ+0xe/0x65
                      [<c1a99546>] start_kernel+0x178/0x38f
                      [<c0100210>] 0xc0100210
     in-hardirq-W at:
                      [<c01468c4>] lockdep_acquire+0x68/0x84
                      [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                      [<c0107fb0>] mask_and_ack_8259A+0x1b/0xcc
                      [<c015b007>] __do_IRQ+0x4f/0x113
                      [<c01062d3>] do_IRQ+0x8c/0xad
     in-softirq-W at:
                      [<c01468c4>] lockdep_acquire+0x68/0x84
                      [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                      [<c0107fb0>] mask_and_ack_8259A+0x1b/0xcc
                      [<c015b007>] __do_IRQ+0x4f/0x113
                      [<c01062d3>] do_IRQ+0x8c/0xad
   }
   ... key      at: [<c142f174>] i8259A_lock+0x14/0x40
 ... acquired at:
   [<c01468c4>] lockdep_acquire+0x68/0x84
   [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
   [<c0107eb2>] enable_8259A_irq+0x10/0x47
   [<c0107f12>] startup_8259A_irq+0x8/0xc
   [<c015b45e>] setup_irq+0xe4/0x14d
   [<c1aaa4c4>] time_init_hook+0xf/0x11
   [<c1a9f320>] time_init+0x44/0x46
   [<c1a9955f>] start_kernel+0x191/0x38f
   [<c0100210>] 0xc0100210

  -> (ioapic_lock){+...} ops: 122 {
     initial-use  at:
                      [<c01468c4>] lockdep_acquire+0x68/0x84
                      [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                      [<c1aa71db>] io_apic_get_version+0x16/0x55
                      [<c1aa5c73>] mp_register_ioapic+0xc6/0x127
                      [<c1aa382e>] acpi_parse_ioapic+0x2d/0x39
                      [<c1abe031>] acpi_table_parse_madt_family+0xb4/0x100
                      [<c1abe093>] acpi_table_parse_madt+0x16/0x18
                      [<c1aa3c8a>] acpi_boot_init+0x132/0x251
                      [<c1aa08ea>] setup_arch+0xd36/0xe37
                      [<c1a99434>] start_kernel+0x66/0x38f
                      [<c0100210>] 0xc0100210
     in-hardirq-W at:
                      [<c01468c4>] lockdep_acquire+0x68/0x84
                      [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                      [<c011bce1>] mask_IO_APIC_irq+0x11/0x31
                      [<c011c5cc>] ack_edge_ioapic_vector+0x31/0x41
                      [<c015b007>] __do_IRQ+0x4f/0x113
                      [<c01062d3>] do_IRQ+0x8c/0xad
   }
   ... key      at: [<c1432514>] ioapic_lock+0x14/0x3c
    -> (i8259A_lock){++..} ops: 5149 {
       initial-use  at:
                       [<c01468c4>] lockdep_acquire+0x68/0x84
                       [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                       [<c0108090>] init_8259A+0x11/0x8f
                       [<c1aa0d22>] init_ISA_irqs+0x12/0x4d
                       [<c1aaa4f0>] pre_intr_init_hook+0x8/0xa
                       [<c1aa0cb9>] init_IRQ+0xe/0x65
                       [<c1a99546>] start_kernel+0x178/0x38f
                       [<c0100210>] 0xc0100210
       in-hardirq-W at:
                       [<c01468c4>] lockdep_acquire+0x68/0x84
                       [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                       [<c0107fb0>] mask_and_ack_8259A+0x1b/0xcc
                       [<c015b007>] __do_IRQ+0x4f/0x113
                       [<c01062d3>] do_IRQ+0x8c/0xad
       in-softirq-W at:
                       [<c01468c4>] lockdep_acquire+0x68/0x84
                       [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
                       [<c0107fb0>] mask_and_ack_8259A+0x1b/0xcc
                       [<c015b007>] __do_IRQ+0x4f/0x113
                       [<c01062d3>] do_IRQ+0x8c/0xad
     }
     ... key      at: [<c142f174>] i8259A_lock+0x14/0x40
   ... acquired at:
   [<c01468c4>] lockdep_acquire+0x68/0x84
   [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
   [<c0107e6b>] disable_8259A_irq+0x10/0x47
   [<c011bdbd>] startup_edge_ioapic_vector+0x31/0x58
   [<c015b45e>] setup_irq+0xe4/0x14d
   [<c015b5a1>] request_irq+0xda/0xf9
   [<c1ac983a>] rtc_init+0x6a/0x1a7
   [<c0100457>] init+0x14a/0x2cb
   [<c0102005>] kernel_thread_helper+0x5/0xb

 ... acquired at:
   [<c01468c4>] lockdep_acquire+0x68/0x84
   [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
   [<c011bce1>] mask_IO_APIC_irq+0x11/0x31
   [<c011c5cc>] ack_edge_ioapic_vector+0x31/0x41
   [<c015b007>] __do_IRQ+0x4f/0x113
   [<c01062d3>] do_IRQ+0x8c/0xad


the hard-irq-unsafe lock's dependencies:
-> (vector_lock){--..} ops: 31 {
   initial-use  at:
                        [<c01468c4>] lockdep_acquire+0x68/0x84
                        [<c10485e9>] _spin_lock+0x21/0x2f
                        [<c011b5e8>] assign_irq_vector+0x34/0xc8
                        [<c1aa82fa>] setup_IO_APIC+0x45a/0xcff
                        [<c1aa56e3>] smp_prepare_cpus+0x5ea/0x8aa
                        [<c010033f>] init+0x32/0x2cb
                        [<c0102005>] kernel_thread_helper+0x5/0xb
   softirq-on-W at:
                        [<c01468c4>] lockdep_acquire+0x68/0x84
                        [<c10485e9>] _spin_lock+0x21/0x2f
                        [<c011b5e8>] assign_irq_vector+0x34/0xc8
                        [<c1aa82fa>] setup_IO_APIC+0x45a/0xcff
                        [<c1aa56e3>] smp_prepare_cpus+0x5ea/0x8aa
                        [<c010033f>] init+0x32/0x2cb
                        [<c0102005>] kernel_thread_helper+0x5/0xb
   hardirq-on-W at:
                        [<c01468c4>] lockdep_acquire+0x68/0x84
                        [<c10485e9>] _spin_lock+0x21/0x2f
                        [<c011b5e8>] assign_irq_vector+0x34/0xc8
                        [<c1aa82fa>] setup_IO_APIC+0x45a/0xcff
                        [<c1aa56e3>] smp_prepare_cpus+0x5ea/0x8aa
                        [<c010033f>] init+0x32/0x2cb
                        [<c0102005>] kernel_thread_helper+0x5/0xb
 }
 ... key      at: [<c1432574>] vector_lock+0x14/0x3c

stack backtrace:
 [<c0104f36>] show_trace+0xd/0xf
 [<c010543e>] dump_stack+0x17/0x19
 [<c0144e34>] check_usage+0x1f6/0x203
 [<c0146395>] __lockdep_acquire+0x8c2/0xaa5
 [<c01468c4>] lockdep_acquire+0x68/0x84
 [<c10487f4>] _spin_lock_irqsave+0x2a/0x3a
 [<c04ff8d2>] startup_msi_irq_wo_maskbit+0x10/0x35
 [<c015b932>] probe_irq_on+0x44/0x107
 [<c0673d58>] serial8250_config_port+0x84b/0x986
 [<c06707b1>] uart_add_one_port+0x105/0x289
 [<c1ace54b>] serial8250_init+0xc3/0x10a
 [<c0100457>] init+0x14a/0x2cb
 [<c0102005>] kernel_thread_helper+0x5/0xb

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -1154,14 +1154,15 @@ u8 irq_vector[NR_IRQ_VECTORS] __read_mos
 int assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	unsigned long flags;
 	int vector;
 
 	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
 
-	spin_lock(&vector_lock);
+	spin_lock_irqsave(&vector_lock, flags);
 
 	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0) {
-		spin_unlock(&vector_lock);
+		spin_unlock_irqrestore(&vector_lock, flags);
 		return IO_APIC_VECTOR(irq);
 	}
 next:
@@ -1172,7 +1173,7 @@ next:
 	if (current_vector >= FIRST_SYSTEM_VECTOR) {
 		offset++;
 		if (!(offset%8)) {
-			spin_unlock(&vector_lock);
+			spin_unlock_irqrestore(&vector_lock, flags);
 			return -ENOSPC;
 		}
 		current_vector = FIRST_DEVICE_VECTOR + offset;
@@ -1183,7 +1184,7 @@ next:
 	if (irq != AUTO_ASSIGN)
 		IO_APIC_VECTOR(irq) = vector;
 
-	spin_unlock(&vector_lock);
+	spin_unlock_irqrestore(&vector_lock, flags);
 
 	return vector;
 }
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -815,14 +815,15 @@ u8 irq_vector[NR_IRQ_VECTORS] __read_mos
 int assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	unsigned long flags;
 	int vector;
 
 	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
 
-	spin_lock(&vector_lock);
+	spin_lock_irqsave(&vector_lock, flags);
 
 	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0) {
-		spin_unlock(&vector_lock);
+		spin_unlock_irqrestore(&vector_lock, flags);
 		return IO_APIC_VECTOR(irq);
 	}
 next:
@@ -841,7 +842,7 @@ next:
 	if (irq != AUTO_ASSIGN)
 		IO_APIC_VECTOR(irq) = vector;
 
-	spin_unlock(&vector_lock);
+	spin_unlock_irqrestore(&vector_lock, flags);
 
 	return vector;
 }
