Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVH3G1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVH3G1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVH3G1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:27:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33000 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750949AbVH3G1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:27:38 -0400
Date: Tue, 30 Aug 2005 08:28:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: 2.6.13-rc7-rt4, fails to build
Message-ID: <20050830062811.GA6516@elte.hu>
References: <1125277360.2678.159.camel@cmn37.stanford.edu> <20050829083541.GA21756@elte.hu> <1125364522.7630.108.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125364522.7630.108.camel@cmn37.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> I still get the error, it is happening in the _smp_ build, I don't 
> know what's wrong...
> 
> arch/i386/mach-generic/built-in.o(.text+0x1183): In function
> `es7000_rename_gsi':
> arch/i386/mach-generic/../mach-es7000/es7000plat.c:68: undefined
> reference to `nr_ioapic_registers'
> make: *** [.tmp_vmlinux1] Error 1
> 
> I'm attaching the .config I'm using for the smp build. 

ok, managed to reproduce it with this .config. It's an effect of the 
IOAPIC_CACHE code. I have fixed it with the patch below (which is also 
in 2.6.13-rt2), and the resulting kernel builds & boots fine. Karsten, 
does it look sane to you?

	Ingo

Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -143,6 +141,10 @@ struct ioapic_data_struct {
 
 static struct ioapic_data_struct *ioapic_data[MAX_IO_APICS];
 
+int nr_ioapic_registers(int apic)
+{
+	return ioapic_data[apic]->nr_registers;
+}
 
 static inline unsigned int __raw_io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
 {
Index: linux/arch/i386/mach-es7000/es7000plat.c
===================================================================
--- linux.orig/arch/i386/mach-es7000/es7000plat.c
+++ linux/arch/i386/mach-es7000/es7000plat.c
@@ -65,7 +65,7 @@ es7000_rename_gsi(int ioapic, int gsi)
 	if (!base) {
 		int i;
 		for (i = 0; i < nr_ioapics; i++)
-			base += nr_ioapic_registers[i];
+			base += nr_ioapic_registers(i);
 	}
 
 	if (!ioapic && (gsi < 16)) 
Index: linux/include/asm-i386/io_apic.h
===================================================================
--- linux.orig/include/asm-i386/io_apic.h
+++ linux/include/asm-i386/io_apic.h
@@ -101,7 +101,7 @@ union IO_APIC_reg_03 {
  * # of IO-APICs and # of IRQ routing registers
  */
 extern int nr_ioapics;
-extern int nr_ioapic_registers[MAX_IO_APICS];
+extern int nr_ioapic_registers(int apic);
 
 enum ioapic_irq_destination_types {
 	dest_Fixed = 0,
 
