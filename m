Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWISF4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWISF4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 01:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWISF4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 01:56:36 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:51207 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751095AbWISF4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 01:56:34 -0400
Subject: Re: [patch 1/8] documentation and scripts
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <20060914102029.642906830@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102029.642906830@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 22:50:51 -0700
Message-Id: <1158645051.2419.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add reference to similar functionality in drivers/md/faulty.c .

Clarify debugfs descriptions.

Add an entry for fault-injection to 
Documentation/kernel-parameters.txt .


Signed-off-by: Don Mullis <dwm@meer.net>

---
 Documentation/fault-injection/fault-injection.txt |   85 ++++++++++------------
 Documentation/kernel-parameters.txt               |    7 +
 2 files changed, 47 insertions(+), 45 deletions(-)

Index: linux-2.6.17/Documentation/fault-injection/fault-injection.txt
===================================================================
--- linux-2.6.17.orig/Documentation/fault-injection/fault-injection.txt
+++ linux-2.6.17/Documentation/fault-injection/fault-injection.txt
@@ -1,6 +1,9 @@
 Fault injection capabilities infrastructure
 ===========================================
 
+See also drivers/md/faulty.c .
+
+
 Available fault injection capabilities
 --------------------------------------
 
@@ -14,58 +17,49 @@ o fail_page_alloc
 
 o fail_make_request
 
-  injects disk IO errors on permitted devices by /sys/block/<device>/make-it-fail
-  or /sys/block/<device>/<partition>/make-it-fail. (generic_make_request())
+  injects disk IO errors on permitted devices by
+  /sys/block/<device>/make-it-fail or
+  /sys/block/<device>/<partition>/make-it-fail. (generic_make_request())
 
 Configure fault-injection capabilities behavior
 -----------------------------------------------
 
-Example for failslab:
-
 o debugfs entries
 
 fault-inject-debugfs kernel module provides some debugfs entries for runtime
-configuration for fault-injection capabilities.
-
-- /debug/failslab/probability:
+configuration of fault-injection capabilities.
 
-	specifies how often it should fail in percent.
+- /debug/*/probability:
 
-- /debug/failslab/interval:
-
-	specifies the interval of failures.
-
-- /debug/failslab/times:
-
-	specifies how many times failures may happen at most.
+	likelihood of failure injection, in percent.
 
-- /debug/failslab/space:
+- /debug/*/interval:
 
-	specifies the size of free space where memory can be allocated
-	safely in bytes.
+	specifies the interval between failures, for calls to
+	should_fail() that pass all the other tests.
 
-- /debug/failslab/process-filter:
+	Note that if you enable this, by setting interval>1, you will
+	probably want to set probability=100.
 
-	specifies whether the process filter is enabled or not.
-	It allows failing only permitted processes by /proc/<pid>/make-it-fail
+- /debug/*/times:
 
-- /debug/failslab/stacktrace-depth:
-
-	specifies the maximum stacktrace depth walking allowed.
-	A value '0' means stacktrace filter is disabled.
+	specifies how many times failures may happen at most.
+	A value of -1 means "no limit".
 
-- /debug/failslab/address-start:
-- /debug/failslab/address-end:
+- /debug/*/space:
 
-	specifies the range of virtual address.
-	It allows failing only if the stacktrace hits in this range.
+	specifies an initial resource "budget", decremented by "size"
+	on each call to should_fail(,size).  Failure injection is
+	suppressed until "space" reaches zero.
 
 o Boot option
 
 In order to inject faults while debugfs is not available (early boot time),
-We can use boot option.
+use the boot option:
 
-- failslab=<interval>,<probability>,<space>,<times>
+    failslab=
+    fail_page_alloc=
+    fail_make_request=<interval>,<probability>,<space>,<times>
 
 How to add new fault injection capability
 -----------------------------------------
@@ -77,44 +71,42 @@ o define the fault attributes
   DEFINE_FAULT_INJECTION(name);
 
   Please see the definition of struct fault_attr in fault-inject.h
-  for the detail.
+  for details.
 
 o provide the way to configure fault attributes
 
 - boot option
 
-  If you need to enable the fault injection capability ealier boot time,
+  If you need to enable the fault injection capability from boot time,
   you can provide boot option to configure it. There is a helper function for it.
 
   setup_fault_attr(attr, str);
 
 - module parameters
 
-  If the scope of the fault injection capability is limited by a kernel module,
-  It is better to provide module parameters to configure the member of fault
-  attributes.
+  If the scope of the fault injection capability is limited to a
+  single kernel module, it is better to provide module parameters to
+  configure the fault attributes.
 
 - debugfs entries
 
   failslab, fail_page_alloc, and fail_make_request use this way.
-
-  But now there is no helper functions to provides debugfs entries for
+  But now there is no helper functions to provide debugfs entries for
   fault injection capabilities. Please refer to lib/fault-inject-debugfs.c
   to know how to do. And please try not to add new one into
   fault-inject-debugfs module.
-
-  Because failslab, fail_page_alloc, and fail_make_request are used ealier
-  boot time before debugfs is available and the slab allocator,
-  the page allocator, and the block layer cannot be built as module.
+  Because failslab, fail_page_alloc, and fail_make_request are used from
+  boot time, before debugfs is available, the slab allocator,
+  the page allocator, and the block layer cannot be built as modules.
 
 o add a hook to insert failures
 
   should_fail() returns 1 when failures should happen.
 
-  should_fail(attr);
+	should_fail(attr,size);
 
-Tests
------
+Application Examples
+--------------------
 
 o inject slab allocation failures into module init/cleanup code
 
@@ -148,3 +140,6 @@ echo 25 > /debug/failslab/probability
 
 ------------------------------------------------------------------------------
 
+
+
+
Index: linux-2.6.17/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.17.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.17/Documentation/kernel-parameters.txt
@@ -544,6 +544,13 @@ running once the system is up.
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
 


