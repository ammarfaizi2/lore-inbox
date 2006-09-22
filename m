Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWIVToY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWIVToY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWIVToY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:44:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:37510 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964830AbWIVToX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:44:23 -0400
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
	kernel BUG at mm/slab.c:2698!
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: David Rientjes <rientjes@cs.washington.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       lkml <linux-kernel@vger.kernel.org>, clameter@engr.sgi.com
In-Reply-To: <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
References: <1158884252.5657.38.camel@keithlap>
	 <20060921174134.4e0d30f2.akpm@osdl.org> <1158888843.5657.44.camel@keithlap>
	 <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060921200806.523ce0b2.akpm@osdl.org>
	 <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060921204629.49caa95f.akpm@osdl.org>
	 <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Fri, 22 Sep 2006 12:44:18 -0700
Message-Id: <1158954258.7292.6.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 21:09 -0700, David Rientjes wrote: 
> On Thu, 21 Sep 2006, Andrew Morton wrote:

Well I think there is 3 bug total exposed my unique situation. I think
all 3 issues are generic mainline bugs that have been around for
awhile.   

1. SRAT not being mapped (patch submitted to fix boot_ioremap code)
  This caused cpus to fail to be borough on line and panicked the box. 

2.  The panic is bad.  I have so far tested the patch David
submitted....  It allowed the cpu_up calls to fail without panicking the
box.  Andrew do you want me to test yours or ???

3. Flat mode i386 numa on a real numa system is broken.  If there is
only 1 node in the system cpus should think they are apart of some other
node.     Patch below.  



  If cases where a real numa system boots the Flat numa option make sure
the cpus don't claim to be apart on a non-existent node.


Signed-off-by: Keith Mannthey <kmannth@us.ibm.com>

--- linux-2.6.18/arch/i386/kernel/smpboot.c	2006-09-19
20:42:06.000000000 -0700
+++ linux-2.6.18-workes/arch/i386/kernel/smpboot.c	2006-09-21
21:57:55.000000000 -0700
@@ -642,9 +642,13 @@
 {
 	int cpu = smp_processor_id();
 	int apicid = logical_smp_processor_id();
-
+	int node = apicid_to_node(apicid);
+	
+	if (!node_online(node))
+		node = first_online_node;
+	
 	cpu_2_logical_apicid[cpu] = apicid;
-	map_cpu_to_node(cpu, apicid_to_node(apicid));
+	map_cpu_to_node(cpu, node);
 }
 
 static void unmap_cpu_to_logical_apicid(int cpu)


