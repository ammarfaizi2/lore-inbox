Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbTHSW5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTHSW5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:57:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:28049 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261415AbTHSW5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:57:44 -0400
Date: Wed, 20 Aug 2003 00:57:42 +0200 (MEST)
Message-Id: <200308192257.h7JMvgI6011356@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [BUG][2.6.0-test3-bk7] x86-64 UP_IOAPIC panic caused by cpumask_t conversion
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The box is UP with I/O-APIC, configured for !SMP, IO_APIC, !ACPI.
2.6.0-test3 worked fine, but 2.6.0-test3-bk7 panics and halts on
boot in arch/x86_64/kernel/io_apic.c:setup_ioapic_ids_from_mpc():

...
POSIX conformance testing by UNIFIX
ENABLING IO-APIC IRQs
BIOS bug, IO-APIC#0 ID 1 is already used!...
Kernel panic: Max APIC ID exceeded!

This happens because cpumask_t on UP implements "a set of CPUs"
as "a set is 0 or 1" (asm-generic/cpumask_up.h), while io_apic.c
actually wants "set of CPU (local APIC) and I/O-APIC IDs",
which obviously doesn't fit the "0 or 1" assumption.

As a quick-and-dirty test I changed linux/cpumask.h as follows

--- linux-2.6.0-test3-bk7/include/linux/cpumask.h.~1~	2003-08-19 23:48:50.000000000 +0200
+++ linux-2.6.0-test3-bk7/include/linux/cpumask.h	2003-08-20 00:07:17.000000000 +0200
@@ -21,7 +21,7 @@
 typedef unsigned long cpumask_t;
 #endif
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_IO_APIC)
 #if NR_CPUS > BITS_PER_LONG
 #include <asm-generic/cpumask_array.h>
 #else

Since NR_CPUS==1 this makes UP_IOAPIC use cpumask_arith.h,
which is what the code used before the cpumask_t conversion.
With this change, the box boots Ok again.

(I believe this is the correct thing to do, except having
CONFIG_X86_IO_APIC in generic code isn't quite right.)

/Mikael
