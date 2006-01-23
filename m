Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWAWLWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWAWLWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 06:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWAWLWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 06:22:15 -0500
Received: from calsoftinc.com ([64.62.215.98]:27526 "HELO calsoftinc.com")
	by vger.kernel.org with SMTP id S1751417AbWAWLWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 06:22:15 -0500
Date: Mon, 23 Jan 2006 16:51:34 +0530 (IST)
From: pravin shelar <pravins@calsoftinc.com>
X-X-Sender: pravins@pravin.s
To: Andi Kleen <ak@suse.de>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] garbage values in file /proc/net/sockstat
Message-ID: <Pine.LNX.4.63.0601231206270.2192@pravin.s>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In 2.6.16-rc1-mm1, (for x86_64 arch) cpu_possible_map is not same 
as NR_CPUS (prefill_possible_map()). Therefore per cpu areas are allocated 
for cpu_possible cpus only (setup_per_cpu_areas()). This causes sockstat 
to return garbage value on x84_64 arch.

So these per_cpu accesses are geting relocated (RELOC_HIDE) using
boot_cpu_pda[]->data_offset which is not initialized.

There are other instances of same bug where per_cpu() macro is used
without cpu_possible() check. e.g. net/core/utils.c :: 
net_random_reseed(), net/core/dev.c :: net_dev_init(), etc.

This patch fixes these bugs.

Regards,
Pravin.

---

Signed-off by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15.1/net/core/dev.c
===================================================================
--- linux-2.6.15.1.orig/net/core/dev.c	2006-01-23 02:31:13.000000000 -0800
+++ linux-2.6.15.1/net/core/dev.c	2006-01-23 02:32:12.000000000 -0800
@@ -3240,7 +3240,7 @@ static int __init net_dev_init(void)
 	 *	Initialise the packet receive queues.
 	 */
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu (i) {
 		struct softnet_data *queue;
 
 		queue = &per_cpu(softnet_data, i);
Index: linux-2.6.15.1/net/core/utils.c
===================================================================
--- linux-2.6.15.1.orig/net/core/utils.c	2006-01-23 02:31:13.000000000 -0800
+++ linux-2.6.15.1/net/core/utils.c	2006-01-23 02:32:12.000000000 -0800
@@ -133,7 +133,7 @@ static int net_random_reseed(void)
 	unsigned long seed[NR_CPUS];
 
 	get_random_bytes(seed, sizeof(seed));
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
 		__net_srandom(state, seed[i]);
 	}
Index: linux-2.6.15.1/net/socket.c
===================================================================
--- linux-2.6.15.1.orig/net/socket.c	2006-01-23 02:31:13.000000000 -0800
+++ linux-2.6.15.1/net/socket.c	2006-01-23 02:32:12.000000000 -0800
@@ -2079,7 +2079,7 @@ void socket_seq_show(struct seq_file *se
 	int cpu;
 	int counter = 0;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for_each_cpu (cpu) 
 		counter += per_cpu(sockets_in_use, cpu);
 
 	/* It can be negative, by the way. 8) */
