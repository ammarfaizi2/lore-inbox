Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVIHPcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVIHPcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVIHPcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:32:22 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:50022
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932531AbVIHPcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:32:21 -0400
Message-Id: <432075E502000078000244AE@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:33:25 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] abstraction of i386 machine check handlers
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part87A5E9D5.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part87A5E9D5.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

This adjusts the i386 machine check infrastructure so that replacing
the
underlying exception handling code can be done by adjusting just a
single
definition rather than many different files.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/cpu/mcheck/k7.c
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/k7.c
--- 2.6.13/arch/i386/kernel/cpu/mcheck/k7.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/k7.c	2005-09-01
11:59:55.000000000 +0200
@@ -18,7 +18,7 @@
 #include "mce.h"
 
 /* Machine Check Handler For AMD Athlon/Duron */
-static fastcall void k7_machine_check(struct pt_regs * regs, long
error_code)
+static MCE_HANDLER(k7)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
@@ -65,33 +65,33 @@ static fastcall void k7_machine_check(st
 	printk (KERN_EMERG "Attempting to continue.\n");
 	mcgstl &= ~(1<<2);
 	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+	return MCE_HANDLED;
 }
 
 
 /* AMD K7 machine check is Intel like */
 void __devinit amd_mcheck_init(struct cpuinfo_x86 *c)
 {
-	u32 l, h;
-	int i;
-
-	machine_check_vector = k7_machine_check;
-	wmb();
+	if (mce_register_handler(k7_machine_check) == 0) {
+		u32 l, h;
+		int i;
+
+		printk (KERN_INFO "Intel machine check architecture
supported.\n");
+		rdmsr (MSR_IA32_MCG_CAP, l, h);
+		if (l & (1<<8))	/* Control register present ? */
+			wrmsr (MSR_IA32_MCG_CTL, 0xffffffff,
0xffffffff);
+		nr_mce_banks = l & 0xff;
+
+		/* Clear status for MC index 0 separately, we don't
touch CTL,
+		 * as some Athlons cause spurious MCEs when its enabled.
*/
+		wrmsr (MSR_IA32_MC0_STATUS, 0x0, 0x0);
+		for (i=1; i<nr_mce_banks; i++) {
+			wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff,
0xffffffff);
+			wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+		}
 
-	printk (KERN_INFO "Intel machine check architecture
supported.\n");
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<8))	/* Control register present ? */
-		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
-	nr_mce_banks = l & 0xff;
-
-	/* Clear status for MC index 0 separately, we don't touch CTL,
-	 * as some Athlons cause spurious MCEs when its enabled. */
-	wrmsr (MSR_IA32_MC0_STATUS, 0x0, 0x0);
-	for (i=1; i<nr_mce_banks; i++) {
-		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+		set_in_cr4 (X86_CR4_MCE);
+		printk (KERN_INFO "Intel machine check reporting enabled
on CPU#%d.\n",
+			smp_processor_id());
 	}
-
-	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on
CPU#%d.\n",
-		smp_processor_id());
 }
diff -Npru 2.6.13/arch/i386/kernel/cpu/mcheck/mce.h
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/mce.h
--- 2.6.13/arch/i386/kernel/cpu/mcheck/mce.h	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/mce.h	2005-09-01
14:04:54.000000000 +0200
@@ -8,6 +8,13 @@ void winchip_mcheck_init(struct cpuinfo_
 
 /* Call the installed machine check handler for this CPU setup. */
 extern fastcall void (*machine_check_vector)(struct pt_regs *, long
error_code);
+static inline int mce_register_handler(fastcall void (*handler)(struct
pt_regs *, long)) {
+	machine_check_vector = handler;
+	wmb();
+	return 0;
+}
+# define MCE_HANDLER(name) fastcall void name##_machine_check(struct
pt_regs *regs, long error_code)
+# define MCE_HANDLED
 
 extern int mce_disabled __initdata;
 extern int nr_mce_banks;
diff -Npru 2.6.13/arch/i386/kernel/cpu/mcheck/p4.c
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/p4.c
--- 2.6.13/arch/i386/kernel/cpu/mcheck/p4.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/p4.c	2005-09-01
12:02:50.000000000 +0200
@@ -159,7 +159,7 @@ done:
 	return mce_num_extended_msrs;
 }
 
-static fastcall void intel_machine_check(struct pt_regs * regs, long
error_code)
+static MCE_HANDLER(intel)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
@@ -229,43 +229,43 @@ static fastcall void intel_machine_check
 	}
 	mcgstl &= ~(1<<2);
 	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+	return MCE_HANDLED;
 }
 
 
 void __devinit intel_p4_mcheck_init(struct cpuinfo_x86 *c)
 {
-	u32 l, h;
-	int i;
+	if (mce_register_handler(intel_machine_check) == 0) {
+		u32 l, h;
+		int i;
 	
-	machine_check_vector = intel_machine_check;
-	wmb();
-
-	printk (KERN_INFO "Intel machine check architecture
supported.\n");
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<8))	/* Control register present ? */
-		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
-	nr_mce_banks = l & 0xff;
-
-	for (i=0; i<nr_mce_banks; i++) {
-		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
-	}
+		printk (KERN_INFO "Intel machine check architecture
supported.\n");
+		rdmsr (MSR_IA32_MCG_CAP, l, h);
+		if (l & (1<<8))	/* Control register present ? */
+			wrmsr (MSR_IA32_MCG_CTL, 0xffffffff,
0xffffffff);
+		nr_mce_banks = l & 0xff;
+
+		for (i=0; i<nr_mce_banks; i++) {
+			wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff,
0xffffffff);
+			wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+		}
 
-	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on
CPU#%d.\n",
-		smp_processor_id());
-
-	/* Check for P4/Xeon extended MCE MSRs */
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<9))	{/* MCG_EXT_P */
-		mce_num_extended_msrs = (l >> 16) & 0xff;
-		printk (KERN_INFO "CPU%d: Intel P4/Xeon Extended MCE
MSRs (%d)"
-				" available\n",
-			smp_processor_id(), mce_num_extended_msrs);
+		set_in_cr4 (X86_CR4_MCE);
+		printk (KERN_INFO "Intel machine check reporting enabled
on CPU#%d.\n",
+			smp_processor_id());
+
+		/* Check for P4/Xeon extended MCE MSRs */
+		rdmsr (MSR_IA32_MCG_CAP, l, h);
+		if (l & (1<<9))	{/* MCG_EXT_P */
+			mce_num_extended_msrs = (l >> 16) & 0xff;
+			printk (KERN_INFO "CPU%d: Intel P4/Xeon Extended
MCE MSRs (%d)"
+					" available\n",
+				smp_processor_id(),
mce_num_extended_msrs);
 
 #ifdef CONFIG_X86_MCE_P4THERMAL
-		/* Check for P4/Xeon Thermal monitor */
-		intel_init_thermal(c);
+			/* Check for P4/Xeon Thermal monitor */
+			intel_init_thermal(c);
 #endif
+		}
 	}
 }
