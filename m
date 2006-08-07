Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWHGRbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWHGRbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHGRbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:31:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25060 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932246AbWHGRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:31:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
Date: Mon, 07 Aug 2006 11:30:24 -0600
In-Reply-To: <20060807085924.72f832af.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 7 Aug 2006 08:59:24 -0700")
Message-ID: <m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com>
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

This version has my stupid typos fix and the true maximum
exposed to make it clear that I have a low default.  The
worst that I can see happening is there won't be any
per_cpu space left for modules if someone sets this
too high, but the system should still boot.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

This of course applies to the -mm tree because the rest
of the irq work is not yet in the mainline kernel.

 arch/x86_64/Kconfig      |   14 ++++++++++++++
 include/asm-x86_64/irq.h |    3 ++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 7598d99..cea78d7 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -384,6 +384,20 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU requires
 	  memory in the static kernel configuration.
 
+config NR_IRQS
+	int "Maximum number of IRQs (224-57344)"
+	range 224 57344
+	depends on SMP
+	default "4096"
+	help
+	  This allows you to specify the maximum number of IRQs which this
+	  kernel will support. Current default is 4096 IRQs as that
+	  is slightly larger than has observed in the field.  Setting
+	  a noticeably larger value will exhaust your per cpu memory,
+	  and waste memory in the per irq arrays.
+
+	  If unsure leave this at 4096.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL
diff --git a/include/asm-x86_64/irq.h b/include/asm-x86_64/irq.h
index 5006c6e..34b264a 100644
--- a/include/asm-x86_64/irq.h
+++ b/include/asm-x86_64/irq.h
@@ -31,7 +31,8 @@ #define NR_VECTORS 256
 
 #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
 
-#define NR_IRQS (NR_VECTORS + (32 *NR_CPUS))
+/* We can use at most NR_CPUS*224 irqs at one time */
+#define NR_IRQS (CONFIG_NR_IRQS)
 #define NR_IRQ_VECTORS NR_IRQS
 
 static __inline__ int irq_canonicalize(int irq)
-- 
1.4.2.rc3.g7e18e

