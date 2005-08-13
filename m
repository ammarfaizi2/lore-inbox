Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVHMBA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVHMBA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 21:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVHMBA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 21:00:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54001 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932073AbVHMBA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 21:00:27 -0400
Message-ID: <42FD4593.9030702@mvista.com>
Date: Fri, 12 Aug 2005 17:57:55 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ryan Brown <some.nzguy@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High
 Resolution Timers & RCU-tasklist features
References: <20050811110051.GA20872@elte.hu>	 <1c1c8636050812172817b14384@mail.gmail.com> <1123893158.12680.70.camel@mindpipe>
In-Reply-To: <1123893158.12680.70.camel@mindpipe>
Content-Type: multipart/mixed;
 boundary="------------010202000701000905080004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010202000701000905080004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo, all

I, silly person that I am, configured an RT, SMP, PREEMPT_DEBUG system. 
  Someone put code in the NMI path to modify the preempt count which, 
often as not will generate a PREEMPT_DEBUG message as there is no tell 
what state the preempt count is in on an NMI interrupt.  I have sent the 
attached patch to Andrew on this, but meanwhile, if you want RT, SMP, 
PREEMPT_DEBUG you will be much better off with this.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------010202000701000905080004
Content-Type: text/plain;
 name="fix-nmi-enter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-nmi-enter.patch"

Source: MontaVista Software, Inc. George Anzinger <george@mvista.com>
Type: Defect Fix 

Description:

    Modifying a word from NMI code runs the very real risk of loosing
    either then new or the old bits.  Remember, we can not prevent an
    NMI interrupt from ANYWHERE, inparticular between the read and the
    write of a read modify write sequence.

    This patch removes the update of the preempt count from the NMI
    path.

Signed-off-by: George Anzinger<george@mvista.com>

 hardirq.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.13-rc/include/linux/hardirq.h
===================================================================
--- linux-2.6.13-rc.orig/include/linux/hardirq.h
+++ linux-2.6.13-rc/include/linux/hardirq.h
@@ -98,9 +98,12 @@ extern void synchronize_irq(unsigned int
 #else
 # define synchronize_irq(irq)	barrier()
 #endif
-
-#define nmi_enter()		irq_enter()
-#define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
+/*
+ * Re think these.  NMI _must_not_ share data words with non-nmi code
+ * Meanwhile, just do a no-op.
+ */
+#define nmi_enter()	/*	irq_enter()  */
+#define nmi_exit()	/*	sub_preempt_count(HARDIRQ_OFFSET) */
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 static inline void account_user_vtime(struct task_struct *tsk)

--------------010202000701000905080004--
