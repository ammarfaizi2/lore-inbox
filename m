Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273272AbTHFC0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273273AbTHFC0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:26:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1174 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S273272AbTHFC0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:26:11 -0400
Subject: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt <colpatch@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060136258.10738.31.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Aug 2003 19:17:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	I've been noticing occasional (and with some kernels, not so
ocassional) hangs after the mtrr init call. Booting with
"initcall_debug" pointed the finger at init_bio(), but further
investigation showed that cpus were actually getting hung in the mtrr
ipi_handler, thus they could not respond to the smp_call_function made
deeper within init_bio(). 

I've found a race in the mtrr ipi_handler() and set_mtrr() functions.

Basically the server, set_mtrr() does the following:

1.1 initialize a flag
1.2 send ipi
1.3 waits for all cpus to check in
1.4 toggle flag
1.5 do stuff
1.6 wait for all cpus to check out
1.7 toggle flag again
1.8 return

While the clients, running ipi_handler() do the following:

2.1 check in
2.2 wait for flag
2.3 do stuff
2.4 check out
2.5 wait for flag
2.6 return

The problem is the flag is on the servers stack! So if 1.7 and 1.8
executes before 2.5 happens, the client's pointer to the flag becomes
invalid (likely overwritten) which causes the client to never see the
flag change, hanging the box.

I believe the solution to this is to just remove the needless
synchronization steps: 1.7 and 2.5. Once all the clients have checked
out, there is no reason to have them hang around only to return all at
once. The final flagging seems needless and racy. 

Amazingly this has been in the kernel for about a year, yet its not
bothered me until very recently. Go figure. 

Please review and comment on the following fix. Please let me know if
I'm just wrong and the final flagging is more needed then I think. 

thanks
-john

diff -Nru a/arch/i386/kernel/cpu/mtrr/main.c b/arch/i386/kernel/cpu/mtrr/main.c
--- a/arch/i386/kernel/cpu/mtrr/main.c	Tue Aug  5 18:45:17 2003
+++ b/arch/i386/kernel/cpu/mtrr/main.c	Tue Aug  5 18:45:17 2003
@@ -165,10 +165,6 @@
 		mtrr_if->set_all();
 
 	atomic_dec(&data->count);
-	while(atomic_read(&data->gate)) {
-		cpu_relax();
-		barrier();
-	}
 	local_irq_restore(flags);
 }
 
@@ -257,7 +253,6 @@
 		barrier();
 	}
 	local_irq_restore(flags);
-	atomic_set(&data.gate,0);
 }
 
 /**