diff -Npru 2.6.13/arch/i386/kernel/cpu/mcheck/p5.c
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/p5.c
--- 2.6.13/arch/i386/kernel/cpu/mcheck/p5.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/p5.c	2005-09-01
12:04:56.000000000 +0200
@@ -17,7 +17,7 @@
 #include "mce.h"
 
 /* Machine check handler for Pentium class Intel */
-static fastcall void pentium_machine_check(struct pt_regs * regs, long
error_code)
+static MCE_HANDLER(pentium)
 {
 	u32 loaddr, hi, lotype;
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
@@ -26,29 +26,30 @@ static fastcall void pentium_machine_che
 	if(lotype&(1<<5))
 		printk(KERN_EMERG "CPU#%d: Possible thermal failure (CPU
on fire ?).\n", smp_processor_id());
 	add_taint(TAINT_MACHINE_CHECK);
+	return MCE_HANDLED;
 }
 
 /* Set up machine check reporting for processors with Intel style MCE
*/
 void __devinit intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 {
-	u32 l, h;
-	
-	/*Check for MCE support */
+	/* Check for MCE support */
 	if( !cpu_has(c, X86_FEATURE_MCE) )
 		return;	
 
 	/* Default P5 to off as its often misconnected */
 	if(mce_disabled != -1)
 		return;
-	machine_check_vector = pentium_machine_check;
-	wmb();
 
-	/* Read registers before enabling */
-	rdmsr(MSR_IA32_P5_MC_ADDR, l, h);
-	rdmsr(MSR_IA32_P5_MC_TYPE, l, h);
-	printk(KERN_INFO "Intel old style machine check architecture
supported.\n");
-
- 	/* Enable MCE */
-	set_in_cr4(X86_CR4_MCE);
-	printk(KERN_INFO "Intel old style machine check reporting
enabled on CPU#%d.\n", smp_processor_id());
+	if (mce_register_handler(pentium_machine_check) == 0) {
+		u32 l, h;
+
+		/* Read registers before enabling */
+		rdmsr(MSR_IA32_P5_MC_ADDR, l, h);
+		rdmsr(MSR_IA32_P5_MC_TYPE, l, h);
+		printk(KERN_INFO "Intel old style machine check
architecture supported.\n");
+
+	 	/* Enable MCE */
+		set_in_cr4(X86_CR4_MCE);
+		printk(KERN_INFO "Intel old style machine check
reporting enabled on CPU#%d.\n", smp_processor_id());
+	}
 }
diff -Npru 2.6.13/arch/i386/kernel/cpu/mcheck/p6.c
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/p6.c
--- 2.6.13/arch/i386/kernel/cpu/mcheck/p6.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/p6.c	2005-09-01
12:05:46.000000000 +0200
@@ -17,7 +17,7 @@
 #include "mce.h"
 
 /* Machine Check Handler For PII/PIII */
-static fastcall void intel_machine_check(struct pt_regs * regs, long
error_code)
+static MCE_HANDLER(intel)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
@@ -77,14 +77,12 @@ static fastcall void intel_machine_check
 	}
 	mcgstl &= ~(1<<2);
 	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+	return MCE_HANDLED;
 }
 
 /* Set up machine check reporting for processors with Intel style MCE
*/
 void __devinit intel_p6_mcheck_init(struct cpuinfo_x86 *c)
 {
-	u32 l, h;
-	int i;
-	
 	/* Check for MCE support */
 	if (!cpu_has(c, X86_FEATURE_MCE))
 		return;
@@ -94,22 +92,24 @@ void __devinit intel_p6_mcheck_init(stru
 		return;
 
 	/* Ok machine check is available */
-	machine_check_vector = intel_machine_check;
-	wmb();
+	if (mce_register_handler(intel_machine_check) == 0) {
+		u32 l, h;
+		int i;
+
+		printk (KERN_INFO "Intel machine check architecture
supported.\n");
+		rdmsr (MSR_IA32_MCG_CAP, l, h);
+		if (l & (1<<8))	/* Control register present ? */
+			wrmsr(MSR_IA32_MCG_CTL, 0xffffffff,
0xffffffff);
+		nr_mce_banks = l & 0xff;
+
+		/* Don't enable bank 0 on intel P6 cores, it goes bang
quickly. */
+		for (i=1; i<nr_mce_banks; i++) {
+			wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff,
0xffffffff);
+			wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+		}
 
-	printk (KERN_INFO "Intel machine check architecture
supported.\n");
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<8))	/* Control register present ? */
-		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
-	nr_mce_banks = l & 0xff;
-
-	/* Don't enable bank 0 on intel P6 cores, it goes bang quickly.
*/
-	for (i=1; i<nr_mce_banks; i++) {
-		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+		set_in_cr4 (X86_CR4_MCE);
+		printk (KERN_INFO "Intel machine check reporting enabled
on CPU#%d.\n",
+			smp_processor_id());
 	}
-
-	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on
CPU#%d.\n",
-		smp_processor_id());
 }
diff -Npru 2.6.13/arch/i386/kernel/cpu/mcheck/winchip.c
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/winchip.c
--- 2.6.13/arch/i386/kernel/cpu/mcheck/winchip.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-machine-check/arch/i386/kernel/cpu/mcheck/winchip.c	2005-09-01
12:07:29.000000000 +0200
@@ -16,22 +16,24 @@
 #include "mce.h"
 
 /* Machine check handler for WinChip C6 */
-static fastcall void winchip_machine_check(struct pt_regs * regs, long
error_code)
+static MCE_HANDLER(winchip)
 {
 	printk(KERN_EMERG "CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK);
+	return MCE_HANDLED;
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
 void __devinit winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
-	u32 lo, hi;
-	machine_check_vector = winchip_machine_check;
-	wmb();
-	rdmsr(MSR_IDT_FCR1, lo, hi);
-	lo|= (1<<2);	/* Enable EIERRINT (int 18 MCE) */
-	lo&= ~(1<<4);	/* Enable MCE */
-	wrmsr(MSR_IDT_FCR1, lo, hi);
-	set_in_cr4(X86_CR4_MCE);
-	printk(KERN_INFO "Winchip machine check reporting enabled on
CPU#0.\n");
+	if (mce_register_handler(winchip_machine_check) == 0) {
+		u32 lo, hi;
+
+		rdmsr(MSR_IDT_FCR1, lo, hi);
+		lo|= (1<<2);	/* Enable EIERRINT (int 18 MCE) */
+		lo&= ~(1<<4);	/* Enable MCE */
+		wrmsr(MSR_IDT_FCR1, lo, hi);
+		set_in_cr4(X86_CR4_MCE);
+		printk(KERN_INFO "Winchip machine check reporting
enabled on CPU#0.\n");
+	}
 }


--=__Part87A5E9D5.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-machine-check.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-machine-check.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClRoaXMgYWRqdXN0cyB0aGUgaTM4NiBtYWNo
aW5lIGNoZWNrIGluZnJhc3RydWN0dXJlIHNvIHRoYXQgcmVwbGFjaW5nIHRoZQp1bmRlcmx5aW5n
IGV4Y2VwdGlvbiBoYW5kbGluZyBjb2RlIGNhbiBiZSBkb25lIGJ5IGFkanVzdGluZyBqdXN0IGEg
c2luZ2xlCmRlZmluaXRpb24gcmF0aGVyIHRoYW4gbWFueSBkaWZmZXJlbnQgZmlsZXMuCgpTaWdu
ZWQtb2ZmLWJ5OiBKYW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCmRpZmYgLU5wcnUg
Mi42LjEzL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L21jaGVjay9rNy5jIDIuNi4xMy1pMzg2LW1hY2hp
bmUtY2hlY2svYXJjaC9pMzg2L2tlcm5lbC9jcHUvbWNoZWNrL2s3LmMKLS0tIDIuNi4xMy9hcmNo
L2kzODYva2VybmVsL2NwdS9tY2hlY2svazcuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjEzLWkzODYtbWFjaGluZS1jaGVjay9hcmNoL2kzODYva2VybmVsL2Nw
dS9tY2hlY2svazcuYwkyMDA1LTA5LTAxIDExOjU5OjU1LjAwMDAwMDAwMCArMDIwMApAQCAtMTgs
NyArMTgsNyBAQAogI2luY2x1ZGUgIm1jZS5oIgogCiAvKiBNYWNoaW5lIENoZWNrIEhhbmRsZXIg
Rm9yIEFNRCBBdGhsb24vRHVyb24gKi8KLXN0YXRpYyBmYXN0Y2FsbCB2b2lkIGs3X21hY2hpbmVf
Y2hlY2soc3RydWN0IHB0X3JlZ3MgKiByZWdzLCBsb25nIGVycm9yX2NvZGUpCitzdGF0aWMgTUNF
X0hBTkRMRVIoazcpCiB7CiAJaW50IHJlY292ZXI9MTsKIAl1MzIgYWxvdywgYWhpZ2gsIGhpZ2gs
IGxvdzsKQEAgLTY1LDMzICs2NSwzMyBAQCBzdGF0aWMgZmFzdGNhbGwgdm9pZCBrN19tYWNoaW5l
X2NoZWNrKHN0CiAJcHJpbnRrIChLRVJOX0VNRVJHICJBdHRlbXB0aW5nIHRvIGNvbnRpbnVlLlxu
Iik7CiAJbWNnc3RsICY9IH4oMTw8Mik7CiAJd3Jtc3IgKE1TUl9JQTMyX01DR19TVEFUVVMsbWNn
c3RsLCBtY2dzdGgpOworCXJldHVybiBNQ0VfSEFORExFRDsKIH0KIAogCiAvKiBBTUQgSzcgbWFj
aGluZSBjaGVjayBpcyBJbnRlbCBsaWtlICovCiB2b2lkIF9fZGV2aW5pdCBhbWRfbWNoZWNrX2lu
aXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQogewotCXUzMiBsLCBoOwotCWludCBpOwotCi0JbWFj
aGluZV9jaGVja192ZWN0b3IgPSBrN19tYWNoaW5lX2NoZWNrOwotCXdtYigpOworCWlmIChtY2Vf
cmVnaXN0ZXJfaGFuZGxlcihrN19tYWNoaW5lX2NoZWNrKSA9PSAwKSB7CisJCXUzMiBsLCBoOwor
CQlpbnQgaTsKKworCQlwcmludGsgKEtFUk5fSU5GTyAiSW50ZWwgbWFjaGluZSBjaGVjayBhcmNo
aXRlY3R1cmUgc3VwcG9ydGVkLlxuIik7CisJCXJkbXNyIChNU1JfSUEzMl9NQ0dfQ0FQLCBsLCBo
KTsKKwkJaWYgKGwgJiAoMTw8OCkpCS8qIENvbnRyb2wgcmVnaXN0ZXIgcHJlc2VudCA/ICovCisJ
CQl3cm1zciAoTVNSX0lBMzJfTUNHX0NUTCwgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZik7CisJCW5y
X21jZV9iYW5rcyA9IGwgJiAweGZmOworCisJCS8qIENsZWFyIHN0YXR1cyBmb3IgTUMgaW5kZXgg
MCBzZXBhcmF0ZWx5LCB3ZSBkb24ndCB0b3VjaCBDVEwsCisJCSAqIGFzIHNvbWUgQXRobG9ucyBj
YXVzZSBzcHVyaW91cyBNQ0VzIHdoZW4gaXRzIGVuYWJsZWQuICovCisJCXdybXNyIChNU1JfSUEz
Ml9NQzBfU1RBVFVTLCAweDAsIDB4MCk7CisJCWZvciAoaT0xOyBpPG5yX21jZV9iYW5rczsgaSsr
KSB7CisJCQl3cm1zciAoTVNSX0lBMzJfTUMwX0NUTCs0KmksIDB4ZmZmZmZmZmYsIDB4ZmZmZmZm
ZmYpOworCQkJd3Jtc3IgKE1TUl9JQTMyX01DMF9TVEFUVVMrNCppLCAweDAsIDB4MCk7CisJCX0K
IAotCXByaW50ayAoS0VSTl9JTkZPICJJbnRlbCBtYWNoaW5lIGNoZWNrIGFyY2hpdGVjdHVyZSBz
dXBwb3J0ZWQuXG4iKTsKLQlyZG1zciAoTVNSX0lBMzJfTUNHX0NBUCwgbCwgaCk7Ci0JaWYgKGwg
JiAoMTw8OCkpCS8qIENvbnRyb2wgcmVnaXN0ZXIgcHJlc2VudCA/ICovCi0JCXdybXNyIChNU1Jf
SUEzMl9NQ0dfQ1RMLCAweGZmZmZmZmZmLCAweGZmZmZmZmZmKTsKLQlucl9tY2VfYmFua3MgPSBs
ICYgMHhmZjsKLQotCS8qIENsZWFyIHN0YXR1cyBmb3IgTUMgaW5kZXggMCBzZXBhcmF0ZWx5LCB3
ZSBkb24ndCB0b3VjaCBDVEwsCi0JICogYXMgc29tZSBBdGhsb25zIGNhdXNlIHNwdXJpb3VzIE1D
RXMgd2hlbiBpdHMgZW5hYmxlZC4gKi8KLQl3cm1zciAoTVNSX0lBMzJfTUMwX1NUQVRVUywgMHgw
LCAweDApOwotCWZvciAoaT0xOyBpPG5yX21jZV9iYW5rczsgaSsrKSB7Ci0JCXdybXNyIChNU1Jf
SUEzMl9NQzBfQ1RMKzQqaSwgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZik7Ci0JCXdybXNyIChNU1Jf
SUEzMl9NQzBfU1RBVFVTKzQqaSwgMHgwLCAweDApOworCQlzZXRfaW5fY3I0IChYODZfQ1I0X01D
RSk7CisJCXByaW50ayAoS0VSTl9JTkZPICJJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBl
bmFibGVkIG9uIENQVSMlZC5cbiIsCisJCQlzbXBfcHJvY2Vzc29yX2lkKCkpOwogCX0KLQotCXNl
dF9pbl9jcjQgKFg4Nl9DUjRfTUNFKTsKLQlwcmludGsgKEtFUk5fSU5GTyAiSW50ZWwgbWFjaGlu
ZSBjaGVjayByZXBvcnRpbmcgZW5hYmxlZCBvbiBDUFUjJWQuXG4iLAotCQlzbXBfcHJvY2Vzc29y
X2lkKCkpOwogfQpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2VybmVsL2NwdS9tY2hlY2sv
bWNlLmggMi42LjEzLWkzODYtbWFjaGluZS1jaGVjay9hcmNoL2kzODYva2VybmVsL2NwdS9tY2hl
Y2svbWNlLmgKLS0tIDIuNi4xMy9hcmNoL2kzODYva2VybmVsL2NwdS9tY2hlY2svbWNlLmgJMjAw
NS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LW1hY2hpbmUt
Y2hlY2svYXJjaC9pMzg2L2tlcm5lbC9jcHUvbWNoZWNrL21jZS5oCTIwMDUtMDktMDEgMTQ6MDQ6
NTQuMDAwMDAwMDAwICswMjAwCkBAIC04LDYgKzgsMTMgQEAgdm9pZCB3aW5jaGlwX21jaGVja19p
bml0KHN0cnVjdCBjcHVpbmZvXwogCiAvKiBDYWxsIHRoZSBpbnN0YWxsZWQgbWFjaGluZSBjaGVj
ayBoYW5kbGVyIGZvciB0aGlzIENQVSBzZXR1cC4gKi8KIGV4dGVybiBmYXN0Y2FsbCB2b2lkICgq
bWFjaGluZV9jaGVja192ZWN0b3IpKHN0cnVjdCBwdF9yZWdzICosIGxvbmcgZXJyb3JfY29kZSk7
CitzdGF0aWMgaW5saW5lIGludCBtY2VfcmVnaXN0ZXJfaGFuZGxlcihmYXN0Y2FsbCB2b2lkICgq
aGFuZGxlcikoc3RydWN0IHB0X3JlZ3MgKiwgbG9uZykpIHsKKwltYWNoaW5lX2NoZWNrX3ZlY3Rv
ciA9IGhhbmRsZXI7CisJd21iKCk7CisJcmV0dXJuIDA7Cit9CisjIGRlZmluZSBNQ0VfSEFORExF
UihuYW1lKSBmYXN0Y2FsbCB2b2lkIG5hbWUjI19tYWNoaW5lX2NoZWNrKHN0cnVjdCBwdF9yZWdz
ICpyZWdzLCBsb25nIGVycm9yX2NvZGUpCisjIGRlZmluZSBNQ0VfSEFORExFRAogCiBleHRlcm4g
aW50IG1jZV9kaXNhYmxlZCBfX2luaXRkYXRhOwogZXh0ZXJuIGludCBucl9tY2VfYmFua3M7CmRp
ZmYgLU5wcnUgMi42LjEzL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L21jaGVjay9wNC5jIDIuNi4xMy1p
Mzg2LW1hY2hpbmUtY2hlY2svYXJjaC9pMzg2L2tlcm5lbC9jcHUvbWNoZWNrL3A0LmMKLS0tIDIu
Ni4xMy9hcmNoL2kzODYva2VybmVsL2NwdS9tY2hlY2svcDQuYwkyMDA1LTA4LTI5IDAxOjQxOjAx
LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWkzODYtbWFjaGluZS1jaGVjay9hcmNoL2kzODYv
a2VybmVsL2NwdS9tY2hlY2svcDQuYwkyMDA1LTA5LTAxIDEyOjAyOjUwLjAwMDAwMDAwMCArMDIw
MApAQCAtMTU5LDcgKzE1OSw3IEBAIGRvbmU6CiAJcmV0dXJuIG1jZV9udW1fZXh0ZW5kZWRfbXNy
czsKIH0KIAotc3RhdGljIGZhc3RjYWxsIHZvaWQgaW50ZWxfbWFjaGluZV9jaGVjayhzdHJ1Y3Qg
cHRfcmVncyAqIHJlZ3MsIGxvbmcgZXJyb3JfY29kZSkKK3N0YXRpYyBNQ0VfSEFORExFUihpbnRl
bCkKIHsKIAlpbnQgcmVjb3Zlcj0xOwogCXUzMiBhbG93LCBhaGlnaCwgaGlnaCwgbG93OwpAQCAt
MjI5LDQzICsyMjksNDMgQEAgc3RhdGljIGZhc3RjYWxsIHZvaWQgaW50ZWxfbWFjaGluZV9jaGVj
awogCX0KIAltY2dzdGwgJj0gfigxPDwyKTsKIAl3cm1zciAoTVNSX0lBMzJfTUNHX1NUQVRVUyxt
Y2dzdGwsIG1jZ3N0aCk7CisJcmV0dXJuIE1DRV9IQU5ETEVEOwogfQogCiAKIHZvaWQgX19kZXZp
bml0IGludGVsX3A0X21jaGVja19pbml0KHN0cnVjdCBjcHVpbmZvX3g4NiAqYykKIHsKLQl1MzIg
bCwgaDsKLQlpbnQgaTsKKwlpZiAobWNlX3JlZ2lzdGVyX2hhbmRsZXIoaW50ZWxfbWFjaGluZV9j
aGVjaykgPT0gMCkgeworCQl1MzIgbCwgaDsKKwkJaW50IGk7CiAJCi0JbWFjaGluZV9jaGVja192
ZWN0b3IgPSBpbnRlbF9tYWNoaW5lX2NoZWNrOwotCXdtYigpOwotCi0JcHJpbnRrIChLRVJOX0lO
Rk8gIkludGVsIG1hY2hpbmUgY2hlY2sgYXJjaGl0ZWN0dXJlIHN1cHBvcnRlZC5cbiIpOwotCXJk
bXNyIChNU1JfSUEzMl9NQ0dfQ0FQLCBsLCBoKTsKLQlpZiAobCAmICgxPDw4KSkJLyogQ29udHJv
bCByZWdpc3RlciBwcmVzZW50ID8gKi8KLQkJd3Jtc3IgKE1TUl9JQTMyX01DR19DVEwsIDB4ZmZm
ZmZmZmYsIDB4ZmZmZmZmZmYpOwotCW5yX21jZV9iYW5rcyA9IGwgJiAweGZmOwotCi0JZm9yIChp
PTA7IGk8bnJfbWNlX2JhbmtzOyBpKyspIHsKLQkJd3Jtc3IgKE1TUl9JQTMyX01DMF9DVEwrNCpp
LCAweGZmZmZmZmZmLCAweGZmZmZmZmZmKTsKLQkJd3Jtc3IgKE1TUl9JQTMyX01DMF9TVEFUVVMr
NCppLCAweDAsIDB4MCk7Ci0JfQorCQlwcmludGsgKEtFUk5fSU5GTyAiSW50ZWwgbWFjaGluZSBj
aGVjayBhcmNoaXRlY3R1cmUgc3VwcG9ydGVkLlxuIik7CisJCXJkbXNyIChNU1JfSUEzMl9NQ0df
Q0FQLCBsLCBoKTsKKwkJaWYgKGwgJiAoMTw8OCkpCS8qIENvbnRyb2wgcmVnaXN0ZXIgcHJlc2Vu
dCA/ICovCisJCQl3cm1zciAoTVNSX0lBMzJfTUNHX0NUTCwgMHhmZmZmZmZmZiwgMHhmZmZmZmZm
Zik7CisJCW5yX21jZV9iYW5rcyA9IGwgJiAweGZmOworCisJCWZvciAoaT0wOyBpPG5yX21jZV9i
YW5rczsgaSsrKSB7CisJCQl3cm1zciAoTVNSX0lBMzJfTUMwX0NUTCs0KmksIDB4ZmZmZmZmZmYs
IDB4ZmZmZmZmZmYpOworCQkJd3Jtc3IgKE1TUl9JQTMyX01DMF9TVEFUVVMrNCppLCAweDAsIDB4
MCk7CisJCX0KIAotCXNldF9pbl9jcjQgKFg4Nl9DUjRfTUNFKTsKLQlwcmludGsgKEtFUk5fSU5G
TyAiSW50ZWwgbWFjaGluZSBjaGVjayByZXBvcnRpbmcgZW5hYmxlZCBvbiBDUFUjJWQuXG4iLAot
CQlzbXBfcHJvY2Vzc29yX2lkKCkpOwotCi0JLyogQ2hlY2sgZm9yIFA0L1hlb24gZXh0ZW5kZWQg
TUNFIE1TUnMgKi8KLQlyZG1zciAoTVNSX0lBMzJfTUNHX0NBUCwgbCwgaCk7Ci0JaWYgKGwgJiAo
MTw8OSkpCXsvKiBNQ0dfRVhUX1AgKi8KLQkJbWNlX251bV9leHRlbmRlZF9tc3JzID0gKGwgPj4g
MTYpICYgMHhmZjsKLQkJcHJpbnRrIChLRVJOX0lORk8gIkNQVSVkOiBJbnRlbCBQNC9YZW9uIEV4
dGVuZGVkIE1DRSBNU1JzICglZCkiCi0JCQkJIiBhdmFpbGFibGVcbiIsCi0JCQlzbXBfcHJvY2Vz
c29yX2lkKCksIG1jZV9udW1fZXh0ZW5kZWRfbXNycyk7CisJCXNldF9pbl9jcjQgKFg4Nl9DUjRf
TUNFKTsKKwkJcHJpbnRrIChLRVJOX0lORk8gIkludGVsIG1hY2hpbmUgY2hlY2sgcmVwb3J0aW5n
IGVuYWJsZWQgb24gQ1BVIyVkLlxuIiwKKwkJCXNtcF9wcm9jZXNzb3JfaWQoKSk7CisKKwkJLyog
Q2hlY2sgZm9yIFA0L1hlb24gZXh0ZW5kZWQgTUNFIE1TUnMgKi8KKwkJcmRtc3IgKE1TUl9JQTMy
X01DR19DQVAsIGwsIGgpOworCQlpZiAobCAmICgxPDw5KSkJey8qIE1DR19FWFRfUCAqLworCQkJ
bWNlX251bV9leHRlbmRlZF9tc3JzID0gKGwgPj4gMTYpICYgMHhmZjsKKwkJCXByaW50ayAoS0VS
Tl9JTkZPICJDUFUlZDogSW50ZWwgUDQvWGVvbiBFeHRlbmRlZCBNQ0UgTVNScyAoJWQpIgorCQkJ
CQkiIGF2YWlsYWJsZVxuIiwKKwkJCQlzbXBfcHJvY2Vzc29yX2lkKCksIG1jZV9udW1fZXh0ZW5k
ZWRfbXNycyk7CiAKICNpZmRlZiBDT05GSUdfWDg2X01DRV9QNFRIRVJNQUwKLQkJLyogQ2hlY2sg
Zm9yIFA0L1hlb24gVGhlcm1hbCBtb25pdG9yICovCi0JCWludGVsX2luaXRfdGhlcm1hbChjKTsK
KwkJCS8qIENoZWNrIGZvciBQNC9YZW9uIFRoZXJtYWwgbW9uaXRvciAqLworCQkJaW50ZWxfaW5p
dF90aGVybWFsKGMpOwogI2VuZGlmCisJCX0KIAl9CiB9CmRpZmYgLU5wcnUgMi42LjEzL2FyY2gv
aTM4Ni9rZXJuZWwvY3B1L21jaGVjay9wNS5jIDIuNi4xMy1pMzg2LW1hY2hpbmUtY2hlY2svYXJj
aC9pMzg2L2tlcm5lbC9jcHUvbWNoZWNrL3A1LmMKLS0tIDIuNi4xMy9hcmNoL2kzODYva2VybmVs
L2NwdS9tY2hlY2svcDUuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysg
Mi42LjEzLWkzODYtbWFjaGluZS1jaGVjay9hcmNoL2kzODYva2VybmVsL2NwdS9tY2hlY2svcDUu
YwkyMDA1LTA5LTAxIDEyOjA0OjU2LjAwMDAwMDAwMCArMDIwMApAQCAtMTcsNyArMTcsNyBAQAog
I2luY2x1ZGUgIm1jZS5oIgogCiAvKiBNYWNoaW5lIGNoZWNrIGhhbmRsZXIgZm9yIFBlbnRpdW0g
Y2xhc3MgSW50ZWwgKi8KLXN0YXRpYyBmYXN0Y2FsbCB2b2lkIHBlbnRpdW1fbWFjaGluZV9jaGVj
ayhzdHJ1Y3QgcHRfcmVncyAqIHJlZ3MsIGxvbmcgZXJyb3JfY29kZSkKK3N0YXRpYyBNQ0VfSEFO
RExFUihwZW50aXVtKQogewogCXUzMiBsb2FkZHIsIGhpLCBsb3R5cGU7CiAJcmRtc3IoTVNSX0lB
MzJfUDVfTUNfQUREUiwgbG9hZGRyLCBoaSk7CkBAIC0yNiwyOSArMjYsMzAgQEAgc3RhdGljIGZh
c3RjYWxsIHZvaWQgcGVudGl1bV9tYWNoaW5lX2NoZQogCWlmKGxvdHlwZSYoMTw8NSkpCiAJCXBy
aW50ayhLRVJOX0VNRVJHICJDUFUjJWQ6IFBvc3NpYmxlIHRoZXJtYWwgZmFpbHVyZSAoQ1BVIG9u
IGZpcmUgPykuXG4iLCBzbXBfcHJvY2Vzc29yX2lkKCkpOwogCWFkZF90YWludChUQUlOVF9NQUNI
SU5FX0NIRUNLKTsKKwlyZXR1cm4gTUNFX0hBTkRMRUQ7CiB9CiAKIC8qIFNldCB1cCBtYWNoaW5l
IGNoZWNrIHJlcG9ydGluZyBmb3IgcHJvY2Vzc29ycyB3aXRoIEludGVsIHN0eWxlIE1DRSAqLwog
dm9pZCBfX2RldmluaXQgaW50ZWxfcDVfbWNoZWNrX2luaXQoc3RydWN0IGNwdWluZm9feDg2ICpj
KQogewotCXUzMiBsLCBoOwotCQotCS8qQ2hlY2sgZm9yIE1DRSBzdXBwb3J0ICovCisJLyogQ2hl
Y2sgZm9yIE1DRSBzdXBwb3J0ICovCiAJaWYoICFjcHVfaGFzKGMsIFg4Nl9GRUFUVVJFX01DRSkg
KQogCQlyZXR1cm47CQogCiAJLyogRGVmYXVsdCBQNSB0byBvZmYgYXMgaXRzIG9mdGVuIG1pc2Nv
bm5lY3RlZCAqLwogCWlmKG1jZV9kaXNhYmxlZCAhPSAtMSkKIAkJcmV0dXJuOwotCW1hY2hpbmVf
Y2hlY2tfdmVjdG9yID0gcGVudGl1bV9tYWNoaW5lX2NoZWNrOwotCXdtYigpOwogCi0JLyogUmVh
ZCByZWdpc3RlcnMgYmVmb3JlIGVuYWJsaW5nICovCi0JcmRtc3IoTVNSX0lBMzJfUDVfTUNfQURE
UiwgbCwgaCk7Ci0JcmRtc3IoTVNSX0lBMzJfUDVfTUNfVFlQRSwgbCwgaCk7Ci0JcHJpbnRrKEtF
Uk5fSU5GTyAiSW50ZWwgb2xkIHN0eWxlIG1hY2hpbmUgY2hlY2sgYXJjaGl0ZWN0dXJlIHN1cHBv
cnRlZC5cbiIpOwotCi0gCS8qIEVuYWJsZSBNQ0UgKi8KLQlzZXRfaW5fY3I0KFg4Nl9DUjRfTUNF
KTsKLQlwcmludGsoS0VSTl9JTkZPICJJbnRlbCBvbGQgc3R5bGUgbWFjaGluZSBjaGVjayByZXBv
cnRpbmcgZW5hYmxlZCBvbiBDUFUjJWQuXG4iLCBzbXBfcHJvY2Vzc29yX2lkKCkpOworCWlmICht
Y2VfcmVnaXN0ZXJfaGFuZGxlcihwZW50aXVtX21hY2hpbmVfY2hlY2spID09IDApIHsKKwkJdTMy
IGwsIGg7CisKKwkJLyogUmVhZCByZWdpc3RlcnMgYmVmb3JlIGVuYWJsaW5nICovCisJCXJkbXNy
KE1TUl9JQTMyX1A1X01DX0FERFIsIGwsIGgpOworCQlyZG1zcihNU1JfSUEzMl9QNV9NQ19UWVBF
LCBsLCBoKTsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiSW50ZWwgb2xkIHN0eWxlIG1hY2hpbmUgY2hl
Y2sgYXJjaGl0ZWN0dXJlIHN1cHBvcnRlZC5cbiIpOworCisJIAkvKiBFbmFibGUgTUNFICovCisJ
CXNldF9pbl9jcjQoWDg2X0NSNF9NQ0UpOworCQlwcmludGsoS0VSTl9JTkZPICJJbnRlbCBvbGQg
c3R5bGUgbWFjaGluZSBjaGVjayByZXBvcnRpbmcgZW5hYmxlZCBvbiBDUFUjJWQuXG4iLCBzbXBf
cHJvY2Vzc29yX2lkKCkpOworCX0KIH0KZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5l
bC9jcHUvbWNoZWNrL3A2LmMgMi42LjEzLWkzODYtbWFjaGluZS1jaGVjay9hcmNoL2kzODYva2Vy
bmVsL2NwdS9tY2hlY2svcDYuYwotLS0gMi42LjEzL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L21jaGVj
ay9wNi5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtaTM4
Ni1tYWNoaW5lLWNoZWNrL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L21jaGVjay9wNi5jCTIwMDUtMDkt
MDEgMTI6MDU6NDYuMDAwMDAwMDAwICswMjAwCkBAIC0xNyw3ICsxNyw3IEBACiAjaW5jbHVkZSAi
bWNlLmgiCiAKIC8qIE1hY2hpbmUgQ2hlY2sgSGFuZGxlciBGb3IgUElJL1BJSUkgKi8KLXN0YXRp
YyBmYXN0Y2FsbCB2b2lkIGludGVsX21hY2hpbmVfY2hlY2soc3RydWN0IHB0X3JlZ3MgKiByZWdz
LCBsb25nIGVycm9yX2NvZGUpCitzdGF0aWMgTUNFX0hBTkRMRVIoaW50ZWwpCiB7CiAJaW50IHJl
Y292ZXI9MTsKIAl1MzIgYWxvdywgYWhpZ2gsIGhpZ2gsIGxvdzsKQEAgLTc3LDE0ICs3NywxMiBA
QCBzdGF0aWMgZmFzdGNhbGwgdm9pZCBpbnRlbF9tYWNoaW5lX2NoZWNrCiAJfQogCW1jZ3N0bCAm
PSB+KDE8PDIpOwogCXdybXNyIChNU1JfSUEzMl9NQ0dfU1RBVFVTLG1jZ3N0bCwgbWNnc3RoKTsK
KwlyZXR1cm4gTUNFX0hBTkRMRUQ7CiB9CiAKIC8qIFNldCB1cCBtYWNoaW5lIGNoZWNrIHJlcG9y
dGluZyBmb3IgcHJvY2Vzc29ycyB3aXRoIEludGVsIHN0eWxlIE1DRSAqLwogdm9pZCBfX2Rldmlu
aXQgaW50ZWxfcDZfbWNoZWNrX2luaXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQogewotCXUzMiBs
LCBoOwotCWludCBpOwotCQogCS8qIENoZWNrIGZvciBNQ0Ugc3VwcG9ydCAqLwogCWlmICghY3B1
X2hhcyhjLCBYODZfRkVBVFVSRV9NQ0UpKQogCQlyZXR1cm47CkBAIC05NCwyMiArOTIsMjQgQEAg
dm9pZCBfX2RldmluaXQgaW50ZWxfcDZfbWNoZWNrX2luaXQoc3RydQogCQlyZXR1cm47CiAKIAkv
KiBPayBtYWNoaW5lIGNoZWNrIGlzIGF2YWlsYWJsZSAqLwotCW1hY2hpbmVfY2hlY2tfdmVjdG9y
ID0gaW50ZWxfbWFjaGluZV9jaGVjazsKLQl3bWIoKTsKKwlpZiAobWNlX3JlZ2lzdGVyX2hhbmRs
ZXIoaW50ZWxfbWFjaGluZV9jaGVjaykgPT0gMCkgeworCQl1MzIgbCwgaDsKKwkJaW50IGk7CisK
KwkJcHJpbnRrIChLRVJOX0lORk8gIkludGVsIG1hY2hpbmUgY2hlY2sgYXJjaGl0ZWN0dXJlIHN1
cHBvcnRlZC5cbiIpOworCQlyZG1zciAoTVNSX0lBMzJfTUNHX0NBUCwgbCwgaCk7CisJCWlmIChs
ICYgKDE8PDgpKQkvKiBDb250cm9sIHJlZ2lzdGVyIHByZXNlbnQgPyAqLworCQkJd3Jtc3IoTVNS
X0lBMzJfTUNHX0NUTCwgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZik7CisJCW5yX21jZV9iYW5rcyA9
IGwgJiAweGZmOworCisJCS8qIERvbid0IGVuYWJsZSBiYW5rIDAgb24gaW50ZWwgUDYgY29yZXMs
IGl0IGdvZXMgYmFuZyBxdWlja2x5LiAqLworCQlmb3IgKGk9MTsgaTxucl9tY2VfYmFua3M7IGkr
KykgeworCQkJd3Jtc3IgKE1TUl9JQTMyX01DMF9DVEwrNCppLCAweGZmZmZmZmZmLCAweGZmZmZm
ZmZmKTsKKwkJCXdybXNyIChNU1JfSUEzMl9NQzBfU1RBVFVTKzQqaSwgMHgwLCAweDApOworCQl9
CiAKLQlwcmludGsgKEtFUk5fSU5GTyAiSW50ZWwgbWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUg
c3VwcG9ydGVkLlxuIik7Ci0JcmRtc3IgKE1TUl9JQTMyX01DR19DQVAsIGwsIGgpOwotCWlmIChs
ICYgKDE8PDgpKQkvKiBDb250cm9sIHJlZ2lzdGVyIHByZXNlbnQgPyAqLwotCQl3cm1zcihNU1Jf
SUEzMl9NQ0dfQ1RMLCAweGZmZmZmZmZmLCAweGZmZmZmZmZmKTsKLQlucl9tY2VfYmFua3MgPSBs
ICYgMHhmZjsKLQotCS8qIERvbid0IGVuYWJsZSBiYW5rIDAgb24gaW50ZWwgUDYgY29yZXMsIGl0
IGdvZXMgYmFuZyBxdWlja2x5LiAqLwotCWZvciAoaT0xOyBpPG5yX21jZV9iYW5rczsgaSsrKSB7
Ci0JCXdybXNyIChNU1JfSUEzMl9NQzBfQ1RMKzQqaSwgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZik7
Ci0JCXdybXNyIChNU1JfSUEzMl9NQzBfU1RBVFVTKzQqaSwgMHgwLCAweDApOworCQlzZXRfaW5f
Y3I0IChYODZfQ1I0X01DRSk7CisJCXByaW50ayAoS0VSTl9JTkZPICJJbnRlbCBtYWNoaW5lIGNo
ZWNrIHJlcG9ydGluZyBlbmFibGVkIG9uIENQVSMlZC5cbiIsCisJCQlzbXBfcHJvY2Vzc29yX2lk
KCkpOwogCX0KLQotCXNldF9pbl9jcjQgKFg4Nl9DUjRfTUNFKTsKLQlwcmludGsgKEtFUk5fSU5G
TyAiSW50ZWwgbWFjaGluZSBjaGVjayByZXBvcnRpbmcgZW5hYmxlZCBvbiBDUFUjJWQuXG4iLAot
CQlzbXBfcHJvY2Vzc29yX2lkKCkpOwogfQpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2Vy
bmVsL2NwdS9tY2hlY2svd2luY2hpcC5jIDIuNi4xMy1pMzg2LW1hY2hpbmUtY2hlY2svYXJjaC9p
Mzg2L2tlcm5lbC9jcHUvbWNoZWNrL3dpbmNoaXAuYwotLS0gMi42LjEzL2FyY2gvaTM4Ni9rZXJu
ZWwvY3B1L21jaGVjay93aW5jaGlwLmMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAy
MDAKKysrIDIuNi4xMy1pMzg2LW1hY2hpbmUtY2hlY2svYXJjaC9pMzg2L2tlcm5lbC9jcHUvbWNo
ZWNrL3dpbmNoaXAuYwkyMDA1LTA5LTAxIDEyOjA3OjI5LjAwMDAwMDAwMCArMDIwMApAQCAtMTYs
MjIgKzE2LDI0IEBACiAjaW5jbHVkZSAibWNlLmgiCiAKIC8qIE1hY2hpbmUgY2hlY2sgaGFuZGxl
ciBmb3IgV2luQ2hpcCBDNiAqLwotc3RhdGljIGZhc3RjYWxsIHZvaWQgd2luY2hpcF9tYWNoaW5l
X2NoZWNrKHN0cnVjdCBwdF9yZWdzICogcmVncywgbG9uZyBlcnJvcl9jb2RlKQorc3RhdGljIE1D
RV9IQU5ETEVSKHdpbmNoaXApCiB7CiAJcHJpbnRrKEtFUk5fRU1FUkcgIkNQVTA6IE1hY2hpbmUg
Q2hlY2sgRXhjZXB0aW9uLlxuIik7CiAJYWRkX3RhaW50KFRBSU5UX01BQ0hJTkVfQ0hFQ0spOwor
CXJldHVybiBNQ0VfSEFORExFRDsKIH0KIAogLyogU2V0IHVwIG1hY2hpbmUgY2hlY2sgcmVwb3J0
aW5nIG9uIHRoZSBXaW5jaGlwIEM2IHNlcmllcyAqLwogdm9pZCBfX2RldmluaXQgd2luY2hpcF9t
Y2hlY2tfaW5pdChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpCiB7Ci0JdTMyIGxvLCBoaTsKLQltYWNo
aW5lX2NoZWNrX3ZlY3RvciA9IHdpbmNoaXBfbWFjaGluZV9jaGVjazsKLQl3bWIoKTsKLQlyZG1z
cihNU1JfSURUX0ZDUjEsIGxvLCBoaSk7Ci0JbG98PSAoMTw8Mik7CS8qIEVuYWJsZSBFSUVSUklO
VCAoaW50IDE4IE1DRSkgKi8KLQlsbyY9IH4oMTw8NCk7CS8qIEVuYWJsZSBNQ0UgKi8KLQl3cm1z
cihNU1JfSURUX0ZDUjEsIGxvLCBoaSk7Ci0Jc2V0X2luX2NyNChYODZfQ1I0X01DRSk7Ci0JcHJp
bnRrKEtFUk5fSU5GTyAiV2luY2hpcCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBlbmFibGVkIG9u
IENQVSMwLlxuIik7CisJaWYgKG1jZV9yZWdpc3Rlcl9oYW5kbGVyKHdpbmNoaXBfbWFjaGluZV9j
aGVjaykgPT0gMCkgeworCQl1MzIgbG8sIGhpOworCisJCXJkbXNyKE1TUl9JRFRfRkNSMSwgbG8s
IGhpKTsKKwkJbG98PSAoMTw8Mik7CS8qIEVuYWJsZSBFSUVSUklOVCAoaW50IDE4IE1DRSkgKi8K
KwkJbG8mPSB+KDE8PDQpOwkvKiBFbmFibGUgTUNFICovCisJCXdybXNyKE1TUl9JRFRfRkNSMSwg
bG8sIGhpKTsKKwkJc2V0X2luX2NyNChYODZfQ1I0X01DRSk7CisJCXByaW50ayhLRVJOX0lORk8g
IldpbmNoaXAgbWFjaGluZSBjaGVjayByZXBvcnRpbmcgZW5hYmxlZCBvbiBDUFUjMC5cbiIpOwor
CX0KIH0K

--=__Part87A5E9D5.0__=--
