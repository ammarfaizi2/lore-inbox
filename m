Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281789AbRKVXhS>; Thu, 22 Nov 2001 18:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281791AbRKVXhK>; Thu, 22 Nov 2001 18:37:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20121 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281789AbRKVXgr>;
	Thu, 22 Nov 2001 18:36:47 -0500
Date: Thu, 22 Nov 2001 18:36:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] /proc/interrupts fixes
Message-ID: <Pine.GSO.4.21.0111221823480.853-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch below switches /proc/interrupts to seq_file.  Due to the
ugly (and heavily platform-dependent) layout there's not much of "seq"
here - we simply use the buffering and overflow-prevention provided by
seq_file.

	Patch works on x86 and should work on every architecture where
it manages to build.  Hopefully - all of them.  IOW, I've done the
conversion for all architectures, but there could be typos.  Patch
is very straightforward - see yourself.

	Folks, please check if it compiles (and works).  IMO it's
worth applying; the question being, at which point...  Linus?

diff -urN S15-pre9/arch/alpha/kernel/irq.c S15-pre9-current/arch/alpha/kernel/irq.c
--- S15-pre9/arch/alpha/kernel/irq.c	Sun Sep 23 16:11:55 2001
+++ S15-pre9-current/arch/alpha/kernel/irq.c	Thu Nov 22 13:59:41 2001
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -514,64 +515,63 @@
 }
 
 int
