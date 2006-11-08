Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754624AbWKHRqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbWKHRqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754623AbWKHRqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:46:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23158 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754624AbWKHRqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:46:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=rDlN9o5phm0EyqdrYtq7xHqJJtp1xPuapOPKpkunwWPU6Fl30GpHW8VUs0sSwxYKzvPRPFwPCjD1f3jZwM+WoFkTil959BTcy5d8ehSDZuZwV5i3/3rbPY5qJQeAiqOjWCvDlAV47duRlH9lnTrNjO4W05P3Sra/R92M6dnRyOA=
References: <20061108174540.976625689@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 09 Nov 2006 02:45:42 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 1/7] documentation and scripts
Content-Disposition: inline; filename=doc.patch
Message-ID: <455217f5.7ce3ac15.468a.ffff84c7@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch set provides some fault-injection capabilities.

- kmalloc() failures

- alloc_pages() failures

- disk IO errors

We can see what really happens if those failures happen.

In order to enable these fault-injection capabilities:

1. Enable relevant config options (CONFIG_FAILSLAB, CONFIG_PAGE_ALLOC,
   CONFIG_MAKE_REQUEST) and if you want to configure them via debugfs,
   enable CONFIG_FAULT_INJECTION_DEBUG_FS.

2. Build and boot with this kernel

