Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSG1L0Z>; Sun, 28 Jul 2002 07:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSG1L0Z>; Sun, 28 Jul 2002 07:26:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39111 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315709AbSG1L0Y>;
	Sun, 28 Jul 2002 07:26:24 -0400
Date: Sun, 28 Jul 2002 13:28:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: [patch] APM fixes, 2.5.29
In-Reply-To: <Pine.LNX.4.44.0207281152430.12794-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207281326150.21244-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes two things:

 - a TLS related bug noticed by Arjan van de Ven: apm_init() should set up 
   all CPU's gdt entries - just in case some code happens to call in the
   APM BIOS on the wrong CPU. This should also handle the case when some 
   APM code gets triggered (by suspend or power button or something).

 - compilation problem

	Ingo

--- linux/arch/i386/kernel/apm.c.orig	Sun Jul 28 11:58:55 2002
+++ linux/arch/i386/kernel/apm.c	Sun Jul 28 13:27:54 2002
@@ -1589,7 +1589,7 @@
 
 	p = buf;
 
-	if ((num_possible_cpus() == 1) &&
+	if ((num_online_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1720,7 +1720,7 @@
 		}
 	}
 
-	if (debug && (num_possible_cpus() == 1)) {
+	if (debug && (num_online_cpus() == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1764,7 +1764,7 @@
 		pm_power_off = apm_power_off;
 	register_sysrq_key('o', &sysrq_poweroff_op);
 
-	if (num_possible_cpus() == 1) {
+	if (num_online_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
@@ -1853,6 +1853,7 @@
 static int __init apm_init(void)
 {
 	struct proc_dir_entry *apm_proc;
+	int i;
 
 	if (apm_info.bios.version == 0) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
@@ -1907,7 +1908,7 @@
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
-	if ((num_possible_cpus() > 1) && !power_off) {
+	if ((num_online_cpus() > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
 		return -ENODEV;
 	}
@@ -1926,37 +1927,39 @@
 	 * NOTE: on SMP we call into the APM BIOS only on CPU#0, so it's
 	 * enough to modify CPU#0's GDT.
 	 */
-	set_base(cpu_gdt_table[0][APM_40 >> 3],
-		 __va((unsigned long)0x40 << 4));
-	_set_limit((char *)&cpu_gdt_table[0][APM_40 >> 3], 4095 - (0x40 << 4));
-
-	apm_bios_entry.offset = apm_info.bios.offset;
-	apm_bios_entry.segment = APM_CS;
-	set_base(cpu_gdt_table[0][APM_CS >> 3],
-		 __va((unsigned long)apm_info.bios.cseg << 4));
-	set_base(cpu_gdt_table[0][APM_CS_16 >> 3],
-		 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-	set_base(cpu_gdt_table[0][APM_DS >> 3],
-		 __va((unsigned long)apm_info.bios.dseg << 4));
+	for (i = 0; i < NR_CPUS; i++) {
+		set_base(cpu_gdt_table[i][APM_40 >> 3],
+			 __va((unsigned long)0x40 << 4));
+		_set_limit((char *)&cpu_gdt_table[i][APM_40 >> 3], 4095 - (0x40 << 4));
+
+		apm_bios_entry.offset = apm_info.bios.offset;
+		apm_bios_entry.segment = APM_CS;
+		set_base(cpu_gdt_table[i][APM_CS >> 3],
+			 __va((unsigned long)apm_info.bios.cseg << 4));
+		set_base(cpu_gdt_table[i][APM_CS_16 >> 3],
+			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
+		set_base(cpu_gdt_table[i][APM_DS >> 3],
+			 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
-	if (apm_info.bios.version == 0x100) {
+		if (apm_info.bios.version == 0x100) {
 #endif
-		/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-		_set_limit((char *)&cpu_gdt_table[0][APM_CS >> 3], 64 * 1024 - 1);
-		/* For some unknown machine. */
-		_set_limit((char *)&cpu_gdt_table[0][APM_CS_16 >> 3], 64 * 1024 - 1);
-		/* For the DEC Hinote Ultra CT475 (and others?) */
-		_set_limit((char *)&cpu_gdt_table[0][APM_DS >> 3], 64 * 1024 - 1);
+			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3], 64 * 1024 - 1);
+			/* For some unknown machine. */
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3], 64 * 1024 - 1);
+			/* For the DEC Hinote Ultra CT475 (and others?) */
+			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3], 64 * 1024 - 1);
 #ifndef APM_RELAX_SEGMENTS
-	} else {
-		_set_limit((char *)&cpu_gdt_table[0][APM_CS >> 3],
-			(apm_info.bios.cseg_len - 1) & 0xffff);
-		_set_limit((char *)&cpu_gdt_table[0][APM_CS_16 >> 3],
-			(apm_info.bios.cseg_16_len - 1) & 0xffff);
-		_set_limit((char *)&cpu_gdt_table[0][APM_DS >> 3],
-			(apm_info.bios.dseg_len - 1) & 0xffff);
-	}
+		} else {
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3],
+				(apm_info.bios.cseg_len - 1) & 0xffff);
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3],
+				(apm_info.bios.cseg_16_len - 1) & 0xffff);
+			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3],
+				(apm_info.bios.dseg_len - 1) & 0xffff);
+		}
 #endif
+	}
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
 	if (apm_proc)
@@ -1964,7 +1967,7 @@
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
-	if (num_possible_cpus() > 1) {
+	if (num_online_cpus() > 1) {
 		printk(KERN_NOTICE
 		   "apm: disabled - APM is not SMP safe (power off active).\n");
 		return 0;

