Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161492AbWHDViu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161492AbWHDViu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161494AbWHDViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:38:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:1197 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161492AbWHDVit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:38:49 -0400
Subject: [PATCH] enable VMSPLIT for highmem kernels
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 04 Aug 2006 14:38:45 -0700
Message-Id: <20060804213845.986D69FA@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll assume that the complete lack of commenting on this patch
mean that everyone agrees with me. :)  Time for -mm I guess.

--

The current VMSPLIT Kconfig option is disabled whenever highmem
is on.  This is a bit screwy because the people who need to
change VMSPLIT the most tend to be the ones *with* highmem and
constrained lowmem.

So, remove the highmem dependency.  But, re-include the
dependency for the "full 1GB of lowmem" option.  You can't have
the full 1GB of lowmem and highmem because of the need for the
vmalloc(), kmap(), etc... areas.

I thought there would be at least a bit of tweaking to do to
get it to work, but everything seems OK.

Boot tested on a 4GB x86 machine, and a 12GB 3-node NUMA-Q:

elm3b82:~# cat /proc/meminfo
MemTotal:      3695412 kB
MemFree:       3659540 kB
...
LowTotal:      2909008 kB
LowFree:       2892324 kB
...
elm3b82:~# zgrep PAE /proc/config.gz
CONFIG_X86_PAE=y

larry:~# cat /proc/meminfo
MemTotal:     11845900 kB
MemFree:      11786748 kB
...
LowTotal:      2855180 kB
LowFree:       2830092 kB

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/arch/i386/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/Kconfig~split-for-pae arch/i386/Kconfig
--- lxc/arch/i386/Kconfig~split-for-pae	2006-08-03 09:01:32.000000000 -0700
+++ lxc-dave/arch/i386/Kconfig	2006-08-04 14:38:34.000000000 -0700
@@ -497,7 +497,7 @@ config HIGHMEM64G
 endchoice
 
 choice
-	depends on EXPERIMENTAL && !X86_PAE
+	depends on EXPERIMENTAL
 	prompt "Memory split" if EMBEDDED
 	default VMSPLIT_3G
 	help
@@ -519,6 +519,7 @@ choice
 	config VMSPLIT_3G
 		bool "3G/1G user/kernel split"
 	config VMSPLIT_3G_OPT
+		depends on !HIGHMEM
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
_
