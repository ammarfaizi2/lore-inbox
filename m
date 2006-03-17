Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWCQMbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWCQMbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWCQMbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:31:03 -0500
Received: from fmr23.intel.com ([143.183.121.15]:57746 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932161AbWCQMbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:31:01 -0500
Date: Fri, 17 Mar 2006 04:30:13 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: vatsa@in.ibm.com, ak@muc.de, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Dont create a control file for BSP that cannot be removed
Message-ID: <20060317043013.A13623@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

this patch just doesnt create an online file if the logical cpu cannot be
offlined.

We originally added to support ppc64 if the kernel has support but BIOS indicated
no offline support, we just didnt create online files for them.

We used the same method in ia64 as well, if we have a cpu taking platform interrupts
but cannot be removed if those interrupts cannot be re-targeted to another cpu.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Don't create "online" control file for BSP (i386/x86_64) since its
not removable.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------
 arch/i386/kernel/topology.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/topology.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/topology.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/topology.c
@@ -41,6 +41,15 @@ int arch_register_cpu(int num){
 		parent = &node_devices[node].node;
 #endif /* CONFIG_NUMA */
 
+	/*
+	 * CPU0 cannot be offlined due to several
+	 * restrictions and assumptions in kernel. This basically
+	 * doesnt add a control file, one cannot attempt to offline
+	 * BSP.
+	 */
+	if (!num)
+		cpu_devices[num].cpu.no_control = 1;
+
 	return register_cpu(&cpu_devices[num].cpu, num, parent);
 }
 
