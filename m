Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267608AbUG3FWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267608AbUG3FWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267611AbUG3FWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:22:30 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26315 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267608AbUG3FW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:22:27 -0400
Date: Fri, 30 Jul 2004 10:54:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Lynch <nathanl@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Fix cpu_up race
Message-ID: <20040730052413.GB32010@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1091052774.24763.14.camel@pants.austin.ibm.com> <20040729052716.GA24612@in.ibm.com> <20040729053011.GC6456@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729053011.GC6456@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:30:11PM +1000, Anton Blanchard wrote:
>  
> > I think Anton pushed this to ameslab. I presume there should be some mechanism
> > for ameslab stuff to be included mainline. If there is such mechanism, then
> > I dont want to push the patch myself.
> 
> It looks good, could you send it directly to akpm, ccing me?

Andrew,
	Patch below fixes a cpu_up race in PPC64. Please apply.


Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>
Signed-off-by : Anton Blanchard <anton@samba.org>


---

 linux-2.6.8-rc2-vatsa/arch/ppc64/kernel/smp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN arch/ppc64/kernel/smp.c~ppc64_cpu_up_fix arch/ppc64/kernel/smp.c
--- linux-2.6.8-rc2/arch/ppc64/kernel/smp.c~ppc64_cpu_up_fix	2004-07-30 10:33:55.000000000 +0530
+++ linux-2.6.8-rc2-vatsa/arch/ppc64/kernel/smp.c	2004-07-30 10:34:02.000000000 +0530
@@ -927,7 +927,11 @@ int __devinit __cpu_up(unsigned int cpu)
 
 	if (smp_ops->give_timebase)
 		smp_ops->give_timebase();
-	cpu_set(cpu, cpu_online_map);
+
+	/* Wait until cpu puts itself in the online map */
+	while (!cpu_online(cpu))
+		cpu_relax();
+
 	return 0;
 }
 
@@ -963,6 +967,10 @@ int __devinit start_secondary(void *unus
 #endif
 #endif
 
+	spin_lock(&call_lock);
+	cpu_set(cpu, cpu_online_map);
+	spin_unlock(&call_lock);
+
 	local_irq_enable();
 
 	return cpu_idle(NULL);

_

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
