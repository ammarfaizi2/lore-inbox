Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTLVB5T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTLVB5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:57:19 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:37130 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264299AbTLVB5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:57:13 -0500
Date: Sun, 21 Dec 2003 18:00:44 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Ingo Oeser <ioe-lkml@rameria.de>
Subject: [PATCH] another minor bit of cpumask cleanup
Message-Id: <20031221180044.0f27eca1.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser pointed out to me in private email that one of the cpumask
macros was broken - the macro for for_each_online_cpu() starts its loop
with _any_ cpu from the provided mask, and only worries about restricting
itself to _online_ cpus when looping to the next cpu:

include/linux/cpumask.h:
> #define for_each_online_cpu(cpu, map)                                   \
>         for (cpu = first_cpu_const(mk_cpumask_const(map));              \
>                 cpu < NR_CPUS;                                          \
>                 cpu = next_online_cpu(cpu,map))

Looking further, I see this macro is never used, and its subordinate
inline macro next_online_cpu() used no where else.  What's more, it's
redundant.  Calling it with a map of "cpu_online_map" (which you have to
do, given it's broken thus) is just as good as calling the macro right
above, "for_each_cpu()", with that same "cpu_online_map". Indeed the
only uses of "for_each_cpu()", in arch/i386/mach-voyager/voyager_smp.c,
do pass "cpu_online_map" explicitly, in 5 of 6 calls there from.

So, having found a piece of code that is broken, redundant and unused,
I hereby off the following patch to remove it.

Thank-you, Ingo.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1497  -> 1.1498 
#	include/linux/cpumask.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/21	pj@sgi.com	1.1498
# Remove a couple unused, redundant, confused macros
# --------------------------------------------
#
diff -Nru a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h	Sun Dec 21 17:37:14 2003
+++ b/include/linux/cpumask.h	Sun Dec 21 17:37:14 2003
@@ -17,22 +17,9 @@
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #endif
 
-static inline int next_online_cpu(int cpu, cpumask_t map)
-{
-	do
-		cpu = next_cpu_const(cpu, map);
-	while (cpu < NR_CPUS && !cpu_online(cpu));
-	return cpu;
-}
-
 #define for_each_cpu(cpu, map)						\
 	for (cpu = first_cpu_const(map);				\
 		cpu < NR_CPUS;						\
 		cpu = next_cpu_const(cpu,map))
-
-#define for_each_online_cpu(cpu, map)					\
-	for (cpu = first_cpu_const(map);				\
-		cpu < NR_CPUS;						\
-		cpu = next_online_cpu(cpu,map))
 
 #endif /* __LINUX_CPUMASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