3. Configure fault-injection capabilities behavior by boot option or debugfs

   - Boot option

     failslab=
     fail_page_alloc=
     fail_make_request=

   - Debugfs

     /debug/failslab/*
     /debug/fail_page_alloc/*
     /debug/fail_make_request/*

   Please refer to the Documentation/fault-injection/fault-injection.txt
   for details.

4. See what really happens.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Don Mullis <dwm@meer.net>

 Documentation/fault-injection/failcmd.sh          |    4 
 Documentation/fault-injection/failmodule.sh       |   31 +++
 Documentation/fault-injection/fault-injection.txt |  223 ++++++++++++++++++++++
 Documentation/kernel-parameters.txt               |    7 
 4 files changed, 265 insertions(+)

Index: 2.6-rc/Documentation/fault-injection/failcmd.sh
===================================================================
--- /dev/null
+++ 2.6-rc/Documentation/fault-injection/failcmd.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+echo 1 > /proc/self/make-it-fail
+exec $*
Index: 2.6-rc/Documentation/fault-injection/failmodule.sh
===================================================================
--- /dev/null
+++ 2.6-rc/Documentation/fault-injection/failmodule.sh
@@ -0,0 +1,31 @@
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
+# Disable any fault injection
+echo 0 > /debug/$1/stacktrace-depth
+
+echo `cat /sys/module/$2/sections/.text` > /debug/$1/address-start
+echo `cat /sys/module/$2/sections/.exit.text` > /debug/$1/address-end
+echo $STACKTRACE_DEPTH > /debug/$1/stacktrace-depth
Index: 2.6-rc/Documentation/fault-injection/fault-injection.txt
===================================================================
--- /dev/null
+++ 2.6-rc/Documentation/fault-injection/fault-injection.txt
@@ -0,0 +1,223 @@
+Fault injection capabilities infrastructure
+===========================================
+
+See also drivers/md/faulty.c and "every_nth" module option for scsi_debug.
+
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
+  injects disk IO errors on permitted devices by
+  /sys/block/<device>/make-it-fail or
+  /sys/block/<device>/<partition>/make-it-fail. (generic_make_request())
+
+Configure fault-injection capabilities behavior
+-----------------------------------------------
+
+o debugfs entries
+
+fault-inject-debugfs kernel module provides some debugfs entries for runtime
+configuration of fault-injection capabilities.
+
+- /debug/*/probability:
+
+	likelihood of failure injection, in percent.
+	Format: <percent>
+
+	Note that one-failure-per-handred is a very high error rate
+	for some testcases. Please set probably=100 and configure
+	/debug/*/interval for such testcases.
+
+- /debug/*/interval:
+
+	specifies the interval between failures, for calls to
+	should_fail() that pass all the other tests.
+
+	Note that if you enable this, by setting interval>1, you will
+	probably want to set probability=100.
+
+- /debug/*/times:
+
+	specifies how many times failures may happen at most.
+	A value of -1 means "no limit".
+
+- /debug/*/space:
+
+	specifies an initial resource "budget", decremented by "size"
+	on each call to should_fail(,size).  Failure injection is
+	suppressed until "space" reaches zero.
+
+- /debug/*/verbose
+
+	Format: { 0 | 1 | 2 }
+	specifies the verbosity of the messages when failure is injected.
+	We default to 0 (no extra messages), setting it to '1' will
+	print only to tell failure happened, '2' will print call trace too -
+	it is useful to debug the problems revealed by fault injection
+	capabilities.
+
+- /debug/*/task-filter:
+
+	Format: { 0 | 1 }
+	A value of '0' disables filtering by process (default).
+	Any positive value limits failures to only processes indicated by
+	/proc/<pid>/make-it-fail==1.
+
+- /debug/*/address-start:
+- /debug/*/address-end:
+
+	specifies the range of virtual addresses tested during
+	stacktrace walking.  Failure is injected only if some caller
+	in the walked stacktrace lies within this range.
+	Default is [0,ULONG_MAX) (whole of virtual address space).
+
+- /debug/*/stacktrace-depth:
+
+	specifies the maximum stacktrace depth walked during search
+	for a caller within [address-start,address-end).
+
+- /debug/failslab/ignore-gfp-highmem:
+- /debug/fail_page_alloc/ignore-gfp-highmem:
+
+	Format: { 0 | 1 }
+	default is 0, setting it to '1' won't inject failures into
+	highmem/user allocations.
+
+- /debug/failslab/ignore-gfp-wait:
+- /debug/fail_page_alloc/ignore-gfp-wait:
+
+	Format: { 0 | 1 }
+	default is 0, setting it to '1' will inject failures
+	only into non-sleep allocations (GFP_ATOMIC allocations).
+
+o Boot option
+
+In order to inject faults while debugfs is not available (early boot time),
+use the boot option:
+
+	failslab=
+	fail_page_alloc=
+	fail_make_request=<interval>,<probability>,<space>,<times>
+
+How to add new fault injection capability
+-----------------------------------------
+
+o #include <linux/fault-inject.h>
+
+o define the fault attributes
+
+  DECLARE_FAULT_INJECTION(name);
+
+  Please see the definition of struct fault_attr in fault-inject.h
+  for details.
+
+o provide the way to configure fault attributes
+
+- boot option
+
+  If you need to enable the fault injection capability from boot time, you can
+  provide boot option to configure it. There is a helper function for it.
+
+  setup_fault_attr(attr, str);
+
+- debugfs entries
+
+  failslab, fail_page_alloc, and fail_make_request use this way.
+  There is a helper function for it.
+
+  init_fault_attr_entries(entries, attr, name);
+  void cleanup_fault_attr_entries(entries);
+
+- module parameters
+
+  If the scope of the fault injection capability is limited to a
+  single kernel module, it is better to provide module parameters to
+  configure the fault attributes.
+
+o add a hook to insert failures
+
+  should_fail() returns 1 when failures should happen.
+
+	should_fail(attr,size);
+
+Application Examples
+--------------------
+
+o inject slab allocation failures into module init/cleanup code
+
+------------------------------------------------------------------------------
+#!/bin/bash
+
+FAILCMD=Documentation/fault-injection/failcmd.sh
+BLACKLIST="root_plug evbug"
+
+FAILNAME=failslab
+echo Y > /debug/$FAILNAME/task-filter
+echo 10 > /debug/$FAILNAME/probability
+echo 100 > /debug/$FAILNAME/interval
+echo -1 > /debug/$FAILNAME/times
+echo 2 > /debug/$FAILNAME/verbose
+echo 1 > /debug/$FAILNAME/ignore-gfp-highmem
+echo 1 > /debug/$FAILNAME/ignore-gfp-wait
+
+blacklist()
+{
+	echo $BLACKLIST | grep $1 > /dev/null 2>&1
+}
+
+oops()
+{
+	dmesg | grep BUG > /dev/null 2>&1 
+}
+
+find /lib/modules/`uname -r` -name '*.ko' -exec basename {} .ko \; |
+	while read i
+	do
+		oops && exit 1
+
+		if ! blacklist $i
+		then
+			echo inserting $i...
+			bash $FAILCMD modprobe $i
+		fi
+	done
+
+lsmod | awk '{ if ($3 == 0) { print $1 } }' |
+	while read i
+	do
+		oops && exit 1
+
+		if ! blacklist $i
+		then
+			echo removing $i...
+			bash $FAILCMD modprobe -r $i
+		fi
+	done
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
+echo injecting errors into the module $1...
+
+modprobe $1
+bash $FAILMOD failslab $1 10
+echo 25 > /debug/failslab/probability
+
+------------------------------------------------------------------------------
+
Index: 2.6-rc/Documentation/kernel-parameters.txt
===================================================================
--- 2.6-rc.orig/Documentation/kernel-parameters.txt
+++ 2.6-rc/Documentation/kernel-parameters.txt
@@ -544,6 +544,13 @@ and is between 256 and 4096 characters. 
 	eurwdt=		[HW,WDT] Eurotech CPU-1220/1410 onboard watchdog.
 			Format: <io>[,<irq>]
 
+	failslab=
+	fail_page_alloc=
+	fail_make_request=[KNL]
+			General fault injection mechanism.
+			Format: <interval>,<probability>,<space>,<times>
+			See also /Documentation/fault-injection/.
+
 	fd_mcs=		[HW,SCSI]
 			See header of drivers/scsi/fd_mcs.c.
 

--
