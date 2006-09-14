Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWINKUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWINKUe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWINKUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:20:34 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:844 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750751AbWINKUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:33 -0400
Message-Id: <20060914102029.642906830@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:13 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 1/8] documentation and scripts
Content-Disposition: inline; filename=doc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the documentation and helper/testing scripts for
fault-injection capabilities.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 Documentation/fault-injection/failcmd.sh          |    4 
 Documentation/fault-injection/failmodule.sh       |   32 ++++
 Documentation/fault-injection/fault-injection.txt |  150 ++++++++++++++++++++++
 3 files changed, 186 insertions(+)

Index: work-shouldfail/Documentation/fault-injection/failcmd.sh
===================================================================
--- /dev/null
+++ work-shouldfail/Documentation/fault-injection/failcmd.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+echo 1 > /proc/self/make-it-fail
+exec $*
Index: work-shouldfail/Documentation/fault-injection/failmodule.sh
===================================================================
--- /dev/null
+++ work-shouldfail/Documentation/fault-injection/failmodule.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+#
+# Usage: failmodule <failname> <modulename> [stacktrace-depth]
+#
+#	<failname>: "failslab", "fail_alloc_page", or "fail_make_request"
+#
+#	<modulename>: module name that you want to inject faults.
+#
+#	[stacktrace-depth]: the maximum number of stacktrace walking allowed
+#
+
+STACKTRACE_DEPTH=5
+if [ $# -gt 2 ]; then
+	STACKTRACE_DEPTH=$3
+fi
+
+if [ ! -d /debug/$1 ]; then
+	echo "Fault-injection $1 does not exist" >&2
+	exit 1
+fi
+if [ ! -d /sys/module/$2 ]; then
+	echo "Module $2 does not exist" >&2
+	exit 1
+fi
+
+# Disable stacktrace filter at first
+echo 0 > /debug/$1/address-end
+echo 1 > /debug/$1/stacktrace-depth
+
+echo `cat /sys/module/$2/sections/.text` > /debug/$1/address-start
+echo `cat /sys/module/$2/sections/.exit.text` > /debug/$1/address-end
+echo $STACKTRACE_DEPTH > /debug/$1/stacktrace-depth
Index: work-shouldfail/Documentation/fault-injection/fault-injection.txt
===================================================================
--- /dev/null
+++ work-shouldfail/Documentation/fault-injection/fault-injection.txt
@@ -0,0 +1,150 @@
+Fault injection capabilities infrastructure
+===========================================
+
+Available fault injection capabilities
+--------------------------------------
+
+o failslab
+
+  injects slab allocation failures. (kmalloc(), kmem_cache_alloc(), ...)
+
+o fail_page_alloc
+
+  injects page allocation failures. (alloc_pages(), get_free_pages(), ...)
+
+o fail_make_request
+
+  injects disk IO errors on permitted devices by /sys/block/<device>/make-it-fail
+  or /sys/block/<device>/<partition>/make-it-fail. (generic_make_request())
+
+Configure fault-injection capabilities behavior
+-----------------------------------------------
+
+Example for failslab:
+
+o debugfs entries
+
+fault-inject-debugfs kernel module provides some debugfs entries for runtime
+configuration for fault-injection capabilities.
+
+- /debug/failslab/probability:
+
+	specifies how often it should fail in percent.
+
+- /debug/failslab/interval:
+
+	specifies the interval of failures.
+
+- /debug/failslab/times:
+
+	specifies how many times failures may happen at most.
+
+- /debug/failslab/space:
+
+	specifies the size of free space where memory can be allocated
+	safely in bytes.
+
+- /debug/failslab/process-filter:
+
+	specifies whether the process filter is enabled or not.
+	It allows failing only permitted processes by /proc/<pid>/make-it-fail
+
+- /debug/failslab/stacktrace-depth:
+
+	specifies the maximum stacktrace depth walking allowed.
+	A value '0' means stacktrace filter is disabled.
+
+- /debug/failslab/address-start:
+- /debug/failslab/address-end:
+
+	specifies the range of virtual address.
+	It allows failing only if the stacktrace hits in this range.
+
+o Boot option
+
+In order to inject faults while debugfs is not available (early boot time),
+We can use boot option.
+
+- failslab=<interval>,<probability>,<space>,<times>
+
+How to add new fault injection capability
+-----------------------------------------
+
+o #include <linux/fault-inject.h>
+
+o define the fault attributes
+
+  DEFINE_FAULT_INJECTION(name);
+
+  Please see the definition of struct fault_attr in fault-inject.h
+  for the detail.
+
+o provide the way to configure fault attributes
+
+- boot option
+
+  If you need to enable the fault injection capability ealier boot time,
+  you can provide boot option to configure it. There is a helper function for it.
+
+  setup_fault_attr(attr, str);
+
+- module parameters
+
+  If the scope of the fault injection capability is limited by a kernel module,
+  It is better to provide module parameters to configure the member of fault
+  attributes.
+
+- debugfs entries
+
+  failslab, fail_page_alloc, and fail_make_request use this way.
+
+  But now there is no helper functions to provides debugfs entries for
+  fault injection capabilities. Please refer to lib/fault-inject-debugfs.c
+  to know how to do. And please try not to add new one into
+  fault-inject-debugfs module.
+
+  Because failslab, fail_page_alloc, and fail_make_request are used ealier
+  boot time before debugfs is available and the slab allocator,
+  the page allocator, and the block layer cannot be built as module.
+
+o add a hook to insert failures
+
+  should_fail() returns 1 when failures should happen.
+
+  should_fail(attr);
+
+Tests
+-----
+
+o inject slab allocation failures into module init/cleanup code
+
+------------------------------------------------------------------------------
+#!/bin/bash
+
+FAILCMD=Documentation/fault-injection/failcmd.sh
+
+modprobe fault-inject-debugfs
+echo Y > /debug/failslab/process-filter
+echo 25 > /debug/failslab/probability
+
+find /lib/modules/`uname -r` -name '*.ko' -exec basename {} .ko \; \
+	| while read i; do bash $FAILCMD modprobe $i;done
+
+lsmod | awk '{ if ($3 == 0) { system("bash $FAILCMD modprobe -r " $1) } }'
+
+------------------------------------------------------------------------------
+
+o inject slab allocation failures only for a specific module
+
+------------------------------------------------------------------------------
+#!/bin/bash
+
+FAILMOD=Documentation/fault-injection/failmodule.sh
+
+modprobe fault-inject-debugfs
+modprobe your-test-module
+bash $FAILMOD failslab your-test-module 10
+echo 25 > /debug/failslab/probability
+
+------------------------------------------------------------------------------
+

--
