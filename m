Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966598AbWKOH4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966598AbWKOH4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966593AbWKOH4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:56:05 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:7629 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755473AbWKOHuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:32 -0500
Message-ID: <363577020.21912@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075024.180138257@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:08 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 01/28] readahead: kconfig options
Content-Disposition: inline; filename=readahead-kconfig-options.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a set of adaptive read-ahead methods.
They enable the kernel to better support many important I/O applications.

MAIN FEATURES
=============

- Adaptive read-ahead buffer management
	- aggressive, thrashing safe read-ahead size
		- optimal memory utilisation while achieving good I/O throughput
		- unnecessary to hand tuning VM_MAX_READAHEAD
		- support slow/fast readers at the same time
		- support large number of concurrent readers
	- aggressive read-ahead on start-of-file
		- configurable recommended read-ahead size
		- safeguarded by dynamic estimated thrashing threshold
		- good for lots-of-small-files case
	- shrinkable look-ahead size
		- cut down up to 40% memory consumption on overloaded situation

- Detecting any form of (semi-)sequencial scan
        - parallel / interleaved sequential scans on one fd
        - sequential reads across file open/close lifetime
        - mixed sequential / random accesses
        - sparse / skimming sequential read

- Support more access patterns
        - backward prefetching

- Better special case handling
        - nfs daemon support: the raparams cache is no longer required
	- laptop mode support: defer look-ahead on drive spinned down
        - loopback file support: avoid double look-ahead

DESIGN STRATEGIES
=================

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
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc4-mm1.orig/mm/Kconfig
+++ linux-2.6.19-rc4-mm1/mm/Kconfig
@@ -163,3 +163,60 @@ config ZONE_DMA_FLAG
 	default "0" if !ZONE_DMA
 	default "1"
 
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
+	  needed for some other purpose.
+
+	  The kernel already has a stock readahead logic that is well
+	  understood and well tuned. This option enables a more complex and
+	  feature rich one. It tries to be smart and memory efficient.
+	  However, due to the great diversity of real world applications, it
+	  might not fit everyone.
+
+	  Please refer to Documentation/sysctl/vm.txt for tunable parameters.
+
+	  It is known to work well for many desktops, file servers and
+	  postgresql databases. Say Y to try it out for yourself.
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
+	  echo 1 > /debug/readahead/debug_level # start events accounting
+	  echo 0 > /debug/readahead/debug_level # pause events accounting
+
+	  echo 2 > /debug/readahead/debug_level # show printk traces
+	  echo 3 > /debug/readahead/debug_level # show printk traces(verbose)
+	  echo 1 > /debug/readahead/debug_level # stop filling my kern.log
+
+	  Say N for production servers.
+
--- linux-2.6.19-rc4-mm1.orig/mm/readahead.c
+++ linux-2.6.19-rc4-mm1/mm/readahead.c
@@ -5,6 +5,8 @@
  *
  * 09Apr2002	akpm@zip.com.au
  *		Initial version.
+ * 26May2006	Fengguang Wu <wfg@ustc.edu>
+ *		Adaptive read-ahead framework.
  */
 
 #include <linux/kernel.h>

--
