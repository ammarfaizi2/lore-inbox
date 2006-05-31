Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWEaGiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWEaGiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWEaGiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:38:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:44427 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964796AbWEaGiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:38:17 -0400
Subject: powerpc genirq mpic conversion & some issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 31 May 2006 16:37:55 +1000
Message-Id: <1149057475.766.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas.

So I've done first step of the conversion which ended up exposing a
couple of places where the genirq "almost" simplified things but not
quite completely :) I basically converted the MPIC (OpenPIC) driver and
it's use by the PowerMac platform (with just that patch, other platforms
will probably not even build, that is expected at this point, also, the
patch itself won't work without another patch adding the call to the new
handlers at the toplevel that I can post separately, but it's irrelevant
to this discussion).

So my actual patch is appended. As you can see, there are a couple of
"issues":

 * Cascaded interrupts. On some powermacs, I have 2 cascaded MPICs (the
output of CPU 0 of the slave one being connected to one of the sources
of the master one). I thus create the 2 instances as usual, then I do
set_irq_data() to set the cascade's handler_data to the instance of the
slave controller and set_irq_chained_handler() to a local function that
"handles" the cascade.

The thing is ... this is at least twice as many lines of code  as it
could be imho :) My main problem with that approach is that the PowerMac
code in this case (platform specific) ends up containing a routine for
the cascade that itself is both specific to cascading from an MPIC, and
cascading to an MPIC. That is, if either the slave or the master is a
different type of controller, the routine will have to be different :

Because it's a handler, it gets called "right away" without any locking
on the descriptor
of the cascade etc... However, it still needs to at least end() the
interrupt on the parent controller. Here, the parent is an MPIC so I
know I only need end() and I know I don't need to lock the irq_desc...
but if the parent was something else, I would need something else. So
the cascade demultiplexer, which should only have to know about the
slave controller, ends up needing a cascade handler written tailored to
the type of parent controller. In fact, in some cases (dumb parent), it
will have to duplicate completely handle_{edge,level}_irq except that it
replaces the handle_IRQ_event() with a loop calling the slave
interrupts.

I will need a similar cascade handler once I "port" over the other PIC
used on PowerMac which is dumb and will definitely a more complex
cascade handlers.

At the end of the day, I'm tempted to just request_irq() the cascade and
have the irq action just do the loop calling generic_handle_irq(). It
won't be a hyper-optimized cascade handler, but I don't care in that
case. The only thing preventing me from doing that is that request_irq()
can't be called that early because it does kmalloc and slab isn't
initialized yet... but I can just do my hack with setup_irq() and a
static action structure like I do for the debugger NMI and for the other
powermac cascade handler...

Finally, a detail, but I find it fairly annoying, is that cascades done
that way simply don't appear in /proc/interrupts (the parent cascade).
So I can't easily diagnose issues like incorrecf ack'ing causing them to
happen too often (like one spurrious cascade irq after each normal one)
etc... using request_irq() or my low-level hacked setup_irq() method
also provides that.
 
So my conclusion here is that set_irq_chained_handler() doesn't buy me
anything. It  doesn't _prevent_ me from doing differently, but I don't
like not using the new infrastructure :)

 * MPIC irq_chip instances. For now, an mpic instance structure embeds
irq_chip structures (in fact, with my patch, it becomes 3 instead of 2
previously because I "cleaned up" the hypertransport interrupt handling
to use a separate irq_chip). The reason I can't just use statically
defined chips (I do have them, I just still need to copy them over to
the mpic instance) is because I need to change a couple of fields for
each instance: the name, but that's a detail and I would have been ok to
drop that "feature" of having different PIC names in /proc/interrupts
for the master and the slave MPIC. The other problem is that the slave
can't implement affinity (for obvious reasons). Thus it neesd the
irq_chip.set_affinity NULLed (since that's how the /proc code "knows"
wether to allow affinity control). That would have forced me to have
twice as much (that is 6) different irq_chips if I wanted to stick to
static ones. A bit too much to my taste.

One option is to have mpic's set_affinity() do nothing on a slave PIC
but that is a bit ugly especially since the /proc interface will act as
if it was actually working.

