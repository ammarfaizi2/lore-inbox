Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbTE1RjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 13:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbTE1RjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 13:39:14 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:2944
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264788AbTE1RjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 13:39:12 -0400
Date: Wed, 28 May 2003 13:42:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: brian@interlinx.bc.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <20030528173432.GA21379@linux.interlinx.bc.ca>
Message-ID: <Pine.LNX.4.50.0305281341160.1982-100000@montezuma.mastecende.com>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz> <20030528173432.GA21379@linux.interlinx.bc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003 brian@interlinx.bc.ca wrote:

> > - they (properly) emulate APIC timer and you'll
> > get information that host bus is running at 66.xxxx MHz. With VMware 2
> > you have to boot with noapic.
> 
> If only this worked.  I tried noapic, but it still tries to use the
> local APIC timer interrupts.  noapic seems to only disable IO-APIC.
> That is why I was "proposing" a new kernel command line arg,
> "nolocalapic".

I submitted a patch for nolapic before...

Index: linux-2.5.45-ac1/arch/i386/kernel/apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.45-ac1/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apic.c
--- linux-2.5.45-ac1/arch/i386/kernel/apic.c	5 Nov 2002 04:47:02 -0000	1.1.1.1
+++ linux-2.5.45-ac1/arch/i386/kernel/apic.c	6 Nov 2002 00:19:38 -0000
@@ -609,11 +609,27 @@
 
 #endif	/* CONFIG_PM */
 
+int enable_local_apic_flag __initdata = 0; /* 0=probe, 1=force, 2=disable e.g. DMI */
+
+static int __init nolapic_setup(char *str)
+{
+	enable_local_apic_flag = 2;
+	return 1;
+}
+
+static int __init lapic_setup(char *str)
+{
+	enable_local_apic_flag = 1;
+	return 1;
+}
+
+__setup("nolapic", nolapic_setup);
+__setup("lapic", lapic_setup);
+
 /*
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
-int dont_enable_local_apic __initdata = 0;
 
 static int __init detect_init_APIC (void)
 {
@@ -621,11 +637,14 @@
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
 	/* Disabled by DMI scan or kernel option? */
-	if (dont_enable_local_apic)
+	if (enable_local_apic_flag == 2)
 		return -1;
 
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
+	
+	if (enable_local_apic_flag == 1)
+		goto force_apic;
 
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -642,6 +661,7 @@
 		goto no_apic;
 	}
 
+force_apic:
 	if (!cpu_has_apic) {
 		/*
 		 * Some BIOSes disable the local APIC in the
Index: linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dmi_scan.c
--- linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c	5 Nov 2002 04:47:02 -0000	1.1.1.1
+++ linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c	6 Nov 2002 00:22:02 -0000
@@ -314,9 +314,9 @@
 static int __init local_apic_kills_bios(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	extern int dont_enable_local_apic;
-	if (!dont_enable_local_apic) {
-		dont_enable_local_apic = 1;
+	extern int enable_local_apic_flag;
+	if (!enable_local_apic_flag) {
+		enable_local_apic_flag = 2;
 		printk(KERN_WARNING "%s with broken BIOS detected. "
 		       "Refusing to enable the local APIC.\n",
 		       d->ident);
@@ -333,9 +333,9 @@
 static int __init apm_kills_local_apic(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	extern int dont_enable_local_apic;
-	if (apm_info.bios.version && !dont_enable_local_apic) {
-		dont_enable_local_apic = 1;
+	extern int enable_local_apic_flag;
+	if (apm_info.bios.version && !enable_local_apic_flag) {
+		enable_local_apic_flag = 2;
 		printk(KERN_WARNING "%s with broken BIOS detected. "
 		       "Refusing to enable the local APIC.\n",
 		       d->ident);
-- 
function.linuxpower.ca
