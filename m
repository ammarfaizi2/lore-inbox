Return-Path: <linux-kernel-owner+w=401wt.eu-S932785AbWL0LwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWL0LwI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWL0LwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:52:07 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49831 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791AbWL0LwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:52:05 -0500
Date: Wed, 27 Dec 2006 17:20:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2/4] i386: make apic probe function non-init
Message-ID: <20061227115022.GB22606@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o struct genapic contains pointer to probe() function which is of type
  __init. Hence MODPOST generates warning if kernel is compiled with
  CONFIG_RELOCATABLE=y for i386.

WARNING: vmlinux - Section mismatch: reference to .init.text: from .data between 'apic_summit' (at offset 0xc058b504) and 'apic_bigsmp'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .data between 'apic_bigsmp' (at offset 0xc058b5a4) and 'cpu.4471'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .data between 'apic_es7000' (at offset 0xc058b644) and 'apic_default'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .data between 'apic_default' (at offset 0xc058b6e4) and 'interrupt'

o One of the possible options is to put special case check in MODPOST to
  not emit warnings for this case but I think it is not a very good option
  in terms of maintenance.

o Another option is to make probe() function non __init. Anyway this function
  is really small so not freeing this memory after init is not a big deal.
  Secondly, from a programming perspective, probably genapic should not
  provide pointers to functions which have been freed as genapic is non
  __init and is used even after initialization is complete. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/mach-generic/bigsmp.c  |    2 +-
 arch/i386/mach-generic/default.c |    2 +-
 arch/i386/mach-generic/es7000.c  |    2 +-
 arch/i386/mach-generic/summit.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/i386/mach-generic/bigsmp.c~i386-make-apic-probe-function-non-init arch/i386/mach-generic/bigsmp.c
--- linux-2.6.20-rc2-reloc/arch/i386/mach-generic/bigsmp.c~i386-make-apic-probe-function-non-init	2006-12-27 16:24:58.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/arch/i386/mach-generic/bigsmp.c	2006-12-27 16:24:58.000000000 +0530
@@ -45,7 +45,7 @@ static struct dmi_system_id __initdata b
 };
 
 
-static __init int probe_bigsmp(void)
+static int probe_bigsmp(void)
 { 
 	if (def_to_bigsmp)
         	dmi_bigsmp = 1;
diff -puN arch/i386/mach-generic/default.c~i386-make-apic-probe-function-non-init arch/i386/mach-generic/default.c
--- linux-2.6.20-rc2-reloc/arch/i386/mach-generic/default.c~i386-make-apic-probe-function-non-init	2006-12-27 16:24:58.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/arch/i386/mach-generic/default.c	2006-12-27 16:24:58.000000000 +0530
@@ -18,7 +18,7 @@
 #include <asm/mach-default/mach_mpparse.h>
 
 /* should be called last. */
-static __init int probe_default(void)
+static int probe_default(void)
 { 
 	return 1;
 } 
diff -puN arch/i386/mach-generic/es7000.c~i386-make-apic-probe-function-non-init arch/i386/mach-generic/es7000.c
--- linux-2.6.20-rc2-reloc/arch/i386/mach-generic/es7000.c~i386-make-apic-probe-function-non-init	2006-12-27 16:24:58.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/arch/i386/mach-generic/es7000.c	2006-12-27 16:24:58.000000000 +0530
@@ -19,7 +19,7 @@
 #include <asm/mach-es7000/mach_mpparse.h>
 #include <asm/mach-es7000/mach_wakecpu.h>
 
-static __init int probe_es7000(void)
+static int probe_es7000(void)
 {
 	/* probed later in mptable/ACPI hooks */
 	return 0;
diff -puN arch/i386/mach-generic/summit.c~i386-make-apic-probe-function-non-init arch/i386/mach-generic/summit.c
--- linux-2.6.20-rc2-reloc/arch/i386/mach-generic/summit.c~i386-make-apic-probe-function-non-init	2006-12-27 16:24:58.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/arch/i386/mach-generic/summit.c	2006-12-27 16:24:58.000000000 +0530
@@ -18,7 +18,7 @@
 #include <asm/mach-summit/mach_ipi.h>
 #include <asm/mach-summit/mach_mpparse.h>
 
-static __init int probe_summit(void)
+static int probe_summit(void)
 { 
 	/* probed later in mptable/ACPI hooks */
 	return 0;
_
