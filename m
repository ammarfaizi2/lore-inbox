Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUG3Pnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUG3Pnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267722AbUG3Pnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:43:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11207 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267720AbUG3Pnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:43:45 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: colpatch@us.ibm.com
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Date: Fri, 30 Jul 2004 08:36:32 -0700
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
References: <1090887007.16676.18.camel@arrakis> <200407290843.46116.jbarnes@engr.sgi.com> <1091139818.4070.7.camel@arrakis>
In-Reply-To: <1091139818.4070.7.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AsmCBHfYzprCXFq"
Message-Id: <200407300836.32812.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AsmCBHfYzprCXFq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, July 29, 2004 3:23 pm, Matthew Dobson wrote:
> What I'm doing is basically ripping out all the old pcibus_to_cpumask()
> calls.  The only arch that defined it to be anything other than
> CPU_MASK_ALL was i386, and theirs should still work.  x86_64 had the
> beginnings of a PCI bus to CPU mask mapping, but it was never filled in,
> just populated with CPU_MASK_ALL, so it does the same with NODE_MASK_ALL
> now.  Those two arches, in their include/asm-$ARCH/topology.h define
> both ARCH_HAS_GET_PCIBUS_NODEMASK and get_pcibus_nodemask(bus).
> include/linux/topology.h defines a simple get_pcibus_nodemask(bus) if
> there isn't an arch-specific one provided.  We then, in
> drivers/pci/probe.c, populate the nodemask field of struct pci_bus with
> this nodemask.  Lookup involves simply returning the nodemask stored in
> the struct pci_bus.

I think this will work.  My tree didn't have nodemask_t though, so it didn't 
compile :)  Here's a first stab at an ia64 portion of the patch.

Jesse

--Boundary-00=_AsmCBHfYzprCXFq
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci-bus-to-node-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci-bus-to-node-ia64.patch"

===== arch/ia64/sn/io/machvec/pci_dma.c 1.30 vs edited =====
--- 1.30/arch/ia64/sn/io/machvec/pci_dma.c	2004-03-26 06:33:08 -08:00
+++ edited/arch/ia64/sn/io/machvec/pci_dma.c	2004-07-30 08:38:05 -07:00
@@ -662,6 +662,19 @@
 	return 0;
 }
 
+/**
+ * sn_get_pcibus_nodemask - return set of nearby nodes for a given PCI bus
+ * @bus: bus number
+ *
+ * Return a nodemask_t with nearby node(s).
+ */
+nodemask_t sn_get_pcibus_nodemask(int bus)
+{
+	nodemask_t nodes;
+	nodes_clear(nodes);
+	return node_set(nasid_to_cnode(busnum_to_nid[bus]), nodes);
+}
+
 EXPORT_SYMBOL(sn_dma_mapping_error);
 EXPORT_SYMBOL(sn_pci_unmap_single);
 EXPORT_SYMBOL(sn_pci_map_single);
===== include/asm-ia64/io.h 1.19 vs edited =====
--- 1.19/include/asm-ia64/io.h	2004-02-03 21:31:10 -08:00
+++ edited/include/asm-ia64/io.h	2004-07-30 08:37:56 -07:00
@@ -391,6 +391,11 @@
 # define outl_p		outl
 #endif
 
+static inline nodemask_t __ia64_get_pcibus_nodemask(int bus)
+{
+	return NODE_MASK_ALL;
+}
+
 /*
  * An "address" in IO memory space is not clearly either an integer or a pointer. We will
  * accept both, thus the casts.
===== include/asm-ia64/machvec.h 1.25 vs edited =====
--- 1.25/include/asm-ia64/machvec.h	2004-07-10 17:14:00 -07:00
+++ edited/include/asm-ia64/machvec.h	2004-07-30 08:38:35 -07:00
@@ -70,6 +70,7 @@
 typedef unsigned short ia64_mv_readw_relaxed_t (void *);
 typedef unsigned int ia64_mv_readl_relaxed_t (void *);
 typedef unsigned long ia64_mv_readq_relaxed_t (void *);
+typedef nodemask_t ia64_mv_get_pcibus_nodemask_t (int bus);
 
 static inline void
 machvec_noop (void)
@@ -138,6 +139,7 @@
 #  define platform_readw_relaxed        ia64_mv.readw_relaxed
 #  define platform_readl_relaxed        ia64_mv.readl_relaxed
 #  define platform_readq_relaxed        ia64_mv.readq_relaxed
+#  define platform_get_pcibus_nodemask  ia64_mv.get_pcibus_nodemask
 # endif
 
 /* __attribute__((__aligned__(16))) is required to make size of the
@@ -184,6 +186,7 @@
 	ia64_mv_readw_relaxed_t *readw_relaxed;
 	ia64_mv_readl_relaxed_t *readl_relaxed;
 	ia64_mv_readq_relaxed_t *readq_relaxed;
+	ia64_mv_get_pcibus_nodemask_t *get_pcibus_nodemask;
 } __attribute__((__aligned__(16))); /* align attrib? see above comment */
 
 #define MACHVEC_INIT(name)			\
@@ -226,6 +229,7 @@
 	platform_readw_relaxed,			\
 	platform_readl_relaxed,			\
 	platform_readq_relaxed,			\
+	platform_get_pcibus_nodemask,		\
 }
 
 extern struct ia64_machine_vector ia64_mv;
@@ -367,6 +371,9 @@
 #endif
 #ifndef platform_readq_relaxed
 # define platform_readq_relaxed	__ia64_readq_relaxed
+#endif
+#ifndef platform_get_pcibus_nodemask
+# define platform_get_pcibus_nodemask __ia64_get_pcibus_nodemask
 #endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
===== include/asm-ia64/machvec_sn2.h 1.14 vs edited =====
--- 1.14/include/asm-ia64/machvec_sn2.h	2004-07-10 17:14:00 -07:00
+++ edited/include/asm-ia64/machvec_sn2.h	2004-07-30 08:31:29 -07:00
@@ -69,6 +69,7 @@
 extern ia64_mv_dma_sync_sg_for_device	sn_dma_sync_sg_for_device;
 extern ia64_mv_dma_mapping_error	sn_dma_mapping_error;
 extern ia64_mv_dma_supported		sn_dma_supported;
+extern ia64_mv_get_pcibus_nodemask_t	sn_get_pcibus_nodemask;
 
 /*
  * This stuff has dual use!
@@ -116,6 +117,7 @@
 #define platform_dma_sync_sg_for_device	sn_dma_sync_sg_for_device
 #define platform_dma_mapping_error		sn_dma_mapping_error
 #define platform_dma_supported		sn_dma_supported
+#define platform_get_pcibus_nodemask	sn_get_pcibus_nodemask
 
 #include <asm/sn/sn2/io.h>
 
===== include/asm-ia64/topology.h 1.10 vs edited =====
--- 1.10/include/asm-ia64/topology.h	2004-02-03 21:35:17 -08:00
+++ edited/include/asm-ia64/topology.h	2004-07-30 08:38:17 -07:00
@@ -45,6 +45,9 @@
 
 void build_cpu_to_node_map(void);
 
+#define ARCH_HAS_GET_PCIBUS_NODEMASK
+extern nodemask_t get_pcibus_nodemask(int bus);
+
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>

--Boundary-00=_AsmCBHfYzprCXFq--