-get_irq_list(char *buf)
+show_interrupts(struct seq_file *p, void *v)
 {
 #ifdef CONFIG_SMP
 	int j;
 #endif
 	int i;
 	struct irqaction * action;
-	char *p = buf;
 
 #ifdef CONFIG_SMP
-	p += sprintf(p, "           ");
+	seq_puts(p, "           ");
 	for (i = 0; i < smp_num_cpus; i++)
-		p += sprintf(p, "CPU%d       ", i);
+		seq_printf(p, "CPU%d       ", i);
 #ifdef DO_BROADCAST_INTS
 	for (i = 0; i < smp_num_cpus; i++)
-		p += sprintf(p, "TRY%d       ", i);
+		seq_printf(p, "TRY%d       ", i);
 #endif
-	*p++ = '\n';
+	seq_putc(p, '\n');
 #endif
 
 	for (i = 0; i < NR_IRQS; i++) {
 		action = irq_desc[i].action;
 		if (!action) 
 			continue;
-		p += sprintf(p, "%3d: ",i);
+		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
-		p += sprintf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (j = 0; j < smp_num_cpus; j++)
-			p += sprintf(p, "%10u ",
+			seq_printf(p, "%10u ",
 				     kstat.irqs[cpu_logical_map(j)][i]);
 #ifdef DO_BROADCAST_INTS
 		for (j = 0; j < smp_num_cpus; j++)
-			p += sprintf(p, "%10lu ",
+			seq_printf(p, "%10lu ",
 				     irq_attempt(cpu_logical_map(j), i));
 #endif
 #endif
-		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
-		p += sprintf(p, "  %c%s",
+		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		seq_printf(p, "  %c%s",
 			     (action->flags & SA_INTERRUPT)?'+':' ',
 			     action->name);
 
 		for (action=action->next; action; action = action->next) {
-			p += sprintf(p, ", %c%s",
+			seq_printf(p, ", %c%s",
 				     (action->flags & SA_INTERRUPT)?'+':' ',
 				     action->name);
 		}
-		*p++ = '\n';
+		seq_putc(p, '\n');
 	}
 #if CONFIG_SMP
-	p += sprintf(p, "IPI: ");
+	seq_puts(p, "IPI: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10lu ",
+		seq_printf(p, "%10lu ",
 			     cpu_data[cpu_logical_map(j)].ipi_count);
-	p += sprintf(p, "\n");
+	seq_putc(p, '\n');
 #endif
-	p += sprintf(p, "ERR: %10lu\n", irq_err_count);
-	return p - buf;
+	seq_printf(p, "ERR: %10lu\n", irq_err_count);
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/arm/kernel/fiq.c S15-pre9-current/arch/arm/kernel/fiq.c
--- S15-pre9/arch/arm/kernel/fiq.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/arm/kernel/fiq.c	Thu Nov 22 14:00:03 2001
@@ -40,6 +40,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/fiq.h>
 #include <asm/io.h>
@@ -92,15 +93,12 @@
 
 static struct fiq_handler *current_fiq = &default_owner;
 
-int get_fiq_list(char *buf)
+int show_fiq_list(struct seq_file *p, void *v)
 {
-	char *p = buf;
-
 	if (current_fiq != &default_owner)
-		p += sprintf(p, "FIQ:              %s\n",
-			     current_fiq->name);
+		seq_printf(p, "FIQ:              %s\n", current_fiq->name);
 
-	return p - buf;
+	return 0;
 }
 
 void set_fiq_handler(void *start, unsigned int length)
diff -urN S15-pre9/arch/arm/kernel/irq.c S15-pre9-current/arch/arm/kernel/irq.c
--- S15-pre9/arch/arm/kernel/irq.c	Sun Jul 29 01:54:41 2001
+++ S15-pre9-current/arch/arm/kernel/irq.c	Thu Nov 22 14:00:17 2001
@@ -28,6 +28,7 @@
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -95,29 +96,28 @@
 	spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	int i;
 	struct irqaction * action;
-	char *p = buf;
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 	    	action = irq_desc[i].action;
 		if (!action)
 			continue;
-		p += sprintf(p, "%3d: %10u ", i, kstat_irqs(i));
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, "%3d: %10u ", i, kstat_irqs(i));
+		seq_printf(p, "  %s", action->name);
 		for (action = action->next; action; action = action->next) {
-			p += sprintf(p, ", %s", action->name);
+			seq_printf(p, ", %s", action->name);
 		}
-		*p++ = '\n';
+		seq_putc(p, '\n');
 	}
 
 #ifdef CONFIG_ARCH_ACORN
-	p += get_fiq_list(p);
+	show_fiq_list(p);
 #endif
-	p += sprintf(p, "Err: %10lu\n", irq_err_count);
-	return p - buf;
+	seq_printf(p, "Err: %10lu\n", irq_err_count);
+	return 0;
 }
 
 /*
diff -urN S15-pre9/arch/cris/kernel/irq.c S15-pre9-current/arch/cris/kernel/irq.c
--- S15-pre9/arch/cris/kernel/irq.c	Sat Aug 11 14:59:20 2001
+++ S15-pre9-current/arch/cris/kernel/irq.c	Thu Nov 22 14:00:28 2001
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -223,27 +224,27 @@
 	NULL, NULL, NULL, NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	struct irqaction * action;
 
 	for (i = 0; i < NR_IRQS; i++) {
 		action = irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %10u %c %s",
+		seq_printf(p, "%2d: %10u %c %s",
 			i, kstat.irqs[0][i],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action = action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, "\n");
+		seq_putc(p, '\n');
 	}
-	return len;
+	return 0;
 }
 
 /* called by the assembler IRQ entry functions defined in irq.h
diff -urN S15-pre9/arch/i386/kernel/irq.c S15-pre9-current/arch/i386/kernel/irq.c
--- S15-pre9/arch/i386/kernel/irq.c	Tue Nov  6 11:36:30 2001
+++ S15-pre9-current/arch/i386/kernel/irq.c	Thu Nov 22 10:40:44 2001
@@ -32,6 +32,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -131,57 +132,53 @@
  * Generic, controller-independent functions:
  */
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
 	struct irqaction * action;
-	char *p = buf;
 
-	p += sprintf(p, "           ");
+	seq_printf(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
-	*p++ = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		action = irq_desc[i].action;
 		if (!action) 
 			continue;
-		p += sprintf(p, "%3d: ",i);
+		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
-		p += sprintf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (j = 0; j < smp_num_cpus; j++)
-			p += sprintf(p, "%10u ",
+			seq_printf(p, "%10u ",
 				kstat.irqs[cpu_logical_map(j)][i]);
 #endif
-		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-			p += sprintf(p, ", %s", action->name);
-		*p++ = '\n';
+			seq_printf(p, ", %s", action->name);
+		seq_putc(p, '\n');
 	}
-	p += sprintf(p, "NMI: ");
+	seq_printf(p, "NMI: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
-			nmi_count(cpu_logical_map(j)));
-	p += sprintf(p, "\n");
+		seq_printf(p, "%10u ", nmi_count(cpu_logical_map(j)));
+	seq_putc(p, '\n');
 #if CONFIG_X86_LOCAL_APIC
-	p += sprintf(p, "LOC: ");
+	seq_printf(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
-			apic_timer_irqs[cpu_logical_map(j)]);
-	p += sprintf(p, "\n");
+		seq_printf(p, "%10u ", apic_timer_irqs[cpu_logical_map(j)]);
+	seq_putc(p, '\n');
 #endif
-	p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-	p += sprintf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
 #endif
-	return p - buf;
+	return 0;
 }
-
 
 /*
  * Global interrupt locks for SMP. Allow interrupts to come in on any
diff -urN S15-pre9/arch/ia64/kernel/irq.c S15-pre9-current/arch/ia64/kernel/irq.c
--- S15-pre9/arch/ia64/kernel/irq.c	Thu Nov 22 03:56:13 2001
+++ S15-pre9-current/arch/ia64/kernel/irq.c	Thu Nov 22 14:00:50 2001
@@ -32,6 +32,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -131,55 +132,54 @@
  * Generic, controller-independent functions:
  */
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
 	struct irqaction * action;
 	irq_desc_t *idesc;
-	char *p = buf;
 
-	p += sprintf(p, "           ");
+	seq_puts(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
-	*p++ = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		idesc = irq_desc(i);
 		action = idesc->action;
 		if (!action)
 			continue;
-		p += sprintf(p, "%3d: ",i);
+		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
-		p += sprintf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (j = 0; j < smp_num_cpus; j++)
-			p += sprintf(p, "%10u ",
+			seq_printf(p, "%10u ",
 				kstat.irqs[cpu_logical_map(j)][i]);
 #endif
-		p += sprintf(p, " %14s", idesc->handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, " %14s", idesc->handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-			p += sprintf(p, ", %s", action->name);
-		*p++ = '\n';
+			seq_printf(p, ", %s", action->name);
+		seq_putc('\n');
 	}
-	p += sprintf(p, "NMI: ");
+	seq_puts(p, "NMI: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
+		seq_printf(p, "%10u ",
 			nmi_count(cpu_logical_map(j)));
-	p += sprintf(p, "\n");
+	seq_putc(p, '\n');
 #if defined(CONFIG_SMP) && defined(CONFIG_X86)
-	p += sprintf(p, "LOC: ");
+	seq_puts(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
+		seq_printf(p, "%10u ",
 			apic_timer_irqs[cpu_logical_map(j)]);
-	p += sprintf(p, "\n");
+	seq_putc(p, '\n');
 #endif
-	p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 #if defined(CONFIG_X86) && defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
-	p += sprintf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
-	return p - buf;
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/m68k/amiga/amiints.c S15-pre9-current/arch/m68k/amiga/amiints.c
--- S15-pre9/arch/m68k/amiga/amiints.c	Fri Feb 16 20:28:32 2001
+++ S15-pre9-current/arch/m68k/amiga/amiints.c	Thu Nov 22 14:11:00 2001
@@ -40,6 +40,7 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -53,7 +54,7 @@
                            unsigned long flags, const char *devname, void *dev_id);
 extern void cia_free_irq(struct ciabase *base, unsigned int irq, void *dev_id);
 extern void cia_init_IRQ(struct ciabase *base);
-extern int cia_get_irq_list(struct ciabase *base, char *buf);
+extern int cia_get_irq_list(struct ciabase *base, struct seq_file *p);
 
 /* irq node variables for amiga interrupt sources */
 static irq_node_t *ami_irq_list[AMI_STD_IRQS];
@@ -468,28 +469,28 @@
 	ami_int4, ami_int5, ami_badint, ami_int7
 };
 
-int amiga_get_irq_list(char *buf)
+int show_amiga_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	irq_node_t *node;
 
 	for (i = 0; i < AMI_STD_IRQS; i++) {
 		if (!(node = ami_irq_list[i]))
 			continue;
-		len += sprintf(buf+len, "ami  %2d: %10u ", i,
+		seq_printf(p, "ami  %2d: %10u ", i,
 		               kstat.irqs[0][SYS_IRQS + i]);
 		do {
 			if (node->flags & SA_INTERRUPT)
-				len += sprintf(buf+len, "F ");
+				seq_puts(p, "F ");
 			else
-				len += sprintf(buf+len, "  ");
-			len += sprintf(buf+len, "%s\n", node->devname);
+				seq_puts(p, "  ");
+			seq_printf(p, "%s\n", node->devname);
 			if ((node = node->next))
-				len += sprintf(buf+len, "                    ");
+				seq_puts(p, "                    ");
 		} while (node);
 	}
 
-	len += cia_get_irq_list(&ciaa_base, buf+len);
-	len += cia_get_irq_list(&ciab_base, buf+len);
-	return len;
+	cia_get_irq_list(&ciaa_base, p);
+	cia_get_irq_list(&ciab_base, p);
+	return 0;
 }
diff -urN S15-pre9/arch/m68k/amiga/cia.c S15-pre9-current/arch/m68k/amiga/cia.c
--- S15-pre9/arch/m68k/amiga/cia.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/amiga/cia.c	Thu Nov 22 14:11:09 2001
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/irq.h>
 #include <asm/amigahw.h>
@@ -158,16 +159,16 @@
 	custom.intena = IF_SETCLR | base->int_mask;
 }
 
-int cia_get_irq_list(struct ciabase *base, char *buf)
+int cia_get_irq_list(struct ciabase *base, struct seq_file *p)
 {
-	int i, j, len = 0;
+	int i, j;
 
 	j = base->cia_irq;
 	for (i = 0; i < CIA_IRQS; i++) {
-		len += sprintf(buf+len, "cia  %2d: %10d ", j + i,
+		seq_printf(p, "cia  %2d: %10d ", j + i,
 			       kstat.irqs[0][SYS_IRQS + j + i]);
-			len += sprintf(buf+len, "  ");
-		len += sprintf(buf+len, "%s\n", base->irq_list[i].devname);
+		seq_puts(p, "  ");
+		seq_printf(p, "%s\n", base->irq_list[i].devname);
 	}
-	return len;
+	return 0;
 }
diff -urN S15-pre9/arch/m68k/amiga/config.c S15-pre9-current/arch/m68k/amiga/config.c
--- S15-pre9/arch/m68k/amiga/config.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/m68k/amiga/config.c	Thu Nov 22 11:39:29 2001
@@ -86,7 +86,7 @@
 extern void amiga_disable_irq (unsigned int);
 static void amiga_get_model(char *model);
 static int amiga_get_hardware_list(char *buffer);
-extern int amiga_get_irq_list (char *);
+extern int show_amiga_interrupts (struct seq_file *, void *);
 /* amiga specific timer functions */
 static unsigned long amiga_gettimeoffset (void);
 static void a3000_gettod (int *, int *, int *, int *, int *, int *);
@@ -403,7 +403,7 @@
   disable_irq          = amiga_disable_irq;
   mach_get_model       = amiga_get_model;
   mach_get_hardware_list = amiga_get_hardware_list;
-  mach_get_irq_list    = amiga_get_irq_list;
+  mach_get_irq_list    = show_amiga_interrupts;
   mach_gettimeoffset   = amiga_gettimeoffset;
   if (AMIGAHW_PRESENT(A3000_CLK)){
     mach_gettod  = a3000_gettod;
diff -urN S15-pre9/arch/m68k/apollo/config.c S15-pre9-current/arch/m68k/apollo/config.c
--- S15-pre9/arch/m68k/apollo/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/apollo/config.c	Thu Nov 22 12:26:43 2001
@@ -31,7 +31,7 @@
 extern void dn_free_irq(unsigned int irq, void *dev_id);
 extern void dn_enable_irq(unsigned int);
 extern void dn_disable_irq(unsigned int);
-extern int dn_get_irq_list(char *);
+extern int show_dn_interrupts(struct seq_file *, void *);
 extern unsigned long dn_gettimeoffset(void);
 extern void dn_gettod(int *, int *, int *, int *, int *, int *);
 extern int dn_dummy_hwclk(int, struct hwclk_time *);
@@ -173,7 +173,7 @@
 	mach_free_irq        = dn_free_irq;
 	enable_irq      = dn_enable_irq;
 	disable_irq     = dn_disable_irq;
-	mach_get_irq_list    = dn_get_irq_list;
+	mach_get_irq_list    = show_dn_interrupts;
 	mach_gettimeoffset   = dn_gettimeoffset;
 	mach_gettod	     = dn_gettod; /* */
 	mach_max_dma_address = 0xffffffff;
diff -urN S15-pre9/arch/m68k/apollo/dn_ints.c S15-pre9-current/arch/m68k/apollo/dn_ints.c
--- S15-pre9/arch/m68k/apollo/dn_ints.c	Tue Mar 13 00:34:06 2001
+++ S15-pre9-current/arch/m68k/apollo/dn_ints.c	Thu Nov 22 12:27:07 2001
@@ -104,7 +104,7 @@
 
 }
 
-int dn_get_irq_list(char *buf) {
+int show_dn_interrupts(struct seq_file *p, void *v) {
 
   printk("dn get irq list\n");
 
diff -urN S15-pre9/arch/m68k/atari/ataints.c S15-pre9-current/arch/m68k/atari/ataints.c
--- S15-pre9/arch/m68k/atari/ataints.c	Fri Feb 16 16:48:09 2001
+++ S15-pre9-current/arch/m68k/atari/ataints.c	Thu Nov 22 14:11:21 2001
@@ -40,6 +40,7 @@
 #include <linux/ptrace.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/traps.h>
@@ -609,37 +610,37 @@
 }
 
 
-int atari_get_irq_list(char *buf)
+int show_atari_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 
 	for (i = 0; i < NUM_INT_SOURCES; ++i) {
 		if (vectors[IRQ_SOURCE_TO_VECTOR(i)] == bad_interrupt)
 			continue;
 		if (i < STMFP_SOURCE_BASE)
-			len += sprintf(buf+len, "auto %2d: %10u ",
+			seq_printf(p,, "auto %2d: %10u ",
 				       i, kstat.irqs[0][i]);
 		else
-			len += sprintf(buf+len, "vec $%02x: %10u ",
+			seq_printf(p,, "vec $%02x: %10u ",
 				       IRQ_SOURCE_TO_VECTOR(i),
 				       kstat.irqs[0][i]);
 
 		if (irq_handler[i].handler != atari_call_irq_list) {
-			len += sprintf(buf+len, "%s\n", irq_param[i].devname);
+			seq_printf(p,, "%s\n", irq_param[i].devname);
 		}
 		else {
 			irq_node_t *p;
 			for( p = (irq_node_t *)irq_handler[i].dev_id; p; p = p->next ) {
-				len += sprintf(buf+len, "%s\n", p->devname);
+				seq_printf(p,, "%s\n", p->devname);
 				if (p->next)
-					len += sprintf( buf+len, "                    " );
+					seq_puts(p,, "                    " );
 			}
 		}
 	}
 	if (num_spurious)
-		len += sprintf(buf+len, "spurio.: %10u\n", num_spurious);
+		seq_printf(p, "spurio.: %10u\n", num_spurious);
 	
-	return len;
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/m68k/atari/config.c S15-pre9-current/arch/m68k/atari/config.c
--- S15-pre9/arch/m68k/atari/config.c	Fri Feb 16 20:28:32 2001
+++ S15-pre9-current/arch/m68k/atari/config.c	Thu Nov 22 12:15:26 2001
@@ -70,7 +70,7 @@
 extern void atari_free_irq (unsigned int irq, void *dev_id);
 extern void atari_enable_irq (unsigned int);
 extern void atari_disable_irq (unsigned int);
-extern int atari_get_irq_list (char *buf);
+extern int show_atari_interrupts (struct seq_file *, void *);
 extern void atari_mksound( unsigned int count, unsigned int ticks );
 #ifdef CONFIG_HEARTBEAT
 static void atari_heartbeat( int on );
@@ -265,7 +265,7 @@
     disable_irq          = atari_disable_irq;
     mach_get_model	 = atari_get_model;
     mach_get_hardware_list = atari_get_hardware_list;
-    mach_get_irq_list	 = atari_get_irq_list;
+    mach_get_irq_list	 = show_atari_interrupts;
     mach_gettimeoffset   = atari_gettimeoffset;
     mach_reset           = atari_reset;
 #ifdef CONFIG_ATARI_FLOPPY
diff -urN S15-pre9/arch/m68k/bvme6000/bvmeints.c S15-pre9-current/arch/m68k/bvme6000/bvmeints.c
--- S15-pre9/arch/m68k/bvme6000/bvmeints.c	Thu Feb 15 23:15:53 2001
+++ S15-pre9-current/arch/m68k/bvme6000/bvmeints.c	Thu Nov 22 14:11:32 2001
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/seq_file.h>
 
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -127,17 +128,17 @@
 	}
 }
 
-int bvme6000_get_irq_list (char *buf)
+int show_bvme6000_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 
 	for (i = 0; i < 256; i++) {
 		if (irq_tab[i].count)
-			len += sprintf (buf+len, "Vec 0x%02x: %8d  %s\n",
+			seq_printf(p, "Vec 0x%02x: %8d  %s\n",
 			    i, irq_tab[i].count,
 			    irq_tab[i].devname ? irq_tab[i].devname : "free");
 	}
-	return len;
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/m68k/bvme6000/config.c S15-pre9-current/arch/m68k/bvme6000/config.c
--- S15-pre9/arch/m68k/bvme6000/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/bvme6000/config.c	Thu Nov 22 12:14:02 2001
@@ -36,7 +36,7 @@
 extern void bvme6000_process_int (int level, struct pt_regs *regs);
 extern void bvme6000_init_IRQ (void);
 extern void bvme6000_free_irq (unsigned int, void *);
-extern int  bvme6000_get_irq_list (char *);
+extern int  show_bvme6000_interrupts(struct seq_file *, void *);
 extern void bvme6000_enable_irq (unsigned int);
 extern void bvme6000_disable_irq (unsigned int);
 static void bvme6000_get_model(char *model);
@@ -145,7 +145,7 @@
     mach_reset		 = bvme6000_reset;
     mach_free_irq	 = bvme6000_free_irq;
     mach_process_int	 = bvme6000_process_int;
-    mach_get_irq_list	 = bvme6000_get_irq_list;
+    mach_get_irq_list	 = show_bvme6000_interrupts;
     mach_request_irq	 = bvme6000_request_irq;
     enable_irq		 = bvme6000_enable_irq;
     disable_irq          = bvme6000_disable_irq;
diff -urN S15-pre9/arch/m68k/hp300/config.c S15-pre9-current/arch/m68k/hp300/config.c
--- S15-pre9/arch/m68k/hp300/config.c	Fri Feb 16 01:52:42 2001
+++ S15-pre9-current/arch/m68k/hp300/config.c	Thu Nov 22 12:10:50 2001
@@ -25,7 +25,7 @@
 
 extern void hp300_reset(void);
 extern void (*hp300_default_handler[])(int, void *, struct pt_regs *);
-extern int hp300_get_irq_list(char *buf);
+extern int show_hp300_interrupts(struct seq_file *, void *);
 
 #ifdef CONFIG_VT
 extern int hp300_keyb_init(void);
@@ -70,7 +70,7 @@
   mach_request_irq     = hp300_request_irq;
   mach_free_irq        = hp300_free_irq;
   mach_get_model       = hp300_get_model;
-  mach_get_irq_list    = hp300_get_irq_list;
+  mach_get_irq_list    = show_hp300_interrupts;
   mach_gettimeoffset   = hp300_gettimeoffset;
   mach_default_handler = &hp300_default_handler;
 #if 0
diff -urN S15-pre9/arch/m68k/hp300/ints.c S15-pre9-current/arch/m68k/hp300/ints.c
--- S15-pre9/arch/m68k/hp300/ints.c	Fri Feb 16 02:01:57 2001
+++ S15-pre9-current/arch/m68k/hp300/ints.c	Thu Nov 22 12:10:06 2001
@@ -148,7 +148,7 @@
 	spin_unlock_irqrestore(&irqlist_lock, flags);
 }
 
-int hp300_get_irq_list(char *buf)
+int show_hp300_interrupts(struct seq_file *p, void *v)
 {
 	return 0;
 }
diff -urN S15-pre9/arch/m68k/kernel/ints.c S15-pre9-current/arch/m68k/kernel/ints.c
--- S15-pre9/arch/m68k/kernel/ints.c	Tue Mar 13 00:34:10 2001
+++ S15-pre9-current/arch/m68k/kernel/ints.c	Thu Nov 22 11:35:35 2001
@@ -242,22 +242,22 @@
 	}
 }
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 
 	/* autovector interrupts */
 	if (mach_default_handler) {
 		for (i = 0; i < SYS_IRQS; i++) {
-			len += sprintf(buf+len, "auto %2d: %10u ", i,
+			seq_printf(p, "auto %2d: %10u ", i,
 			               i ? kstat.irqs[0][i] : num_spurious);
-				len += sprintf(buf+len, "  ");
-			len += sprintf(buf+len, "%s\n", irq_list[i].devname);
+			seq_puts(p, "  ");
+			seq_printf(p, "%s\n", irq_list[i].devname);
 		}
 	}
 
-	len += mach_get_irq_list(buf+len);
-	return len;
+	mach_get_irq_list(p, v);
+	return 0;
 }
 
 void init_irq_proc(void)
diff -urN S15-pre9/arch/m68k/kernel/setup.c S15-pre9-current/arch/m68k/kernel/setup.c
--- S15-pre9/arch/m68k/kernel/setup.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/kernel/setup.c	Thu Nov 22 11:39:53 2001
@@ -80,7 +80,7 @@
 void (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
 void (*mach_get_model) (char *model) = NULL;
 int (*mach_get_hardware_list) (char *buffer) = NULL;
-int (*mach_get_irq_list) (char *) = NULL;
+int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
 void (*mach_process_int) (int, struct pt_regs *) = NULL;
 /* machine dependent timer functions */
 unsigned long (*mach_gettimeoffset) (void);
diff -urN S15-pre9/arch/m68k/mac/config.c S15-pre9-current/arch/m68k/mac/config.c
--- S15-pre9/arch/m68k/mac/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/mac/config.c	Thu Nov 22 11:56:12 2001
@@ -66,7 +66,7 @@
 extern unsigned long mac_gettimeoffset (void);
 extern int mac_hwclk (int, struct hwclk_time *);
 extern int mac_set_clock_mmss (unsigned long);
-extern int mac_get_irq_list(char *);
+extern int show_mac_interrupts(struct seq_file *, void *);
 extern void iop_preinit(void);
 extern void iop_init(void);
 extern void via_init(void);
@@ -241,7 +241,7 @@
 	disable_irq          = mac_disable_irq;
 	mach_get_model	 = mac_get_model;
 	mach_default_handler = &mac_handlers;
-	mach_get_irq_list    = mac_get_irq_list;
+	mach_get_irq_list    = show_mac_interrupts;
 	mach_gettimeoffset   = mac_gettimeoffset;
 	mach_gettod          = mac_gettod;
 	mach_hwclk           = mac_hwclk;
diff -urN S15-pre9/arch/m68k/mac/macints.c S15-pre9-current/arch/m68k/mac/macints.c
--- S15-pre9/arch/m68k/mac/macints.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/mac/macints.c	Thu Nov 22 14:11:45 2001
@@ -120,6 +120,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h> /* for intr_count */
 #include <linux/delay.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -576,9 +577,9 @@
  *		  displayed for us as autovector irq 0.
  */
 
-int mac_get_irq_list (char *buf)
+int show_mac_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	irq_node_t *node;
 	char *base;
 
@@ -618,25 +619,24 @@
 			case 8: base = "bbn";
 				break;
 		}
-		len += sprintf(buf+len, "%4s %2d: %10u ",
-				base, i, kstat.irqs[0][i]);
+		seq_printf(p, "%4s %2d: %10u ", base, i, kstat.irqs[0][i]);
 
 		do {
 			if (node->flags & IRQ_FLG_FAST) {
-				len += sprintf(buf+len, "F ");
+				seq_puts(p, "F ");
 			} else if (node->flags & IRQ_FLG_SLOW) {
-				len += sprintf(buf+len, "S ");
+				seq_puts(p, "S ");
 			} else {
-				len += sprintf(buf+len, "  ");
+				seq_puts(p, "  ");
 			}
-			len += sprintf(buf+len, "%s\n", node->devname);
+			seq_printf(p, "%s\n", node->devname);
 			if ((node = node->next)) {
-				len += sprintf(buf+len, "                    ");
+				seq_puts(p, "                    ");
 			}
 		} while(node);
 
 	}
-	return len;
+	return 0;
 }
 
 void mac_default_handler(int irq, void *dev_id, struct pt_regs *regs)
diff -urN S15-pre9/arch/m68k/mvme147/147ints.c S15-pre9-current/arch/m68k/mvme147/147ints.c
--- S15-pre9/arch/m68k/mvme147/147ints.c	Thu Feb 15 23:15:54 2001
+++ S15-pre9-current/arch/m68k/mvme147/147ints.c	Thu Nov 22 14:11:53 2001
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/seq_file.h>
 
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -112,17 +113,17 @@
 	}
 }
 
