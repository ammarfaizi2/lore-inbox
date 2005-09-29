Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVI2XEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVI2XEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVI2XEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:04:14 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:31455 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751334AbVI2XEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:04:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Fri, 30 Sep 2005 01:04:35 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
References: <200509281624.29256.rjw@sisk.pl> <200509300001.10258.rjw@sisk.pl> <20050929152914.A15943@unix-os.sc.intel.com>
In-Reply-To: <20050929152914.A15943@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EMHPDVpeZZAKXHu"
Message-Id: <200509300104.36454.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_EMHPDVpeZZAKXHu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday, 30 of September 2005 00:29, Siddha, Suresh B wrote:
> On Fri, Sep 30, 2005 at 12:01:08AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, 29 of September 2005 02:00, Siddha, Suresh B wrote:
> > > 
> > > My patch as such shouldn't change the behavior of the existing swsup
> > > code. I am making only boot_level4_pgt as initdata. But not the 
> > > init_level4_pgt.
> > 
> > Suresh, unfortunately the kernel does not boot with your patch, because
> 
> Did you try just only my patch on top of 2.6.14-rc2? You can get that
> patch from http://www.x86-64.org/lists/discuss/msg07313.html

The patch that I tested is attached.  I think it's the same one.  I've just applied
it on top of 2.6.14-rc2-git7, and it doesn't boot.

> > it clears init_level4_pgt.
> 
> what is wrong with zapping low mappings? Looks like someother change
> you are trying assumes that low mappings are always present in init_level4_pgt,
> which is wrong..

Nope.

The problem (as I see it) is this:
In x86_64_start_kernel() you copy boot_level4_pgt[] into init_level4_pgt[],
and you make the latter your current PGD by loading cr3 with its address.
Fine.  With this PGD you call start_kernel() which calls setup_arch(), which
calls zap_low_mappings(0) that fills init_level4_pgt[] (which at this moment
is still your current PGD) with zeros ...

