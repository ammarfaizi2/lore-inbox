Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbSKFVkg>; Wed, 6 Nov 2002 16:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266117AbSKFVkg>; Wed, 6 Nov 2002 16:40:36 -0500
Received: from p50828914.dip.t-dialin.net ([80.130.137.20]:20237 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S266116AbSKFVka>; Wed, 6 Nov 2002 16:40:30 -0500
Date: Wed, 6 Nov 2002 21:47:05 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: axp-list mailing list <axp-list@redhat.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] eliminate compile warnings
Message-ID: <20021106214705.A15525@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: axp-list mailing list <axp-list@redhat.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

My attempt to compile 2.5.46 with gcc 3.3 resulted in over 66% lines of the
form:

xyz.c: warning: comparison between signed and unsigned

This is a first step to eliminate those, covering arch/alpha. Most fixes
are obvious, but please check.

BTW who is the current maintainer for Alpha issues? MAINTAINERS has no 
entry :-/

Thorsten





diff -ur linux-2.5.46/arch/alpha/kernel/err_common.c linux-2.5.46-ds20/arch/alpha/kernel/err_common.c
--- linux-2.5.46/arch/alpha/kernel/err_common.c	Wed Nov  6 19:04:14 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/err_common.c	Wed Nov  6 20:02:50 2002
@@ -34,10 +34,10 @@
  * Generic
  */
 void
