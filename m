Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUCSAWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUCSASL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:18:11 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:12209 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263169AbUCSAQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:16:05 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nodemask_t ia64 changes [6/7]
Date: Thu, 18 Mar 2004 16:15:18 -0800
User-Agent: KMail/1.6.1
References: <1079651085.8149.177.camel@arrakis>
In-Reply-To: <1079651085.8149.177.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181615.18498.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 3:04 pm, Matthew Dobson wrote:
> nodemask_t-06-ia64.patch - Changes to ia64 specific code.  Untested. 
> Code review & testing requested.

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/kernel/smpboot.c linux-2.6.4-nodemask_t-ia64/arch/ia64/kernel/smpboot.c
--- linux-2.6.4-vanilla/arch/ia64/kernel/smpboot.c	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/kernel/smpboot.c	Thu Mar 11 16:02:22 2004
@@ -474,7 +474,7 @@ build_cpu_to_node_map (void)
 {
 	int cpu, i, node;
 
-	for(node=0; node<MAX_NUMNODES; node++)
+	for_each_node(node)
 		cpus_clear(node_to_cpu_mask[node]);

This is your API, so you'd probably know, but might this not end up
initializing some of the node_to_cpu_mask array?  Oh, nevermind, it
looks like this won't just get online nodes...

@@ -134,11 +137,11 @@ static void __init reassign_cpu_only_nod

I'm not sure about this reassign_cpu_only_node() stuff, Bob Picco
would though...

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/fakeprom/fpmem.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/fakeprom/fpmem.c
--- linux-2.6.4-vanilla/arch/ia64/sn/fakeprom/fpmem.c	Wed Mar 10 18:55:26 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/fakeprom/fpmem.c	Thu Mar 11 12:01:24 2004

I'm hoping this file will eventually go away, but the change looks ok.

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/machvec/pci_bus_cvlink.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Wed Mar 10 18:55:37 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Mar 11 14:42:49 2004
@@ -791,7 +791,6 @@ sn_pci_init (void)
 	struct list_head *ln;
 	struct pci_bus *pci_bus = NULL;
 	struct pci_dev *pci_dev = NULL;
-	extern int numnodes;

Neat, saved a bad extern.

@@ -62,7 +62,7 @@ find_lboard_nasid(lboard_t *start, nasid
 		    (start->brd_nasid == nasid))
 			return start;
 
-		if (numionodes == numnodes)
+		if (numionodes == num_online_nodes())
 			start = KLCF_NEXT_ANY(start);
 		else
 			start = KLCF_NEXT(start);
@@ -95,7 +95,7 @@ find_lboard_class_nasid(lboard_t *start,
 		    (start->brd_nasid == nasid))
 			return start;
 
-		if (numionodes == numnodes)
+		if (numionodes == num_online_nodes())
 			start = KLCF_NEXT_ANY(start);

@@ -210,7 +210,7 @@ io_module_init(void)
     /*
      * Second scan, look for headless/memless board hosted by compute nodes.
      */
-    for (node = numnodes; node < numionodes; node++) {
+    for (node = num_online_nodes(); node < numionodes; node++) {
 	nasid_t		nasid;

Here's the ionode stuff I was talking about...

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-ia64/numa.h linux-2.6.4-nodemask_t-ia64/include/asm-ia64/numa.h
--- linux-2.6.4-vanilla/include/asm-ia64/numa.h	Wed Mar 10 18:55:25 2004
+++ linux-2.6.4-nodemask_t-ia64/include/asm-ia64/numa.h	Thu Mar 11 12:01:24 2004
@@ -59,7 +59,7 @@ extern struct node_cpuid_s node_cpuid[NR
  */
 
 extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
-#define node_distance(from,to) (numa_slit[from * numnodes + to])
+#define node_distance(from,to) (numa_slit[from * num_online_nodes() + to])

Might the SLIT contain offline nodes too?  I can imagine that it might
for hotplug aware hardware...

 
 /* klnuma.c */
-extern void replicate_kernel_text(int numnodes);
+extern void replicate_kernel_text(void);  /* TODO: is this used??? */
 extern unsigned long get_freemem_start(cnodeid_t cnode);
-extern void setup_replication_mask(int maxnodes);
+extern void setup_replication_mask(void); /* TODO: is this used??? */

Nope, it was at one time, but didn't provide much benefit (we should
probably benchmark it again on a really large system...).

Other than that, it looks ok.  Now I've got to test it.

Thanks,
Jesse




