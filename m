Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWCNI3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWCNI3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWCNI3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:29:40 -0500
Received: from fmr18.intel.com ([134.134.136.17]:12697 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932132AbWCNI3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:29:37 -0500
Subject: Re: [PATCH] kexec for ia64
From: Zou Nan hai <nanhai.zou@intel.com>
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <1142271576.10787.15.camel@lyra.fc.hp.com>
References: <1142271576.10787.15.camel@lyra.fc.hp.com>
Content-Type: multipart/mixed; boundary="=-bUMkokKWzqVIk8JW9W6V"
Organization: 
Message-Id: <1142318909.2545.4.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Mar 2006 14:48:30 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bUMkokKWzqVIk8JW9W6V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-03-14 at 01:39, Khalid Aziz wrote:
> I have updated kexec patch for ia64. Attached patch fixes a couple of
> bugs from previous version and incorporates code developed by Nan Hai.
> This patch works on 2.6.16-rc6 kernel. Also attached is a patch for
> kexec-tools which applies on top of kexec-tools-1.101 release from Eric
> Biederman <http://www.xmission.com/%
> 7Eebiederm/files/kexec/kexec-tools-1.101.tar.gz> and adds support for
> ia64. Please test and provide feedback.
> 
> I am working on integrating kdump support and will post that patch once
> I have tested it.


Thanks for merging the patches,

Some issues in the patches.
1. in machine_crash_shutdown 
we can't call device_shutdown, because device or device driver may fail
at this point.
call to machine_shutdown is unnecessary, because high level code will
call it.

2. I am afraid
#ifdef ...
#include ...
#endif 
is not the linux including style, ifdefs are already in header file, you
just need to include the header. and there is also some unnecessary extern declares in your code.

3. Is the set ar.k0 code necessary? ar.k0 is already holding the right
value.

4. Is the VHPT disable code necessary? kernel will soon goes into
Physical mode and the new kernel will reset VHPT walker.

5. Is the PCI disable code too complex?

The overall concern is I am afraid the code is too much than
necessary. 

Attach is the kdump patches which I have sent to you for merging.
I post it to community for early test on various platforms before 
merging is done.

the first patch applies to 2.6.15 kernel

the second patch applies to kexec-tools-1.101 and the generic
kexec-tools-1.101-kdump.patch

to test kexec, build the kernel with CPU_HOTPLUG and kexec enabled, 
reboot to this kernel.
kexec -l vmlinux.gz --initrd="...." --append="...."
kexec -e

the second kernel can be any kernel even an 2.4 based kernel...

to test kdump, build the first kernel with kdump enabled, 
you may need to enable sysrq support to help you trigger a crash.

Build a second crashdumping UP kernel with pseudo proc fs vmcore
enabled.

boot to first kernel with kernel parameter crashkernel=XXXM@YYYM which
means reserve XXXM memory at physical address YYYM for crashdumping
kernel.

then kexec -p crash-kernel-vmlinux.gz --initrd="...." --append="...."

echo c > /proc/sysre-trigger
to tigger a crash.

Then the crash dumping kernel boots, log into the crash dumping kernel,
cp /proc/vmcore core

gdb first-kernel-vmlinux core

Thanks
Zou Nan hai








--=-bUMkokKWzqVIk8JW9W6V
Content-Disposition: attachment; filename=ia64-kexec-kdump-2.6.15.patch
Content-Type: text/x-patch; name=ia64-kexec-kdump-2.6.15.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nraup a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	2006-03-01 07:57:10.000000000 +0800
+++ b/arch/ia64/Kconfig	2006-03-01 08:45:15.000000000 +0800
@@ -374,6 +374,23 @@ config IA64_PALINFO
 	  To use this option, you have to ensure that the "/proc file system
 	  support" (CONFIG_PROC_FS) is enabled, too.
 
+config KEXEC
+       bool "kexec system call (EXPERIMENTAL)"
+       depends on EXPERIMENTAL && (!SMP || HOTPLUG_CPU)
+       help
+         kexec is a system call that implements the ability to shutdown your
+         current kernel, and to start another kernel.  It is like a reboot
+         but it is indepedent of the system firmware.   And like a reboot
+         you can start any kernel with it, not just Linux.
+
+         The name comes from the similiarity to the exec system call.
+
+config CRASH_DUMP
+        bool "kernel crash dumps (EXPERIMENTAL)"
+        depends on EXPERIMENTAL
+        help
+          Generate crash dump after being started by kexec.
+
 source "drivers/firmware/Kconfig"
 
 source "fs/Kconfig.binfmt"
diff -Nraup a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
--- a/arch/ia64/kernel/crash.c	1970-01-01 08:00:00.000000000 +0800
+++ b/arch/ia64/kernel/crash.c	2006-03-01 08:44:30.000000000 +0800
@@ -0,0 +1,104 @@
+/*
+ *  arch/ia64/kernel/crash.c
+ *
+ *  Copyright (C) 2005 Intel Corp
+ *  Zou Nan hai <nanhai.zou@intel.com>
+ */
+#include <linux/smp.h>
+#include <linux/kexec.h>
+#include <linux/pci.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+
+note_buf_t crash_notes[NR_CPUS];
+
+static void device_shootdown(void)
+{
+       struct pci_dev *dev;
+       irq_desc_t *desc;
+       u16 pci_command;
+
+       list_for_each_entry(dev, &pci_devices, global_list) {
+	       desc = irq_descp(dev->irq);
+	       if (!desc->action)
+		       continue;
+	       pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+	       if (pci_command & PCI_COMMAND_MASTER) {
+		       pci_command &= ~PCI_COMMAND_MASTER;
+		       pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	       }
+	       disable_irq_nosync(dev->irq);
+	       desc->handler->end(dev->irq);
+       }
+}
+
+static Elf64_Word *append_elf_note(Elf64_Word *buf, char *name, 
+		unsigned type, void *data,
+		size_t data_len)
+{
+        struct elf_note *note = (struct elf_note *)buf;
+        note->n_namesz = strlen(name) + 1;
+        note->n_descsz = data_len;
+        note->n_type   = type;
+        buf += (sizeof(*note) + 3)/4;
+        memcpy(buf, name, note->n_namesz);
+        buf += (note->n_namesz + 3)/4;
+        memcpy(buf, data, data_len);
+        buf += (data_len + 3)/4;
+        return buf;
+}
+
+static void final_note(void *buf)
+{
+	memset(buf, 0, sizeof(struct elf_note));
+}
+
+static void crash_save_this_cpu(void)
+{
+	void *buf;
+	struct elf_prstatus prstatus;
+	int cpu = smp_processor_id();
+	elf_greg_t *dst = (elf_greg_t *)&prstatus.pr_reg;
+
+	memset(&prstatus, 0, sizeof(prstatus));
+	prstatus.pr_pid = current->pid;
+
+    	dst[1] = ia64_getreg(_IA64_REG_GP);
+    	dst[12] = ia64_getreg(_IA64_REG_SP);
+    	dst[13] = ia64_getreg(_IA64_REG_TP);
+
+    	dst[42] = ia64_getreg(_IA64_REG_IP);
+    	dst[45] = ia64_getreg(_IA64_REG_AR_RSC);
+
+	ia64_setreg(_IA64_REG_AR_RSC, 0);		
+	ia64_srlz_i();
+
+    	dst[46] = ia64_getreg(_IA64_REG_AR_BSP);
+    	dst[47] = ia64_getreg(_IA64_REG_AR_BSPSTORE);
+	
+    	dst[48] = ia64_getreg(_IA64_REG_AR_RNAT);
+    	dst[49] = ia64_getreg(_IA64_REG_AR_CCV);
+    	dst[50] = ia64_getreg(_IA64_REG_AR_UNAT);
+	
+    	dst[51] = ia64_getreg(_IA64_REG_AR_FPSR);
+    	dst[52] = ia64_getreg(_IA64_REG_AR_PFS);
+    	dst[53] = ia64_getreg(_IA64_REG_AR_LC);
+	
+    	dst[54] = ia64_getreg(_IA64_REG_AR_LC);
+    	dst[55] = ia64_getreg(_IA64_REG_AR_CSD);
+    	dst[56] = ia64_getreg(_IA64_REG_AR_SSD);
+
+	buf = &crash_notes[cpu][0];
+	buf = append_elf_note(buf, "CORE", NT_PRSTATUS, &prstatus,
+		sizeof(prstatus));
+	final_note(buf);
+}
+
+void machine_crash_shutdown(void)
+{
+	crash_save_this_cpu();
+	device_shootdown();
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+}
diff -Nraup a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
--- a/arch/ia64/kernel/efi.c	2006-03-01 07:57:10.000000000 +0800
+++ b/arch/ia64/kernel/efi.c	2006-03-01 08:44:30.000000000 +0800
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/efi.h>
+#include <linux/kexec.h>
 
 #include <asm/io.h>
 #include <asm/kregs.h>
@@ -40,7 +41,7 @@ extern efi_status_t efi_call_phys (void 
 struct efi efi;
 EXPORT_SYMBOL(efi);
 static efi_runtime_services_t *runtime;
-static unsigned long mem_limit = ~0UL, max_addr = ~0UL;
+static unsigned long mem_limit = ~0UL, max_addr = ~0UL, min_addr = 0UL;
 
 #define efi_call_virt(f, args...)	(*(f))(args)
 
@@ -384,24 +385,18 @@ efi_init (void)
 	efi_config_table_t *config_tables;
 	efi_char16_t *c16;
 	u64 efi_desc_size;
-	char *cp, *end, vendor[100] = "unknown";
+	char *cp, vendor[100] = "unknown";
 	extern char saved_command_line[];
 	int i;
 
 	/* it's too early to be able to use the standard kernel command line support... */
 	for (cp = saved_command_line; *cp; ) {
 		if (memcmp(cp, "mem=", 4) == 0) {
-			cp += 4;
-			mem_limit = memparse(cp, &end);
-			if (end != cp)
-				break;
-			cp = end;
+			mem_limit = memparse(cp + 4, &cp);
 		} else if (memcmp(cp, "max_addr=", 9) == 0) {
-			cp += 9;
-			max_addr = GRANULEROUNDDOWN(memparse(cp, &end));
-			if (end != cp)
-				break;
-			cp = end;
+			max_addr = GRANULEROUNDDOWN(memparse(cp + 9, &cp));
+		} else if (memcmp(cp, "min_addr=", 9) == 0) {
+			min_addr = GRANULEROUNDDOWN(memparse(cp + 9, &cp));
 		} else {
 			while (*cp != ' ' && *cp)
 				++cp;
@@ -409,9 +404,11 @@ efi_init (void)
 				++cp;
 		}
 	}
+
+	if (min_addr != 0UL)
+		printk(KERN_INFO "Ignoring memory below %luMB\n", min_addr >> 20);
 	if (max_addr != ~0UL)
 		printk(KERN_INFO "Ignoring memory above %luMB\n", max_addr >> 20);
-
 	efi.systab = __va(ia64_boot_param->efi_systab);
 
 	/*
@@ -785,7 +782,8 @@ find_memmap_space (void)
 		as = max(contig_low, md->phys_addr);
 		ae = min(contig_high, efi_md_end(md));
 
-		/* keep within max_addr= command line arg */
+		/* keep within max_addr= and min_addr= command line arg */
+		as = max(as, min_addr);
 		ae = min(ae, max_addr);
 		if (ae <= as)
 			continue;
@@ -895,7 +893,8 @@ efi_memmap_init(unsigned long *s, unsign
 		} else
 			ae = efi_md_end(md);
 
-		/* keep within max_addr= command line arg */
+		/* keep within max_addr= and min_addr command line arg */
+		as = max(as, min_addr);
 		ae = min(ae, max_addr);
 		if (ae <= as)
 			continue;
@@ -1007,6 +1006,11 @@ efi_initialize_iomem_resources(struct re
 			 */
 			insert_resource(res, code_resource);
 			insert_resource(res, data_resource);
+#ifdef CONFIG_KEXEC
+			if (crashk_res.end > crashk_res.start)
+				insert_resource(res, &crashk_res);
+#endif
+
 		}
 	}
 }
