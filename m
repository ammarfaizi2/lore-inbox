Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWFTWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWFTWaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWFTW3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42205 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751363AbWFTW3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:23 -0400
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
Subject: [PATCH 19/25] irq: Remove msi hacks
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:32 -0600
Message-Id: <11508425251099-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <115084252460-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com> <115084252460-git-send-!
 email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the nasty way that CONFIG_PCI_MSI was implemented
we wound up with set_irq_info and set_native_irq_info, with move_irq and
move_native_irq.  Both functions did the same thing but they were
built and called under different circumstances.  Now that the msi hacks
are gone we can kill move_irq and set_irq_info.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/irq.h |   36 ------------------------------------
 1 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 6d1ad88..cfd2f31 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -202,36 +202,6 @@ void set_pending_irq(unsigned int irq, c
 void move_native_irq(int irq);
 void move_masked_irq(int irq);
 
-#ifdef CONFIG_PCI_MSI
-/*
- * Wonder why these are dummies?
- * For e.g the set_ioapic_affinity_vector() calls the set_ioapic_affinity_irq()
- * counter part after translating the vector to irq info. We need to perform
- * this operation on the real irq, when we dont use vector, i.e when
- * pci_use_vector() is false.
- */
-static inline void move_irq(int irq)
-{
-}
-
-static inline void set_irq_info(int irq, cpumask_t mask)
-{
-}
-
-#else /* CONFIG_PCI_MSI */
-
-static inline void move_irq(int irq)
-{
-	move_native_irq(irq);
-}
-
-static inline void set_irq_info(int irq, cpumask_t mask)
-{
-	set_native_irq_info(irq, mask);
-}
-
-#endif /* CONFIG_PCI_MSI */
-
 #else /* CONFIG_GENERIC_PENDING_IRQ || CONFIG_IRQBALANCE */
 
 static inline void move_irq(int irq)
@@ -250,16 +220,10 @@ static inline void set_pending_irq(unsig
 {
 }
 
-static inline void set_irq_info(int irq, cpumask_t mask)
-{
-	set_native_irq_info(irq, mask);
-}
-
 #endif /* CONFIG_GENERIC_PENDING_IRQ */
 
 #else /* CONFIG_SMP */
 
-#define move_irq(x)
 #define move_native_irq(x)
 #define move_masked_irq(x)
 
-- 
1.4.0.gc07e

