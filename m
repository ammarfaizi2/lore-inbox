Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWFTW3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWFTW3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWFTW3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41437 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751379AbWFTW3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:22 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 20/25] irq: Generalize the check for HARDIRQ_BITS.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:33 -0600
Message-Id: <11508425253581-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425251099-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com> <115084252460-git-send-!
 email-ebiederm@xmission.com> <11508425251099-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for systems that cannot receive every interrupt
on a single cpu simultaneously, in the check to see if we have enough HARDIRQ_BITS.

MAX_HARDIRQS_PER_CPU becomes the count of the maximum number of hardare
generated interrupts per cpu.

On architectures that support per cpu interrupt delivery this can be a
significant space savings and scalability bonus.

This patch adds support for systems that cannot receive every interrupt on

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/asm-x86_64/hardirq.h |    3 +++
 include/linux/hardirq.h      |    7 ++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86_64/hardirq.h b/include/asm-x86_64/hardirq.h
index 64a65ce..95d5e09 100644
--- a/include/asm-x86_64/hardirq.h
+++ b/include/asm-x86_64/hardirq.h
@@ -6,6 +6,9 @@ #include <linux/irq.h>
 #include <asm/pda.h>
 #include <asm/apic.h>
 
+/* We can have at most NR_VECTORS irqs routed to a cpu at a time */
+#define MAX_HARDIRQS_PER_CPU NR_VECTORS
+
 #define __ARCH_IRQ_STAT 1
 
 #define local_softirq_pending() read_pda(__softirq_pending)
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index ccabda7..f60b8c3 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -27,11 +27,16 @@ #define SOFTIRQ_BITS	8
 
 #ifndef HARDIRQ_BITS
 #define HARDIRQ_BITS	12
+
+#ifndef MAX_HARDIRQS_PER_CPU
+#define MAX_HARDIRQS_PER_CPU NR_IRQS
+#endif
+
 /*
  * The hardirq mask has to be large enough to have space for potentially
  * all IRQ sources in the system nesting on a single CPU.
  */
-#if (1 << HARDIRQ_BITS) < NR_IRQS
+#if (1 << HARDIRQ_BITS) < MAX_HARDIRQS_PER_CPU
 # error HARDIRQ_BITS is too low!
 #endif
 #endif
-- 
1.4.0.gc07e

