Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRJ0QXa>; Sat, 27 Oct 2001 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274513AbRJ0QXX>; Sat, 27 Oct 2001 12:23:23 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:28126 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S273831AbRJ0QXE>;
	Sat, 27 Oct 2001 12:23:04 -0400
Date: Sat, 27 Oct 2001 18:23:33 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110271623.SAA04333@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] fix 2.4 SMP kernel hang on UP P4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus & Alan,

A 2.4 kernel built with SMP or UP_APIC support may hang during boot
if run on a UP P4 machine. The patch below fixes this, please apply.

The events that lead to the hang are:
1. The BIOS boots the OS with the local APIC enabled. cpu_has_apic is true.
2. init_apic_mappings() calls detect_init_APIC().
3. detect_init_APIC() doesn't know about the P4, so it returns failure.
4. init_apic_mappings() maps the local APIC to a dummy page.
5. Much later, APIC_init_uniprocessor() sees that cpu_has_apic is true,
   so it calls setup_APIC_clocks().
6. setup_APIC_clocks() calls calibrate_APIC_clock().
7. Since the local APIC was mapped to a dummy page, calibrate_APIC_clock()
   doesn't actually touch the HW. It detects and returns a 0 MHz bus clock.
8. setup_APIC_clocks() calls setup_APIC_timer() with the 0 MHz bus clock.
9. setup_APIC_timer() spins in a loop, waiting to APIC_TMCCT to decrement.
   But APIC_TMCCT is in the dummy page, so it doesn't change and the
   loop never terminates. At this point, you'll see something like:

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1707.5365 MHz.
..... host bus clock speed is 0.0000 MHz.
cpu: 0, clocks: 0, slice: 0
// hangs

The fix simply ensures that detect_init_APIC() doesn't return failure
when running on a P4 with an already enabled local APIC.

/Mikael

--- linux-2.4.13/arch/i386/kernel/apic.c.~1~	Thu Oct 11 13:34:39 2001
+++ linux-2.4.13/arch/i386/kernel/apic.c	Sat Oct 27 17:47:49 2001
@@ -588,6 +588,7 @@
 		goto no_apic;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 ||
+		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
