Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSGMI00>; Sat, 13 Jul 2002 04:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318125AbSGMI0Z>; Sat, 13 Jul 2002 04:26:25 -0400
Received: from holomorphy.com ([66.224.33.161]:3489 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318122AbSGMI0Z>;
	Sat, 13 Jul 2002 04:26:25 -0400
Date: Sat, 13 Jul 2002 01:28:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: NUMA-Q breakage 5/7 in_interrupt() race
Message-ID: <20020713082814.GE21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rml@tech9.net
References: <20020712224003.GC25360@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020712224003.GC25360@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ===== include/asm-i386/hardirq.h 1.7 vs edited =====
> +	preempt_disable();
> +
> +	return retval;
> +}

Not sure how it survived running. That should be a preempt_enable() on
the way out. Maybe I should have used the get_cpu()/put_cpu() stuff.

Amended patch follows.


Cheers,
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
+	preempt_enable();
+
+	return retval;
+}
 
 #define in_irq() (local_irq_count(smp_processor_id()) != 0)
 