diff -Nraup a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
--- a/arch/ia64/kernel/entry.S	2006-03-01 07:57:10.000000000 +0800
+++ b/arch/ia64/kernel/entry.S	2006-03-01 08:44:30.000000000 +0800
@@ -1588,7 +1588,7 @@ sys_call_table:
 	data8 sys_mq_timedreceive		// 1265
 	data8 sys_mq_notify
 	data8 sys_mq_getsetattr
-	data8 sys_ni_syscall			// reserved for kexec_load
+	data8 sys_kexec_load
 	data8 sys_ni_syscall			// reserved for vserver
 	data8 sys_waitid			// 1270
 	data8 sys_add_key
diff -Nraup a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
--- a/arch/ia64/kernel/machine_kexec.c	1970-01-01 08:00:00.000000000 +0800
+++ b/arch/ia64/kernel/machine_kexec.c	2006-03-01 08:44:30.000000000 +0800
@@ -0,0 +1,67 @@
+/*
+ *  arch/ia64/kernel/machine_exec.c
+ *
+ *  Copyright (C) 2005 Intel Corp
+ *  Zou Nan hai <nanhai.zou@intel.com>
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/cpu.h>
+#include <linux/kexec.h>
+#include <asm/meminit.h>
+#include <asm/delay.h>
+
+int
+machine_kexec_prepare(struct kimage * image)
+{
+       return 0;
+}
+
+void
+machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+void
+machine_shutdown(void)
+{
+#ifdef CONFIG_SMP
+	int cpu;
+        for_each_online_cpu(cpu) {
+                if (cpu != smp_processor_id())
+                        cpu_down(cpu);
+        }
+#endif
+	printk(KERN_INFO "kexec: machine_shutdown called\n");
+}
+
+const extern unsigned char relocate_new_kernel[];
+const extern unsigned long relocate_new_kernel_size;
+typedef void (*relocate_kernel_t) (unsigned long, kimage_entry_t, void *,
+	unsigned long);
+
+extern void *efi_get_pal_addr(void);
+
+NORET_TYPE void
+machine_kexec(struct kimage *image)
+{
+	relocate_kernel_t relocator;
+	void *pal_addr = efi_get_pal_addr();
+	unsigned long
+	code_addr = (unsigned long)page_address(image->control_code_page);
+
+	ia64_set_itv(1<<16);
+	local_irq_disable();
+	relocator = (relocate_kernel_t)&code_addr;
+        memcpy((void *)code_addr, relocate_new_kernel,
+			relocate_new_kernel_size);
+	flush_icache_range(code_addr, code_addr + relocate_new_kernel_size);
+
+	(*relocator)(image->start, image->head, ia64_boot_param,
+			GRANULEROUNDDOWN((unsigned long) pal_addr));
+	BUG();
+
+	for(;;);
+
+}
diff -Nraup a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
--- a/arch/ia64/kernel/Makefile	2006-03-01 07:57:10.000000000 +0800
+++ b/arch/ia64/kernel/Makefile	2006-03-01 08:44:30.000000000 +0800
@@ -23,6 +23,7 @@ obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
+obj-$(CONFIG_KEXEC)             += machine_kexec.o crash.o relocate_kernel.o
 obj-$(CONFIG_IA64_UNCACHED_ALLOCATOR)	+= uncached.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
diff -Nraup a/arch/ia64/kernel/relocate_kernel.S b/arch/ia64/kernel/relocate_kernel.S
--- a/arch/ia64/kernel/relocate_kernel.S	1970-01-01 08:00:00.000000000 +0800
+++ b/arch/ia64/kernel/relocate_kernel.S	2006-03-01 08:44:30.000000000 +0800
@@ -0,0 +1,187 @@
+/*
+ *  arch/ia64/kernel/relocate_kernel.S
+ *
+ *  Copyright (C) 2005 Intel Corp
+ *  Zou Nan hai <nanhai.zou@intel.com>
+ */
+#include <asm/asmmacro.h>
+#include <asm/kregs.h>
+#include <asm/pgtable.h>
+#include <asm/mca_asm.h>
+
+/* relocate new kernel
+ * => switch to physical mode
+ * => purge all TC and TR entries
+ * => go through kimage page_list to copy segments
+ * => clear system state
+ * => call to entry in physical mode
+ */
+
+GLOBAL_ENTRY(relocate_new_kernel)
+	.prologue
+	alloc r31=ar.pfs,4,0,0,0
+        .body
+.here:
+{
+	rsm psr.i| psr.ic
+	mov r15=ip
+}
+	;;
+{
+        flushrs                         // must be first insn in group
+        srlz.i
+}
+	;;
+
+	//first switch to physical mode
+	add r3=1f-.here, r15
+	movl r16 = IA64_PSR_AC|IA64_PSR_BN|IA64_PSR_IC
+	mov ar.rsc=0	          	// put RSE in enforced lazy mode
+	;;
+	add r2=__reloc_stack-.here, r15
+	;;
+	add sp=8192-16, r2
+	;;
+	tpa sp=sp
+	tpa r3=r3
+	;;
+	mov r18=ar.rnat
+	mov ar.bspstore=r2
+	;;
+        mov cr.ipsr=r16
+        mov cr.iip=r3
+        mov cr.ifs=r0
+	srlz.i
+	;;
+	mov ar.rnat=r18
+	rfi
+	;;
+1:
+	//physical mode code begin
+	mov b6=in0
+	tpa r28=in2			// tpa must before TLB purge
+
+	// purge all TC entries
+#define O(member)       IA64_CPUINFO_##member##_OFFSET
+        GET_THIS_PADDR(r2, cpu_info)    // load phys addr of cpu_info into r2
+        ;;
+        addl r17=O(PTCE_STRIDE),r2
+        addl r2=O(PTCE_BASE),r2
+        ;;
+        ld8 r18=[r2],(O(PTCE_COUNT)-O(PTCE_BASE));;    	// r18=ptce_base
+        ld4 r19=[r2],4                                  // r19=ptce_count[0]
+        ld4 r21=[r17],4                                 // r21=ptce_stride[0]
+        ;;
+        ld4 r20=[r2]                                    // r20=ptce_count[1]
+        ld4 r22=[r17]                                   // r22=ptce_stride[1]
+        mov r24=r0
+        ;;
+        adds r20=-1,r20
+        ;;
+#undef O
+2:
+        cmp.ltu p6,p7=r24,r19
+(p7)    br.cond.dpnt.few 4f
+        mov ar.lc=r20
+3:
+        ptc.e r18
+        ;;
+        add r18=r22,r18
+        br.cloop.sptk.few 3b
+        ;;
+        add r18=r21,r18
+        add r24=1,r24
+        ;;
+        br.sptk.few 2b
+4:
+        srlz.i
+        ;;
+	//purge TR entry for kernel text and data
+        movl r16=KERNEL_START
+        mov r18=KERNEL_TR_PAGE_SHIFT<<2
+        ;;
+        ptr.i r16, r18
+        ptr.d r16, r18
+        ;;
+        srlz.i
+        ;;
+
+	// purge TR entry for percpu data
+        movl r16=PERCPU_ADDR
+        mov r18=PERCPU_PAGE_SHIFT<<2
+        ;;
+        ptr.d r16,r18
+        ;;
+        srlz.d
+
+        // purge TR entry for stack
+        mov r16=IA64_KR(CURRENT_STACK)
+        ;;
+        shl r16=r16,IA64_GRANULE_SHIFT
+        movl r19=PAGE_OFFSET
+        ;;
+        add r16=r19,r16
+        mov r18=IA64_GRANULE_SHIFT<<2
+        ;;
+        ptr.d r16,r18
+        ;;
+        srlz.i
+	;;
+
+        // purge TR entry for pal code
+        mov r16=in3
+        mov r18=IA64_GRANULE_SHIFT<<2
+        ;;
+        ptr.i r16,r18
+        ;;
+        srlz.i
+	;;
+
+	// copy segments
+	movl r16=PAGE_MASK
+	mov  r30=in1			// in1 is page_list
+	br.sptk.few .dest_page
+	;;
+.loop:
+	ld8  r30=[in1], 8;;
+.dest_page:
+	tbit.z p0, p6=r30, 0;;    	// 0x1 dest page
+(p6)	and r17=r30, r16
+(p6)	br.cond.sptk.few .loop;;
+
+	tbit.z p0, p6=r30, 1;;		// 0x2 indirect page
+(p6)	and in1=r30, r16
+(p6)	br.cond.sptk.few .loop;;
+
+	tbit.z p0, p6=r30, 2;;		// 0x4 end flag
+(p6)	br.cond.sptk.few .end_loop;;
+
+	tbit.z p6, p0=r30, 3;;		// 0x8 source page
+(p6)	br.cond.sptk.few .loop
+
+	and r18=r30, r16
+
+	// simple copy page, may optimize later
+	movl r14=PAGE_SIZE/8 - 1;;
+	mov ar.lc=r14;;
+1:
+	ld8 r14=[r18], 8;;
+	st8 [r17]=r14, 8;;
+	fc.i r17
+	br.ctop.sptk.few 1b
+	br.sptk.few .loop
+	;;
+
+.end_loop:
+	sync.i			// for fc.i
+	;;
+	srlz.i
+	;;
+	br.call.sptk.many b0=b6;;
+__reloc_stack:
+.skip 8192
+relocate_new_kernel_end:
+END(relocate_new_kernel)
+	.global relocate_new_kernel_size
+relocate_new_kernel_size:
+	data8	relocate_new_kernel_end - relocate_new_kernel
diff -Nraup a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c	2006-03-01 07:57:10.000000000 +0800
+++ b/arch/ia64/kernel/setup.c	2006-03-01 08:44:30.000000000 +0800
@@ -43,6 +43,8 @@
 #include <linux/initrd.h>
 #include <linux/platform.h>
 #include <linux/pm.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 #include <asm/ia32.h>
 #include <asm/machvec.h>
