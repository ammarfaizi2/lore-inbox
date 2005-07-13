Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVGMEvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVGMEvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 00:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVGMEvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 00:51:23 -0400
Received: from fmr22.intel.com ([143.183.121.14]:62858 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262577AbVGMEvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 00:51:21 -0400
Date: Tue, 12 Jul 2005 21:51:02 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       prasanna@in.ibm.com
Subject: Re: [PATCH]Kprobes IA64 - Fix race when break hits and kprobe not found
Message-ID: <20050712215101.A9616@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050712185230.A8528@unix-os.sc.intel.com> <20050712190231.789da83c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050712190231.789da83c.akpm@osdl.org>; from akpm@osdl.org on Tue, Jul 12, 2005 at 07:02:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 07:02:31PM -0700, Andrew Morton wrote:
> Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
> >
> > This patch applies on top of  "Prasanna S Panchamukhi's" recent postings
> >  Kprobes: Prevent possible race condition ia64 changes
> 
> I am not aware of such a patch.  Your patch hit a reject when I tried to
> apply it to Linus's tree.  So I don't know what's going on..

Andrew,
	This should apply cleanly ontop of Linus's tree.

----------------------------------------------------------
This patch addresses a potential race condition for a case where
Kprobe has been removed right after another CPU has taken
a break hit.

The way this is addressed here is when the CPU that has taken a break hit
does not find its corresponding kprobe, then we check to see if the
original instruction got replaced with other than break. If it got
replaced with other than break instruction, then we continue to execute
from the replaced instruction, else if we find that it is still a break, then
we let the kernel handle this, as this might be the break instruction inserted by
other than kprobe(may be kernel debugger).

This patch applies on top of  "Prasanna S Panchamukhi's" recent postings
Kprobes: Prevent possible race condition ia64 changes

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
=======================================================================
 arch/ia64/kernel/kprobes.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+)

Index: linux-2.6.13-rc2-mm2/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.13-rc2-mm2.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.13-rc2-mm2/arch/ia64/kernel/kprobes.c
@@ -545,6 +545,38 @@ static void prepare_ss(struct kprobe *p,
 	ia64_psr(regs)->ss = 1;
 }
 
+static int is_ia64_break_inst(struct pt_regs *regs)
+{
+	unsigned int slot = ia64_psr(regs)->ri;
+	unsigned int template, major_opcode;
+	unsigned long kprobe_inst;
+	unsigned long *kprobe_addr = (unsigned long *)regs->cr_iip;
+	bundle_t bundle;
+
+	memcpy(&bundle, kprobe_addr, sizeof(bundle_t));
+	template = bundle.quad0.template;
+
+	/* Move to slot 2, if bundle is MLX type and kprobe slot is 1 */
+ 	if (slot == 1 && bundle_encoding[template][1] == L)
+   		slot++;
+
+	/* Get Kprobe probe instruction at given slot*/
+	get_kprobe_inst(&bundle, slot, &kprobe_inst, &major_opcode);
+
+ 	/* For break instruction,
+ 	 * Bits 37:40 Major opcode to be zero
+	 * Bits 27:32 X6 to be zero
+	 * Bits 32:35 X3 to be zero
+	 */
+	if (major_opcode || ((kprobe_inst >> 27) & 0x1FF) ) {
+		/* Not a break instruction */
+		return 0;
+	}
+
+ 	/* Is a break instruction */
+	return 1;
+}
+
 static int pre_kprobes_handler(struct die_args *args)
 {
 	struct kprobe *p;
@@ -592,6 +624,19 @@ static int pre_kprobes_handler(struct di
 	p = get_kprobe(addr);
 	if (!p) {
 		unlock_kprobes();
+		if (!is_ia64_break_inst(regs)) {
+			/*
+			 * The breakpoint instruction was removed right
+			 * after we hit it.  Another cpu has removed
+			 * either a probepoint or a debugger breakpoint
+			 * at this address.  In either case, no further
+			 * handling of this interrupt is appropriate.
+			 */
+			ret = 1;
+
+		}
+
+		/* Not one of our break, let kernel handle it */
 		goto no_kprobe;
 	}
 
