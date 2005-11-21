Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVKUVtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVKUVtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVKUVtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:49:12 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:5143 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751080AbVKUVtK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:49:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=smsXs8evJyDGZ4BxEa9tA4hA0wBUcBRjmCbakBt5xmqDD49SsjGIi6AKoqjhI3jpD08Bgwrr4RkvDDDSO7eAm5TFuIlUMQ6wj2HeB0SYUW1rASK/C32dXcWIfUzhjgCNwDzcckRkFsZzM/JPXdbLofzE+GS9zgItp5j7A7iwNa0=
Message-ID: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
Date: Mon, 21 Nov 2005 13:49:09 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: x86_64: apic id lift patch
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Please check the patch regarding apicid lifting.

For some reason, we need to lift AP apicid but keep the BSP apicid to 0....

Also it solve the E0 later single but have apic id reorder problem...

YH


diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -786,13 +786,24 @@ static void __init amd_detect_cmp(struct
 #ifdef CONFIG_SMP
 	int cpu = smp_processor_id();
 	unsigned bits;
+	int cores_vir;
 #ifdef CONFIG_NUMA
 	int node = 0;
-	unsigned apicid = phys_proc_id[cpu];
+	unsigned initial_apicid = phys_proc_id[cpu];
+	unsigned apicid = hard_smp_processor_id();
 #endif
+	
+	cores_vir = c->x86_max_cores;
+	if(cores_vir == 1) {
+		unsigned level = cpuid_eax(1);
+		/* double check if it is E0 later, only E0 later can reorder apicid
for single core */
+        	if ((level & 0xf0f00) >= 0x20f00) {
+			cores_vir = 2;
+		}
+	}

 	bits = 0;
-	while ((1 << bits) < c->x86_max_cores)
+	while ((1 << bits) < cores_vir)
 		bits++;

 	/* Low order bits define the core id (index of core in socket) */
@@ -802,32 +813,23 @@ static void __init amd_detect_cmp(struct

 #ifdef CONFIG_NUMA
   	node = phys_proc_id[cpu];
- 	if (apicid_to_node[apicid] != NUMA_NO_NODE)
- 		node = apicid_to_node[apicid];
+
+ 	if (apicid_to_node[apicid] == NUMA_NO_NODE)
+ 		apicid_to_node[apicid] = node;
+	
  	if (!node_online(node)) {
- 		/* Two possibilities here:
+ 		/* One possibilities here:
  		   - The CPU is missing memory and no node was created.
- 		   In that case try picking one from a nearby CPU
- 		   - The APIC IDs differ from the HyperTransport node IDs
- 		   which the K8 northbridge parsing fills in.
- 		   Assume they are all increased by a constant offset,
- 		   but in the same order as the HT nodeids.
- 		   If that doesn't result in a usable node fall back to the
- 		   path for the previous case.  */
- 		int ht_nodeid = apicid - (phys_proc_id[0] << bits);
- 		if (ht_nodeid >= 0 &&
- 		    apicid_to_node[ht_nodeid] != NUMA_NO_NODE)
- 			node = apicid_to_node[ht_nodeid];
- 		/* Pick a nearby node */
- 		if (!node_online(node))
- 			node = nearby_node(apicid);
+ 		   In that case try picking one from a nearby CPU */
+ 		node = nearby_node(apicid);
  	}
+
 	numa_set_node(cpu, node);
+#endif

   	printk(KERN_INFO "CPU %d(%d) -> Node %d -> Core %d\n",
   			cpu, c->x86_max_cores, node, cpu_core_id[cpu]);
 #endif
-#endif
 }

 static int __init init_amd(struct cpuinfo_x86 *c)
