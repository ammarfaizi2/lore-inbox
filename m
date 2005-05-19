Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVESDg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVESDg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 23:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVESDg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 23:36:57 -0400
Received: from graphe.net ([209.204.138.32]:27908 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262461AbVESDgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 23:36:55 -0400
Date: Wed, 18 May 2005 20:36:51 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix pcibus_to_node for x86_64
In-Reply-To: <428BE417.4050402@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505181822580.14855@graphe.net>
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net>
 <428A8697.4010606@us.ibm.com> <Pine.LNX.4.62.0505171707100.18365@graphe.net>
 <428B7A5F.9090404@us.ibm.com> <Pine.LNX.4.62.0505181035140.6359@graphe.net>
 <428BE417.4050402@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Matthew Dobson wrote:

> x86_64 surprisingly does define pcibus_to_cpumask, but NOT
> pcibus_to_node().  That means when they unconditionally #include
> <asm-generic/topology.h> at the bottom of asm-x86_64/topology.h they get a
> confusing mish-mash of pcibus functions.  What I mean is, on x86_64
> pcibus_to_cpumask will do the right thing but pcibus_to_node will not.
> This is broken.  The correct thing to do would be to define pcibus_to_node
> in asm-x86_64/topology.h and only include asm-generic/topology.h if
> DISCONTIG/NUMA isn't defined.

Correct. There is a bit missing there. x86_64 has the pci_bus_to_node 
array but not the macro pcibus_to_node. On cursory review it looks as if
it would already be right. Just the _ and the [] ....

Here is a fix for x86_64 that adds pcibus_to_node to 
asm-x86_64/topology.h. Patch against 2.6.12-rc4-mm2:

Index: linux-2.6.12-rc4/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-x86_64/topology.h	2005-05-17 02:19:53.000000000 +0000
+++ linux-2.6.12-rc4/include/asm-x86_64/topology.h	2005-05-19 01:40:06.000000000 +0000
@@ -26,7 +26,8 @@
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
-#define pcibus_to_cpumask(bus)		node_to_cpumask(pci_bus_to_node[(bus)->number]);
+#define pcibus_to_node(bus)		pci_bus_to_node[(bus)->number]
+#define pcibus_to_cpumask(bus)		node_to_cpumask(pcibus_to_node(bus));
 
 #ifdef CONFIG_NUMA
 /* sched_domains SD_NODE_INIT for x86_64 machines */