-int mvme147_get_irq_list (char *buf)
+int show_mvme147_interrupts (struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 
 	for (i = 0; i < 256; i++) {
 		if (irq_tab[i].count)
-			len += sprintf (buf+len, "Vec 0x%02x: %8d  %s\n",
+			seq_printf(p, "Vec 0x%02x: %8d  %s\n",
 			    i, irq_tab[i].count,
 			    irq_tab[i].devname ? irq_tab[i].devname : "free");
 	}
-	return len;
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/m68k/mvme147/config.c S15-pre9-current/arch/m68k/mvme147/config.c
--- S15-pre9/arch/m68k/mvme147/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/mvme147/config.c	Thu Nov 22 11:51:51 2001
@@ -36,7 +36,7 @@
 extern void mvme147_process_int (int level, struct pt_regs *regs);
 extern void mvme147_init_IRQ (void);
 extern void mvme147_free_irq (unsigned int, void *);
-extern int  mvme147_get_irq_list (char *);
+extern int  show_mvme147_interrupts (struct seq_file *, void *);
 extern void mvme147_enable_irq (unsigned int);
 extern void mvme147_disable_irq (unsigned int);
 static void mvme147_get_model(char *model);
@@ -113,7 +113,7 @@
 	mach_reset		= mvme147_reset;
 	mach_free_irq		= mvme147_free_irq;
 	mach_process_int	= mvme147_process_int;
-	mach_get_irq_list	= mvme147_get_irq_list;
+	mach_get_irq_list	= show_mvme147_interrupts;
 	mach_request_irq	= mvme147_request_irq;
 	enable_irq		= mvme147_enable_irq;
 	disable_irq		= mvme147_disable_irq;
diff -urN S15-pre9/arch/m68k/mvme16x/16xints.c S15-pre9-current/arch/m68k/mvme16x/16xints.c
--- S15-pre9/arch/m68k/mvme16x/16xints.c	Thu Feb 15 23:15:54 2001
+++ S15-pre9-current/arch/m68k/mvme16x/16xints.c	Thu Nov 22 14:12:01 2001
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/ptrace.h>
@@ -114,17 +115,17 @@
 	}
 }
 
