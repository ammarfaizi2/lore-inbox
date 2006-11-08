Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753868AbWKHCCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbWKHCCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbWKHCCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:02:50 -0500
Received: from mga07.intel.com ([143.182.124.22]:28712 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1753859AbWKHCCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:02:49 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,398,1157353200"; 
   d="scan'208"; a="142764576:sNHT47952247"
Date: Tue, 7 Nov 2006 17:40:25 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: ak@suse.de, akpm@osdl.org
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com
Subject: Re: [patch 2/4] introduce the mechanism of disabling cpu hotplug control
Message-ID: <20061107174024.B5401@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com> <20061107173624.A5401@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061107173624.A5401@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Tue, Nov 07, 2006 at 05:36:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'cpu_hotplug_no_control' and when set, the hotplug control file("online")
will not be added under /sys/devices/system/cpu/cpuX/

Next patch doing PCI quirks will use this.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/arch/i386/kernel/topology.c b/arch/i386/kernel/topology.c
index 07d6da3..9b766e7 100644
--- a/arch/i386/kernel/topology.c
+++ b/arch/i386/kernel/topology.c
@@ -40,14 +40,22 @@ int arch_register_cpu(int num)
 	 * restrictions and assumptions in kernel. This basically
 	 * doesnt add a control file, one cannot attempt to offline
 	 * BSP.
+	 *
+	 * Also certain PCI quirks require to remove this control file
+	 * for all CPU's.
 	 */
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!num || cpu_hotplug_no_control)
+#else
 	if (!num)
+#endif
 		cpu_devices[num].cpu.no_control = 1;
 
 	return register_cpu(&cpu_devices[num].cpu, num);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+int cpu_hotplug_no_control;
 
 void arch_unregister_cpu(int num) {
 	return unregister_cpu(&cpu_devices[num].cpu);
diff --git a/include/asm-i386/cpu.h b/include/asm-i386/cpu.h
index b1bc7b1..3c5da33 100644
--- a/include/asm-i386/cpu.h
+++ b/include/asm-i386/cpu.h
@@ -13,6 +13,7 @@ struct i386_cpu {
 extern int arch_register_cpu(int num);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void arch_unregister_cpu(int);
+extern int cpu_hotplug_no_control;
 #endif
 
 DECLARE_PER_CPU(int, cpu_state);
