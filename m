Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277295AbRJEB0A>; Thu, 4 Oct 2001 21:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277296AbRJEBZv>; Thu, 4 Oct 2001 21:25:51 -0400
Received: from dot.cygnus.com ([205.180.230.224]:2308 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S277295AbRJEBZd>;
	Thu, 4 Oct 2001 21:25:33 -0400
Date: Thu, 4 Oct 2001 18:25:52 -0700
From: Richard Henderson <rth@dot.cygnus.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.11-pre3: fix pc164 srm interrupts
Message-ID: <20011004182552.A802@dot.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Jay Estabrook:

(1) The PC164 broken interupt mask hack was only applied to the MILO
    interrupt handler, and not the SRM interrupt handler.

(2) SRM sometimes mis-identifies a PC164 as an EB164, which results
    in our interrupt fixes not being installed.  Fix this by noticing
    that an EB164 is never an EV56.


r~



diff -rup 2.4.10-dist/arch/alpha/kernel/setup.c 2.4.10/arch/alpha/kernel/setup.c
--- 2.4.10-dist/arch/alpha/kernel/setup.c	Sun Aug 12 10:38:47 2001
+++ 2.4.10/arch/alpha/kernel/setup.c	Thu Oct  4 16:05:16 2001
@@ -85,7 +93,7 @@ unsigned char aux_device_present = 0xaa;
 
 static struct alpha_machine_vector *get_sysvec(long, long, long);
 static struct alpha_machine_vector *get_sysvec_byname(const char *);
-static void get_sysnames(long, long, char **, char **);
+static void get_sysnames(long, long, long, char **, char **);
 
 static char command_line[COMMAND_LINE_SIZE];
 char saved_command_line[COMMAND_LINE_SIZE];
@@ -537,14 +545,14 @@ setup_arch(char **cmdline_p)
 	/*
 	 * Indentify and reconfigure for the current system.
 	 */
+	cpu = (struct percpu_struct*)((char*)hwrpb + hwrpb->processor_offset);
+
 	get_sysnames(hwrpb->sys_type, hwrpb->sys_variation,
-		     &type_name, &var_name);
+		     cpu->type, &type_name, &var_name);
 	if (*var_name == '0')
 		var_name = "";
 
 	if (!vec) {
-		cpu = (struct percpu_struct*)
-			((char*)hwrpb + hwrpb->processor_offset);
 		vec = get_sysvec(hwrpb->sys_type, hwrpb->sys_variation,
 				 cpu->type);
 	}