-int mvme16x_get_irq_list (char *buf)
+int show_mvme16x_interrupts (struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 
 	for (i = 0; i < 192; i++) {
 		if (irq_tab[i].count)
-			len += sprintf (buf+len, "Vec 0x%02x: %8d  %s\n",
+			seq_printf(p, "Vec 0x%02x: %8d  %s\n",
 			    i+64, irq_tab[i].count,
 			    irq_tab[i].devname ? irq_tab[i].devname : "free");
 	}
-	return len;
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/m68k/mvme16x/config.c S15-pre9-current/arch/m68k/mvme16x/config.c
--- S15-pre9/arch/m68k/mvme16x/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/mvme16x/config.c	Thu Nov 22 11:47:34 2001
@@ -40,7 +40,7 @@
 extern void mvme16x_process_int (int level, struct pt_regs *regs);
 extern void mvme16x_init_IRQ (void);
 extern void mvme16x_free_irq (unsigned int, void *);
-extern int  mvme16x_get_irq_list (char *);
+extern int show_mvme16x_interrupts (struct seq_file *, void *);
 extern void mvme16x_enable_irq (unsigned int);
 extern void mvme16x_disable_irq (unsigned int);
 static void mvme16x_get_model(char *model);
@@ -156,7 +156,7 @@
     mach_reset		 = mvme16x_reset;
     mach_free_irq	 = mvme16x_free_irq;
     mach_process_int	 = mvme16x_process_int;
-    mach_get_irq_list	 = mvme16x_get_irq_list;
+    mach_get_irq_list	 = show_mvme16x_interrupts;
     mach_request_irq	 = mvme16x_request_irq;
     enable_irq           = mvme16x_enable_irq;
     disable_irq          = mvme16x_disable_irq;
diff -urN S15-pre9/arch/m68k/q40/config.c S15-pre9-current/arch/m68k/q40/config.c
--- S15-pre9/arch/m68k/q40/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/q40/config.c	Thu Nov 22 11:44:57 2001
@@ -45,7 +45,7 @@
 extern void (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
 extern void q40_init_IRQ (void);
 extern void q40_free_irq (unsigned int, void *);
-extern int  q40_get_irq_list (char *);
+extern int  show_q40_interrupts (struct seq_file *, void *);
 extern void q40_enable_irq (unsigned int);
 extern void q40_disable_irq (unsigned int);
 static void q40_get_model(char *model);
@@ -236,7 +236,7 @@
     mach_reset		 = q40_reset;
     mach_free_irq	 = q40_free_irq; 
     mach_process_int	 = q40_process_int;
-    mach_get_irq_list	 = q40_get_irq_list;
+    mach_get_irq_list	 = show_q40_interrupts;
     mach_request_irq	 = q40_request_irq;
     enable_irq		 = q40_enable_irq;
     disable_irq          = q40_disable_irq;
diff -urN S15-pre9/arch/m68k/q40/q40ints.c S15-pre9-current/arch/m68k/q40/q40ints.c
--- S15-pre9/arch/m68k/q40/q40ints.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/q40/q40ints.c	Thu Nov 22 14:12:09 2001
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 
 #include <asm/rtc.h>
 #include <asm/ptrace.h>
@@ -431,21 +432,20 @@
 	  }
 }
 
-int q40_get_irq_list (char *buf)
+int show_q40_interrupts (struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 
-	for (i = 0; i <= Q40_IRQ_MAX; i++) 
-	  {
+	for (i = 0; i <= Q40_IRQ_MAX; i++) {
 		if (irq_tab[i].count)
-	      len += sprintf (buf+len, "%sIRQ %02d: %8d  %s%s\n",
+		      seq_printf(p, "%sIRQ %02d: %8d  %s%s\n",
 			      (i<=15) ? "ISA-" : "    " ,		
 			    i, irq_tab[i].count,
 			    irq_tab[i].devname[0] ? irq_tab[i].devname : "?",
 			    irq_tab[i].handler == q40_defhand ? 
 					" (now unassigned)" : "");
 	}
-	return len;
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/m68k/sun3/config.c S15-pre9-current/arch/m68k/sun3/config.c
--- S15-pre9/arch/m68k/sun3/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/sun3/config.c	Thu Nov 22 11:41:29 2001
@@ -36,7 +36,7 @@
 char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
 
 extern unsigned long sun3_gettimeoffset(void);
-extern int sun3_get_irq_list (char *);
+extern int show_sun3_interrupts (char *);
 extern void sun3_sched_init(void (*handler)(int, void *, struct pt_regs *));
 extern void sun3_get_model (char* model);
 extern void idprom_init (void);
@@ -145,7 +145,7 @@
 	enable_irq     	     =  sun3_enable_irq;
         disable_irq  	     =  sun3_disable_irq;
 	mach_process_int     =  sun3_process_int;
-        mach_get_irq_list    =  sun3_get_irq_list;
+        mach_get_irq_list    =  show_sun3_interrupts;
         mach_gettod          =  sun3_gettod;	
         mach_reset           =  sun3_reboot;
 	mach_gettimeoffset   =  sun3_gettimeoffset;
diff -urN S15-pre9/arch/m68k/sun3/sun3ints.c S15-pre9-current/arch/m68k/sun3/sun3ints.c
--- S15-pre9/arch/m68k/sun3/sun3ints.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/sun3/sun3ints.c	Thu Nov 22 14:12:17 2001
@@ -15,6 +15,7 @@
 #include <asm/intersil.h>
 #include <asm/oplib.h>
 #include <asm/sun3ints.h>
+#include <linux/seq_file.h>
 
 extern void sun3_leds (unsigned char);
 
@@ -62,7 +63,7 @@
 	*sun3_intreg |=  (1<<irq);
 }
 
-int sun3_get_irq_list(char *buf)
+int show_sun3_interrupts(struct seq_file *p, void *v)
 {
 	return 0;
 }
diff -urN S15-pre9/arch/m68k/sun3x/config.c S15-pre9-current/arch/m68k/sun3x/config.c
--- S15-pre9/arch/m68k/sun3x/config.c	Tue Jul  3 21:09:05 2001
+++ S15-pre9-current/arch/m68k/sun3x/config.c	Thu Nov 22 11:41:37 2001
@@ -58,7 +58,7 @@
 
 	sun3x_prom_init();
 
-	mach_get_irq_list	 = sun3_get_irq_list;
+	mach_get_irq_list	 = show_sun3_interrupts;
 	mach_max_dma_address = 0xffffffff; /* we can DMA anywhere, whee */
 
 	mach_keyb_init       = sun3x_keyb_init;
diff -urN S15-pre9/arch/mips/baget/irq.c S15-pre9-current/arch/mips/baget/irq.c
--- S15-pre9/arch/mips/baget/irq.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips/baget/irq.c	Thu Nov 22 14:12:37 2001
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/delay.h>
+#include <linux/seq_file.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -141,27 +142,27 @@
  */
 static struct irqaction *irq_action[BAGET_IRQ_NR] = { NULL, };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	struct irqaction * action;
 
 	for (i = 0 ; i < BAGET_IRQ_NR ; i++) {
 		action = irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			i, kstat.irqs[0][i],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, "\n");
+		seq_putc(p, '\n');
 	}
-	return len;
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/mips/dec/irq.c S15-pre9-current/arch/mips/dec/irq.c
--- S15-pre9/arch/mips/dec/irq.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips/dec/irq.c	Thu Nov 22 14:12:46 2001
@@ -15,6 +15,7 @@
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/seq_file.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -92,27 +93,27 @@
     NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-    int i, len = 0;
-    struct irqaction *action;
+	int i;
+	struct irqaction *action;
 
-    for (i = 0; i < 32; i++) {
-	action = irq_action[i];
-	if (!action)
-	    continue;
-	len += sprintf(buf + len, "%2d: %8d %c %s",
-		       i, kstat.irqs[0][i],
-		       (action->flags & SA_INTERRUPT) ? '+' : ' ',
-		       action->name);
-	for (action = action->next; action; action = action->next) {
-	    len += sprintf(buf + len, ",%s %s",
-			   (action->flags & SA_INTERRUPT) ? " +" : "",
-			   action->name);
+	for (i = 0; i < 32; i++) {
+		action = irq_action[i];
+		if (!action)
+			continue;
+		seq_printf(p, "%2d: %8d %c %s",
+				i, kstat.irqs[0][i],
+				(action->flags & SA_INTERRUPT) ? '+' : ' ',
+				action->name);
+		for (action = action->next; action; action = action->next) {
+			seq_printf(p, ",%s %s",
+				(action->flags & SA_INTERRUPT) ? " +" : "",
+				action->name);
+		}
+		seq_putc(p, '\n');
 	}
-	len += sprintf(buf + len, "\n");
-    }
-    return len;
+	return 0;
 }
 
 /*
diff -urN S15-pre9/arch/mips/ite-boards/generic/irq.c S15-pre9-current/arch/mips/ite-boards/generic/irq.c
--- S15-pre9/arch/mips/ite-boards/generic/irq.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips/ite-boards/generic/irq.c	Thu Nov 22 14:12:53 2001
@@ -46,6 +46,7 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/serial_reg.h>
+#include <linux/seq_file.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -217,34 +218,34 @@
 };
 
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-        int i, len = 0, j;
+        int i, j;
         struct irqaction * action;
 
-        len += sprintf(buf+len, "           ");
+        seq_printf(p, "           ");
         for (j=0; j<smp_num_cpus; j++)
-                len += sprintf(buf+len, "CPU%d       ",j);
-        *(char *)(buf+len++) = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p, '\n');
 
         for (i = 0 ; i < NR_IRQS ; i++) {
                 action = irq_desc[i].action;
                 if ( !action || !action->handler )
                         continue;
-                len += sprintf(buf+len, "%3d: ", i);		
-                len += sprintf(buf+len, "%10u ", kstat_irqs(i));
+                seq_printf(p, "%3d: ", i);		
+                seq_printf(p, "%10u ", kstat_irqs(i));
                 if ( irq_desc[i].handler )		
-                        len += sprintf(buf+len, " %s ", irq_desc[i].handler->typename );
+                        seq_printf(p, " %s ", irq_desc[i].handler->typename );
                 else
-                        len += sprintf(buf+len, "  None      ");
-                len += sprintf(buf+len, "    %s",action->name);
+                        seq_puts(p, "  None      ");
+                seq_printf(p, "    %s",action->name);
                 for (action=action->next; action; action = action->next) {
-                        len += sprintf(buf+len, ", %s", action->name);
+                        seq_printf(p, ", %s", action->name);
                 }
-                len += sprintf(buf+len, "\n");
+                seq_putc(p, '\n');
         }
-        len += sprintf(buf+len, "BAD: %10lu\n", spurious_count);
-        return len;
+        seq_printf(p, "BAD: %10lu\n", spurious_count);
+        return 0;
 }
 
 asmlinkage void do_IRQ(int irq, struct pt_regs *regs)
diff -urN S15-pre9/arch/mips/kernel/irq.c S15-pre9-current/arch/mips/kernel/irq.c
--- S15-pre9/arch/mips/kernel/irq.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips/kernel/irq.c	Thu Nov 22 14:13:20 2001
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 
@@ -69,32 +70,31 @@
  * Generic, controller-independent functions:
  */
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	struct irqaction * action;
-	char *p = buf;
 	int i;
 
-	p += sprintf(p, "           ");
+	seq_puts(p, "           ");
 	for (i=0; i < 1 /*smp_num_cpus*/; i++)
-		p += sprintf(p, "CPU%d       ", i);
-	*p++ = '\n';
+		seq_printf(p, "CPU%d       ", i);
+	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		action = irq_desc[i].action;
 		if (!action) 
 			continue;
-		p += sprintf(p, "%3d: ",i);
-		p += sprintf(p, "%10u ", kstat_irqs(i));
-		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, "%3d: ",i);
+		seq_printf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-			p += sprintf(p, ", %s", action->name);
-		*p++ = '\n';
+			seq_printf(p, ", %s", action->name);
+		seq_putc(p, '\n');
 	}