@@ -247,6 +249,32 @@ reserve_memory (void)
 	}
 #endif
 
+#ifdef CONFIG_KEXEC
+	/* crashkernel=size@addr specifies the location to reserve for
+	 * a crash kernel.  By reserving this memory we guarantee
+	 * that linux never set's it up as a DMA target.
+	 * Useful for holding code to do something appropriate
+	 * after a kernel panic.
+	 */
+	{
+		char *from = strstr(saved_command_line, "crashkernel=");
+		if (from) {
+			unsigned long size, base;
+			size = memparse(from + 12, &from);
+			if (*from == '@') {
+				base = memparse(from + 1, &from);
+				rsvd_region[n].start =
+					(unsigned long)__va(base);
+				rsvd_region[n].end =
+					(unsigned long)__va(base + size);
+				crashk_res.start = base;
+				crashk_res.end = base + size - 1;
+				n++;
+			}
+		}
+	}
+#endif
+
 	efi_memmap_init(&rsvd_region[n].start, &rsvd_region[n].end);
 	n++;
 
@@ -489,6 +517,16 @@ setup_arch (char **cmdline_p)
 	if (!strstr(saved_command_line, "nomca"))
 		ia64_mca_init();
 
+#ifdef CONFIG_CRASH_DUMP
+        {
+                char *from = strstr(saved_command_line, "elfcorehdr=");
+                if (from)
+                        elfcorehdr_addr = memparse(from+11, &from);
+
+                saved_max_pfn = (unsigned long) -1;
+        }
+#endif
+
 	platform_setup(cmdline_p);
 	paging_init();
 }
