Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWHGP1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWHGP1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWHGP1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:27:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16864 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932150AbWHGP1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:27:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Date: Mon, 07 Aug 2006 09:26:21 -0600
Message-ID: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currrently on a SMP system we can theoretically support
NR_CPUS*224 irqs.  Unfortunately our data structures
don't cope will with that many irqs, nor does hardware
typically provide that many irq sources.

With the number of cores starting to follow Moores
law, and the apicid limits being raised beyond an 8bit
number trying to track our current maximum with our
current data structures would be fatal and wasteful.

So this patch decouples the number of irqs we support
from the number of cpus.  We can revisit this decision
once someone reworks the current data structures.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/Kconfig      |   13 +++++++++++++
 include/asm-x86_64/irq.h |    3 ++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 7598d99..d744e5b 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -384,6 +384,19 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU requires
 	  memory in the static kernel configuration.
 
+config NR_IRQS
+	int "Maximum number of IRQs (224-4096)"
+	range 256 4096
+	depends on SMP
+	default "4096"
+	help
+	  This allows you to specify the maximum number of IRQs which this
+	  kernel will support. Current maximum is 4096 IRQs as that
+	  is slightly larger than has observed in the field.
+
+	  This is purely to save memory - each supported IRQ requires
+	  memory in the static kernel configuration.
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