-	p += sprintf(p, "ERR: %10lu\n", irq_err_count);
-	return p - buf;
+	seq_printf(p, "ERR: %10lu\n", irq_err_count);
+	return 0;
 }
 
 /*
diff -urN S15-pre9/arch/mips/kernel/old-irq.c S15-pre9-current/arch/mips/kernel/old-irq.c
--- S15-pre9/arch/mips/kernel/old-irq.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips/kernel/old-irq.c	Thu Nov 22 14:13:26 2001
@@ -24,6 +24,7 @@
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/seq_file.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -123,27 +124,27 @@
 	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	struct irqaction * action;
 
 	for (i = 0 ; i < 32 ; i++) {
 		action = irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			i, kstat.irqs[0][i],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, "\n");
+		seq_putc(p, '\n');
 	}
-	return len;
+	return 0;
 }
 
 static inline void i8259_mask_and_ack_irq(int irq)
diff -urN S15-pre9/arch/mips/mips-boards/atlas/atlas_int.c S15-pre9-current/arch/mips/mips-boards/atlas/atlas_int.c
--- S15-pre9/arch/mips/mips-boards/atlas/atlas_int.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips/mips-boards/atlas/atlas_int.c	Thu Nov 22 14:13:33 2001
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/seq_file.h>
 
 #include <asm/irq.h>
 #include <asm/mips-boards/atlas.h>
@@ -93,9 +94,9 @@
 	NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	int num = 0;
 	struct irqaction *action;
 
@@ -103,18 +104,18 @@
 		action = irq_desc[i].action;
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat.irqs[0][num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, " [hw0]\n");
+		seq_printf(p, " [hw0]\n");
 	}
-	return len;
+	return 0;
 }
 
 int request_irq(unsigned int irq, 
diff -urN S15-pre9/arch/mips/philips/nino/irq.c S15-pre9-current/arch/mips/philips/nino/irq.c
--- S15-pre9/arch/mips/philips/nino/irq.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips/philips/nino/irq.c	Thu Nov 22 14:13:42 2001
@@ -23,6 +23,7 @@
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/seq_file.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -114,27 +115,27 @@
     NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-    int i, len = 0;
+    int i;
     struct irqaction *action;
 
     for (i = 0; i < NR_IRQS; i++) {
 	action = irq_action[i];
 	if (!action)
 	    continue;
-	len += sprintf(buf + len, "%2d: %8d %c %s",
+	seq_printf(p, "%2d: %8d %c %s",
 		       i, kstat.irqs[0][i],
 		       (action->flags & SA_INTERRUPT) ? '+' : ' ',
 		       action->name);
 	for (action = action->next; action; action = action->next) {
-	    len += sprintf(buf + len, ",%s %s",
+	    seq_printf(p, ",%s %s",
 			   (action->flags & SA_INTERRUPT) ? " +" : "",
 			   action->name);
 	}
-	len += sprintf(buf + len, "\n");
+	seq_putc(p, '\n');
     }
-    return len;
+    return 0;
 }
 
 atomic_t __mips_bh_counter;
diff -urN S15-pre9/arch/mips64/mips-boards/atlas/atlas_int.c S15-pre9-current/arch/mips64/mips-boards/atlas/atlas_int.c
--- S15-pre9/arch/mips64/mips-boards/atlas/atlas_int.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips64/mips-boards/atlas/atlas_int.c	Thu Nov 22 14:13:49 2001
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/seq_file.h>
 
 #include <asm/irq.h>
 #include <asm/mips-boards/atlas.h>
@@ -89,9 +90,9 @@
 	NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	int num = 0;
 	struct irqaction *action;
 
@@ -99,18 +100,18 @@
 		action = irq_desc[i].action;
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat.irqs[0][num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, " [hw0]\n");
+		seq_puts(p, " [hw0]\n");
 	}
-	return len;
+	return 0;
 }
 
 int request_irq(unsigned int irq, 
diff -urN S15-pre9/arch/mips64/mips-boards/malta/malta_int.c S15-pre9-current/arch/mips64/mips-boards/malta/malta_int.c
--- S15-pre9/arch/mips64/mips-boards/malta/malta_int.c	Sun Sep 23 16:11:56 2001
+++ S15-pre9-current/arch/mips64/mips-boards/malta/malta_int.c	Thu Nov 22 14:13:55 2001
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/random.h>
+#include <linux/seq_file.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -119,9 +120,9 @@
 }
 
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	int num = 0;
 	struct irqaction *action;
 
@@ -129,33 +130,33 @@
 		action = irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat.irqs[0][num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, " [on-chip]\n");
+		seq_puts(p, " [on-chip]\n");
 	}
 	for (i = 0; i < MALTAINT_END; i++, num++) {
 		action = hw0_irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat.irqs[0][num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, " [hw0]\n");
+		seq_puts(p, " [hw0]\n");
 	}
-	return len;
+	return 0;
 }
 
 int request_irq(unsigned int irq, 
diff -urN S15-pre9/arch/mips64/sgi-ip22/ip22-int.c S15-pre9-current/arch/mips64/sgi-ip22/ip22-int.c
--- S15-pre9/arch/mips64/sgi-ip22/ip22-int.c	Sun Sep 23 16:11:57 2001
+++ S15-pre9-current/arch/mips64/sgi-ip22/ip22-int.c	Thu Nov 22 14:14:04 2001
@@ -8,6 +8,7 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
@@ -231,9 +232,9 @@
 	NULL, NULL, NULL, NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	int num = 0;
 	struct irqaction * action;
 
@@ -241,33 +242,33 @@
 		action = irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat.irqs[0][num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, " [on-chip]\n");
+		seq_puts(p, " [on-chip]\n");
 	}
 	for (i = 0 ; i < 24 ; i++, num++) {
 		action = local_irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s",
+		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat.irqs[0][num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, " [local]\n");
+		seq_puts(p, " [local]\n");
 	}
-	return len;
+	return 0;
 }
 
 /*
diff -urN S15-pre9/arch/mips64/sgi-ip27/ip27-irq.c S15-pre9-current/arch/mips64/sgi-ip27/ip27-irq.c
--- S15-pre9/arch/mips64/sgi-ip27/ip27-irq.c	Sun Sep 23 16:11:57 2001
+++ S15-pre9-current/arch/mips64/sgi-ip27/ip27-irq.c	Thu Nov 22 14:14:10 2001
@@ -20,6 +20,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/seq_file.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -136,27 +137,27 @@
 /* This is stupid for an Origin which can have thousands of IRQs ...  */
 static struct irqaction *irq_action[NR_IRQS];
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	struct irqaction * action;
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		action = irq_action[i];
 		if (!action) 
 			continue;
-		len += sprintf(buf+len, "%2d: %8d %c %s", i, kstat.irqs[0][i],
+		seq_printf(p, "%2d: %8d %c %s", i, kstat.irqs[0][i],
 		               (action->flags & SA_INTERRUPT) ? '+' : ' ',
 		               action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 			               (action->flags & SA_INTERRUPT)
 			                ? " +" : "",
 			                action->name);
 		}
-		len += sprintf(buf+len, "\n");
+		seq_putc(p, '\n');
 	}