diff -Nraup a/include/asm/kexec.h b/include/asm/kexec.h
--- a/include/asm/kexec.h	1970-01-01 08:00:00.000000000 +0800
+++ b/include/asm/kexec.h	2006-03-01 08:44:30.000000000 +0800
@@ -0,0 +1,29 @@
+#ifndef _IA64_KEXEC_H
+#define _IA64_KEXEC_H
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * Someone correct me if FIXADDR_START - PAGEOFFSET is not the correct
+ * calculation for the amount of memory directly mappable into the
+ * kernel memory space.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+/* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
+
+#define KEXEC_CONTROL_CODE_SIZE        (1UL << 14)
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_IA_64
+
+#define MAX_NOTE_BYTES 1024
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+extern note_buf_t crash_notes[];
+#endif
diff -Nraup a/include/asm/meminit.h b/include/asm/meminit.h
--- a/include/asm/meminit.h	2006-03-01 07:57:10.000000000 +0800
+++ b/include/asm/meminit.h	2006-03-01 08:44:30.000000000 +0800
@@ -16,11 +16,12 @@
  * 	- initrd (optional)
  * 	- command line string
  * 	- kernel code & data
+ *	- crash dumping code reserved region
  * 	- Kernel memory map built from EFI memory map
  *
  * More could be added if necessary
  */
