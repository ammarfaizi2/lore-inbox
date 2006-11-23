Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757269AbWKWBfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269AbWKWBfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757268AbWKWBfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:35:30 -0500
Received: from smtp-out.google.com ([216.239.45.12]:1204 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1757267AbWKWBfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:35:16 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=bbudMl1cULD+t7EtH+F0F4MAdLCaxeZUIudvyVUhxijx1w5oRIkafPwBwVwzhgJDz
	8w234Wfpwr2hagS6/swOw==
Subject: [Patch4/4]: fake numa for x86_64 patches
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Mel Gorman <mel@csn.ul.ie>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 22 Nov 2006 17:34:55 -0800
Message-Id: <1164245696.29844.155.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the kernel command line option for numa=fake so that
user can specify different size nodes on a command line.


Signed-off-by: David Rientjes <reintjes@google.com>
Signed-off-by: Paul Menage <menage@google.com>
Signed-off-by: Rohit Seth <rohitseth@google.com>



--- linux-2.6.19-rc5-mm2.org/arch/x86_64/mm/numa.c	2006-11-22 16:50:34.000000000 -0800
+++ linux-2.6.19-rc5-mm2/arch/x86_64/mm/numa.c	2006-11-22 16:51:02.000000000 -0800
@@ -39,6 +39,10 @@ cpumask_t node_to_cpumask[MAX_NUMNODES] 
 int numa_off __initdata;
 struct bootnode nodes[MAX_NUMNODES] __initdata;
 
+#ifdef CONFIG_NUMA_EMU
+char fake_numa[32] __initdata;
+#endif
+
 void __init populate_physnode_map(struct bootnode *nodes, int numnodes)
 {
 	int i; 
@@ -287,6 +291,22 @@ static int split_nodes_equal(struct boot
 }
 
 /*
+ * Splits the remaining system RAM into chunks of size.  The remaining memory is
+ * always assigned to a final node and can be asymmetric.  Returns the number of
+ * nodes split.
+ */
+static int split_nodes_size(struct bootnode *nodes, u64 *addr, u64 max_addr,
+			    int node_start, u64 sz)
+{
+	int i = node_start;
+	sz = (sz << 20) & NODE_HASH_MASK;
+	while (!setup_node_range(i++, nodes, addr, sz, max_addr))
+		;
+	return i - node_start;
+}
+
+
+/*
  * Sets up the system RAM area from start_pfn to end_pfn according to the
  * numa=fake command line.
  */
@@ -294,17 +314,86 @@ static int numa_emulation(unsigned long 
 {
 	u64 addr = start_pfn << PAGE_SHIFT;
 	u64 max_addr = end_pfn << PAGE_SHIFT;
+	u64 sz;
 	int num_nodes;
+	int coeff_flag;
+	int coeff = -1;
+	int num;
 	int i;
+	char *temp = fake_numa;
 
 	memset(&nodes, 0, sizeof(nodes));
 	/*
 	 * If the numa=fake command line is just a single number N, split the
 	 * system RAM into N fake nodes.
 	 */
-	num_nodes = split_nodes_equal(nodes, &addr, max_addr, 0, numa_fake);
-	if (num_nodes < 0)
-		return num_nodes;
+	if (!strchr(temp, '*')) {
+		num_nodes = split_nodes_equal(nodes, &addr, max_addr, 0,
+					      simple_strtol(temp, NULL, 0));
+		if (num_nodes < 0)
+			return num_nodes;
+		goto out;
+	}
+
+	/* Parse the command line */
+	for (coeff_flag = num = num_nodes = 0; ; temp++) {
+		if (*temp && isdigit(*temp)) {
+			num = num * 10 + *temp - '0';
+			continue;
+		} else if (*temp == '*') {
+			if (num > 0)
+				coeff = num;
+			coeff_flag = 1;
+		} else if (!*temp) {
+			if (!coeff_flag)
+				coeff = 1;
+			/*
+			 * Round down to the nearest 4MB for hash function.
+			 * Command line coefficients are in megabytes.
+			 */
+			sz = ((u64)num << 20) & NODE_HASH_MASK;
+			if (sz)
+				for (i = 0; i < coeff; i++, num_nodes++)
+					if (setup_node_range(num_nodes, nodes,
+						&addr, sz, max_addr) < 0)
+						goto done;
+			if (!*temp)
+				break;
+			coeff = -1;
+			coeff_flag = 0;
+		}
+		num = 0;
+	}
+done:
+	if (!num_nodes)
+		return -1;
+	/* Fill remaining system RAM */
+	if (addr < max_addr) {
+		if (coeff_flag && coeff < 0) {
+			/* Split remaining nodes into num-sized chunks */
+			num_nodes += split_nodes_size(nodes, &addr, max_addr,
+						      num_nodes, num);
+			goto out;
+		}
+		switch (*(temp - 1)) {
+		case '*':
+			/* Split remaining nodes into coeff chunks */
+			if (coeff <= 0)
+				break;
+			num_nodes += split_nodes_equal(nodes, &addr, max_addr,
+						       num_nodes, coeff);
+			break;
+		case ',':
+			/* Do not allocate remaining system RAM */
+			break;
+		default:
+			/* Give one final node */
+			setup_node_range(num_nodes, nodes, &addr,
+					 max_addr - addr, max_addr);
+			num_nodes++;
+		}
+	}
+out:
 	populate_physnode_map(nodes, num_nodes);
  	for_each_online_node(i) {
 		e820_register_active_regions(i, nodes[i].start >> PAGE_SHIFT,
@@ -410,15 +499,18 @@ void __init paging_init(void)
 
 static __init int numa_setup(char *opt)
 { 
+#ifdef CONFIG_NUMA_EMU
+	char *t;
+#endif
 	if (!opt)
 		return -EINVAL;
 	if (!strncmp(opt,"off",3))
 		numa_off = 1;
 #ifdef CONFIG_NUMA_EMU
 	if(!strncmp(opt, "fake=", 5)) {
-		numa_fake = simple_strtoul(opt+5,NULL,0);
-		if (numa_fake >= MAX_NUMNODES)
-			numa_fake = MAX_NUMNODES;
+		numa_fake = 1;
+		t = strchr(opt, ' ');
+		strlcpy(fake_numa, opt+5, (t-opt-5)+1);
 	}
 #endif
 #ifdef CONFIG_ACPI_NUMA
--- linux-2.6.19-rc5-mm2.org/Documentation/x86_64/boot-options.txt	2006-11-22 12:20:54.000000000 -0800
+++ linux-2.6.19-rc5-mm2/Documentation/x86_64/boot-options.txt	2006-11-20 11:44:05.000000000 -0800
@@ -149,7 +149,17 @@ NUMA
 
   numa=noacpi   Don't parse the SRAT table for NUMA setup
 
-  numa=fake=X   Fake X nodes and ignore NUMA setup of the actual machine.
+  numa=fake=<cmdline>
+		If a number, fakes <cmdline> nodes and ignores NUMA setup of
+		the actual machine.  Otherwise, system memory is configured
+		depending on the sizes and coefficients listed.  For example:
+			numa=fake=2*512,1024,4*256,*128
+		gives two 512M nodes, a 1024M node, four 256M nodes, and the
+		rest split into 128M chunks.  If the last character of
+		<cmdline> is a *, the remaining memory is divided equally
+		among its coefficient:
+			numa=fake=2*512,2*
+		gives two 512M nodes and the rest split into two nodes.
 
   numa=hotadd=percent
 		Only allow hotadd memory to preallocate page structures upto


