Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWISGBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWISGBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWISGBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:01:15 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:54792 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S932314AbWISGBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:01:12 -0400
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection
	capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20060914102033.462112306@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102033.462112306@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 22:56:28 -0700
Message-Id: <1158645388.2419.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Undo temporary fix-up for clean application of patch
"[patch 8/8] stacktrace filtering for fault-injection capabilities".

Fix bug in !(CONFIG_STACK_UNWIND || CONFIG_STACKTRACE) case, based on
code inspection only.  Anyone with a non-i386, -x86_64, -s390 willing
to test this?

Reintroduce stacktrace-specific documentation, factored out earlier.


Signed-off-by: Don Mullis <dwm@meer.net>

---
 Documentation/fault-injection/fault-injection.txt |   13 +++++++++++++
 include/linux/fault-inject.h                      |    2 +-
 lib/fault-inject.c                                |    2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6.17/lib/fault-inject.c
===================================================================
--- linux-2.6.17.orig/lib/fault-inject.c
+++ linux-2.6.17/lib/fault-inject.c
@@ -136,7 +136,7 @@ static int fail_stacktrace(struct fault_
 
 #else
 
-#define fail_stacktrace(attr)	(0)
+#define fail_stacktrace(attr)	(1)
 
 #endif
 
Index: linux-2.6.17/Documentation/fault-injection/fault-injection.txt
===================================================================
--- linux-2.6.17.orig/Documentation/fault-injection/fault-injection.txt
+++ linux-2.6.17/Documentation/fault-injection/fault-injection.txt
@@ -61,6 +61,19 @@ configuration of fault-injection capabil
 	A negative value means that failures are enabled for
 	pid==-process_filter irrespective of /proc/<pid>/make-it-fail.
 
+- /debug/*/stacktrace-depth:
+
+	specifies the maximum stacktrace depth walked during search
+	for a caller within [address-start,address-end).  A value of 0
+	disables the stacktrace filter.
+
+- /debug/*/address-start:
+- /debug/*/address-end:
+
+	specifies the range of virtual addresses tested during
+	stacktrace walking.  Failure is injected only if some caller
+	in the walked stacktrace lies within this range.
+
 o Boot option
 
 In order to inject faults while debugfs is not available (early boot time),
Index: linux-2.6.17/include/linux/fault-inject.h
===================================================================
--- linux-2.6.17.orig/include/linux/fault-inject.h
+++ linux-2.6.17/include/linux/fault-inject.h
@@ -16,7 +16,7 @@ struct fault_attr {
 	atomic_t times;
 	atomic_t space;
 	unsigned long count;
-	u32 process_filter;
+	atomic_t process_filter;
 	unsigned long stacktrace_depth;
 	unsigned long address_start;
 	unsigned long address_end;


