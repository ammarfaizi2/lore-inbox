Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbSKLVnu>; Tue, 12 Nov 2002 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbSKLVnt>; Tue, 12 Nov 2002 16:43:49 -0500
Received: from holomorphy.com ([66.224.33.161]:957 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266974AbSKLVns>;
	Tue, 12 Nov 2002 16:43:48 -0500
Date: Tue, 12 Nov 2002 13:48:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112214804.GX23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	Martin.Bligh@us.ibm.com, hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112213504.GV23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 01:35:04PM -0800, William Lee Irwin III wrote:
> I'll remove the bus number mangling from it so it uses ->sysdata
> instead, make it an additional stage of the patch series and convert 
> arch/i386/pci/numa.c to use it instead.
> Bus number mangling has been vetoed numerous times; the agreed-upon
> method of dealing with this is stuffing arch-private information in
> ->sysdata and dispatching on that within PCI config access routines.

[7/4] NUMA-Q: introduce __pcibus_to_node()

This introduces a generic __pcibus_to_node() method in asm/topology.h
and provides a NUMA-Q -specific implementation.

 asm-generic/topology.h |    3 +++
 asm-i386/topology.h    |    4 ++++
 2 files changed, 7 insertions(+)


diff -urpN pci-2.5.47-6/include/asm-generic/topology.h pci-2.5.47-7/include/asm-generic/topology.h
--- pci-2.5.47-6/include/asm-generic/topology.h	2002-11-10 19:28:04.000000000 -0800
+++ pci-2.5.47-7/include/asm-generic/topology.h	2002-11-12 13:03:40.000000000 -0800
@@ -47,5 +47,8 @@
 #ifndef __node_to_memblk
 #define __node_to_memblk(node)		(0)
 #endif
+#ifndef __pcibus_to_node
+#define __pcibus_to_node(bus)          (0)
+#endif
 
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -urpN pci-2.5.47-6/include/asm-i386/topology.h pci-2.5.47-7/include/asm-i386/topology.h
--- pci-2.5.47-6/include/asm-i386/topology.h	2002-11-10 19:28:05.000000000 -0800
+++ pci-2.5.47-7/include/asm-i386/topology.h	2002-11-12 13:04:43.000000000 -0800
@@ -83,6 +83,10 @@ static inline unsigned long __node_to_cp
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)
 
+/* Returns the number of the node containing PCI bus 'bus' */
+#define __pcibus_to_node(bus) ((int)((bus)->sysdata))
+
+
 #else /* !CONFIG_X86_NUMAQ */
 /*
  * Other i386 platforms should define their own version of the 
