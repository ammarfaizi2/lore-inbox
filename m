Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWI2Eba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWI2Eba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 00:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWI2Eba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 00:31:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29603 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751504AbWI2Eb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 00:31:29 -0400
Date: Thu, 28 Sep 2006 21:31:11 -0700
From: Paul Jackson <pj@sgi.com>
To: menage@google.com
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, mbligh@google.com,
       rohitseth@google.com, winget@google.com, dev@sw.ru, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Generic container system
Message-Id: <20060928213111.c881195c.pj@sgi.com>
In-Reply-To: <20060928104035.840699000@menage.corp.google.com>
References: <20060928104035.840699000@menage.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aha - I must have missed the memo - I take it this patch set doesn't compile yet.

If I just apply it to 2.6.18, and try my favorite config 'make sn2_defconfig',
then CONFIG_CPUSETS is disabled, because neither of the CONFIG_CONTAINER*
settings are enabled, and furthermore it doesn't build, with the complaints:

===================================================================================
kernel/built-in.o: In function `account_system_time':
(.text+0xc1e2): undefined reference to `cpuacct_charge'
kernel/built-in.o: In function `account_user_time':
(.text+0xc332): undefined reference to `cpuacct_charge'
make: *** [.tmp_vmlinux1] Error 1
===================================================================================

Apparently some generic code in kernel/sched.c is using cpuacct_charge,
but cpuacct_charge is only defined if CONFIG_CONTAINER_CPUACCT is
enabled.  Perhaps you need an empty stub for cpuacct_charge in
cpu_acct.h, in the event that CONTAINER_CPUACCT is not enabled.

If I then apply the following patch to my sn2_defconfig:

===================================================================================
--- 2.6.18.orig/arch/ia64/configs/sn2_defconfig 2006-09-28 20:37:02.162797053 -0700
+++ 2.6.18/arch/ia64/configs/sn2_defconfig      2006-09-28 21:05:22.119968786 -0700
@@ -1214,3 +1214,5 @@ CONFIG_CRYPTO_CRC32C=m
 #
 # Hardware crypto devices
 #
+CONFIG_CONTAINERS=y
+CONFIG_CONTAINER_CPUACCT=y
===================================================================================

it gets further (well, less far, actually), dying in the builds of
kernel/cpu_acct.c and kernel/cpuset.o, with the complaints:

===================================================================================
kernel/cpu_acct.c: In function 'cpuusage_read':
kernel/cpu_acct.c:57: warning: format '%llu' expects type 'long long unsigned int', but argument 3 has type 'cputime64_t'
kernel/cpu_acct.c:57: warning: format '%llu' expects type 'long long unsigned int', but argument 3 has type 'cputime64_t'
kernel/cpuset.c:1000: warning: initialization from incompatible pointer type
kernel/cpuset.c:1007: warning: initialization from incompatible pointer type
kernel/cpuset.c:1014: warning: initialization from incompatible pointer type
kernel/cpuset.c:1021: warning: initialization from incompatible pointer type
kernel/cpuset.c:1028: warning: initialization from incompatible pointer type
kernel/cpuset.c:1035: warning: initialization from incompatible pointer type
kernel/cpuset.c:1042: warning: initialization from incompatible pointer type
kernel/cpuset.c:1049: warning: initialization from incompatible pointer type
kernel/cpuset.c:1056: warning: initialization from incompatible pointer type
kernel/cpuset.c: In function 'cpuset_create':
kernel/cpuset.c:1102: error: invalid lvalue in assignment
kernel/cpuset.c:1126: error: invalid lvalue in assignment
kernel/cpuset.c: At top level:
kernel/cpuset.c:1153: error: static declaration of 'cpuset_subsys' follows non-static declaration
kernel/cpuset.c:58: error: previous declaration of 'cpuset_subsys' was here
make[1]: *** [kernel/cpuset.o] Error 1                                                    
===================================================================================

Looking at the relevant lines of kernel/cpuset.c, I see:

58: extern struct container_subsys cpuset_subsys;
59: #define container_cs(_cont) ((struct cpuset *)(_cont)->subsys[cpuset_subsys.subsys_id])
1102: container_cs(cont) = &top_cpuset;
1126: container_cs(cont) = cs;
1153: static struct container_subsys cpuset_subsys = {

Looks like cpuset_subsys doesn't know if it is extern or static,
and container_cs() is a cast thingie, which isn't allowed on the
left side in modern gcc.

That's enough damage for one night ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
