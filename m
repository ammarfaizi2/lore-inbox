Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbTJAWrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJAWrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:47:14 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19460 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261646AbTJAWrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:47:08 -0400
Date: Wed, 1 Oct 2003 23:47:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6: Oops at 'sysexit' on all threads after APM resume.
In-Reply-To: <1065020242.21551.285.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0310012329260.7095-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, David Woodhouse wrote:
> general protection fault: 0000 [#11]
> CPU:	0
> EIP:	0060:[<c010b3f5>]	Not tainted
> EFLAGS:	00010246
> EIP is at sysenter_past_esp+0x6e/0x71
> eax: 00000001   ebx: 00000000    ecx: bffffd78   edx: ffffe410
> esi: 0804b280   edi: bffffdab    ebp: d6056000   esp: d6057fc4
> 
> 0xc010b3f5 <sysenter_past_esp+110>:     sysexit

Glad to have your company.  Don't know when this started, first saw it
when I started using Dell Latitude C610 with RH9 a couple of weeks ago.
I use the workaround patch below (leaving warning in to remind me it's
not really a fix).  Seems some uses of suspend key go the intended route
(lots of noisy debug messages) e.g. the first after reboot; but some
bypass it completely e.g. the next.  And in that latter case, the vital
MSRs are not reinitialized.  Sorry, no time at present to follow it up.

Hugh

--- 2.6.0-test6/arch/i386/kernel/sysenter.c	2003-08-09 05:44:45.000000000 +0100
+++ linux/arch/i386/kernel/sysenter.c	2003-10-01 23:27:50.576482336 +0100
@@ -34,6 +34,32 @@
 	put_cpu();	
 }
 
+int fixup_sysenter(void)
+{
+#ifdef CONFIG_X86_HIGH_ENTRY
+	struct tss_struct *tss = (struct tss_struct *) __fix_to_virt(FIX_TSS_0);
+#else
+	struct tss_struct *tss = init_tss;
+#endif
+	unsigned int cs, esp, eip, high;
+	int ret = 0;
+
+	if (!boot_cpu_has(X86_FEATURE_SEP))
+		return 0;
+	tss += get_cpu();
+	rdmsr(MSR_IA32_SYSENTER_CS, cs, high);
+	rdmsr(MSR_IA32_SYSENTER_ESP, esp, high);
+	rdmsr(MSR_IA32_SYSENTER_EIP, eip, high);
+	if (cs != __KERNEL_CS || esp != tss->esp1 ||
+	    eip != (unsigned long) sysenter_entry) {
+		enable_sep_cpu(NULL);
+		printk("fixup_sysenter: %x %x %x\n", cs, esp, eip);
+		ret = 1;
+	}
+	put_cpu();
+	return ret;
+}
+
 /*
  * These symbols are defined by vsyscall.o to mark the bounds
  * of the ELF DSO images included therein.
--- 2.6.0-test6/arch/i386/kernel/traps.c	2003-09-28 07:31:58.000000000 +0100
+++ linux/arch/i386/kernel/traps.c	2003-10-01 23:27:50.593479752 +0100
@@ -388,7 +388,7 @@
 	return;
 
 gp_in_kernel:
-	if (!fixup_exception(regs))
+	if (!fixup_sysenter() && !fixup_exception(regs))
 		die("general protection fault", regs, error_code);
 }
 

