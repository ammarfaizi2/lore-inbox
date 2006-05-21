Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWEULDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWEULDC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 07:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEULDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 07:03:01 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:44996 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932392AbWEULDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 07:03:01 -0400
Date: Sun, 21 May 2006 13:03:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
Message-ID: <20060521110300.GB21117@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org> <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org> <20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520022650.46b048f8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Andrew, could you try this - do newly started processes work fine if you 
> > re-enable the vdso after booting with vdso=0?
> 
> vmm:/home/akpm# echo 1 > /proc/sys/vm/vdso_enabled 
> vmm:/home/akpm# 
> vmm:/home/akpm> ls -l
> zsh: segmentation fault  ls -l

Andrew, could you try the patch below, does your FC1 box work with it 
applied and CONFIG_COMPAT_VDSO enabled? (no need to pass any boot 
options)

The config option reinstates the high mapping, so that old glibc can 
reference it as data (that is i think what happened in the original FC1 
glibc). Newer distributions can (and will) turn this off. The option 
defaults to y, so that we are compatible by default.

( Small additional detail: to further limit the security impact of the
  workaround, the page is nonexec, so on the unlikely chance of someone
  running a FC1 glibc with a new kernel on new, NX-capable hardware
  using the PAE i386 kernel, execution is denied on that page. [i have
  tested this kernel combination and execution is indeed denied in that
  case.] )

	Ingo

---
Subject: vDSO: provide workaround for older glibcs
From: Ingo Molnar <mingo@elte.hu>

this patch adds CONFIG_COMPAT_VDSO (default=y), which provides support
for older glibcs to reference the high-mapped VDSO. Newer distributions
(anything newer than say 2 years) can turn this off.

NOTE: the exec bit is turned off for the vDSO, because glibc only
reference the vDSO, but dont try to execute it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/Kconfig           |    9 +++++++++
 arch/i386/kernel/sysenter.c |    5 +++++
 2 files changed, 14 insertions(+)

Index: linux-vdso-rand.q/arch/i386/Kconfig
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/Kconfig
+++ linux-vdso-rand.q/arch/i386/Kconfig
@@ -762,6 +762,15 @@ config HOTPLUG_CPU
 	  enable suspend on SMP systems. CPUs can be controlled through
 	  /sys/devices/system/cpu.
 
+config COMPAT_VDSO
+	bool "Compat VDSO support"
+	default y
+	help
+	  Map the VDSO to the fixed old-style address too.
+	---help---
+	  Say N here if you are running a sufficiently recent glibc
+	  version, to remove the (unused) high-mapped VDSO mapping.
+	  If unsure, say Y.
 
 endmenu
 
Index: linux-vdso-rand.q/arch/i386/kernel/sysenter.c
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/sysenter.c
+++ linux-vdso-rand.q/arch/i386/kernel/sysenter.c
@@ -69,6 +69,11 @@ int __init sysenter_setup(void)
 {
 	syscall_page = (void *)get_zeroed_page(GFP_ATOMIC);
 
+#ifdef CONFIG_COMPAT_VDSO
+	__set_fixmap(FIX_VSYSCALL, __pa(syscall_page), PAGE_READONLY);
+	printk("Compat vDSO mapped to %08lx.\n", __fix_to_virt(FIX_VSYSCALL));
+#endif
+
 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
 		memcpy(syscall_page,
 		       &vsyscall_int80_start,