-mchk_dump_mem(void *data, int length, char **annotation)
+mchk_dump_mem(void *data, unsigned int length, char **annotation)
 {
 	unsigned long *ldata = data;
-	int i;
+	unsigned int i;
 	
 	for(i = 0; (i * sizeof(*ldata)) < length; i++) {
 		if (annotation && !annotation[i]) 
@@ -715,7 +715,7 @@
 cdl_check_console_data_log(void)
 {
 	struct percpu_struct *pcpu;
-	int cpu;
+	unsigned long cpu;
 
 	for(cpu = 0; cpu < hwrpb->nr_processors; cpu++) {
 		pcpu = (struct percpu_struct *)
diff -ur linux-2.5.46/arch/alpha/kernel/err_impl.h linux-2.5.46-ds20/arch/alpha/kernel/err_impl.h
--- linux-2.5.46/arch/alpha/kernel/err_impl.h	Wed Nov  6 19:04:14 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/err_impl.h	Wed Nov  6 21:10:37 2002
@@ -133,7 +133,7 @@
  */
 extern char *err_print_prefix;
 
-extern void mchk_dump_mem(void *, int, char **);
+extern void mchk_dump_mem(void *, unsigned int, char **);
 extern void mchk_dump_logout_frame(struct el_common *);
 extern void ev7_register_error_handlers(void);
 extern void ev7_machine_check(u64, u64, struct pt_regs *);
diff -ur linux-2.5.46/arch/alpha/kernel/irq.c linux-2.5.46-ds20/arch/alpha/kernel/irq.c
--- linux-2.5.46/arch/alpha/kernel/irq.c	Wed Nov  6 19:04:14 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/irq.c	Wed Nov  6 20:03:53 2002
@@ -252,7 +252,7 @@
 {
 	unsigned char hexnum [HEX_DIGITS];
 	unsigned long value;
-	int i;
+	unsigned long i;
 
 	if (!count)
 		return -EINVAL;
diff -ur linux-2.5.46/arch/alpha/kernel/osf_sys.c linux-2.5.46-ds20/arch/alpha/kernel/osf_sys.c
--- linux-2.5.46/arch/alpha/kernel/osf_sys.c	Wed Nov  6 19:04:14 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/osf_sys.c	Wed Nov  6 20:34:13 2002
@@ -104,7 +104,7 @@
 struct osf_dirent_callback {
 	struct osf_dirent *dirent;
 	long *basep;
-	int count;
+	unsigned int count;
 	int error;
 };
 
@@ -114,7 +114,7 @@
 {
 	struct osf_dirent *dirent;
 	struct osf_dirent_callback *buf = (struct osf_dirent_callback *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	unsigned int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
 
 	buf->error = -EINVAL;	/* only used if we fail */
 	if (reclen > buf->count)
@@ -478,6 +478,9 @@
 	return error;
 }
 
+
+asmlinkage long sys_swapon(const char * specialfile, int swap_flags);	/* mm/swapfile.c */
+
 asmlinkage int
 osf_swapon(const char *path, int flags, int lowat, int hiwat)
 {
@@ -521,8 +524,8 @@
 asmlinkage int
 osf_getdomainname(char *name, int namelen)
 {
-	unsigned len;
-	int i, error;
+	unsigned len, i;
+	int error;
 
 	error = verify_area(VERIFY_WRITE, name, namelen);
 	if (error)
@@ -1416,14 +1419,14 @@
 
 	if (addr) {
 		addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
-		if (addr != -ENOMEM)
+		if (addr != (unsigned) -ENOMEM)
 			return addr;
 	}
 
 	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
 					 len, limit);
-	if (addr != -ENOMEM)
+	if (addr != (unsigned) -ENOMEM)
 		return addr;
 
 	/* Finally, try allocating in low memory.  */
diff -ur linux-2.5.46/arch/alpha/kernel/pci.c linux-2.5.46-ds20/arch/alpha/kernel/pci.c
--- linux-2.5.46/arch/alpha/kernel/pci.c	Wed Nov  6 19:04:14 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/pci.c	Wed Nov  6 20:37:11 2002
@@ -474,5 +474,5 @@
 pci_controller_num(struct pci_dev *pdev)
 {
         struct pci_controller *hose = pdev->sysdata;
-	return (hose ? hose->index : -ENXIO);
+	return (hose ? (signed) hose->index : -ENXIO);
 }
diff -ur linux-2.5.46/arch/alpha/kernel/setup.c linux-2.5.46-ds20/arch/alpha/kernel/setup.c
--- linux-2.5.46/arch/alpha/kernel/setup.c	Sat Oct 19 04:01:16 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/setup.c	Wed Nov  6 20:46:35 2002
@@ -202,7 +202,7 @@
 	};
 
 	struct resource *io = &ioport_resource;
-	long i;
+	unsigned long i;
 
 	if (hose_head) {
 		struct pci_controller *hose;
@@ -258,7 +258,7 @@
 	unsigned long start_kernel_pfn, end_kernel_pfn;
 	unsigned long bootmap_size, bootmap_pages, bootmap_start;
 	unsigned long start, end;
-	int i;
+	unsigned int i;
 
 	/* Find free clusters, and init and free the bootmem accordingly.  */
 	memdesc = (struct memdesc_struct *)
@@ -327,7 +327,7 @@
 		}
 	}
 
-	if (bootmap_start == -1) {
+	if (bootmap_start == (unsigned long)-1L) {
 		max_low_pfn >>= 1;
 		goto try_again;
 	}
@@ -398,7 +398,7 @@
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;
-	int i;
+	unsigned int i;
 
 	memdesc = (struct memdesc_struct *)
 		(hwrpb->mddt_offset + (unsigned long) hwrpb);
@@ -804,13 +804,13 @@
 
 	/* Search the system tables first... */
 	vec = NULL;
-	if (type < N(systype_vecs)) {
+	if ((unsigned)type < N(systype_vecs)) {
 		vec = systype_vecs[type];
 	} else if ((type > ST_API_BIAS) &&
-		   (type - ST_API_BIAS) < N(api_vecs)) {
+		   ((unsigned)type - ST_API_BIAS) < N(api_vecs)) {
 		vec = api_vecs[type - ST_API_BIAS];
 	} else if ((type > ST_UNOFFICIAL_BIAS) &&
-		   (type - ST_UNOFFICIAL_BIAS) < N(unofficial_vecs)) {
+		   ((unsigned)type - ST_UNOFFICIAL_BIAS) < N(unofficial_vecs)) {
 		vec = unofficial_vecs[type - ST_UNOFFICIAL_BIAS];
 	}
 
@@ -818,7 +818,7 @@
 
 	if (!vec) {
 		/* Member ID is a bit-field. */
-		long member = (variation >> 10) & 0x3f;
+		unsigned long member = (variation >> 10) & 0x3f;
 
 		cpu &= 0xffffffff; /* make it usable */
 
@@ -938,13 +938,13 @@
 
 	/* If not in the tables, make it UNKNOWN,
 	   else set type name to family */
-	if (type < N(systype_names)) {
+	if ((unsigned)type < N(systype_names)) {
 		*type_name = systype_names[type];
 	} else if ((type > ST_API_BIAS) &&
-		   (type - ST_API_BIAS) < N(api_names)) {
+		   ((unsigned)type - ST_API_BIAS) < N(api_names)) {
 		*type_name = api_names[type - ST_API_BIAS];
 	} else if ((type > ST_UNOFFICIAL_BIAS) &&
-		   (type - ST_UNOFFICIAL_BIAS) < N(unofficial_names)) {
+		   ((unsigned)type - ST_UNOFFICIAL_BIAS) < N(unofficial_names)) {
 		*type_name = unofficial_names[type - ST_UNOFFICIAL_BIAS];
 	} else {
 		*type_name = sys_unknown;
@@ -966,7 +966,7 @@
 	default: /* default to variation "0" for now */
 		break;
 	case ST_DEC_EB164:
-		if (member < N(eb164_indices))
+		if ((unsigned)member < N(eb164_indices))
 			*variation_name = eb164_names[eb164_indices[member]];
 		/* PC164 may show as EB164 variation, but with EV56 CPU,
 		   so, since no true EB164 had anything but EV5... */
@@ -974,27 +974,27 @@
 			*variation_name = eb164_names[1]; /* make it PC164 */
 		break;
 	case ST_DEC_ALCOR:
-		if (member < N(alcor_indices))
+		if ((unsigned)member < N(alcor_indices))
 			*variation_name = alcor_names[alcor_indices[member]];
 		break;
 	case ST_DEC_EB64P:
-		if (member < N(eb64p_indices))
+		if ((unsigned)member < N(eb64p_indices))
 			*variation_name = eb64p_names[eb64p_indices[member]];
 		break;
 	case ST_DEC_EB66:
-		if (member < N(eb66_indices))
+		if ((unsigned)member < N(eb66_indices))
 			*variation_name = eb66_names[eb66_indices[member]];
 		break;
 	case ST_DEC_RAWHIDE:
-		if (member < N(rawhide_indices))
+		if ((unsigned)member < N(rawhide_indices))
 			*variation_name = rawhide_names[rawhide_indices[member]];
 		break;
 	case ST_DEC_TITAN:
-		if (member < N(titan_indices))
+		if ((unsigned)member < N(titan_indices))
 			*variation_name = titan_names[titan_indices[member]];
 		break;
 	case ST_DEC_TSUNAMI:
-		if (member < N(tsunami_indices))
+		if ((unsigned)member < N(tsunami_indices))
 			*variation_name = tsunami_names[tsunami_indices[member]];
 		break;
 	}
diff -ur linux-2.5.46/arch/alpha/kernel/smc37c669.c linux-2.5.46-ds20/arch/alpha/kernel/smc37c669.c
--- linux-2.5.46/arch/alpha/kernel/smc37c669.c	Sat Oct 19 04:02:00 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/smc37c669.c	Wed Nov  6 20:48:56 2002
@@ -2269,7 +2269,7 @@
 ** We are translating a device IRQ to an ISA IRQ
 */
     	for ( i = 0; ( SMC37c669_irq_table[i].device_irq != -1 ) || ( SMC37c669_irq_table[i].isa_irq != -1 ); i++ ) {
-	    if ( irq == SMC37c669_irq_table[i].device_irq ) {
+	    if ( (signed)irq == SMC37c669_irq_table[i].device_irq ) {
 	    	translated_irq = SMC37c669_irq_table[i].isa_irq;
 		break;
 	    }
@@ -2280,7 +2280,7 @@
 ** We are translating an ISA IRQ to a device IRQ
 */
     	for ( i = 0; ( SMC37c669_irq_table[i].isa_irq != -1 ) || ( SMC37c669_irq_table[i].device_irq != -1 ); i++ ) {
-	    if ( irq == SMC37c669_irq_table[i].isa_irq ) {
+	    if ( (signed)irq == SMC37c669_irq_table[i].isa_irq ) {
 	    	translated_irq = SMC37c669_irq_table[i].device_irq;
 		break;
 	    }
@@ -2321,7 +2321,7 @@
 ** We are translating a device DMA channel to an ISA DMA channel
 */
     	for ( i = 0; ( SMC37c669_drq_table[i].device_drq != -1 ) || ( SMC37c669_drq_table[i].isa_drq != -1 ); i++ ) {
-	    if ( drq == SMC37c669_drq_table[i].device_drq ) {
+	    if ( (signed)drq == SMC37c669_drq_table[i].device_drq ) {
 	    	translated_drq = SMC37c669_drq_table[i].isa_drq;
 		break;
 	    }
@@ -2332,7 +2332,7 @@
 ** We are translating an ISA DMA channel to a device DMA channel
 */
     	for ( i = 0; ( SMC37c669_drq_table[i].isa_drq != -1 ) || ( SMC37c669_drq_table[i].device_drq != -1 ); i++ ) {
-	    if ( drq == SMC37c669_drq_table[i].isa_drq ) {
+	    if ( (signed)drq == SMC37c669_drq_table[i].isa_drq ) {
 	    	translated_drq = SMC37c669_drq_table[i].device_drq;
 		break;
 	    }
diff -ur linux-2.5.46/arch/alpha/kernel/smp.c linux-2.5.46-ds20/arch/alpha/kernel/smp.c
--- linux-2.5.46/arch/alpha/kernel/smp.c	Sat Oct 19 04:01:19 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/smp.c	Wed Nov  6 20:49:26 2002
@@ -499,7 +499,7 @@
 setup_smp(void)
 {
 	struct percpu_struct *cpubase, *cpu;
-	int i;
+	unsigned int i;
 
 	if (boot_cpuid != 0) {
 		printk(KERN_WARNING "SMP: Booting off cpu %d instead of 0?\n",
diff -ur linux-2.5.46/arch/alpha/kernel/time.c linux-2.5.46-ds20/arch/alpha/kernel/time.c
--- linux-2.5.46/arch/alpha/kernel/time.c	Sat Oct 19 04:01:54 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/time.c	Wed Nov  6 20:50:48 2002
@@ -316,7 +316,7 @@
 		diff = cycle_freq - est_cycle_freq;
 		if (diff < 0)
 			diff = -diff;
-		if (diff > one_percent) {
+		if ((unsigned)diff > one_percent) {
 			cycle_freq = est_cycle_freq;
 			printk("HWRPB cycle frequency bogus.  "
 			       "Estimated %lu Hz\n", cycle_freq);
diff -ur linux-2.5.46/arch/alpha/kernel/traps.c linux-2.5.46-ds20/arch/alpha/kernel/traps.c
--- linux-2.5.46/arch/alpha/kernel/traps.c	Wed Nov  6 19:04:14 2002
+++ linux-2.5.46-ds20/arch/alpha/kernel/traps.c	Wed Nov  6 21:00:46 2002
@@ -406,7 +406,7 @@
 	info.si_signo = SIGILL;
 	info.si_errno = 0;
 	info.si_code = ILL_ILLOPC;
-	info.si_addr = regs.pc;
+	info.si_addr = (void *)regs.pc;
 	send_sig_info(SIGILL, &info, current);
 }
 
@@ -429,7 +429,7 @@
 	info.si_signo = SIGILL;
 	info.si_errno = 0;
 	info.si_code = ILL_ILLOPC;
-	info.si_addr = regs.pc;
+	info.si_addr = (void *)regs.pc;
 	force_sig_info(SIGILL, &info, current);
 }
 
diff -ur linux-2.5.46/arch/alpha/lib/fpreg.c linux-2.5.46-ds20/arch/alpha/lib/fpreg.c
--- linux-2.5.46/arch/alpha/lib/fpreg.c	Sat Oct 19 04:02:24 2002
+++ linux-2.5.46-ds20/arch/alpha/lib/fpreg.c	Wed Nov  6 21:05:46 2002
@@ -48,6 +48,7 @@
 	      case 29: STT(29, val); break;
 	      case 30: STT(30, val); break;
 	      case 31: STT(31, val); break;
+	      default: return 0;		/* silence gcc */
 	}
 	return val;
 }
@@ -141,6 +142,7 @@
 	      case 29: STS(29, val); break;
 	      case 30: STS(30, val); break;
 	      case 31: STS(31, val); break;
+	      default: return 0;		/* silence gcc */
 	}
 	return val;
 }
diff -ur linux-2.5.46/arch/alpha/lib/io.c linux-2.5.46-ds20/arch/alpha/lib/io.c
--- linux-2.5.46/arch/alpha/lib/io.c	Sat Oct 19 04:02:27 2002
+++ linux-2.5.46-ds20/arch/alpha/lib/io.c	Wed Nov  6 21:07:48 2002
@@ -414,7 +414,7 @@
 	/* Optimize co-aligned transfers.  Everything else gets handled
 	   a byte at a time. */
 
-	if (count >= 8 && ((long)to & 7) == (from & 7)) {
+	if (count >= 8 && ((unsigned long)to & 7) == (from & 7)) {
 		count -= 8;
 		do {
 			*(u64 *)to = __raw_readq(from);
@@ -425,7 +425,7 @@
 		count += 8;
 	}
 
-	if (count >= 4 && ((long)to & 3) == (from & 3)) {
+	if (count >= 4 && ((unsigned long)to & 3) == (from & 3)) {
 		count -= 4;
 		do {
 			*(u32 *)to = __raw_readl(from);
@@ -436,7 +436,7 @@
 		count += 4;
 	}
 		
-	if (count >= 2 && ((long)to & 1) == (from & 1)) {
+	if (count >= 2 && ((unsigned long)to & 1) == (from & 1)) {
 		count -= 2;
 		do {
 			*(u16 *)to = __raw_readw(from);
@@ -465,7 +465,7 @@
 	   a byte at a time. */
 	/* FIXME -- align FROM.  */
 
-	if (count >= 8 && (to & 7) == ((long)from & 7)) {
+	if (count >= 8 && (to & 7) == ((unsigned long)from & 7)) {
 		count -= 8;
 		do {
 			__raw_writeq(*(const u64 *)from, to);
@@ -476,7 +476,7 @@
 		count += 8;
 	}
 
-	if (count >= 4 && (to & 3) == ((long)from & 3)) {
+	if (count >= 4 && (to & 3) == ((unsigned long)from & 3)) {
 		count -= 4;
 		do {
 			__raw_writel(*(const u32 *)from, to);
@@ -487,7 +487,7 @@
 		count += 4;
 	}
 		
-	if (count >= 2 && (to & 1) == ((long)from & 1)) {
+	if (count >= 2 && (to & 1) == ((unsigned long)from & 1)) {
 		count -= 2;
 		do {
 			__raw_writew(*(const u16 *)from, to);
diff -ur linux-2.5.46/arch/alpha/mm/init.c linux-2.5.46-ds20/arch/alpha/mm/init.c
--- linux-2.5.46/arch/alpha/mm/init.c	Sat Oct 19 04:02:30 2002
+++ linux-2.5.46-ds20/arch/alpha/mm/init.c	Wed Nov  6 21:08:53 2002
@@ -242,7 +242,7 @@
 	if (alpha_using_srm) {
 		static struct vm_struct console_remap_vm;
 		unsigned long vaddr = VMALLOC_START;
-		long i, j;
+		unsigned long i, j;
 
 		/* Set up the third level PTEs and update the virtual
 		   addresses of the CRB entries.  */


-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
