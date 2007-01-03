Return-Path: <linux-kernel-owner+w=401wt.eu-S1750716AbXACLej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbXACLej (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 06:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbXACLei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 06:34:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:36993 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbXACLei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 06:34:38 -0500
Date: Wed, 3 Jan 2007 17:04:30 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 1/4] i386: Fix modpost warning in SMP trampoline code
Message-ID: <20070103113430.GF17546@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o MODPOST generates warning for i386 if kernel is compiled with 
  CONFIG_RELOCATABLE=y

WARNING: vmlinux - Section mismatch: reference to .init.text:startup_32_smp
from .data between 'trampoline_data' (at offset 0xc0519cf8) and 'boot_gdt'

o trampoline code/data can go into init section is CPU hotplug is not 
  enabled.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/trampoline.S |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN arch/i386/kernel/trampoline.S~i386-fix-modpost-warning-in-smp-trampoline-code arch/i386/kernel/trampoline.S
--- linux-2.6.20-rc2-mm1-reloc/arch/i386/kernel/trampoline.S~i386-fix-modpost-warning-in-smp-trampoline-code	2007-01-03 11:56:19.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/arch/i386/kernel/trampoline.S	2007-01-03 11:56:19.000000000 +0530
@@ -38,6 +38,11 @@
 
 .data
 
+/* We can free up trampoline after bootup if cpu hotplug is not supported. */
+#ifndef CONFIG_HOTPLUG_CPU
+.section ".init.data","aw",@progbits
+#endif
+
 .code16
 
 ENTRY(trampoline_data)
_
