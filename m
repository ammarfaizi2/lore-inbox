Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTFDEtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 00:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTFDEtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 00:49:31 -0400
Received: from [204.94.215.101] ([204.94.215.101]:11450 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262820AbTFDEt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 00:49:29 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2[01] i386 does not reenable local apic
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jun 2003 15:02:40 +1000
Message-ID: <1648.1054702960@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initial /proc/cpuinfo (Compaq Evo N800v).

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
stepping	: 7
cpu MHz		: 1993.585
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht tm
bogomips	: 3971.48

arc/i386/kernel/apic.c::detect_init_APIC()

	switch (boot_cpu_data.x86_vendor) {
	case X86_VENDOR_AMD:
		if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1)
			break;
		if (boot_cpu_data.x86 == 15 && cpu_has_apic)
			break;
		goto no_apic;
	case X86_VENDOR_INTEL:
		if (boot_cpu_data.x86 == 6 ||
		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
			break;
		goto no_apic;
	default:
		goto no_apic;
	}

	if (!cpu_has_apic) {
		/*
		 * Some BIOSes disable the local APIC in the
		 * APIC_BASE MSR. This can only be done in
		 * software for Intel P6 and AMD K7 (Model > 1).
		 */
		rdmsr(MSR_IA32_APICBASE, l, h);
		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
			printk("Local APIC disabled by BIOS -- reenabling.\n");
			l &= ~MSR_IA32_APICBASE_BASE;
			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
			wrmsr(MSR_IA32_APICBASE, l, h);
		}
	}

Because boot_cpu_data.x86 == 15 and the local APIC is disabled in BIOS,
detect_init_APIC() skips the code that reenables the local APIC.  This
test is back to front.  Change the code to force X86_VENDOR_INTEL to
drop through and it successfully reenables the local apic, I even get
NMI events.

