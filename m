Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315993AbSEJOF3>; Fri, 10 May 2002 10:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315994AbSEJOF2>; Fri, 10 May 2002 10:05:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:31467 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S315993AbSEJOF0>; Fri, 10 May 2002 10:05:26 -0400
Date: Fri, 10 May 2002 15:07:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
        "Saxena, Sunil" <sunil.saxena@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] "noht" disable HyperThreading
Message-ID: <Pine.LNX.4.21.0205101448030.936-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's good that 2.4.19-pre on Xeon now defaults to HyperThreading on,
but currently there's no way to disable it.  Wouldn't it be prudent
to support a "noht" boot arg?  (Why retain obscure "acpismp=force"?
because it's conceivable that it could help some non-HT machine to
boot, which fails to boot otherwise.)

Hugh

--- 2.4.19-pre8/Documentation/kernel-parameters.txt	Mon Feb 25 19:37:51 2002
+++ linux/Documentation/kernel-parameters.txt	Fri May 10 14:16:58 2002
@@ -68,6 +68,8 @@
 	53c7xx=		[HW,SCSI] Amiga SCSI controllers.
 
 	acpi=		[HW,ACPI] Advanced Configuration and Power Interface 
+
+	acpismp=force	[IA-32] Early setup parse and use ACPI SMP table.
  
 	ad1816=		[HW,SOUND]
 
@@ -378,6 +380,8 @@
 	nohlt		[BUGS=ARM]
  
 	no-hlt		[BUGS=ix86]
+
+	noht		[SMP,IA-32] Disables P4 Xeon(tm) HyperThreading.
 
 	noisapnp	[ISAPNP] Disables ISA PnP code.
 
--- 2.4.19-pre8/arch/i386/kernel/setup.c	Fri May  3 12:15:08 2002
+++ linux/arch/i386/kernel/setup.c	Fri May 10 14:23:07 2002
@@ -166,6 +166,7 @@
 
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
+static int disable_x86_ht __initdata = 0;
 
 int enable_acpi_smp_table;
 
@@ -727,7 +728,7 @@
 } /* setup_memory_region */
 
 
-static void __init parse_mem_cmdline (char ** cmdline_p)
+static void __init parse_cmdline_early (char ** cmdline_p)
 {
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
 	int len = 0;
@@ -738,6 +739,8 @@
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	for (;;) {
+		if (c != ' ')
+			goto nextchar;
 		/*
 		 * "mem=nopentium" disables the 4MB page tables.
 		 * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
@@ -745,7 +748,7 @@
 		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
 		 * <start> to <start>+<mem>, overriding the bios size.
 		 */
-		if (c == ' ' && !memcmp(from, "mem=", 4)) {
+		if (!memcmp(from, "mem=", 4)) {
 			if (to != command_line)
 				to--;
 			if (!memcmp(from+4, "nopentium", 9)) {
@@ -774,17 +777,23 @@
 				}
 			}
 		}
-		/* acpismp=force forces parsing and use of the ACPI SMP table */
-		if (c == ' ' && !memcmp(from, "acpismp=force", 13))
-			 enable_acpi_smp_table = 1;
+
+		/* "noht" disables HyperThreading (2 logical cpus per Xeon) */
+		else if (!memcmp(from, "noht", 4))
+			disable_x86_ht = 1;
+
+		/* "acpismp=force" forces parsing and use of the ACPI SMP table */
+		else if (!memcmp(from, "acpismp=force", 13))
+			enable_acpi_smp_table = 1;
+
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
 		 * This also works to reduce highmem size on bigger boxes.
 		 */
-		if (c == ' ' && !memcmp(from, "highmem=", 8))
+		else if (!memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
-	
+nextchar:
 		c = *(from++);
 		if (!c)
 			break;
@@ -841,7 +850,7 @@
 	data_resource.start = virt_to_bus(&_etext);
 	data_resource.end = virt_to_bus(&_edata)-1;
 
-	parse_mem_cmdline(cmdline_p);
+	parse_cmdline_early(cmdline_p);
 
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
@@ -1025,6 +1034,17 @@
 	}
 #endif
 
+	/*
+	 * If enable_acpi_smp_table and HT feature present, acpitable.c
+	 * will find all logical cpus despite disable_x86_ht: so if both
+	 * "noht" and "acpismp=force" are specified, let "noht" override
+	 * "acpismp=force" cleanly.  Why retain "acpismp=force"? because
+	 * parsing ACPI SMP table might prove useful on some non-HT cpu.
+	 */
+	if (disable_x86_ht) {
+		clear_bit(X86_FEATURE_HT, &boot_cpu_data.x86_capability[0]);
+		enable_acpi_smp_table = 0;
+	}
 	if (test_bit(X86_FEATURE_HT, &boot_cpu_data.x86_capability[0]))
 		enable_acpi_smp_table = 1;
 	
@@ -2267,7 +2287,7 @@
 		strcpy(c->x86_model_id, p);
 	
 #ifdef CONFIG_SMP
-	if (test_bit(X86_FEATURE_HT, &c->x86_capability)) {
+	if (test_bit(X86_FEATURE_HT, &c->x86_capability) && !disable_x86_ht) {
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
@@ -2717,6 +2737,10 @@
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
 #endif
+
+	/* HT disabled? */
+	if (disable_x86_ht)
+		clear_bit(X86_FEATURE_HT, &c->x86_capability);
 
 	/* FXSR disabled? */
 	if (disable_x86_fxsr) {

