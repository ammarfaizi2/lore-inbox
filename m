Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTIEBdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbTIEBdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:33:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30693 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261509AbTIEBdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:33:16 -0400
Subject: [RFC] NR_CPUS=8 on a 32 cpu box
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Dave H <haveblue@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062725220.1307.1562.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Sep 2003 18:27:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All, 

	So, I found the cause of that memory corruption I mentioned last night.
I was booting on the 16x w/ HT and I hadn't taken note that NR_CPUS now
defaults to 8. Whoops. Ends up there isn't any bounds checking when
bringing up the cpus, thus we overflow bios_cpu_apicid[]. 

Here's a quick patch that checks if num_processors has hit NR_CPUS. 
Seems to fix it for me.

Let me know if you have any comments or suggestions. 

thanks
-john

===== arch/i386/kernel/mpparse.c 1.49 vs edited =====
--- 1.49/arch/i386/kernel/mpparse.c	Sun Aug 31 16:14:25 2003
+++ edited/arch/i386/kernel/mpparse.c	Thu Sep  4 18:07:15 2003
@@ -167,6 +167,10 @@
 		boot_cpu_logical_apicid = apicid;
 	}
 
+	if (num_processors > NR_CPUS){
+		printk(KERN_WARNING "NR_CPUS limit of %i reached. Cannot boot CPU(apicid 0x%d).\n", NR_CPUS, m->mpc_apicid);
+		return;
+	}
 	num_processors++;
 
 	if (MAX_APICS - m->mpc_apicid <= 0) {



