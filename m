Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTFDKke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTFDKke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:40:34 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:52627 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263187AbTFDKkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:40:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.53191.406196.811094@gargle.gargle.HOWL>
Date: Wed, 4 Jun 2003 12:53:59 +0200
From: mikpe@csd.uu.se
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2[01] i386 does not reenable local apic
In-Reply-To: <1648.1054702960@kao2.melbourne.sgi.com>
References: <1648.1054702960@kao2.melbourne.sgi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
 > arc/i386/kernel/apic.c::detect_init_APIC()
 > 
 > 	switch (boot_cpu_data.x86_vendor) {
 > 	case X86_VENDOR_AMD:
 > 		if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1)
 > 			break;
 > 		if (boot_cpu_data.x86 == 15 && cpu_has_apic)
 > 			break;
 > 		goto no_apic;
 > 	case X86_VENDOR_INTEL:
 > 		if (boot_cpu_data.x86 == 6 ||
 > 		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
 > 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 > 			break;
 > 		goto no_apic;
 > 	default:
 > 		goto no_apic;
 > 	}
 > 
 > 	if (!cpu_has_apic) {
 > 		/*
 > 		 * Some BIOSes disable the local APIC in the
 > 		 * APIC_BASE MSR. This can only be done in
 > 		 * software for Intel P6 and AMD K7 (Model > 1).
 > 		 */
 > 		rdmsr(MSR_IA32_APICBASE, l, h);
 > 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
 > 			printk("Local APIC disabled by BIOS -- reenabling.\n");
 > 			l &= ~MSR_IA32_APICBASE_BASE;
 > 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 > 			wrmsr(MSR_IA32_APICBASE, l, h);
 > 		}
 > 	}
 > 
 > Because boot_cpu_data.x86 == 15 and the local APIC is disabled in BIOS,
 > detect_init_APIC() skips the code that reenables the local APIC.  This
 > test is back to front.  Change the code to force X86_VENDOR_INTEL to
 > drop through and it successfully reenables the local apic, I even get
 > NMI events.

The correct fix is to delete the "&& cpu_has_apic" test for family 15
CPUs. Simply falling through for VENDOR_INTEL will oops UP P5s.

I've seen a few P4 owners being caught by this. OTOH, several of those
had crap BIOSen that caused hangs with local APIC enabled.

I'll do a patch for 2.4.22-pre, if we ever actually get a 2.4.21 final...

/Mikael