-	return len;
+	return 0;
 }
 
 /*
diff -urN S15-pre9/arch/parisc/kernel/irq.c S15-pre9-current/arch/parisc/kernel/irq.c
--- S15-pre9/arch/parisc/kernel/irq.c	Fri Feb 16 22:54:22 2001
+++ S15-pre9-current/arch/parisc/kernel/irq.c	Thu Nov 22 14:14:16 2001
@@ -39,6 +39,7 @@
 #include <linux/random.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/seq_file.h>
 
 #include <asm/cache.h>
 
@@ -160,19 +161,18 @@
 		BUG();
 }
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 #ifdef CONFIG_PROC_FS
-	char *p = buf;
 	int i, j;
 	int regnr, irq_no;
 	struct irq_region *region;
 	struct irqaction *action, *mainaction;
 
-	p += sprintf(p, "           ");
+	seq_puts(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
-	*p++ = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p, '\n');
 
 	for (regnr = 0; regnr < NR_IRQ_REGS; regnr++) {
 	    region = irq_region[regnr];
@@ -188,40 +188,34 @@
 		
 		irq_no = IRQ_FROM_REGION(regnr) + i;
 		
-		p += sprintf(p, "%3d: ", irq_no);
+		seq_printf(p, "%3d: ", irq_no);
 #ifndef CONFIG_SMP
-		p += sprintf(p, "%10u ", kstat_irqs(irq_no));
+		seq_printf(p, "%10u ", kstat_irqs(irq_no));
 #else
 		for (j = 0; j < smp_num_cpus; j++)
-		    p += sprintf(p, "%10u ",
+		    seq_printf(p, "%10u ",
 			    kstat.irqs[cpu_logical_map(j)][irq_no]);
 #endif
-		p += sprintf(p, " %14s", 
+		seq_printf(p, " %14s", 
 			    region->data.name ? region->data.name : "N/A");
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-		    p += sprintf(p, ", %s", action->name);
-		*p++ = '\n';
+		    seq_printf(p, ", %s", action->name);
+		seq_putc(p, '\n');
 	    }	    	     
 	}  
 
-	p += sprintf(p, "\n");
+	seq_putc(p, '\n');
 #if CONFIG_SMP
-	p += sprintf(p, "LOC: ");
+	seq_puts(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
+		seq_printf(p, "%10u ",
 			apic_timer_irqs[cpu_logical_map(j)]);
-	p += sprintf(p, "\n");
+	seq_putc(p, '\n');
 #endif
-
-	return p - buf;
-
-#else	/* CONFIG_PROC_FS */
-
-	return 0;	
-
 #endif	/* CONFIG_PROC_FS */
+	return 0;
 }
 
 
diff -urN S15-pre9/arch/ppc/amiga/amiints.c S15-pre9-current/arch/ppc/amiga/amiints.c
--- S15-pre9/arch/ppc/amiga/amiints.c	Thu May 24 18:25:07 2001
+++ S15-pre9-current/arch/ppc/amiga/amiints.c	Thu Nov 22 14:14:26 2001
@@ -44,6 +44,7 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -61,7 +62,7 @@
                            unsigned long flags, const char *devname, void *dev_id);
 extern void cia_free_irq(unsigned int irq, void *dev_id);
 extern void cia_init_IRQ(struct ciabase *base);
-extern int cia_get_irq_list(struct ciabase *base, char *buf);
+extern int cia_get_irq_list(struct ciabase *base, struct seq_file *p);
 
 /* irq node variables for amiga interrupt sources */
 static irq_node_t *ami_irq_list[AMI_STD_IRQS];
@@ -480,28 +481,28 @@
 };
 #endif
 
-int amiga_get_irq_list(char *buf)
+int show_amiga_intreeupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	irq_node_t *node;
 
 	for (i = 0; i < AMI_STD_IRQS; i++) {
 		if (!(node = ami_irq_list[i]))
 			continue;
-		len += sprintf(buf+len, "ami  %2d: %10u ", i,
+		seq_printf(p, "ami  %2d: %10u ", i,
 		               kstat.irqs[0][SYS_IRQS + i]);
 		do {
 			if (node->flags & SA_INTERRUPT)
-				len += sprintf(buf+len, "F ");
+				seq_puts(p, "F ");
 			else
-				len += sprintf(buf+len, "  ");
-			len += sprintf(buf+len, "%s\n", node->devname);
+				seq_puts(p, "  ");
+			seq_printf(p, "%s\n", node->devname);
 			if ((node = node->next))
-				len += sprintf(buf+len, "                    ");
+				seq_puts(p, "                    ");
 		} while (node);
 	}
 
-	len += cia_get_irq_list(&ciaa_base, buf+len);
-	len += cia_get_irq_list(&ciab_base, buf+len);
+	cia_get_irq_list(&ciaa_base, p);
+	cia_get_irq_list(&ciab_base, p);
 	return len;
 }
diff -urN S15-pre9/arch/ppc/amiga/cia.c S15-pre9-current/arch/ppc/amiga/cia.c
--- S15-pre9/arch/ppc/amiga/cia.c	Thu May 24 18:25:07 2001
+++ S15-pre9-current/arch/ppc/amiga/cia.c	Thu Nov 22 14:14:33 2001
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/irq.h>
 #include <asm/amigahw.h>
@@ -222,16 +223,16 @@
 	custom.intena = IF_SETCLR | base->int_mask;
 }
 
-int cia_get_irq_list(struct ciabase *base, char *buf)
+int cia_get_irq_list(struct ciabase *base, struct seq_file *p)
 {
-	int i, j, len = 0;
+	int i, j;
 
 	j = base->cia_irq;
 	for (i = 0; i < CIA_IRQS; i++) {
-		len += sprintf(buf+len, "cia  %2d: %10d ", j + i,
+		seq_printf(p, "cia  %2d: %10d ", j + i,
 			       kstat.irqs[0][SYS_IRQS + j + i]);
-			len += sprintf(buf+len, "  ");
-		len += sprintf(buf+len, "%s\n", base->irq_list[i].devname);
+		seq_puts(p, "  ");
+		seq_printf(p, "%s\n", base->irq_list[i].devname);
 	}
-	return len;
+	return 0;
 }
diff -urN S15-pre9/arch/ppc/amiga/config.c S15-pre9-current/arch/ppc/amiga/config.c
--- S15-pre9/arch/ppc/amiga/config.c	Wed Oct 24 04:09:51 2001
+++ S15-pre9-current/arch/ppc/amiga/config.c	Thu Nov 22 14:14:42 2001
@@ -28,6 +28,7 @@
 #ifdef CONFIG_ZORRO
 #include <linux/zorro.h>
 #endif
+#include <linux/seq_file.h>
 
 #include <asm/bootinfo.h>
 #include <asm/setup.h>
@@ -91,7 +92,7 @@
 extern void amiga_disable_irq (unsigned int);
 static void amiga_get_model(char *model);
 static int amiga_get_hardware_list(char *buffer);
-extern int amiga_get_irq_list (char *);
+extern int show_amiga_interrupts (struct seq_file *, void *);
 /* amiga specific timer functions */
 static unsigned long amiga_gettimeoffset (void);
 static void a3000_gettod (int *, int *, int *, int *, int *, int *);
@@ -422,7 +423,7 @@
 #endif
   mach_get_model       = amiga_get_model;
   mach_get_hardware_list = amiga_get_hardware_list;
-  mach_get_irq_list    = amiga_get_irq_list;
+  mach_get_irq_list    = show_amiga_interrupts;
   mach_gettimeoffset   = amiga_gettimeoffset;
   if (AMIGAHW_PRESENT(A3000_CLK)){
     mach_gettod  = a3000_gettod;
diff -urN S15-pre9/arch/ppc/amiga/ints.c S15-pre9-current/arch/ppc/amiga/ints.c
--- S15-pre9/arch/ppc/amiga/ints.c	Thu May 24 18:25:07 2001
+++ S15-pre9-current/arch/ppc/amiga/ints.c	Thu Nov 22 14:14:48 2001
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/setup.h>
 #include <asm/system.h>
@@ -143,20 +144,20 @@
 	}
 }
 
