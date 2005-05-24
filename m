Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVEXKV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVEXKV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVEXKVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:21:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:56028 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261890AbVEXKOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:14:07 -0400
Date: Tue, 24 May 2005 15:45:32 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@muc.de, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: [PATCH 1/5] Kprobes: Temporary disarming of reentrant probe
Message-ID: <20050524101532.GA27215@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please provide your feedback on this patchset.

Thanks
Prasanna

In situations where a kprobes handler calls a routine which has a probe on it,
then kprobes_handler() disarms the new probe forever. This patch removes the
above limitation by temporarily disarming the new probe. When the another probe
hits while handling the old probe, the kprobes_handler() saves previous kprobes
state and handles the new probe without calling the new kprobes registered
handlers. kprobe_post_handler() restores back the previous kprobes state and the
normal execution continues.
However on x86_64 architecture, re-rentrancy is provided only through
pre_handler(). If a routine having probe is referenced through post_handler(),
then the probes on that routine are disarmed forever, since the exception stack
is gets changed after the processor single steps the instruction of the new
probe.

This patch includes generic changes to support temporary disarming on
reentrancy of probes.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
---


---

 linux-2.6.12-rc4-mm2-prasanna/include/linux/kprobes.h |    9 +++++++++
 linux-2.6.12-rc4-mm2-prasanna/kernel/kprobes.c        |    1 +
 2 files changed, 10 insertions(+)

diff -puN include/linux/kprobes.h~kprobes-temporary-disarming-on-reentrancy-generic include/linux/kprobes.h
--- linux-2.6.12-rc4-mm2/include/linux/kprobes.h~kprobes-temporary-disarming-on-reentrancy-generic	2005-05-24 15:28:08.000000000 +0530
+++ linux-2.6.12-rc4-mm2-prasanna/include/linux/kprobes.h	2005-05-24 15:28:08.000000000 +0530
@@ -36,6 +36,12 @@
 
 #include <asm/kprobes.h>
 
+/* kprobe_status settings */
+#define KPROBE_HIT_ACTIVE	0x00000001
+#define KPROBE_HIT_SS		0x00000002
+#define KPROBE_REENTER		0x00000004
+#define KPROBE_HIT_SSDONE	0x00000008
+
 struct kprobe;
 struct pt_regs;
 struct kretprobe;
@@ -55,6 +61,9 @@ struct kprobe {
 	/* list of kprobes for multi-handler support */
 	struct list_head list;
 
+	/*count the number of times this probe was temporarily disarmed */
+	unsigned long nmissed;
+
 	/* location of the probe point */
 	kprobe_opcode_t *addr;
 
diff -puN kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-generic kernel/kprobes.c
--- linux-2.6.12-rc4-mm2/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-generic	2005-05-24 15:28:08.000000000 +0530
+++ linux-2.6.12-rc4-mm2-prasanna/kernel/kprobes.c	2005-05-24 15:28:08.000000000 +0530
@@ -334,6 +334,7 @@ int register_kprobe(struct kprobe *p)
 	}
 	spin_lock_irqsave(&kprobe_lock, flags);
 	old_p = get_kprobe(p->addr);
+	p->nmissed = 0;
 	if (old_p) {
 		ret = register_aggr_kprobe(old_p, p);
 		goto out;

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