-#define IA64_MAX_RSVD_REGIONS 6
+#define IA64_MAX_RSVD_REGIONS 7
 
 struct rsvd_region {
 	unsigned long start;	/* virtual address of beginning of element */
diff -Nraup a/include/asm-ia64/kexec.h b/include/asm-ia64/kexec.h
--- a/include/asm-ia64/kexec.h	1970-01-01 08:00:00.000000000 +0800
+++ b/include/asm-ia64/kexec.h	2006-03-01 08:44:30.000000000 +0800
@@ -0,0 +1,29 @@
+#ifndef _IA64_KEXEC_H
+#define _IA64_KEXEC_H
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * Someone correct me if FIXADDR_START - PAGEOFFSET is not the correct
+ * calculation for the amount of memory directly mappable into the
+ * kernel memory space.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+/* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
+
+#define KEXEC_CONTROL_CODE_SIZE        (1UL << 14)
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_IA_64
+
+#define MAX_NOTE_BYTES 1024
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+extern note_buf_t crash_notes[];
+#endif
diff -Nraup a/include/asm-ia64/meminit.h b/include/asm-ia64/meminit.h
--- a/include/asm-ia64/meminit.h	2006-03-01 07:57:10.000000000 +0800
+++ b/include/asm-ia64/meminit.h	2006-03-01 08:44:30.000000000 +0800
@@ -16,11 +16,12 @@
  * 	- initrd (optional)
  * 	- command line string
  * 	- kernel code & data
+ *	- crash dumping code reserved region
  * 	- Kernel memory map built from EFI memory map
  *
  * More could be added if necessary
  */
-#define IA64_MAX_RSVD_REGIONS 6
+#define IA64_MAX_RSVD_REGIONS 7
 
 struct rsvd_region {
 	unsigned long start;	/* virtual address of beginning of element */
diff -Nraup a/include/linux/kexec.h b/include/linux/kexec.h
--- a/include/linux/kexec.h	2006-03-01 07:57:10.000000000 +0800
+++ b/include/linux/kexec.h	2006-03-01 08:44:30.000000000 +0800
@@ -41,7 +41,7 @@ typedef unsigned long kimage_entry_t;
 #define IND_DONE         0x4
 #define IND_SOURCE       0x8
 
-#define KEXEC_SEGMENT_MAX 8
+#define KEXEC_SEGMENT_MAX 16
 struct kexec_segment {
 	void __user *buf;
 	size_t bufsz;

--=-bUMkokKWzqVIk8JW9W6V
Content-Disposition: attachment; filename=ia64-kexec-tool-kdump.patch.gz
Content-Type: application/x-gzip; name=ia64-kexec-tool-kdump.patch.gz
Content-Transfer-Encoding: base64

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

--=-bUMkokKWzqVIk8JW9W6V--

