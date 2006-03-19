Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWCSCmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWCSCmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWCSClv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:41:51 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:36546 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751279AbWCSCee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:34 -0500
Message-Id: <20060319023448.714508000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:14 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 01/23] readahead: kconfig options
Content-Disposition: inline; filename=readahead-kconfig-options.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a set of adaptive read-ahead methods.
They enable the kernel to better support many important I/O applications.

The functional features include:

- Adaptive read-ahead buffer management
	- aggressive, thrashing safe read-ahead size
		- optimal memory utilisation while achieving good I/O throughput
		- unnecessary to hand tuning VM_MAX_READAHEAD
		- support slow/fast readers at the same time
		- support large number of concurrent readers
	- shrinkable look-ahead size
		- cut down up to 40% memory consumption on overloaded situation

- Support common access patterns
        - multiple streams on one fd
        - backward prefetching
        - sparse reading
        - seeking and reading

- Special case handling
        - nfsd support: the raparams cache is no longer required
	- laptop mode support: defer look-ahead on drive spinned down
        - loopback file support: avoid double look-ahead

The design strategies are:

- Dual methods design
        - stateful method: the fast and default one
	- stateless method: the robust and failsafe one
	- if anything abnormal happens, the stateful method bails out, the
	  stateless method queries the page cache and possibly restart the
	  read-ahead process

- Robust feedback design
	- sense and handle important states so that the logic wont run away
	- detect danger of thrashing and prevent it in advance
        - extensive accounting and debugging traces

This patch:

Add kconfig options to enable/disable:
	- adaptive read-ahead logic
	- adaptive read-ahead debug traces and events accounting

The read-ahead introduction text is cited from the well written LWN article
"Adaptive file readahead" <http://lwn.net/Articles/155510/> :)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/Kconfig |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/mm/Kconfig
+++ linux-2.6.16-rc6-mm2/mm/Kconfig
@@ -145,3 +145,58 @@ config MIGRATION
 	  while the virtual addresses are not changed. This is useful for
 	  example on NUMA systems to put pages nearer to the processors accessing
 	  the page.
+
+#
+# Adaptive file readahead
+#
+config ADAPTIVE_READAHEAD
+	bool "Adaptive file readahead (EXPERIMENTAL)"
+	default n
+	depends on EXPERIMENTAL
+	help
+	  Readahead is a technique employed by the kernel in an attempt
+	  to improve file reading performance. If the kernel has reason
+	  to believe that a particular file is being read sequentially,
+	  it will attempt to read blocks from the file into memory before
+	  the application requests them. When readahead works, it speeds
+	  up the system's throughput, since the reading application does
+	  not have to wait for its requests. When readahead fails, instead,
+	  it generates useless I/O and occupies memory pages which are
+	  needed for some other purpose. For sequential readings,
+
+	  Normally, the kernel uses a stock readahead logic that is well
+	  understood and well tuned. This option enables a much complex and
+	  feature rich one. It is more aggressive and memory efficient in
+	  doing readahead, and supports some less-common access patterns such
+	  as reading backward and reading sparsely. However, due to the great
+	  diversity of real world applications, it might not fit everyone.
+
+	  Please refer to Documentation/sysctl/vm.txt for tunable parameters.
+
+	  Say Y here if you are building kernel for file servers.
+	  Say N if you are unsure.
+
+config DEBUG_READAHEAD
+	bool "Readahead debug and accounting"
+	default n
+	depends on ADAPTIVE_READAHEAD
+	select DEBUG_FS
+	help
+	  This option injects extra code to dump detailed debug traces and do
+	  readahead events accounting.
+
+	  To actually get the data:
+
+	  mkdir /debug
+	  mount -t debug none /debug
+
+	  After that you can do the following:
+
+	  echo > /debug/readahead/events # reset the counters
+	  cat /debug/readahead/events    # check the counters
+
+	  echo 1 > /debug/readahead/debug_level # show printk traces
+	  echo 2 > /debug/readahead/debug_level # show verbose printk traces
+	  echo 0 > /debug/readahead/debug_level # stop filling my kern.log
+
+	  Say N, unless you have readahead performance problems.

--