@@ -801,6 +809,8 @@ get_sysvec(long type, long variation, lo
 		/* Member ID is a bit-field. */
 		long member = (variation >> 10) & 0x3f;
 
+		cpu &= 0xffffffff; /* make it usable */
+
 		switch (type) {
 		case ST_DEC_ALCOR:
 			if (member < N(alcor_indices))
@@ -809,6 +819,10 @@ get_sysvec(long type, long variation, lo
 		case ST_DEC_EB164:
 			if (member < N(eb164_indices))
 				vec = eb164_vecs[eb164_indices[member]];
+			/* PC164 may show as EB164 variation with EV56 CPU,
+			   but, since no true EB164 had anything but EV5... */
+			if (vec == &eb164_mv && cpu == EV56_CPU)
+				vec = &pc164_mv;
 			break;
 		case ST_DEC_EB64P:
 			if (member < N(eb64p_indices))
@@ -827,21 +841,18 @@ get_sysvec(long type, long variation, lo
 				vec = tsunami_vecs[tsunami_indices[member]];
 			break;
 		case ST_DEC_1000:
-			cpu &= 0xffffffff;
 			if (cpu == EV5_CPU || cpu == EV56_CPU)
 				vec = &mikasa_primo_mv;
 			else
 				vec = &mikasa_mv;
 			break;
 		case ST_DEC_NORITAKE:
-			cpu &= 0xffffffff;
 			if (cpu == EV5_CPU || cpu == EV56_CPU)
 				vec = &noritake_primo_mv;
 			else
 				vec = &noritake_mv;
 			break;
 		case ST_DEC_2100_A500:
-			cpu &= 0xffffffff;
 			if (cpu == EV5_CPU || cpu == EV56_CPU)
 				vec = &sable_gamma_mv;
 			else
@@ -905,7 +916,7 @@ get_sysvec_byname(const char *name)
 }
 
 static void
-get_sysnames(long type, long variation,
+get_sysnames(long type, long variation, long cpu,
 	     char **type_name, char **variation_name)
 {
 	long member;
@@ -938,12 +949,18 @@ get_sysnames(long type, long variation,
 
 	member = (variation >> 10) & 0x3f; /* member ID is a bit-field */
 
+	cpu &= 0xffffffff; /* make it usable */
+
 	switch (type) { /* select by family */
 	default: /* default to variation "0" for now */
 		break;
 	case ST_DEC_EB164:
 		if (member < N(eb164_indices))
 			*variation_name = eb164_names[eb164_indices[member]];
+		/* PC164 may show as EB164 variation, but with EV56 CPU,
+		   so, since no true EB164 had anything but EV5... */
+		if (eb164_indices[member] == 0 && cpu == EV56_CPU)
+			*variation_name = eb164_names[1]; /* make it PC164 */
 		break;
 	case ST_DEC_ALCOR:
 		if (member < N(alcor_indices))
@@ -1054,7 +1071,7 @@ int get_cpuinfo(char *buffer)
 		cpu_name = cpu_names[cpu_index];
 
 	get_sysnames(hwrpb->sys_type, hwrpb->sys_variation,
-		     &systype_name, &sysvariation_name);
+		     cpu->type, &systype_name, &sysvariation_name);
 
 	nr_processors = get_nr_processors(cpu, hwrpb->nr_processors);
 
diff -rup 2.4.10-dist/arch/alpha/kernel/sys_cabriolet.c 2.4.10/arch/alpha/kernel/sys_cabriolet.c
--- 2.4.10-dist/arch/alpha/kernel/sys_cabriolet.c	Wed Jan 24 15:16:23 2001
+++ 2.4.10/arch/alpha/kernel/sys_cabriolet.c	Thu Oct  4 16:09:03 2001
@@ -106,12 +106,12 @@ cabriolet_device_interrupt(unsigned long
 }
 
 static void __init
-cabriolet_init_irq(void)
+common_init_irq(void (*srm_dev_int)(unsigned long v, struct pt_regs *r))
 {
 	init_i8259a_irqs();
 
 	if (alpha_using_srm) {
-		alpha_mv.device_interrupt = srm_device_interrupt;
+		alpha_mv.device_interrupt = srm_dev_int;
 		init_srm_irqs(35, 0);
 	}
 	else {
@@ -131,29 +131,47 @@ cabriolet_init_irq(void)
 	setup_irq(16+4, &isa_cascade_irqaction);
 }
 
+static void __init
+cabriolet_init_irq(void)
+{
+	common_init_irq(srm_device_interrupt);
+}
+
 #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_PC164)
+/* In theory, the PC164 has the same interrupt hardware as the other
+   Cabriolet based systems.  However, something got screwed up late
+   in the development cycle which broke the interrupt masking hardware.
+   Repeat, it is not possible to mask and ack interrupts.  At all.
+
+   In an attempt to work around this, while processing interrupts,
+   we do not allow the IPL to drop below what it is currently.  This
+   prevents the possibility of recursion.  
+
+   ??? Another option might be to force all PCI devices to use edge
+   triggered rather than level triggered interrupts.  That might be
+   too invasive though.  */
+
 static void
-pc164_device_interrupt(unsigned long v, struct pt_regs *r)
+pc164_srm_device_interrupt(unsigned long v, struct pt_regs *r)
 {
-	/* In theory, the PC164 has the same interrupt hardware as
-	   the other Cabriolet based systems.  However, something 
-	   got screwed up late in the development cycle which broke
-	   the interrupt masking hardware.  Repeat, it is not 
-	   possible to mask and ack interrupts.  At all.
-
-	   In an attempt to work around this, while processing 
-	   interrupts, we do not allow the IPL to drop below what
-	   it is currently.  This prevents the possibility of
-	   recursion.  
-
-	   ??? Another option might be to force all PCI devices
-	   to use edge triggered rather than level triggered
-	   interrupts.  That might be too invasive though.  */
+	__min_ipl = getipl();
+	srm_device_interrupt(v, r);
+	__min_ipl = 0;
+}
 
+static void
+pc164_device_interrupt(unsigned long v, struct pt_regs *r)
+{
 	__min_ipl = getipl();
 	cabriolet_device_interrupt(v, r);
 	__min_ipl = 0;
 }
+
+static void __init
+pc164_init_irq(void)
+{
+	common_init_irq(pc164_srm_device_interrupt);
+}
 #endif
 
 /*
@@ -419,7 +437,7 @@ struct alpha_machine_vector pc164_mv __i
 	device_interrupt:	pc164_device_interrupt,
 
 	init_arch:		cia_init_arch,
-	init_irq:		cabriolet_init_irq,
+	init_irq:		pc164_init_irq,
 	init_rtc:		common_init_rtc,
 	init_pci:		alphapc164_init_pci,
 	pci_map_irq:		alphapc164_map_irq,
