Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318043AbSGLWh4>; Fri, 12 Jul 2002 18:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSGLWhz>; Fri, 12 Jul 2002 18:37:55 -0400
Received: from holomorphy.com ([66.224.33.161]:35487 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318043AbSGLWhy>;
	Fri, 12 Jul 2002 18:37:54 -0400
Date: Fri, 12 Jul 2002 15:39:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com
Subject: NUMA-Q breakage 2/7 xquad_portio ioremap deadlock
Message-ID: <20020712223942.GZ25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_online_map stuff for hotplug cpu created a brand new bootstrap
ordering problem for NUMA-Q. The mmapped portio region needs to be
ioremapped early but ioremap attempts to do TLB shootdown, and
smp_call_function() (called by flush_tlb_all()) deadlocks when
cpu_online_map is uninitialized.

Workaround (due to Matt Dobson) below.



diff -Nur linux-2.5.23-vanilla/arch/i386/kernel/smp.c linux-2.5.23-patched/arch/i386/kernel/smp.c
--- linux-2.5.23-vanilla/arch/i386/kernel/smp.c	Tue Jun 18 19:11:47 2002
+++ linux-2.5.23-patched/arch/i386/kernel/smp.c	Mon Jul  8 14:52:32 2002
@@ -569,7 +569,7 @@
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
 
-	if (!cpus)
+	if (cpus <= 0)
 		return 0;
 
 	data.func = func;