> > +++ linux-2.6.14-rc2-git7/arch/x86_64/mm/init.c	2005-09-29 22:13:55.000000000 +0200
> > @@ -313,7 +313,7 @@
> >  void __cpuinit zap_low_mappings(int cpu)
> >  {
> >  	if (cpu == 0) {
> > -		pgd_t *pgd = pgd_offset_k(0UL);
> > +		pgd_t *pgd = boot_level4_pgt;
> >  		pgd_clear(pgd);
> 
> Don't do this. Its wrong.

Perhaps it is.
 
> Please send me your patch that you are having problems with. I can take 
> a look at it.

I'll post it in a while to the list.  I'm not touching the init code anyway and
the box hangs before it has a chance to send anything to the serial console.

Greetings,
Rafael

--Boundary-00=_EMHPDVpeZZAKXHu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="init-and-zap-low-address-mappings-on-demand-for-cpu-hotplug.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="init-and-zap-low-address-mappings-on-demand-for-cpu-hotplug.patch"

=46rom suresh.b.siddha@intel.com Tue Sep 27 01:19:51 2005
Return-Path: <discuss-return-7231-rjwysocki=3Dsisk.pl@x86-64.org>
Received: from murder ([unix socket])
	 by ogre.sisk.pl (Cyrus v2.2.12) with LMTPA;
	 Tue, 27 Sep 2005 01:16:05 +0200
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 3F4BA70D0
	for <rafael@ogre.sisk.pl>; Tue, 27 Sep 2005 01:16:05 +0200 (CEST)
Received: from anf141.internetdsl.tpnet.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESM=
TP
 id 23839-03 for <rafael@ogre.sisk.pl>; Tue, 27 Sep 2005 01:16:01 +0200 (CE=
ST)
Received: from opteron.x86-64.org (opteron.x86-64.org [65.74.133.13])
	by ogre.sisk.pl (Postfix) with SMTP id A25FD70B9
	for <rjwysocki@sisk.pl>; Tue, 27 Sep 2005 01:16:00 +0200 (CEST)
Received: (qmail 28628 invoked by alias); 26 Sep 2005 23:20:38 -0000
Mailing-List: contact discuss-help@x86-64.org; run by ezmlm
Precedence: bulk
List-Post: <mailto:discuss@x86-64.org>
List-Help: <mailto:discuss-help@x86-64.org>
List-Unsubscribe: <mailto:discuss-unsubscribe@x86-64.org>
List-Subscribe: <mailto:discuss-subscribe@x86-64.org>
Delivered-To: mailing list discuss@x86-64.org
Received: (qmail 28615 invoked by uid 518); 26 Sep 2005 23:20:37 -0000
X-Envelope-From: sbsiddha@unix-os.sc.intel.com
Date: Mon, 26 Sep 2005 16:19:51 -0700
=46rom: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org,
 akpm@osdl.org,
 discuss@x86-64.org
Message-ID: <20050926161951.A6640@unix-os.sc.intel.com>
References: <20050921135731.B14439@unix-os.sc.intel.com> <20050922094818.GB=
79762@muc.de> <20050923172855.D12631@unix-os.sc.intel.com> <20050926065856.=
GA99750@muc.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset=3Dus-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050926065856.GA99750@muc.de>; from ak@muc.de on Mon, Sep 26=
, 2005 at 08:58:56AM +0200
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Subject: [discuss] Re: init and zap low address mappings on demand for cpu =
hotplug
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
X-UID: 16375
X-Length: 12549
Status: RO
X-Status: RC
X-KMail-EncryptionState: N
X-KMail-SignatureState: N
X-KMail-MDN-Sent: =20

On Mon, Sep 26, 2005 at 08:58:56AM +0200, Andi Kleen wrote:
> Looks good. Thanks Suresh. The boot page tables should be marked __initda=
ta
> now, but that can be done in an follow on patch.

Appended new complete patch. Andrew, please apply.

> i386 should probably get similar treatment.

Will do it sometime soon.

=2D-
low address mappings are not zapped after boot as they are required later f=
or=20
cpu hotplug. These identity mapped low address mappings cause corruption=20
when udev process is spawned early in boot. Since these low mappings=20
are mapped global, cr3 writes (during context switches to udev process)=20
will not flush these identity low mappings. These low mappings will be=20
used by the kernel when it writes into the udev/hotplug user space,=20
thereby corrupting kernel memory.

Andi Kleen also brought up another point. We should zap these low mappings,=
=20
as soon as possible, so that we can catch kernel bugs more effectively.

This patch introduces boot_level4_pgt, which will always have low identity
addresses mapped. Druing boot, all the processors will use this as their
level4 pgt. On BP, we will switch to init_level4_pgt as soon as we enter
C code and  zap the low mappings as soon as we are done with the usage of=20
identity low mapped addresses. On AP's we will zap the low mappings as=20
soon as we jump to C code.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>

diff -Npru linux-2.6.14-rc1/arch/i386/kernel/acpi/boot.c linux-2.6.14-rc1.h=
ot/arch/i386/kernel/acpi/boot.c
=2D-- linux-2.6.14-rc1/arch/i386/kernel/acpi/boot.c	2005-09-23 16:14:40.326=
091080 -0700
+++ linux-2.6.14-rc1.hot/arch/i386/kernel/acpi/boot.c	2005-09-26 14:49:16.6=
06625368 -0700
@@ -544,7 +544,7 @@ acpi_scan_rsdp(unsigned long start, unsi
 	 * RSDP signature.
 	 */
 	for (offset =3D 0; offset < length; offset +=3D 16) {
=2D		if (strncmp((char *)(start + offset), "RSD PTR ", sig_len))
+		if (strncmp((char *)(__va(start) + offset), "RSD PTR ", sig_len))
 			continue;
 		return (start + offset);
 	}
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/head.S linux-2.6.14-rc1.hot/=
arch/x86_64/kernel/head.S
=2D-- linux-2.6.14-rc1/arch/x86_64/kernel/head.S	2005-09-23 16:14:40.327090=
928 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/head.S	2005-09-26 15:30:20.6450=
34592 -0700
@@ -12,6 +12,7 @@
=20
 #include <linux/linkage.h>
 #include <linux/threads.h>
+#include <linux/init.h>
 #include <asm/desc.h>
 #include <asm/segment.h>
 #include <asm/page.h>
@@ -70,7 +71,7 @@ startup_32:
 	movl	%eax, %cr4
=20
 	/* Setup early boot stage 4 level pagetables */
=2D	movl	$(init_level4_pgt - __START_KERNEL_map), %eax
+	movl	$(boot_level4_pgt - __START_KERNEL_map), %eax
 	movl	%eax, %cr3
=20
 	/* Setup EFER (Extended Feature Enable Register) */
@@ -113,7 +114,7 @@ startup_64:
 	movq	%rax, %cr4
=20
 	/* Setup early boot stage 4 level pagetables. */
=2D	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
+	movq	$(boot_level4_pgt - __START_KERNEL_map), %rax
 	movq	%rax, %cr3
=20
 	/* Check if nx is implemented */
@@ -240,20 +241,10 @@ ljumpvector:
 ENTRY(stext)
 ENTRY(_stext)
=20
=2D	/*
=2D	 * This default setting generates an ident mapping at address 0x100000
=2D	 * and a mapping for the kernel that precisely maps virtual address
=2D	 * 0xffffffff80000000 to physical address 0x000000. (always using
=2D	 * 2Mbyte large pages provided by PAE mode)
=2D	 */
 .org 0x1000
 ENTRY(init_level4_pgt)
=2D	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
=2D	.fill	255,8,0
=2D	.quad	0x000000000000a007 + __PHYSICAL_START
=2D	.fill	254,8,0
=2D	/* (2^48-(2*1024*1024*1024))/(2^39) =3D 511 */
=2D	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
+	/* This gets initialized in x86_64_start_kernel */
+	.fill	512,8,0
=20
 .org 0x2000
 ENTRY(level3_ident_pgt)
@@ -350,6 +341,24 @@ ENTRY(wakeup_level4_pgt)
 	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
 #endif
=20
+#ifndef CONFIG_HOTPLUG_CPU
+	__INITDATA
+#endif
+	/*
+	 * This default setting generates an ident mapping at address 0x100000
+	 * and a mapping for the kernel that precisely maps virtual address
+	 * 0xffffffff80000000 to physical address 0x000000. (always using
+	 * 2Mbyte large pages provided by PAE mode)
+	 */
+	.align PAGE_SIZE
+ENTRY(boot_level4_pgt)
+	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
+	.fill	255,8,0
+	.quad	0x000000000000a007 + __PHYSICAL_START
+	.fill	254,8,0
+	/* (2^48-(2*1024*1024*1024))/(2^39) =3D 511 */
+	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
+
 	.data
=20
 	.align 16
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/head64.c linux-2.6.14-rc1.ho=
t/arch/x86_64/kernel/head64.c
=2D-- linux-2.6.14-rc1/arch/x86_64/kernel/head64.c	2005-09-23 16:14:40.3270=
90928 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/head64.c	2005-09-26 14:52:31.67=
8969864 -0700
@@ -19,6 +19,7 @@
 #include <asm/bootsetup.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
+#include <asm/pgtable.h>
=20
 /* Don't add a printk in there. printk relies on the PDA which is not init=
ialized=20
    yet. */
@@ -86,6 +87,13 @@ void __init x86_64_start_kernel(char * r
 		set_intr_gate(i, early_idt_handler);
 	asm volatile("lidt %0" :: "m" (idt_descr));
 	clear_bss();
+
+	/*
+	 * switch to init_level4_pgt from boot_level4_pgt
+	 */
+	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
+	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+
 	pda_init(0);
 	copy_bootdata(real_mode_data);
 #ifdef CONFIG_SMP
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/setup.c linux-2.6.14-rc1.hot=
/arch/x86_64/kernel/setup.c
=2D-- linux-2.6.14-rc1/arch/x86_64/kernel/setup.c	2005-09-23 16:14:40.32809=
0776 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup.c	2005-09-26 14:49:16.607=
625216 -0700
@@ -571,6 +571,8 @@ void __init setup_arch(char **cmdline_p)
=20
 	init_memory_mapping(0, (end_pfn_map << PAGE_SHIFT));
=20
+	zap_low_mappings(0);
+
 #ifdef CONFIG_ACPI
 	/*
 	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/setup64.c linux-2.6.14-rc1.h=
ot/arch/x86_64/kernel/setup64.c
=2D-- linux-2.6.14-rc1/arch/x86_64/kernel/setup64.c	2005-09-23 16:14:40.328=
090776 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup64.c	2005-09-26 14:49:16.6=
08625064 -0700
@@ -137,7 +137,6 @@ void pda_init(int cpu)
 			panic("cannot allocate irqstack for cpu %d", cpu);=20
 	}
=20
=2D	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
=20
 	pda->irqstackptr +=3D IRQSTACKSIZE-64;
 }=20
@@ -193,6 +192,7 @@ void __cpuinit cpu_init (void)
 	/* CPU 0 is initialised in head64.c */
 	if (cpu !=3D 0) {
 		pda_init(cpu);
+		zap_low_mappings(cpu);
 	} else=20
 		estacks =3D boot_exception_stacks;=20
=20
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/smpboot.c linux-2.6.14-rc1.h=
ot/arch/x86_64/kernel/smpboot.c
=2D-- linux-2.6.14-rc1/arch/x86_64/kernel/smpboot.c	2005-09-23 16:14:40.329=
090624 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/smpboot.c	2005-09-26 14:49:16.6=
08625064 -0700
@@ -1067,9 +1067,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
  */
 void __init smp_cpus_done(unsigned int max_cpus)
 {
=2D#ifndef CONFIG_HOTPLUG_CPU
=2D	zap_low_mappings();
=2D#endif
 	smp_cleanup_boot();
=20
 #ifdef CONFIG_X86_IO_APIC
diff -Npru linux-2.6.14-rc1/arch/x86_64/mm/init.c linux-2.6.14-rc1.hot/arch=
/x86_64/mm/init.c
=2D-- linux-2.6.14-rc1/arch/x86_64/mm/init.c	2005-09-23 16:14:40.329090624 =
=2D0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/mm/init.c	2005-09-26 14:49:16.60962491=
2 -0700
@@ -310,12 +310,19 @@ void __init init_memory_mapping(unsigned
=20
 extern struct x8664_pda cpu_pda[NR_CPUS];
=20
=2D/* Assumes all CPUs still execute in init_mm */
=2Dvoid zap_low_mappings(void)
+void __cpuinit zap_low_mappings(int cpu)
 {
=2D	pgd_t *pgd =3D pgd_offset_k(0UL);
=2D	pgd_clear(pgd);
=2D	flush_tlb_all();
+	if (cpu =3D=3D 0) {
+		pgd_t *pgd =3D pgd_offset_k(0UL);
+		pgd_clear(pgd);
+	} else {
+		/*
+		 * For AP's, zap the low identity mappings by changing the cr3
+		 * to init_level4_pgt and doing local flush tlb all
+		 */
+		asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+	}
+	__flush_tlb_all();
 }
=20
 #ifndef CONFIG_NUMA
@@ -438,14 +445,13 @@ void __init mem_init(void)
 		datasize >> 10,
 		initsize >> 10);
=20
+#ifdef CONFIG_SMP
 	/*
=2D	 * Subtle. SMP is doing its boot stuff late (because it has to
=2D	 * fork idle threads) - but it also needs low mappings for the
=2D	 * protected-mode entry to work. We zap these entries only after
=2D	 * the WP-bit has been tested.
+	 * Sync boot_level4_pgt mappings with the init_level4_pgt
+	 * except for the low identity mappings which are already zapped
+	 * in init_level4_pgt. This sync-up is essential for AP's bringup
 	 */
=2D#ifndef CONFIG_SMP
=2D	zap_low_mappings();
+	memcpy(boot_level4_pgt+1, init_level4_pgt+1, (PTRS_PER_PGD-1)*sizeof(pgd_=
t));
 #endif
 }
=20
diff -Npru linux-2.6.14-rc1/include/asm-x86_64/pgtable.h linux-2.6.14-rc1.h=
ot/include/asm-x86_64/pgtable.h
=2D-- linux-2.6.14-rc1/include/asm-x86_64/pgtable.h	2005-09-23 16:14:40.330=
090472 -0700
+++ linux-2.6.14-rc1.hot/include/asm-x86_64/pgtable.h	2005-09-26 14:49:16.6=
09624912 -0700
@@ -16,6 +16,7 @@ extern pud_t level3_physmem_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
+extern pgd_t boot_level4_pgt[];
 extern unsigned long __supported_pte_mask;
=20
 #define swapper_pg_dir init_level4_pgt
diff -Npru linux-2.6.14-rc1/include/asm-x86_64/smp.h linux-2.6.14-rc1.hot/i=
nclude/asm-x86_64/smp.h
=2D-- linux-2.6.14-rc1/include/asm-x86_64/smp.h	2005-09-23 16:14:40.3300904=
72 -0700
+++ linux-2.6.14-rc1.hot/include/asm-x86_64/smp.h	2005-09-26 14:49:16.61062=
4760 -0700
@@ -47,7 +47,7 @@ extern void lock_ipi_call_lock(void);
 extern void unlock_ipi_call_lock(void);
 extern int smp_num_siblings;
 extern void smp_send_reschedule(int cpu);
=2Dextern void zap_low_mappings(void);
+extern void zap_low_mappings(int cpu);
 void smp_stop_cpu(void);
 extern int smp_call_function_single(int cpuid, void (*func) (void *info),
 				void *info, int retry, int wait);



--Boundary-00=_EMHPDVpeZZAKXHu--
