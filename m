Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUH2RKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUH2RKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUH2RKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:10:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5009 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268203AbUH2RIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:08:04 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
Date: Sun, 29 Aug 2004 10:07:50 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1093786747.1708.8.camel@mulgrave> <200408290948.06473.jbarnes@engr.sgi.com> <1093798704.10973.15.camel@mulgrave>
In-Reply-To: <1093798704.10973.15.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m1gMBwx+1Cy8/WQ"
Message-Id: <200408291007.50553.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_m1gMBwx+1Cy8/WQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday, August 29, 2004 9:58 am, James Bottomley wrote:
> On Sun, 2004-08-29 at 12:48, Jesse Barnes wrote:
> > But I think this breaks what the code is supposed to do.  You're right
> > that we shouldn't use cpu_online_map, but we should leave the nodemask in
> > there and fix the code that sets it in the non-NUMA case instead.
>
> Well, let's say it puts back the original behaviour. If you look at even
> the NUMA code before these changes, it had cpu_possible_map in there.
>
> I totally agree about fixing NUMA, it looks completely broken to me in
> the way it handles cpu maps because node_to_cpumask(i) needs to expand
> to cpu_possible_map for initialisation and cpu_online_map for
> operation.  Has anyone ever checked NUMA for hotplug CPU?

I've up and downed a few CPUs on an Altix, and it seems to work ok, but that's 
a pretty basic test.  How about this?

Jesse


--Boundary-00=_m1gMBwx+1Cy8/WQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="node-to-cpumask-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="node-to-cpumask-fix.patch"

===== include/asm-generic/topology.h 1.6 vs edited =====
--- 1.6/include/asm-generic/topology.h	2004-02-03 21:35:17 -08:00
+++ edited/include/asm-generic/topology.h	2004-08-29 10:06:17 -07:00
@@ -36,13 +36,13 @@
 #define parent_node(node)	(0)
 #endif
 #ifndef node_to_cpumask
-#define node_to_cpumask(node)	(cpu_online_map)
+#define node_to_cpumask(node)	(cpu_possible_map)
 #endif
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
 #endif
 #ifndef pcibus_to_cpumask
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
+#define pcibus_to_cpumask(bus)	(cpu_possible_map)
 #endif
 
 /* Cross-node load balancing interval. */

--Boundary-00=_m1gMBwx+1Cy8/WQ--