-int m68k_get_irq_list(char *buf)
+int m68k_get_irq_list(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 
 	/* autovector interrupts */
 	if (mach_default_handler) {
 		for (i = 0; i < SYS_IRQS; i++) {
-			len += sprintf(buf+len, "auto %2d: %10u ", i,
+			seq_printf(p, "auto %2d: %10u ", i,
 			               i ? kstat.irqs[0][i] : num_spurious);
-				len += sprintf(buf+len, "  ");
-			len += sprintf(buf+len, "%s\n", irq_list[i].devname);
+			seq_puts(p, "  ");
+			seq_printf(p, "%s\n", irq_list[i].devname);
 		}
 	}
 
-	len += mach_get_irq_list(buf+len);
-	return len;
+	mach_get_irq_list(p, v);
+	return 0;
 }
diff -urN S15-pre9/arch/ppc/kernel/apus_setup.c S15-pre9-current/arch/ppc/kernel/apus_setup.c
--- S15-pre9/arch/ppc/kernel/apus_setup.c	Thu Nov 22 03:56:13 2001
+++ S15-pre9-current/arch/ppc/kernel/apus_setup.c	Thu Nov 22 11:28:46 2001
@@ -95,7 +95,7 @@
 void (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
 void (*mach_get_model) (char *model) = NULL;
 int (*mach_get_hardware_list) (char *buffer) = NULL;
-int (*mach_get_irq_list) (char *) = NULL;
+int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
 void (*mach_process_int) (int, struct pt_regs *) = NULL;
 /* machine dependent timer functions */
 unsigned long (*mach_gettimeoffset) (void);
@@ -671,12 +671,12 @@
 	return irq;
 }
 
-int apus_get_irq_list(char *buf)
+int show_apus_interrupts(struct seq_file *p, void *v)
 {
 #ifdef CONFIG_APUS
-	extern int amiga_get_irq_list(char *buf);
+	extern int show_amiga_interrupts(struct seq_file *p, void *v)
 	
-	return amiga_get_irq_list (buf);
+	return show_amiga_interrupts(p, v);
 #else
 	return 0;
 #endif
diff -urN S15-pre9/arch/ppc/kernel/irq.c S15-pre9-current/arch/ppc/kernel/irq.c
--- S15-pre9/arch/ppc/kernel/irq.c	Sun Sep 23 16:11:57 2001
+++ S15-pre9-current/arch/ppc/kernel/irq.c	Thu Nov 22 14:15:03 2001
@@ -47,6 +47,7 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 #include <linux/random.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -371,58 +372,58 @@
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 #ifdef CONFIG_APUS
-	return apus_get_irq_list (buf);
+	return show_apus_interrupts(p, v);
 #else
-	int i, len = 0, j;
+	int i, j;
 	struct irqaction * action;
 
-	len += sprintf(buf+len, "           ");
+	seq_puts(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
-		len += sprintf(buf+len, "CPU%d       ",j);
-	*(char *)(buf+len++) = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		action = irq_desc[i].action;
 		if ( !action || !action->handler )
 			continue;
-		len += sprintf(buf+len, "%3d: ", i);		
+		seq_printf(p, "%3d: ", i);		
 #ifdef CONFIG_SMP
 		for (j = 0; j < smp_num_cpus; j++)
-			len += sprintf(buf+len, "%10u ",
+			seq_printf(p, "%10u ",
 				kstat.irqs[cpu_logical_map(j)][i]);
 #else		
-		len += sprintf(buf+len, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #endif /* CONFIG_SMP */
 		if ( irq_desc[i].handler )		
-			len += sprintf(buf+len, " %s ", irq_desc[i].handler->typename );
+			seq_printf(p, " %s ", irq_desc[i].handler->typename );
 		else
-			len += sprintf(buf+len, "  None      ");
-		len += sprintf(buf+len, "%s", (irq_desc[i].status & IRQ_LEVEL) ? "Level " : "Edge  ");
-		len += sprintf(buf+len, "    %s",action->name);
+			seq_puts(p, "  None      ");
+		seq_printf(p, "%s", (irq_desc[i].status & IRQ_LEVEL) ? "Level " : "Edge  ");
+		seq_printf(p, "    %s",action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ", %s", action->name);
+			seq_printf(p, ", %s", action->name);
 		}
-		len += sprintf(buf+len, "\n");
+		seq_putc(p, '\n');
 	}
 #ifdef CONFIG_TAU_INT
 	if (tau_initialized){
-		len += sprintf(buf+len, "TAU: ");
+		seq_puts(p, "TAU: ");
 		for (j = 0; j < smp_num_cpus; j++)
-			len += sprintf(buf+len, "%10u ",
+			seq_printf(p, "%10u ",
 					tau_interrupts(j));
-		len += sprintf(buf+len, "  PowerPC             Thermal Assist (cpu temp)\n");
+		seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
 	}
 #endif
 #ifdef CONFIG_SMP
 	/* should this be per processor send/receive? */
-	len += sprintf(buf+len, "IPI (recv/sent): %10u/%u\n",
+	seq_printf(p, "IPI (recv/sent): %10u/%u\n",
 		       atomic_read(&ipi_recv), atomic_read(&ipi_sent));
 #endif		
-	len += sprintf(buf+len, "BAD: %10u\n", ppc_spurious_interrupts);
-	return len;
+	seq_printf(p, "BAD: %10u\n", ppc_spurious_interrupts);
+	return 0;
 #endif /* CONFIG_APUS */
 }
 
diff -urN S15-pre9/arch/s390/kernel/irq.c S15-pre9-current/arch/s390/kernel/irq.c
--- S15-pre9/arch/s390/kernel/irq.c	Sat Aug 11 14:59:21 2001
+++ S15-pre9-current/arch/s390/kernel/irq.c	Thu Nov 22 10:40:44 2001
@@ -28,6 +28,7 @@
 #include <linux/threads.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -59,22 +60,19 @@
 BUILD_SMP_INTERRUPT(spurious_interrupt)
 #endif
 
-#if 0
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
 	struct irqaction * action;
-	char *p = buf;
 
-	p += sprintf(p, "           ");
+	seq_puts(p, "           ");
 
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
+		seq_printf(p, "CPU%d       ",j);
 
-	*p++ = '\n';
+	seq_putc(p, '\n');
 
-	for (i = 0 ; i < NR_IRQS ; i++)
-	{
+	for (i = 0 ; i < NR_IRQS ; i++) {
 		if (ioinfo[i] == INVALID_STORAGE_AREA)
 			continue;
 
@@ -83,35 +81,33 @@
   		if (!action)
 			continue;
 
-		p += sprintf(p, "%3d: ",i);
+		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
-		p += sprintf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (j=0; j<smp_num_cpus; j++)
-			p += sprintf( p, "%10u ",
+			seq_printf( p, "%10u ",
 			              kstat.irqs[cpu_logical_map(j)][i]);
 #endif
-		p += sprintf(p, " %14s", ioinfo[i]->irq_desc.handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, " %14s", ioinfo[i]->irq_desc.handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
 		{
-			p += sprintf(p, ", %s", action->name);
+			seq_printf(p, ", %s", action->name);
 
 		} /* endfor */
 
-		*p++ = '\n';
+		seq_putc(p, '\n');
 	
 	} /* endfor */
 
-	p += sprintf(p, "NMI: %10u\n", nmi_counter);
+	seq_printf(p, "NMI: %10u\n", nmi_counter);
 #ifdef CONFIG_SMP
-	p += sprintf(p, "IPI: %10u\n", atomic_read(&ipi_count));
+	seq_printf(p, "IPI: %10u\n", atomic_read(&ipi_count));
 #endif
-
-	return p - buf;
+	return 0;
 }
-#endif
 
 /*
  * Global interrupt locks for SMP. Allow interrupts to come in on any
diff -urN S15-pre9/arch/s390x/kernel/irq.c S15-pre9-current/arch/s390x/kernel/irq.c
--- S15-pre9/arch/s390x/kernel/irq.c	Sat Aug 11 14:59:21 2001
+++ S15-pre9-current/arch/s390x/kernel/irq.c	Thu Nov 22 10:40:44 2001
@@ -28,6 +28,7 @@
 #include <linux/threads.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -59,19 +60,17 @@
 BUILD_SMP_INTERRUPT(spurious_interrupt)
 #endif
 
-#if 0
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
 	struct irqaction * action;
-	char *p = buf;
 
-	p += sprintf(p, "           ");
+	seq_puts(p, "           ");
 
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
+		seq_printf(p, "CPU%d       ",j);
 
-	*p++ = '\n';
+	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++)
 	{
@@ -83,35 +82,34 @@
   		if (!action)
 			continue;
 
-		p += sprintf(p, "%3d: ",i);
+		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
-		p += sprintf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (j=0; j<smp_num_cpus; j++)
-			p += sprintf( p, "%10u ",
+			seq_printf( p, "%10u ",
 			              kstat.irqs[cpu_logical_map(j)][i]);
 #endif
-		p += sprintf(p, " %14s", ioinfo[i]->irq_desc.handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, " %14s", ioinfo[i]->irq_desc.handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
 		{
-			p += sprintf(p, ", %s", action->name);
+			seq_printf(p, ", %s", action->name);
 
 		} /* endfor */
 
-		*p++ = '\n';
+		seq_putc(p, '\n');
 	
 	} /* endfor */
 
-	p += sprintf(p, "NMI: %10u\n", nmi_counter);
+	seq_printf(p, "NMI: %10u\n", nmi_counter);
 #ifdef CONFIG_SMP
-	p += sprintf(p, "IPI: %10u\n", atomic_read(&ipi_count));
+	seq_printf(p, "IPI: %10u\n", atomic_read(&ipi_count));
 #endif
 
-	return p - buf;
+	return 0;
 }
-#endif
 
 /*
  * Global interrupt locks for SMP. Allow interrupts to come in on any
diff -urN S15-pre9/arch/sh/kernel/irq.c S15-pre9-current/arch/sh/kernel/irq.c
--- S15-pre9/arch/sh/kernel/irq.c	Sun Sep 23 16:11:57 2001
+++ S15-pre9-current/arch/sh/kernel/irq.c	Thu Nov 22 14:15:17 2001
@@ -27,6 +27,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -84,31 +85,30 @@
  */
 
 #if defined(CONFIG_PROC_FS)
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
 	struct irqaction * action;
-	char *p = buf;
 
-	p += sprintf(p, "           ");
+	seq_puts(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
-	*p++ = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p, '\n');
 
 	for (i = 0 ; i < ACTUAL_NR_IRQS ; i++) {
 		action = irq_desc[i].action;
 		if (!action) 
 			continue;
-		p += sprintf(p, "%3d: ",i);
-		p += sprintf(p, "%10u ", kstat_irqs(i));
-		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, "%3d: ",i);
+		seq_printf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-			p += sprintf(p, ", %s", action->name);
-		*p++ = '\n';
+			seq_printf(p, ", %s", action->name);
+		seq_putc(p, '\n');
 	}
-	return p - buf;
+	return 0;
 }
 #endif
 
diff -urN S15-pre9/arch/sparc/kernel/irq.c S15-pre9-current/arch/sparc/kernel/irq.c
--- S15-pre9/arch/sparc/kernel/irq.c	Sun Jul 29 01:54:42 2001
+++ S15-pre9-current/arch/sparc/kernel/irq.c	Thu Nov 22 14:15:23 2001
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/threads.h>
 #include <linux/spinlock.h>
+#include <linux/seq_file.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -97,42 +98,42 @@
 	  NULL, NULL, NULL, NULL, NULL, NULL , NULL, NULL
 };
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	struct irqaction * action;
 #ifdef CONFIG_SMP
 	int j;
 #endif
 
 	if (sparc_cpu_model == sun4d) {
-		extern int sun4d_get_irq_list(char *);
+		extern int show_sun4d_interrupts(struct seq_file *, void *);
 		
-		return sun4d_get_irq_list(buf);
+		return show_sun4d_interrupts(p, v);
 	}
 	for (i = 0 ; i < (NR_IRQS+1) ; i++) {
 	        action = *(i + irq_action);
 		if (!action) 
 		        continue;
-		len += sprintf(buf+len, "%3d: ", i);
+		seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
-		len += sprintf(buf+len, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (j = 0; j < smp_num_cpus; j++)
-			len += sprintf(buf+len, "%10u ",
+			seq_printf(p, "%10u ",
 				kstat.irqs[cpu_logical_map(j)][i]);
 #endif
-		len += sprintf(buf+len, " %c %s",
+		seq_printf(p, " %c %s",
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
-			len += sprintf(buf+len, ",%s %s",
+			seq_printf(p, ",%s %s",
 				(action->flags & SA_INTERRUPT) ? " +" : "",
 				action->name);
 		}
-		len += sprintf(buf+len, "\n");
+		seq_putc(p, '\n');
 	}
-	return len;
+	return 0;
 }
 
 void free_irq(unsigned int irq, void *dev_id)
diff -urN S15-pre9/arch/sparc/kernel/sun4d_irq.c S15-pre9-current/arch/sparc/kernel/sun4d_irq.c
--- S15-pre9/arch/sparc/kernel/sun4d_irq.c	Sun Jul 29 01:54:42 2001
+++ S15-pre9-current/arch/sparc/kernel/sun4d_irq.c	Thu Nov 22 14:15:29 2001
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
+#include <linux/seq_file.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -72,9 +73,9 @@
 spinlock_t sun4d_imsk_lock = SPIN_LOCK_UNLOCKED;
 #endif
 
-int sun4d_get_irq_list(char *buf)
+int show_sun4d_interrupts(struct seq_file *p, void *v)
 {
-	int i, j = 0, k = 0, len = 0, sbusl;
+	int i, j = 0, k = 0, sbusl;
 	struct irqaction * action;
 #ifdef CONFIG_SMP
 	int x;
@@ -94,21 +95,21 @@
 			}
 			continue;
 		}
-found_it:	len += sprintf(buf+len, "%3d: ", i);
+found_it:	seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
-		len += sprintf(buf+len, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (x = 0; x < smp_num_cpus; x++)
-			len += sprintf(buf+len, "%10u ",
+			seq_printf(p, "%10u ",
 				       kstat.irqs[cpu_logical_map(x)][i]);
 #endif
-		len += sprintf(buf+len, "%c %s",
+		seq_printf(p, "%c %s",
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
 			action->name);
 		action = action->next;
 		for (;;) {
 			for (; action; action = action->next) {
-				len += sprintf(buf+len, ",%s %s",
+				seq_printf(p, ",%s %s",
 					(action->flags & SA_INTERRUPT) ? " +" : "",
 					action->name);
 			}
@@ -123,9 +124,9 @@
 				action = sbus_actions [(j << 5) + (sbusl << 2)].action;
 			}
 		}
-		len += sprintf(buf+len, "\n");
+		seq_putc(p, '\n');
 	}
-	return len;
+	return 0;
 }
 
 void sun4d_free_irq(unsigned int irq, void *dev_id)
diff -urN S15-pre9/arch/sparc64/kernel/irq.c S15-pre9-current/arch/sparc64/kernel/irq.c
--- S15-pre9/arch/sparc64/kernel/irq.c	Thu Nov 22 03:56:13 2001
+++ S15-pre9-current/arch/sparc64/kernel/irq.c	Thu Nov 22 14:15:38 2001
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -104,9 +105,9 @@
 #define put_smpaff_in_irqaction(action, smpaff)	(action)->mask = (smpaff)
 #define get_smpaff_in_irqaction(action) 	((action)->mask)
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, len = 0;
+	int i;
 	struct irqaction *action;
 #ifdef CONFIG_SMP
 	int j;
@@ -115,23 +116,23 @@
 	for(i = 0; i < (NR_IRQS + 1); i++) {
 		if(!(action = *(i + irq_action)))
 			continue;
-		len += sprintf(buf + len, "%3d: ", i);
+		seq_print(p, "%3d: ", i);
 #ifndef CONFIG_SMP
-		len += sprintf(buf + len, "%10u ", kstat_irqs(i));
+		seq_print(p, "%10u ", kstat_irqs(i));
 #else
 		for (j = 0; j < smp_num_cpus; j++)
-			len += sprintf(buf + len, "%10u ",
+			seq_print(p, "%10u ",
 				       kstat.irqs[cpu_logical_map(j)][i]);
 #endif
-		len += sprintf(buf + len, " %s:%lx", action->name, \
+		seq_print(p, " %s:%lx", action->name,
 						get_ino_in_irqaction(action));
 		for(action = action->next; action; action = action->next) {
-			len += sprintf(buf+len, ", %s:%lx", action->name, \
+			seq_print(p, ", %s:%lx", action->name,
 						get_ino_in_irqaction(action));
 		}
-		len += sprintf(buf + len, "\n");
+		seq_putc(p, '\n');
 	}
-	return len;
+	return 0;
 }
 
 /* Now these are always passed a true fully specified sun4u INO. */
diff -urN S15-pre9/fs/proc/proc_misc.c S15-pre9-current/fs/proc/proc_misc.c
--- S15-pre9/fs/proc/proc_misc.c	Thu Nov 22 03:56:18 2001
+++ S15-pre9-current/fs/proc/proc_misc.c	Thu Nov 22 14:53:51 2001
@@ -57,7 +57,6 @@
 extern int get_partition_list(char *, char **, off_t, int);
 extern int get_filesystem_list(char *);
 extern int get_exec_domain_list(char *);
-extern int get_irq_list(char *);
 extern int get_dma_list(char *);
 extern int get_locks_status (char *, char **, off_t, int);
 extern int get_swaparea_info (char *);
@@ -328,14 +327,53 @@
 	return len;
 }
 
-#if !defined(CONFIG_ARCH_S390)
-static int interrupts_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
+static void *single_start(struct seq_file *p, loff_t *pos)
 {
-	int len = get_irq_list(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
+	return (void *)(*pos == 0);
 }
-#endif
+static void *single_next(struct seq_file *p, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+static void single_stop(struct seq_file *p, void *v)
+{
+}
+extern int show_interrupts(struct seq_file *p, void *v);
+static struct seq_operations proc_interrupts_op = {
+	start:	single_start,
+	next:	single_next,
+	stop:	single_stop,
+	show:	show_interrupts,
+};
+static int interrupts_open(struct inode *inode, struct file *file)
+{
+	unsigned size = PAGE_SIZE;
+	/*
+	 * probably should depend on NR_CPUS, but that's only rough estimate;
+	 * if we'll need more it will be given,
+	 */
+	char *buf = kmalloc(size, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = seq_open(file, &proc_interrupts_op);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = size;
+	} else
+		kfree(buf);
+	return res;
+}
+static struct file_operations proc_interrupts_operations = {
+	open:		interrupts_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
 
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -512,9 +550,6 @@
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"partitions",	partitions_read_proc},
-#if !defined(CONFIG_ARCH_S390)
-		{"interrupts",	interrupts_read_proc},
-#endif
 		{"filesystems",	filesystems_read_proc},
 		{"dma",		dma_read_proc},
 		{"ioports",	ioports_read_proc},
@@ -537,6 +572,9 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("mounts", 0, &proc_mounts_operations);
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+#if defined(CONFIG_ARCH_S390) || defined(CONFIG_X86) || defined(CONFIG_ARCH_MIPS)
+	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
+#endif
 #ifdef CONFIG_MODULES
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif
diff -urN S15-pre9/include/asm-arm/mach/irq.h S15-pre9-current/include/asm-arm/mach/irq.h
--- S15-pre9/include/asm-arm/mach/irq.h	Fri Feb 16 22:50:15 2001
+++ S15-pre9-current/include/asm-arm/mach/irq.h	Thu Nov 22 12:56:42 2001
@@ -35,7 +35,7 @@
 
 extern void (*init_arch_irq)(void);
 extern int setup_arm_irq(int, struct irqaction *);
-extern int get_fiq_list(char *);
+extern int show_fiq_list(struct seq_file *, void *);
 extern void init_FIQ(void);
 
 #endif
diff -urN S15-pre9/include/asm-m68k/machdep.h S15-pre9-current/include/asm-m68k/machdep.h
--- S15-pre9/include/asm-m68k/machdep.h	Fri Feb 16 20:30:21 2001
+++ S15-pre9-current/include/asm-m68k/machdep.h	Thu Nov 22 14:06:23 2001
@@ -1,6 +1,8 @@
 #ifndef _M68K_MACHDEP_H
 #define _M68K_MACHDEP_H
 
+#include <linux/seq_file.h>
+
 struct pt_regs;
 struct kbd_repeat;
 struct mktime;
@@ -22,7 +24,7 @@
 extern void (*mach_free_irq) (unsigned int irq, void *dev_id);
 extern void (*mach_get_model) (char *model);
 extern int (*mach_get_hardware_list) (char *buffer);
-extern int (*mach_get_irq_list) (char *buf);
+extern int (*mach_get_irq_list) (struct seq_file *p, void *v);
 extern void (*mach_process_int) (int irq, struct pt_regs *fp);
 /* machine dependent timer functions */
 extern unsigned long (*mach_gettimeoffset)(void);
diff -urN S15-pre9/include/asm-m68k/macintosh.h S15-pre9-current/include/asm-m68k/macintosh.h
--- S15-pre9/include/asm-m68k/macintosh.h	Fri Feb 16 07:12:30 2001
+++ S15-pre9-current/include/asm-m68k/macintosh.h	Thu Nov 22 11:54:36 2001
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACINTOSH_H
 #define __ASM_MACINTOSH_H
 
+#include <linux/seq_file.h>
+
 /*
  *	Apple Macintoshisms
  */
@@ -15,7 +17,7 @@
 extern void mac_enable_irq(unsigned int);
 extern void mac_disable_irq(unsigned int);
 extern int mac_irq_pending(unsigned int);
-extern int mac_get_irq_list(char *);
+extern int show_mac_interrupts(struct seq_file *, void *);
 #if 0
 extern void mac_default_handler(int irq);
 #endif
diff -urN S15-pre9/include/asm-m68k/sun3ints.h S15-pre9-current/include/asm-m68k/sun3ints.h
--- S15-pre9/include/asm-m68k/sun3ints.h	Tue Jul  3 21:09:14 2001
+++ S15-pre9-current/include/asm-m68k/sun3ints.h	Thu Nov 22 11:42:57 2001
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
+#include <linux/seq_file.h>
 #include <asm/segment.h>
 #include <asm/intersil.h>
 #include <asm/oplib.h>
@@ -32,7 +33,7 @@
 extern void sun3_free_irq (unsigned int irq, void *dev_id);
 extern void sun3_enable_interrupts (void);
 extern void sun3_disable_interrupts (void);
-extern int sun3_get_irq_list(char *buf);
+extern int show_sun3_interrupts(struct seq_file *, void *);
 extern void sun3_process_int(int, struct pt_regs *);
 extern volatile unsigned char* sun3_intreg;
 
diff -urN S15-pre9/include/linux/seq_file.h S15-pre9-current/include/linux/seq_file.h
--- S15-pre9/include/linux/seq_file.h	Thu Nov 22 03:56:20 2001
+++ S15-pre9-current/include/linux/seq_file.h	Thu Nov 22 14:38:07 2001
@@ -2,7 +2,11 @@
 #define _LINUX_SEQ_FILE_H
 #ifdef __KERNEL__
 
+#include <linux/types.h>
+
 struct seq_operations;
+struct file;
+struct inode;
 
 struct seq_file {
 	char *buf;
@@ -12,6 +16,7 @@
 	loff_t index;
 	struct semaphore sem;
 	struct seq_operations *op;
+	void *private;
 };
 
 struct seq_operations {

