Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTFDAW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTFDAW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:22:56 -0400
Received: from [209.172.88.2] ([209.172.88.2]:64567 "EHLO caex01.trans.corp")
	by vger.kernel.org with ESMTP id S262015AbTFDAWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:22:55 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: IOAPIC not disabled on shutdown of X86_UP_IOAPIC kernel 2.4.18
Date: Tue, 3 Jun 2003 17:36:19 -0700
Message-ID: <36504F2E352484458C5D574719DC837217B31B@caex01.trans.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IOAPIC not disabled on shutdown of X86_UP_IOAPIC kernel 2.4.18
Thread-Index: AcMqMVEfBoG4C9QIQ6GRQFwyTOPaMg==
From: "Philip Thomas" <PThomas@pillardata.com>
To: <mingo@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch causes the IOAPIC to be disabled during shutdown of
kernels compiled with either the CONFIG_SMP or the CONFIG_X86_UP_IOAPIC
options (either of which causes the IOAPIC to be initialized).
Previously, the IOAPIC was disabled only during shutdown of CONFIG_SMP
kernels, and not CONFIG_X86_UP_IOAPIC kernels.  This caused unexpected
IRQ errors on warm boot of CONFIG_X86_UP_IOAPIC kernel because BIOS did
not reset the IOAPIC.

Phil

--- arch/i386/kernel/process.c.orig	2003-06-03 17:03:28.000000000
-0700
+++ arch/i386/kernel/process.c	2003-06-03 17:03:41.000000000 -0700
@@ -399,11 +399,17 @@
 		__asm__ __volatile__ ("hlt");
 	}
 	/*
-	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
+	 * Stop all CPUs and turn off local APICs, so
 	 * other OSs see a clean IRQ state.
 	 */
 	if (!netdump_func)
 		smp_send_stop();
+#endif
+
+#if CONFIG_X86_IOAPIC
+	/*
+	 * Turn off the IO-APIC, so other OSs see a clean IRQ state.
+	 */
 	disable_IO_APIC();
 #endif

