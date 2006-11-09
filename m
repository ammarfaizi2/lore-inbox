Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423726AbWKIBuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423726AbWKIBuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161783AbWKIBuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:50:05 -0500
Received: from mga07.intel.com ([143.182.124.22]:5801 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161782AbWKIBuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:50:02 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="143342213:sNHT19927999"
Date: Wed, 8 Nov 2006 17:27:32 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: ak@suse.de, akpm@osdl.org
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com, greg@kroah.com
Subject: [patch 2/4] i386: introduce the mechanism of disabling cpu hotplug control
Message-ID: <20061108172732.C10294@unix-os.sc.intel.com>
References: <20061108172017.A10294@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061108172017.A10294@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Wed, Nov 08, 2006 at 05:20:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'enable_cpu_hotplug' flag and when cleared, the hotplug control file
("online") will not be added under /sys/devices/system/cpu/cpuX/

Next patch doing PCI quirks will use this.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/arch/i386/kernel/topology.c b/arch/i386/kernel/topology.c
index 07d6da3..844c08f 100644
--- a/arch/i386/kernel/topology.c
+++ b/arch/i386/kernel/topology.c
@@ -40,14 +40,18 @@ int arch_register_cpu(int num)
 	 * restrictions and assumptions in kernel. This basically
 	 * doesnt add a control file, one cannot attempt to offline
 	 * BSP.
+	 *
+	 * Also certain PCI quirks require not to enable hotplug control
+	 * for all CPU's.
 	 */
-	if (!num)
+	if (!num || !enable_cpu_hotplug)
 		cpu_devices[num].cpu.no_control = 1;
 
 	return register_cpu(&cpu_devices[num].cpu, num);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+int enable_cpu_hotplug = 1;
 
 void arch_unregister_cpu(int num) {
 	return unregister_cpu(&cpu_devices[num].cpu);
diff --git a/include/asm-i386/cpu.h b/include/asm-i386/cpu.h
index b1bc7b1..9d914e1 100644
--- a/include/asm-i386/cpu.h
+++ b/include/asm-i386/cpu.h
@@ -13,6 +13,9 @@ struct i386_cpu {
 extern int arch_register_cpu(int num);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void arch_unregister_cpu(int);
+extern int enable_cpu_hotplug;
+#else
+#define enable_cpu_hotplug	0
 #endif
 
 DECLARE_PER_CPU(int, cpu_state);
