Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268068AbUHFEjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268068AbUHFEjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268063AbUHFEjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:39:39 -0400
Received: from holomorphy.com ([207.189.100.168]:36040 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268068AbUHFEjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:39:20 -0400
Date: Thu, 5 Aug 2004 21:39:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040806043915.GT17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org> <20040806033448.GP17188@holomorphy.com> <20040806042420.GS17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806042420.GS17188@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 08:34:48PM -0700, William Lee Irwin III wrote:
>> It appears that init_idle() and fork_by_hand() could be combined into
>> a single method that calls init_idle() on behalf of the caller, which
>> would amount to something like:
>> task_t * __init fork_idle(int cpu)

On Thu, Aug 05, 2004 at 09:24:20PM -0700, William Lee Irwin III wrote:
> Atop the full 2.6.8-rc3-mm1 series:

Fix up sparc32 properly (incremental).

Index: mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc/kernel/sun4d_smp.c	2004-08-05 20:42:08.015287880 -0700
+++ mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c	2004-08-05 21:29:42.301370440 -0700
@@ -201,7 +201,7 @@
 			int no;
 
 			/* Cook up an idler for this guy. */
-			p = fork_idle(p, cpu);
+			p = fork_idle(p, i);
 			cpucount++;
 			current_set[i] = p->thread_info;
 			for (no = 0; !cpu_find_by_instance(no, NULL, &mid)
Index: mm1-2.6.8-rc3/arch/sparc/kernel/sun4m_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc/kernel/sun4m_smp.c	2004-08-05 05:30:44.000000000 -0700
+++ mm1-2.6.8-rc3/arch/sparc/kernel/sun4m_smp.c	2004-08-05 21:29:33.360729624 -0700
@@ -173,18 +173,9 @@
 			int timeout;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(NULL, NULL, CLONE_IDLETASK);
-
+			p = fork_idle(i);
 			cpucount++;
-
-			p = prev_task(&init_task);
-
-			init_idle(p, i);
-
 			current_set[i] = p->thread_info;
-
-			unhash_process(p);
-
 			/* See trampoline.S for details... */
 			entry += ((i-1) * 3);
 
