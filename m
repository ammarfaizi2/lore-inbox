Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753185AbWKFORy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbWKFORy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbWKFORy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:17:54 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:43657 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1753185AbWKFORx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:17:53 -0500
Subject: [patch] Regression in 2.6.19-rc microcode driver
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: shaohua.li@intel.com, akpm@osdl.org, bunk@stusta.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Nov 2006 15:15:38 +0100
Message-Id: <1162822538.3138.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if the microcode driver is built in (rather than module) there are some,
ehm, interesting effects happening due to the new "call out to
userspace" behavior that is introduced.. and which runs too early. The
result is a boot hang; which is really nasty.

The patch below is a minimally safe patch to fix this regression for
2.6.19 by just not requesting actual microcode updates during early
boot. (That is a good idea in general anyway)

The "real" fix is a lot more complex given the entire cpu hotplug
scenario (during cpu hotplug you normally need to load the microcode as
well); but the interactions for that are just really messy at this
point; this fix at least makes it work and avoids a full detangle of
hotplug.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

--- linux-2.6.18/arch/i386/kernel/microcode.c.org	2006-11-06 14:50:37.000000000 +0100
+++ linux-2.6.18/arch/i386/kernel/microcode.c	2006-11-06 14:52:30.000000000 +0100
@@ -577,7 +577,7 @@ static void microcode_init_cpu(int cpu)
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 	mutex_lock(&microcode_mutex);
 	collect_cpu_info(cpu);
-	if (uci->valid)
+	if (uci->valid && system_state==SYSTEM_RUNNING)
 		cpu_request_microcode(cpu);
 	mutex_unlock(&microcode_mutex);
 	set_cpus_allowed(current, old);

