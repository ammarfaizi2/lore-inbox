Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbTABSVu>; Thu, 2 Jan 2003 13:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTABSVt>; Thu, 2 Jan 2003 13:21:49 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:49381 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266298AbTABSVn>;
	Thu, 2 Jan 2003 13:21:43 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15892.34096.565694.402521@napali.hpl.hp.com>
Date: Thu, 2 Jan 2003 10:30:08 -0800
To: "Andrey Panin" <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation (common part)
In-Reply-To: <20021224060331.GA1090@pazke>
References: <20021224060331.GA1090@pazke>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 24 Dec 2002 09:03:31 +0300, "Andrey Panin" <pazke@orbita1.ru> said:

  Andrey> Hi all, this patch moves some common parts of irq handling
  Andrey> code to one place.  Arch specific patches will follow. Patch
  Andrey> for i386 is tested and performed well, but other arch
  Andrey> specific patched are not. Please take a look.

  Andrey> Please CC me answering this letter, I'm not subscribed to
  Andrey> lkml currently.

+/*
+ * Controller mappings for all interrupt sources:
+ */
+irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
+	[0 ... NR_IRQS - 1] = {
+		.handler =	&no_irq_type,
+		.lock =		SPIN_LOCK_UNLOCKED,
+	}
+};

This isn't good.  For example, NUMA platforms with per-CPU irqs want
to allocate the irq descriptors in local memory.  On ia64, we
introduced a minimal irq-descriptor API for this purpose:

	/* Return a pointer to the irq descriptor for IRQ.  */
	static inline struct irq_desc * irq_desc (int irq);

	/* Extract the IA-64 vector that corresponds to IRQ.  */
	static inline ia64_vector irq_to_vector (int irq);

	/*
	 * Convert the local IA-64 vector to the corresponding irq number.
	 * This translation is done in the context of the interrupt domain
	 * that the currently executing CPU belongs to.
	 */
	static inline unsigned int local_vector_to_irq (ia64_vector vec);

I think the platform-independent part of the code really would only
need the first routine irq_desc().  The other two are ia64-specific.

BTW: if you haven't done so already, I'd suggest to take a look at
arch/ia64/kernel/irq.c.  I tried to keep this code as close as
possible to the x86 version.  There shouldn't be anything in there
that isn't wanted for a good reason.

Thanks,

	--david
