Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWINVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWINVud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWINVu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:50:28 -0400
Received: from mga07.intel.com ([143.182.124.22]:45722 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751182AbWINVuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:50:25 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,166,1157353200"; 
   d="scan'208"; a="116665086:sNHT86089360"
Date: Thu, 14 Sep 2006 14:34:34 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Linux IA64 <linux-ia64@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Systemtap <systemtap@sources.redhat.com>
Subject: [PATCH] Kprobes - fixup the pagefault exception caused by probehandlers
Message-ID: <20060914143433.B30207@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the user-specified kprobe handler causes the page fault
when accessing user space address, fixup this fault since
do_page_fault() should not continue as the kprobe handler are
run with preemption disabled.

Please apply.


Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---
 arch/ia64/kernel/kprobes.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: 2.6.18-rc6-git2/arch/ia64/kernel/kprobes.c
===================================================================
--- 2.6.18-rc6-git2.orig/arch/ia64/kernel/kprobes.c
+++ 2.6.18-rc6-git2/arch/ia64/kernel/kprobes.c
@@ -768,6 +768,12 @@ static int __kprobes kprobes_fault_handl
 		 */
 		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
 			return 1;
+		/*
+		 * In case the user-specified fault handler returned
+		 * zero, try to fix up.
+		 */
+		if (ia64_done_with_exception(regs))
+			return 1;
 
 		/*
 		 * In case the user-specified fault handler returned
