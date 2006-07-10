Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWGJBz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWGJBz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbWGJBz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:55:26 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:48074 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161292AbWGJBzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:55:25 -0400
Date: Sun, 9 Jul 2006 21:49:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
To: Andrew Morton <akpm@osdl.org>
Cc: "gregoire.favre" <gregoire.favre@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
Message-ID: <200607092152_MC3-1-C488-18A8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060709154445.60d6619c.akpm@osdl.org>

On Sun, 9 Jul 2006 15:44:45 -0700, Andrew Morton wrote:

> I meant, in smp.h:
> 
> #else /* CONFIG_SMP */
> #define smp_call_function_single(cpu, fn, arg, x, y) fn(arg)
> #endif        /* CONFIG_SMP */

But smp_call_function_single() generates an error if you try to call
it on your own CPU, so that doesn't make sense.

I fixed it like this, because that register defaults to zero
anyway and doesn't need initialization on CPU 0.

What I can't figure out is how this ever gets called on CPU 0
during init, whether it's SMP or not.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc1-mm1-64.orig/arch/x86_64/kernel/vsyscall.c
+++ 2.6.18-rc1-mm1-64/arch/x86_64/kernel/vsyscall.c
@@ -253,13 +253,14 @@ void __cpuinit vsyscall_set_cpu(int cpu)
 #ifdef CONFIG_NUMA
 	node = cpu_to_node[cpu];
 #endif
+#ifdef CONFIG_SMP
 	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
 		/* the notifier is unfortunately not executed on the
 		   target CPU */
 		void *info = (void *)((node << 12) | cpu);
 		smp_call_function_single(cpu, write_rdtscp_cb, info, 0, 1);
 	}
-
+#endif
 	/* Store cpu number in limit so that it can be loaded quickly
 	   in user space in vgetcpu.
 	   12 bits for the CPU and 8 bits for the node. */
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
