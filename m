Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbTGCLSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTGCLSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:18:10 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:10423 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S265141AbTGCLSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:18:05 -0400
Subject: Re: 2.5.74-mm1 (p4-clockmod does not compile) PATCH
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20030703112026.GO26348@holomorphy.com>
References: <20030703023714.55d13934.akpm@osdl.org>
	 <1057229141.1479.16.camel@LNX.iNES.RO>
	 <20030703110713.GN26348@holomorphy.com>
	 <1057231068.1479.18.camel@LNX.iNES.RO>
	 <20030703112026.GO26348@holomorphy.com>
Content-Type: multipart/mixed; boundary="=-NHzOfSpeL42lAaTbX4aL"
Organization: iNES Group SRL
Message-Id: <1057231947.1479.23.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-3) 
Date: 03 Jul 2003 14:32:27 +0300
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NHzOfSpeL42lAaTbX4aL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-07-03 at 14:20, William Lee Irwin III wrote:
> Great! Could you send back the diff? (or alternatively, the file
> contents if you didn't preserve the old contents) so I can send the
> proper diff upstream?

I have attached the patch since evolution seems to really want to break
the patch if I do an "Insert text file" :(

-- 
Cioby

--=-NHzOfSpeL42lAaTbX4aL
Content-Disposition: attachment; filename=p4-clockmod.patch
Content-Type: text/plain; name=p4-clockmod.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /usr/src/linux-2.5.74/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c.original	2003-07-03 14:12:35.000000000 +0300
+++ /usr/src/linux-2.5.74/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-07-03 14:28:10.000000000 +0300
@@ -53,10 +53,9 @@
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 {
 	u32 l, h;
-	unsigned long cpus_allowed;
+	cpumask_t cpus_allowed, affected_cpu_map;
 	struct cpufreq_freqs freqs;
 	int hyperthreading = 0;
-	int affected_cpu_map = 0;
 	int sibling = 0;
 
 	if (!cpu_online(cpu) || (newstate > DC_DISABLE) || 
@@ -67,16 +66,16 @@
 	cpus_allowed = current->cpus_allowed;
 
 	/* only run on CPU to be set, or on its sibling */
-	affected_cpu_map = 1 << cpu;
+       affected_cpu_map = cpumask_of_cpu(cpu);
 #ifdef CONFIG_X86_HT
 	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
 	if (hyperthreading) {
 		sibling = cpu_sibling_map[cpu];
-		affected_cpu_map |= (1 << sibling);
+                cpu_set(sibling, affected_cpu_map);
 	}
 #endif
 	set_cpus_allowed(current, affected_cpu_map);
-	BUG_ON(!(affected_cpu_map & (1 << smp_processor_id())));
+        BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
 
 	/* get current state */
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);

--=-NHzOfSpeL42lAaTbX4aL--

