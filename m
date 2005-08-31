Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVHaVxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVHaVxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHaVxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:53:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:23522 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932534AbVHaVxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:53:47 -0400
Subject: [PATCH] Fix kprobes handling of simultaneous probe hit/unregister
From: Jim Keniston <jkenisto@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Prasanna Panchamukhi <ppancham@in.ibm.com>,
       SystemTAP <systemtap@sources.redhat.com>,
       "David S. Miller" <davem@davemloft.net>
Content-Type: multipart/mixed; boundary="=-zgYfx1Bn8aG6cqpfYv33"
Organization: 
Message-Id: <1125525217.2855.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 31 Aug 2005 14:53:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zgYfx1Bn8aG6cqpfYv33
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a bug in kprobes's handling of a corner case on i386
and x86_64.  On an SMP system, if one CPU unregisters a kprobe just
after another CPU hits that probepoint, kprobe_handler() on the latter
CPU sees that the kprobe has been unregistered, and attempts to let the
CPU continue as if the probepoint hadn't been hit.  The bug is that on
i386 and x86_64, we were neglecting to set the IP back to the beginning
of the probed instruction.  This could cause an oops or crash.

This bug doesn't exist on ppc64 and ia64, where a breakpoint
instruction leaves the IP pointing to the beginning of the instruction.
I don't know about sparc64.  (Dave, could you please advise?)

This fix has been tested on i386 and x86_64 SMP systems.  To reproduce
the problem, set one CPU to work registering and unregistering a kprobe
repeatedly, and another CPU pounding the probepoint in a tight loop.

Please apply.

Acked-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>

--=-zgYfx1Bn8aG6cqpfYv33
Content-Disposition: attachment; filename=kprobes_unregister_fix.patch
Content-Type: text/plain; name=kprobes_unregister_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.13/arch/i386/kernel/kprobes.c	2005-08-30 12:27:35.000000000 -0700
+++ linux-fixed/arch/i386/kernel/kprobes.c	2005-08-30 15:33:03.000000000 -0700
@@ -220,7 +220,10 @@
 			 * either a probepoint or a debugger breakpoint
 			 * at this address.  In either case, no further
 			 * handling of this interrupt is appropriate.
+			 * Back up over the (now missing) int3 and run
+			 * the original instruction.
 			 */
+			regs->eip -= sizeof(kprobe_opcode_t);
 			ret = 1;
 		}
 		/* Not one of ours: let kernel handle it */
--- linux-2.6.13/arch/x86_64/kernel/kprobes.c	2005-08-30 12:27:35.000000000 -0700
+++ linux-fixed/arch/x86_64/kernel/kprobes.c	2005-08-30 15:32:31.000000000 -0700
@@ -360,7 +360,10 @@
 			 * either a probepoint or a debugger breakpoint
 			 * at this address.  In either case, no further
 			 * handling of this interrupt is appropriate.
+			 * Back up over the (now missing) int3 and run
+			 * the original instruction.
 			 */
+			regs->rip = (unsigned long)addr;
 			ret = 1;
 		}
 		/* Not one of ours: let kernel handle it */

--=-zgYfx1Bn8aG6cqpfYv33--

