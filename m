Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129983AbQKWI7P>; Thu, 23 Nov 2000 03:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130337AbQKWI7E>; Thu, 23 Nov 2000 03:59:04 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:51113 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S129983AbQKWI67>; Thu, 23 Nov 2000 03:58:59 -0500
Date: Thu, 23 Nov 2000 09:23:24 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yeHW-0006GT-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001123091503.25130B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

 Here is a patch that should fix the problem.  I could trim down
verify_local_APIC() now, but given the code freeze I guess it's for
post-2.4. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-2.4.0-test11-ac2.macro/arch/i386/kernel/mpparse.c linux-2.4.0-test11-ac2/arch/i386/kernel/mpparse.c
--- linux-2.4.0-test11-ac2.macro/arch/i386/kernel/mpparse.c	Wed Nov 22 21:05:29 2000
+++ linux-2.4.0-test11-ac2/arch/i386/kernel/mpparse.c	Mon Nov 20 18:01:58 2000
@@ -486,18 +486,6 @@ void __init get_smp_config (void)
 {
 	struct intel_mp_floating *mpf = mpf_found;
 	printk("Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
-
-	/* Spot non intel cpus in boards whose bios is a bit loose with the MP
-	   specification. If the CPU is intel then it may have an external APIC */
-	   
-	if(boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
-		!test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
-	{
-		printk(KERN_WARNING "MP table found but your processor appears not to be SMP capable.\n");
-		printk(KERN_WARNING "Boot will continue single processor.\n");
-		return;
-	}
-	
 	if (mpf->mpf_feature2 & (1<<7)) {
 		printk("    IMCR and PIC compatibility mode.\n");
 		pic_mode = 1;
diff -up --recursive --new-file linux-2.4.0-test11-ac2.macro/arch/i386/kernel/setup.c linux-2.4.0-test11-ac2/arch/i386/kernel/setup.c
--- linux-2.4.0-test11-ac2.macro/arch/i386/kernel/setup.c	Wed Nov 22 21:05:29 2000
+++ linux-2.4.0-test11-ac2/arch/i386/kernel/setup.c	Wed Nov 22 22:22:15 2000
@@ -779,9 +779,7 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 #ifdef CONFIG_X86_IO_APIC
 	/*
-	 * get boot-time SMP configuration: 
-	 * Don't try and use the SMP configuration/APIC unless the CPU
-	 * has a local APIC.
+	 * get boot-time SMP configuration:
 	 */
 	if (smp_found_config)
 		get_smp_config();
diff -up --recursive --new-file linux-2.4.0-test11-ac2.macro/arch/i386/kernel/smpboot.c linux-2.4.0-test11-ac2/arch/i386/kernel/smpboot.c
--- linux-2.4.0-test11-ac2.macro/arch/i386/kernel/smpboot.c	Mon Nov 20 18:01:59 2000
+++ linux-2.4.0-test11-ac2/arch/i386/kernel/smpboot.c	Wed Nov 22 22:23:06 2000
@@ -886,8 +886,10 @@ void __init smp_boot_cpus(void)
 	/*
 	 * If we couldn't find a local APIC, then get out of here now!
 	 */
-	if (!verify_local_APIC()) {
-		printk(KERN_ERR "BIOS bug, local APIC at 0x%lX not detected!...\n", mp_lapic_addr);
+	if (APIC_INTEGRATED(apic_version[boot_cpu_id]) &&
+	    !test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability)) {
+		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
+			boot_cpu_id);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
@@ -896,6 +898,8 @@ void __init smp_boot_cpus(void)
 		smp_num_cpus = 1;
 		goto smp_done;
 	}
+
+	verify_local_APIC();
 
 	/*
 	 * If SMP should be disabled, then really disable it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
