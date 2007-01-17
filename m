Return-Path: <linux-kernel-owner+w=401wt.eu-S1751146AbXAQMwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbXAQMwM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 07:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXAQMwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 07:52:12 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:36245 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbXAQMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 07:52:11 -0500
Date: Wed, 17 Jan 2007 15:58:20 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
To: akpm@osdl.org
Cc: hpa@zytor.com, devel@openvz.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuid.c: use smp_call_function_single()
Message-ID: <20070117125819.GA6021@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It will execure cpuid only on the cpu we need.

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 arch/i386/kernel/cpuid.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/i386/kernel/cpuid.c
+++ b/arch/i386/kernel/cpuid.c
@@ -48,7 +48,6 @@ static struct class *cpuid_class;
 #ifdef CONFIG_SMP
 
 struct cpuid_command {
-	int cpu;
 	u32 reg;
 	u32 *data;
 };
@@ -57,8 +56,7 @@ static void cpuid_smp_cpuid(void *cmd_bl
 {
 	struct cpuid_command *cmd = (struct cpuid_command *)cmd_block;
 
-	if (cmd->cpu == smp_processor_id())
-		cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2],
+	cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2],
 		      &cmd->data[3]);
 }
 
@@ -70,11 +68,10 @@ static inline void do_cpuid(int cpu, u32
 	if (cpu == smp_processor_id()) {
 		cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
 	} else {
-		cmd.cpu = cpu;
 		cmd.reg = reg;
 		cmd.data = data;
 
-		smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
+		smp_call_function_single(cpu, cpuid_smp_cpuid, &cmd, 1, 1);
 	}
 	preempt_enable();
 }

