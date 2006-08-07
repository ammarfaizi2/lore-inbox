Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWHGWLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWHGWLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWHGWLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:11:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30941 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751155AbWHGWLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:11:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
	<m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com>
	<20060807105537.08557636.rdunlap@xenotime.net>
	<m1psfcbcnk.fsf@ebiederm.dsl.xmission.com>
	<20060807120454.79b6e1dc.rdunlap@xenotime.net>
Date: Mon, 07 Aug 2006 16:10:14 -0600
In-Reply-To: <20060807120454.79b6e1dc.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 7 Aug 2006 12:04:54 -0700")
Message-ID: <m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently on a SMP system we can theoretically support
NR_CPUS*224 irqs.  Unfortunately our data structures
don't cope will with that many irqs, nor does hardware
typically provide that many irq sources.

With the number of cores starting to follow Moore's Law,
and the apicid limits being raised beyond an 8bit
number trying to track our current maximum with our
current data structures would be fatal and wasteful.

So this patch decouples the number of irqs we support
from the number of cpus.  We can revisit this decision
once someone reworks the current data structures.

This version has my stupid typos fixed and the true maximum
exposed to make it clear that I have a low default.  The
worst that I can see happening is there won't be any
per_cpu space left for modules if someone sets this
too high, but the system should still boot.

For non-SMP systems the default is no set to 224 IRQs.

The description has been reworded in an attempt
to make it clear what this option controls.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/Kconfig      |   25 +++++++++++++++++++++++++
 include/asm-x86_64/irq.h |    3 ++-
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 7598d99..adcbb21 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -384,6 +384,31 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU requires
 	  memory in the static kernel configuration.
 
+config NR_IRQS
+	int "Maximum number of IRQs (224-57344)"
+	range 224 57344
+	default "4096" if SMP
+	default "224" if !SMP
+	help
+	  This option allows you to specify the maximum number of interrupt
+	  sources your kernel will support.  Architecturally there are 
+	  224 interrupt destinations per cpu, so setting to a higher value
+	  can be wasteful.
+	  
+	  Many machines have irq controllers with unconnected interrupt
+	  pins, leading to unused irq numbers in the kernel.  Since a
+	  destination is not assigned to an unused interrupt source
+	  it can be reasonable to support more interrupt sources then
+	  there are destinations to receive them.
+
+	  The current recommended value is 4096 as it is slightly more irqs
+	  than any known machine and still small enough to have a
+	  reasonable memory consumption. Setting a noticeably larger value
+	  will exhaust your per cpu memory, and waste memory in the per irq
+	  arrays.
+
+	  If unsure leave this at the default.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL
diff --git a/include/asm-x86_64/irq.h b/include/asm-x86_64/irq.h
index 5006c6e..b0f6460 100644
--- a/include/asm-x86_64/irq.h
+++ b/include/asm-x86_64/irq.h
@@ -31,7 +31,8 @@ #define NR_VECTORS 256
 
 #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
 
-#define NR_IRQS (NR_VECTORS + (32 *NR_CPUS))
+/* We can be setup to receive at most NR_CPUS*224 irqs simultaneously */
+#define NR_IRQS (CONFIG_NR_IRQS)
 #define NR_IRQ_VECTORS NR_IRQS
 
 static __inline__ int irq_canonicalize(int irq)
-- 
1.4.2.rc3.g7e18e

