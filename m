Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268349AbTBNK5q>; Fri, 14 Feb 2003 05:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268353AbTBNK5q>; Fri, 14 Feb 2003 05:57:46 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:8534
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268349AbTBNK5o>; Fri, 14 Feb 2003 05:57:44 -0500
Date: Fri, 14 Feb 2003 06:06:16 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] flush_tlb_all is not preempt safe.
Message-ID: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Considering that smp_call_function isn't allowed to hold a lock 
reference and within smp_call_function we lock and unlock call_lock thus 
triggering a preempt point. Therefore we can't guarantee that we'll be on 
the same processor when we hit do_flush_tlb_all_local.

void flush_tlb_all(void)
{
	preempt_disable();
	smp_call_function (flush_tlb_all_ipi,0,1,1);

	do_flush_tlb_all_local();
	preempt_enable();
}

...

smp_call_function()
{
	spin_lock(call_lock);
	...
	spin_unlock(call_lock);
	<preemption point>
}

...

do_flush_tlb_all_local() - possibly not executing on same processor 
anymore.

This case is fixed in my smp_call_function_on_cpu patches by not allowing 
smp_call_function to invoke preemption.

Index: linux-2.5.60-uml/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60-uml/arch/i386/kernel/smp.c	10 Feb 2003 22:14:16 -0000	1.1.1.1
+++ linux-2.5.60-uml/arch/i386/kernel/smp.c	14 Feb 2003 10:59:19 -0000
@@ -452,9 +452,11 @@
 
 void flush_tlb_all(void)
 {
+	preempt_disable();
 	smp_call_function (flush_tlb_all_ipi,0,1,1);
 
 	do_flush_tlb_all_local();
+	preempt_enable();
 }
 
 /*

-- 
function.linuxpower.ca
