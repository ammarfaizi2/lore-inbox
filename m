Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSGLWjr>; Fri, 12 Jul 2002 18:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSGLWjR>; Fri, 12 Jul 2002 18:39:17 -0400
Received: from holomorphy.com ([66.224.33.161]:37279 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318046AbSGLWiP>;
	Fri, 12 Jul 2002 18:38:15 -0400
Date: Fri, 12 Jul 2002 15:40:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rml@tech9.net
Subject: NUMA-Q breakage 5/7 in_interrupt() race
Message-ID: <20020712224003.GC25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rml@tech9.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On smaller machines, bootstrapping proceeds far enough to see races
in kmaps near generic_file_read() etc. This is precisely the
in_interrupt() BUG(), but it's quite clear this is happening in
process context. Not even the smaller machines can survive this.
That is, it is impossible to run at all without it (or an equivalent).

Robert, please apply.


Thanks,
Bill


===== include/asm-i386/hardirq.h 1.7 vs edited =====
--- 1.7/include/asm-i386/hardirq.h	Mon May 20 10:51:17 2002
+++ edited/include/asm-i386/hardirq.h	Thu Jul 11 19:51:02 2002
@@ -22,8 +22,24 @@
  * Are we in an interrupt context? Either doing bottom half
  * or hardware interrupt processing?
  */
-#define in_interrupt() ({ int __cpu = smp_processor_id(); \
-	(local_irq_count(__cpu) + local_bh_count(__cpu) != 0); })
+static inline int in_interrupt(void)
+{
+	int total_count, retval, cpu;
+
+	preempt_disable();
+	cpu = smp_processor_id();
+
+	total_count = local_irq_count(cpu) + local_bh_count(cpu);
+
+	if (total_count)
+		retval = 1;
+	else
+		retval = 0;
+
+	preempt_disable();
+
+	return retval;
+}
 
 #define in_irq() (local_irq_count(smp_processor_id()) != 0)
 
