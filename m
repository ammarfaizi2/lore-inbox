Return-Path: <linux-kernel-owner+w=401wt.eu-S932164AbXAQKDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbXAQKDv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 05:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXAQKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 05:03:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46564 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164AbXAQKDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 05:03:50 -0500
Date: Wed, 17 Jan 2007 11:02:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>
Subject: Re: [patch] KVM: do VMXOFF upon reboot
Message-ID: <20070117100210.GA13080@elte.hu>
References: <20070117091319.GA30036@elte.hu> <20070117095141.GA11341@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117095141.GA11341@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> So i think we should do the patch below - this makes reboot work even 
> in atomic contexts. [...]

hm, this causes problems if KVM is not active on a VT-capable CPU: even 
on CPUs with VT supported, if a VT context is not actually activated, a 
vmxoff causes an invalid opcode exception. So the updated patch below 
uses a slightly more sophisticated approach to avoid that problem.

	Ingo

-------------------->
Subject: [patch] kvm: do VMXOFF upon reboot
From: Ingo Molnar <mingo@elte.hu>

my laptop's BIOS apparently gets confused if the kernel tries to
reboot without first turning VT context off, which results in a
hung (emergency-)reboot. So make sure this happens, right before
we reboot.

( NOTE: this is a dual-core system, but only the core where the
  BIOS executes seems to be affected - the other core can have an
  active VT context just fine - so we dont have to risk reboot
  robustness by doing a CPU cross-call in the emergency reboot
  handler. )

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/reboot.c   |   16 ++++++++++++++++
 arch/x86_64/kernel/reboot.c |   15 +++++++++++++++
 2 files changed, 31 insertions(+)

Index: linux/arch/i386/kernel/reboot.c
===================================================================
--- linux.orig/arch/i386/kernel/reboot.c
+++ linux/arch/i386/kernel/reboot.c
@@ -318,6 +318,22 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	unsigned long ecx = cpuid_ecx(1);
+
+	/*
+	 * Disable any possibly active VT context (if VT supported):
+	 */
+	if (test_bit(5, &ecx)) { /* has VT support */
+		asm volatile (
+			"1: .byte 0x0f, 0x01, 0xc4	\n" /* vmxoff */
+			"2:				\n"
+ 			".section __ex_table,\"a\"	\n"
+			"   .align 4			\n"
+			"   .long 	1b,2b		\n"
+			".previous			\n"
+		);
+	}
+
 	if (!reboot_thru_bios) {
 		if (efi_enabled) {
 			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
Index: linux/arch/x86_64/kernel/reboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/reboot.c
+++ linux/arch/x86_64/kernel/reboot.c
@@ -114,8 +114,23 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	unsigned long ecx = cpuid_ecx(1);
 	int i;
 
+	/*
+	 * Disable any possibly active VT context (if VT supported):
+	 */
+	if (test_bit(5, &ecx)) { /* has VT support */
+		asm volatile (
+			"1: .byte 0x0f, 0x01, 0xc4	\n" /* vmxoff */
+			"2:				\n"
+ 			".section __ex_table,\"a\"	\n"
+			"   .align 8			\n"
+			"   .quad 	1b,2b		\n"
+			".previous			\n"
+		);
+	}
+
 	/* Tell the BIOS if we want cold or warm reboot */
 	*((unsigned short *)__va(0x472)) = reboot_mode;
        
