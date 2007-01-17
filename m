Return-Path: <linux-kernel-owner+w=401wt.eu-S932175AbXAQJxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbXAQJxS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbXAQJxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:53:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60331 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175AbXAQJxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:53:18 -0500
Date: Wed, 17 Jan 2007 10:51:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>
Subject: [patch] KVM: do VMXOFF upon reboot
Message-ID: <20070117095141.GA11341@elte.hu>
References: <20070117091319.GA30036@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117091319.GA30036@elte.hu>
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

> Subject: [patch] call reboot notifier list when doing an emergency reboot
> From: Ingo Molnar <mingo@elte.hu>
> 
> my laptop (Lenovo T60) hangs during reboot if the shutdown notifiers are 
> not called. So the following command, which on other systems i use as a 
> quick way to reboot into a new kernel:
> 
>    echo b > /proc/sysrq-trigger
> 
> just hangs indefinitely after the kernel prints "Restarting system".

i also figured out which one of the many reboot notifiers makes the 
crutial difference: it's kvm_reboot().

So i think we should do the patch below - this makes reboot work even in 
atomic contexts. (My previous patch makes sense nevertheless, as reboot 
notifiers are quite useful in general, even during SysRq-b or panic 
reboots. For example the SATA disk caches are flushed.)

I have tested this without the other kernel/sys.c patch, and this solves 
the hung reboot problem equally well.

	Ingo

--------------------->
Subject: [patch] KVM: do VMXOFF upon reboot
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
 arch/i386/kernel/reboot.c   |    8 ++++++++
 arch/x86_64/kernel/reboot.c |    7 +++++++
 2 files changed, 15 insertions(+)

Index: linux/arch/i386/kernel/reboot.c
===================================================================
--- linux.orig/arch/i386/kernel/reboot.c
+++ linux/arch/i386/kernel/reboot.c
@@ -318,6 +318,14 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	unsigned long ecx = cpuid_ecx(1);
+
+	/*
+	 * Disable any possibly active VT context (if VT supported):
+	 */
+	if (test_bit(5, &ecx)) /* has VT support */
+		asm volatile (".byte 0x0f, 0x01, 0xc4"); /* vmxoff */
+
 	if (!reboot_thru_bios) {
 		if (efi_enabled) {
 			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
Index: linux/arch/x86_64/kernel/reboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/reboot.c
+++ linux/arch/x86_64/kernel/reboot.c
@@ -114,8 +114,15 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	unsigned long ecx = cpuid_ecx(1);
 	int i;
 
+	/*
+	 * Disable any possibly active VT context (if VT supported):
+	 */
+	if (test_bit(5, &ecx)) /* has VT support */
+		asm volatile (".byte 0x0f, 0x01, 0xc4"); /* vmxoff */
+
 	/* Tell the BIOS if we want cold or warm reboot */
 	*((unsigned short *)__va(0x472)) = reboot_mode;
        