Another one might be to define an irq flag set by the PIC in the desc
saying that affinity control doesn't exist for a given irq...

Or I can just continue doing what I do.... I don't like it much but it
works.

What do you think ?
cheers,

Ben.


Index: linux-wor arch/powerpc/platforms/powermac/pic.c |   17 ++-
 arch/powerpc/sysdev/mpic.c            |  188 +++++++++++++++++-----------------
 include/asm-powerpc/mpic.h            |   25 ----
 3 files changed, 116 insertions(+), 114 deletions(-)

k/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mpic.c	2006-05-31 15:46:36.000000000 +1000
+++ linux-work/arch/powerpc/sysdev/mpic.c	2006-05-31 16:00:37.000000000 +1000
@@ -101,8 +101,8 @@ static inline u32 _mpic_cpu_read(struct 
 
 	if (mpic->flags & MPIC_PRIMARY)
 		cpu = hard_smp_processor_id();
-
-	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->cpuregs[cpu], reg);
+	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN,
+			  mpic->cpuregs[cpu], reg);
 }
 
 static inline void _mpic_cpu_write(struct mpic *mpic, unsigned int reg, u32 value)
@@ -379,14 +379,14 @@ static inline u32 mpic_physmask(u32 cpum
 /* Get the mpic structure from the IPI number */
 static inline struct mpic * mpic_from_ipi(unsigned int ipi)
 {
-	return container_of(irq_desc[ipi].chip, struct mpic, hc_ipi);
+	return irq_desc[ipi].chip_data;
 }
 #endif
 
 /* Get the mpic structure from the irq number */
 static inline struct mpic * mpic_from_irq(unsigned int irq)
 {
-	return container_of(irq_desc[irq].chip, struct mpic, hc_irq);
+	return irq_desc[irq].chip_data;
 }
 
 /* Send an EOI */
@@ -411,7 +411,7 @@ static irqreturn_t mpic_ipi_action(int i
  */
 
 
-static void mpic_enable_irq(unsigned int irq)
+static void mpic_unmask_irq(unsigned int irq)
 {
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
@@ -430,35 +430,9 @@ static void mpic_enable_irq(unsigned int
 			break;
 		}
 	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);	
-
-#ifdef CONFIG_MPIC_BROKEN_U3
-	if (mpic->flags & MPIC_BROKEN_U3) {
-		unsigned int src = irq - mpic->irq_offset;
-		if (mpic_is_ht_interrupt(mpic, src) &&
-		    (irq_desc[irq].status & IRQ_LEVEL))
-			mpic_ht_end_irq(mpic, src);
-	}
-#endif /* CONFIG_MPIC_BROKEN_U3 */
-}
-
-static unsigned int mpic_startup_irq(unsigned int irq)
-{
-#ifdef CONFIG_MPIC_BROKEN_U3
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = irq - mpic->irq_offset;
-#endif /* CONFIG_MPIC_BROKEN_U3 */
-
-	mpic_enable_irq(irq);
-
-#ifdef CONFIG_MPIC_BROKEN_U3
-	if (mpic_is_ht_interrupt(mpic, src))
-		mpic_startup_ht_interrupt(mpic, src, irq_desc[irq].status);
-#endif /* CONFIG_MPIC_BROKEN_U3 */
-
-	return 0;
 }
 
-static void mpic_disable_irq(unsigned int irq)
+static void mpic_mask_irq(unsigned int irq)
 {
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
@@ -479,23 +453,58 @@ static void mpic_disable_irq(unsigned in
 	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
 }
 
-static void mpic_shutdown_irq(unsigned int irq)
+static void mpic_end_irq(unsigned int irq)
 {
+	struct mpic *mpic = mpic_from_irq(irq);
+
+#ifdef DEBUG_IRQ
+	DBG("%s: end_irq: %d\n", mpic->name, irq);
+#endif
+	/* We always EOI on end_irq() even for edge interrupts since that
+	 * should only lower the priority, the MPIC should have properly
+	 * latched another edge interrupt coming in anyway
+	 */
+
+	mpic_eoi(mpic);
+}
+
 #ifdef CONFIG_MPIC_BROKEN_U3
+
+static void mpic_unmask_ht_irq(unsigned int irq)
+{
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = irq - mpic->irq_offset;
 
-	if (mpic_is_ht_interrupt(mpic, src))
-		mpic_shutdown_ht_interrupt(mpic, src, irq_desc[irq].status);
+	mpic_unmask_irq(irq);
 
-#endif /* CONFIG_MPIC_BROKEN_U3 */
+	if (irq_desc[irq].status & IRQ_LEVEL)
+		mpic_ht_end_irq(mpic, src);
+}
 
-	mpic_disable_irq(irq);
+static unsigned int mpic_startup_ht_irq(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_irq(irq);
+	unsigned int src = irq - mpic->irq_offset;
+
+	mpic_unmask_irq(irq);
+	mpic_startup_ht_interrupt(mpic, src, irq_desc[irq].status);
+
+	return 0;
 }
 
-static void mpic_end_irq(unsigned int irq)
+static void mpic_shutdown_ht_irq(unsigned int irq)
 {
 	struct mpic *mpic = mpic_from_irq(irq);
+	unsigned int src = irq - mpic->irq_offset;
+
+	mpic_shutdown_ht_interrupt(mpic, src, irq_desc[irq].status);
+	mpic_mask_irq(irq);
+}
+
+static void mpic_end_ht_irq(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_irq(irq);
+	unsigned int src = irq - mpic->irq_offset;
 
 #ifdef DEBUG_IRQ
 	DBG("%s: end_irq: %d\n", mpic->name, irq);
@@ -505,21 +514,16 @@ static void mpic_end_irq(unsigned int ir
 	 * latched another edge interrupt coming in anyway
 	 */
 
-#ifdef CONFIG_MPIC_BROKEN_U3
-	if (mpic->flags & MPIC_BROKEN_U3) {
-		unsigned int src = irq - mpic->irq_offset;
-		if (mpic_is_ht_interrupt(mpic, src) &&
-		    (irq_desc[irq].status & IRQ_LEVEL))
-			mpic_ht_end_irq(mpic, src);
-	}
-#endif /* CONFIG_MPIC_BROKEN_U3 */
-
+	if (irq_desc[irq].status & IRQ_LEVEL)
+		mpic_ht_end_irq(mpic, src);
 	mpic_eoi(mpic);
 }
 
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
 #ifdef CONFIG_SMP
 
-static void mpic_enable_ipi(unsigned int irq)
+static void mpic_unmask_ipi(unsigned int irq)
 {
 	struct mpic *mpic = mpic_from_ipi(irq);
 	unsigned int src = irq - mpic->ipi_offset;
@@ -528,7 +532,7 @@ static void mpic_enable_ipi(unsigned int
 	mpic_ipi_write(src, mpic_ipi_read(src) & ~MPIC_VECPRI_MASK);
 }
 
-static void mpic_disable_ipi(unsigned int irq)
+static void mpic_mask_ipi(unsigned int irq)
 {
 	/* NEVER disable an IPI... that's just plain wrong! */
 }
@@ -561,6 +565,28 @@ static void mpic_set_affinity(unsigned i
 		       mpic_physmask(cpus_addr(tmp)[0]));	
 }
 
+static struct irq_chip mpic_irq_chip = {
+	.mask	= mpic_mask_irq,
+	.unmask	= mpic_unmask_irq,
+	.end	= mpic_end_irq,
+};
+
+static struct irq_chip mpic_ipi_chip = {
+	.mask	= mpic_mask_ipi,
+	.unmask	= mpic_unmask_ipi,
+	.end	= mpic_end_ipi,
+};
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+static struct irq_chip mpic_irq_ht_chip = {
+	.startup	= mpic_startup_ht_irq,
+	.shutdown	= mpic_shutdown_ht_irq,
+	.mask		= mpic_mask_irq,
+	.unmask		= mpic_unmask_ht_irq,
+	.end		= mpic_end_ht_irq,
+};
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
 
 /*
  * Exported functions
@@ -590,19 +616,19 @@ struct mpic * __init mpic_alloc(unsigned
 	memset(mpic, 0, sizeof(struct mpic));
 	mpic->name = name;
 
+	mpic->hc_irq = mpic_irq_chip;
 	mpic->hc_irq.typename = name;
-	mpic->hc_irq.startup = mpic_startup_irq;
-	mpic->hc_irq.shutdown = mpic_shutdown_irq;
-	mpic->hc_irq.enable = mpic_enable_irq;
-	mpic->hc_irq.disable = mpic_disable_irq;
-	mpic->hc_irq.end = mpic_end_irq;
 	if (flags & MPIC_PRIMARY)
 		mpic->hc_irq.set_affinity = mpic_set_affinity;
+#ifdef CONFIG_MPIC_BROKEN_U3
+	mpic->hc_ht_irq = mpic_irq_ht_chip;
+	mpic->hc_ht_irq.typename = name;
+	if (flags & MPIC_PRIMARY)
+		mpic->hc_ht_irq.set_affinity = mpic_set_affinity;
+#endif /* CONFIG_MPIC_BROKEN_U3 */
 #ifdef CONFIG_SMP
 	mpic->hc_ipi.typename = name;
-	mpic->hc_ipi.enable = mpic_enable_ipi;
-	mpic->hc_ipi.disable = mpic_disable_ipi;
-	mpic->hc_ipi.end = mpic_end_ipi;
+	mpic->hc_ipi = mpic_ipi_chip;
 #endif /* CONFIG_SMP */
 
 	mpic->flags = flags;
@@ -698,28 +724,6 @@ void __init mpic_assign_isu(struct mpic 
 		mpic->num_sources = isu_first + mpic->isu_size;
 }
 
-void __init mpic_setup_cascade(unsigned int irq, mpic_cascade_t handler,
-			       void *data)
-{
-	struct mpic *mpic = mpic_find(irq, NULL);
-	unsigned long flags;
-
-	/* Synchronization here is a bit dodgy, so don't try to replace cascade
-	 * interrupts on the fly too often ... but normally it's set up at boot.
-	 */
-	spin_lock_irqsave(&mpic_lock, flags);
-	if (mpic->cascade)	       
-		mpic_disable_irq(mpic->cascade_vec + mpic->irq_offset);
-	mpic->cascade = NULL;
-	wmb();
-	mpic->cascade_vec = irq - mpic->irq_offset;
-	mpic->cascade_data = data;
-	wmb();
-	mpic->cascade = handler;
-	mpic_enable_irq(irq);
-	spin_unlock_irqrestore(&mpic_lock, flags);
-}
-
 void __init mpic_init(struct mpic *mpic)
 {
 	int i;
@@ -751,8 +755,10 @@ void __init mpic_init(struct mpic *mpic)
 #ifdef CONFIG_SMP
 		if (!(mpic->flags & MPIC_PRIMARY))
 			continue;
-		irq_desc[mpic->ipi_offset+i].status |= IRQ_PER_CPU;
-		irq_desc[mpic->ipi_offset+i].chip = &mpic->hc_ipi;
+		set_irq_chip_data(mpic->ipi_offset+i, mpic);
+		set_irq_chip_and_handler(mpic->ipi_offset+i,
+					 &mpic->hc_ipi,
+					 handle_percpu_irq);
 #endif /* CONFIG_SMP */
 	}
 
@@ -764,7 +770,7 @@ void __init mpic_init(struct mpic *mpic)
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
-		mpic_scan_ht_pics(mpic);
+ 		mpic_scan_ht_pics(mpic);
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
 	for (i = 0; i < mpic->num_sources; i++) {
@@ -812,8 +818,16 @@ void __init mpic_init(struct mpic *mpic)
 
 		/* init linux descriptors */
 		if (i < mpic->irq_count) {
+			struct irq_chip *chip = &mpic->hc_irq;
+
 			irq_desc[mpic->irq_offset+i].status = level ? IRQ_LEVEL : 0;
-			irq_desc[mpic->irq_offset+i].chip = &mpic->hc_irq;
+#ifdef CONFIG_MPIC_BROKEN_U3
+			if (mpic_is_ht_interrupt(mpic, i))
+				chip = &mpic->hc_ht_irq;
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+			set_irq_chip_data(mpic->irq_offset+i, mpic);
+			set_irq_chip_and_handler(mpic->irq_offset+i, chip,
+						 handle_fastack_irq);
 		}
 	}
 	
@@ -967,14 +981,6 @@ int mpic_get_one_irq(struct mpic *mpic, 
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
 #endif
-	if (mpic->cascade && irq == mpic->cascade_vec) {
-#ifdef DEBUG_LOW
-		DBG("%s: cascading ...\n", mpic->name);
-#endif
-		irq = mpic->cascade(regs, mpic->cascade_data);
-		mpic_eoi(mpic);
-		return irq;
-	}
 	if (unlikely(irq == MPIC_VEC_SPURRIOUS))
 		return -1;
 	if (irq < MPIC_VEC_IPI_0) {
Index: linux-work/include/asm-powerpc/mpic.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mpic.h	2006-05-31 15:46:36.000000000 +1000
+++ linux-work/include/asm-powerpc/mpic.h	2006-05-31 15:57:21.000000000 +1000
@@ -110,9 +110,6 @@
 #define MPIC_VEC_TIMER_1	248
 #define MPIC_VEC_TIMER_0	247
 
-/* Type definition of the cascade handler */
-typedef int (*mpic_cascade_t)(struct pt_regs *regs, void *data);
-
 #ifdef CONFIG_MPIC_BROKEN_U3
 /* Fixup table entry */
 struct mpic_irq_fixup
@@ -129,9 +126,12 @@ struct mpic_irq_fixup
 struct mpic
 {
 	/* The "linux" controller struct */
-	hw_irq_controller	hc_irq;
+	struct irq_chip		hc_irq;
+#ifdef CONFIG_MPIC_BROKEN_U3
+	struct irq_chip		hc_ht_irq;
+#endif
 #ifdef CONFIG_SMP
-	hw_irq_controller	hc_ipi;
+	struct irq_chip		hc_ipi;
 #endif
 	const char		*name;
 	/* Flags */
@@ -149,10 +149,6 @@ struct mpic
 	unsigned int		num_sources;
 	/* Number of CPUs */
 	unsigned int		num_cpus;
-	/* cascade handler */
-	mpic_cascade_t		cascade;
-	void			*cascade_data;
-	unsigned int		cascade_vec;
 	/* senses array */
 	unsigned char		*senses;
 	unsigned int		senses_count;
@@ -233,17 +229,6 @@ extern void mpic_assign_isu(struct mpic 
  */
 extern void mpic_init(struct mpic *mpic);
 
-/* Setup a cascade. Currently, only one cascade is supported this
- * way, though you can always do a normal request_irq() and add
- * other cascades this way. You should call this _after_ having
- * added all the ISUs
- *
- * @irq_no:	"linux" irq number of the cascade (that is offset'ed vector)
- * @handler:	cascade handler function
- */
-extern void mpic_setup_cascade(unsigned int irq_no, mpic_cascade_t hanlder,
-			       void *data);
-
 /*
  * All of the following functions must only be used after the
  * ISUs have been assigned and the controller fully initialized
Index: linux-work/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pic.c	2006-05-31 15:46:36.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/pic.c	2006-05-31 16:10:49.000000000 +1000
@@ -503,9 +503,19 @@ static void __init pmac_pic_probe_oldsty
 }
 #endif /* CONFIG_PPC32 */
 
-static int pmac_u3_cascade(struct pt_regs *regs, void *data)
+static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc,
+			    struct pt_regs *regs)
 {
-	return mpic_get_one_irq((struct mpic *)data, regs);
+	struct mpic *mpic = desc->handler_data;
+	unsigned int max = 100;
+
+	while(max--) {
+		int irq = mpic_get_one_irq(mpic, regs);
+		if (irq < 0)
+			break;
+		generic_handle_irq(irq, regs);
+	};
+	desc->chip->end(irq);
 }
 
 static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
@@ -613,7 +623,8 @@ static int __init pmac_pic_probe_mpic(vo
 		of_node_put(slave);
 		return 0;
 	}
-	mpic_setup_cascade(slave->intrs[0].line, pmac_u3_cascade, mpic2);
+	set_irq_data(slave->intrs[0].line, mpic2);
+	set_irq_chained_handler(slave->intrs[0].line, pmac_u3_cascade);
 
 	of_node_put(slave);
 	return 0;


