Return-Path: <linux-kernel-owner+w=401wt.eu-S932481AbXAGKns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbXAGKns (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbXAGKnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:43:47 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43894 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481AbXAGKnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:43:46 -0500
Date: Sun, 7 Jan 2007 11:43:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Fix cpu hotplug (missing 'online' attribute).
Message-ID: <20070107104343.GC14724@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Fix cpu hotplug (missing 'online' attribute).

72486f1f8f0a2bc828b9d30cf4690cf2dd6807fc inverts the logic if an
'online' attribute in /sys/devices/system/cpu/cpuX should appear.
So we end up with no hotpluggable cpus at all...
Set the hotpluggable value to one to make sure the online
attribute appears again.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2007-01-06 15:20:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2007-01-06 15:20:32.000000000 +0100
@@ -794,7 +794,10 @@ static int __init topology_init(void)
 	int ret;
 
 	for_each_possible_cpu(cpu) {
-		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu);
+		struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+		c->hotpluggable = 1;
+		ret = register_cpu(c, cpu);
 		if (ret)
 			printk(KERN_WARNING "topology_init: register_cpu %d "
 			       "failed (%d)\n", cpu, ret);
