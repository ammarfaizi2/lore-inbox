Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTKED5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 22:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTKED5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 22:57:44 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:16112 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262729AbTKED5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 22:57:42 -0500
Date: Tue, 4 Nov 2003 19:57:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
Subject: [PATCH] > 256 CPU cpumask build fix - const confusion
Message-Id: <20031104195728.040db07a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply the following patch.  It's needed to build NR_CPUS > 256.

Without this fix, you get compile errors:
    include/linux/cpumask.h: In function `next_online_cpu':
    include/linux/cpumask.h:56: structure has no member named `val'


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1357  -> 1.1358 
#	include/linux/cpumask.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/04	pj@sgi.com	1.1358
# Fix cpumask const confusion if NR_CPUS > 128 (i386) or > 256 (ia64).
# --------------------------------------------
#
diff -Nru a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h	Tue Nov  4 19:31:30 2003
+++ b/include/linux/cpumask.h	Tue Nov  4 19:31:30 2003
@@ -53,18 +53,18 @@
 static inline int next_online_cpu(int cpu, cpumask_t map)
 {
 	do
-		cpu = next_cpu_const(cpu, map);
+		cpu = next_cpu_const(cpu, mk_cpumask_const(map));
 	while (cpu < NR_CPUS && !cpu_online(cpu));
 	return cpu;
 }
 
 #define for_each_cpu(cpu, map)						\
-	for (cpu = first_cpu_const(map);				\
+	for (cpu = first_cpu_const(mk_cpumask_const(map));		\
 		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu,map))
+		cpu = next_cpu_const(cpu,mk_cpumask_const(map)))
 
 #define for_each_online_cpu(cpu, map)					\
-	for (cpu = first_cpu_const(map);				\
+	for (cpu = first_cpu_const(mk_cpumask_const(map));		\
 		cpu < NR_CPUS;						\
 		cpu = next_online_cpu(cpu,map))
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
