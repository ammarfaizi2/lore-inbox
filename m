Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWCYL64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWCYL64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 06:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWCYL64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 06:58:56 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53476
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751371AbWCYL6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 06:58:55 -0500
Date: Sat, 25 Mar 2006 03:59:00 -0800 (PST)
Message-Id: <20060325.035900.121310564.davem@davemloft.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP busted on non-cpu-hotplug systems
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060325034744.35b70f43.akpm@osdl.org>
References: <20060325.024226.53296559.davem@davemloft.net>
	<20060325034744.35b70f43.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 25 Mar 2006 03:47:44 -0800

> I think it'd be cleanest to require that the arch do that -
> fixup_cpu_present_map() looks like a bit of a hack.

Indeed it does.  I'm planning on doing someting like this
for sparc64:

diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 1b6e2ad..7dc28a4 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -1298,6 +1298,7 @@ void __init smp_prepare_cpus(unsigned in
 		while (!cpu_find_by_instance(instance, NULL, &mid)) {
 			if (mid != boot_cpu_id) {
 				cpu_clear(mid, phys_cpu_present_map);
+				cpu_clear(mid, cpu_present_map);
 				if (num_possible_cpus() <= max_cpus)
 					break;
 			}
@@ -1332,8 +1333,10 @@ void __init smp_setup_cpu_possible_map(v
 
 	instance = 0;
 	while (!cpu_find_by_instance(instance, NULL, &mid)) {
-		if (mid < NR_CPUS)
+		if (mid < NR_CPUS) {
 			cpu_set(mid, phys_cpu_present_map);
+			cpu_set(mid, cpu_present_map);
+		}
 		instance++;
 	}
 }
