Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWEQWQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWEQWQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWEQWQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:16:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:54750 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751244AbWEQWPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:15:46 -0400
Date: Thu, 18 May 2006 00:15:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: [patchset] Generic IRQ Subsystem: -V4
Message-ID: <20060517221536.GA13444@elte.hu>
References: <20060517001310.GA12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Version 4 of the genirq patch-queue, against 2.6.17-rc4. This 
patch-queue improves the generic IRQ layer to be truly generic, by 
adding various abstractions and features to it, without impacting 
existing functionality.

The number of patches has increased to 56 and the total patchsize has 
increased to 294K, so we wont be sending the patches to lkml. The full 
patch-queue can be downloaded from:

  http://redhat.com/~mingo/generic-irq-subsystem/

The split-out queue is at:

  http://redhat.com/~mingo/generic-irq-subsystem/patches/

In -V4 there are lots of changes all around the map. The most 
significant one is the conversion of the i386 and the x86_64 
architectures to a fully irq-chip based IRQ handling model.

This brought nice simplifications for these architectures:

$ diffstat patches/genirq-i386-irqchip.patch

  arch/i386/kernel/i8259.c   |   45 +++--------
  arch/i386/kernel/io_apic.c |  171 ++++++++++++++-------------------------------
  arch/i386/kernel/irq.c     |   19 ++---
  include/asm-i386/hw_irq.h  |    2
  4 files changed, 80 insertions(+), 157 deletions(-)

$ diffstat patches/genirq-x86_64-irqchip.patch

 arch/x86_64/kernel/i8259.c   |   50 +++----------
 arch/x86_64/kernel/io_apic.c |  165 ++++++++++---------------------------------
 arch/x86_64/kernel/irq.c     |    7 +
 include/asm-x86_64/hw_irq.h  |    2 
 4 files changed, 60 insertions(+), 164 deletions(-)

the IRQ handling hotpath for the most optimal flow got faster and 
leaner. The number of functions called in a typical IRQ decreased too. 
The irqchip implementations have become short and sweet:

 static struct irq_chip ioapic_chip __read_mostly = {
         .name           = "IO-APIC",
         .startup        = startup_ioapic_vector,
         .mask           = mask_ioapic_vector,
         .unmask         = unmask_ioapic_vector,
         .ack            = ack_apic,
 #ifdef CONFIG_SMP
         .set_affinity   = set_ioapic_affinity_vector,
 #endif
         .retrigger      = ioapic_retrigger_vector,
 };

 static struct irq_chip lapic_chip __read_mostly = {
         .name           = "local-APIC-edge",
         .mask           = mask_lapic_irq,
         .unmask         = unmask_lapic_irq,
         .ack            = ack_apic,
 };

 static struct irq_chip i8259A_chip = {
         .name           = "XT-PIC",
         .mask           = disable_8259A_irq,
         .unmask         = enable_8259A_irq,
         .mask_ack       = mask_and_ack_8259A,
 };

see the split-out patches at:

 http://redhat.com/~mingo/generic-irq-subsystem/patches/genirq-i386-irqchip.patch
 http://redhat.com/~mingo/generic-irq-subsystem/patches/genirq-x86_64-irqchip.patch

Another new feature is the handle_level_irq_fastack() highlevel irq-flow 
handler, which allows faster IRQ handling without masking/unmasking. 
This is current used by the new i386 and x86_64 IO-APIC code, but it 
could also be useful to most optimally support transparent ACK sequences 
in OpenPIC/MPIC controllers.

There were also extensive renames done to make the irq_chip and irq_desc 
fields clearer.

All changes since -V3:

- fixed set_wake prototype bug (reported by Daniel Walker)

- documentation fixes (Randy Dunlap)

- call desc->handle_irq() highlevel irq-flow handlers from __do_IRQ() 
  too, allowing gradual transition from a __do_IRQ() based model to an 
  irq-chips model. This was used for the i386 and x86_64 transition with 
  great success.

- ARM updates

- More size reduction:

      text    data     bss     dec     hex filename
   3430374  985464 1325080 5740918  579976 vmlinux-x64.orig
   3434234  982216 1321240 5737690  578cda vmlinux-x64.genirq

  while .text got larger, .data and .bss got smaller, so it's a net
  size reduction of ~4K.

- better debugging info from spurious interrupts.

- truly remove the irq_dir[] and smp_affinity_entry[] arrays. (this 
  change was announced in -V3 but went MIA)

- introduced the handle_level_irq_fastack() highlevel flow handler, for 
  fast IO-APIC interrupt handling. This should enable the most optimal 
  flow for transparent-ACK IRQ controllers too. (such as OpenPIC/MPIC)

- pushed desc->lock handling into the highlevel flow handlers. This 
  unified and simplified the arch-level call sites.

- sem2mutex: kernel/irq/autoprobe.c probe_sem => probe_lock mutex 
  conversion.

- changed the desc->handle_irq() handlers to be explicit fastcalls, to 
  keep the 4K_STACKS assembly code simpler.

- removed desc->affinity_entry - nothing uses it

- added chip->name as the primary field - chip->typename is still 
  kept for compatibility purposes.

- probe_irq() related fix in drivers/mfd/ucb1x00-core.c

- include flow information in /proc/interrupts for irq-chip based 
  architectures too.

- genirq-i386-irqchip.patch: change the i386 architecture to be irqchip 
  based.

- genirq-x86_64-irqchip.patch: change the x86_64 architecture to be 
  irqchip based.

- renamed 'desc->handler' to 'desc->chip' - the code got much cleaner 
  due to this.

- retrigger fix on i386 and x86_64, it is now MSI-vector aware.

- renamed 'desc->handle' to 'desc->handle_irq'

- moved the set_irq_handler() method of setting desc->handle_irq() from 
  ARM into the generic code.

-V4 has been build-tested with allyesconfig, and booted on x86, x86_64 
and various ARM platforms. Nevertheless the new i386 and x86_64 IRQ code 
is experimental and has been tested only on a limited number of systems.

	Ingo, Thomas
