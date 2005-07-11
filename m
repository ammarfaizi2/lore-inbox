Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVGKVVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVGKVVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVGKVTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:19:32 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:20430 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262693AbVGKVRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:17:08 -0400
Subject: [PATCH 29/29v2] Add core locking documentation to Infiniband
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110449.4389.5042.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 17:09:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add core locking documentation to Infiniband

Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

-- 
 core_locking.txt |  114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 114 insertions(+)
diff -uprN linux-2.6.13-rc2-mm1-28/Documentation/infiniband/core_locking.txt linux-2.6.13-rc2-mm1-29/Documentation/infiniband/core_locking.txt
-- linux-2.6.13-rc2-mm1-28/Documentation/infiniband/core_locking.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13-rc2-mm1-29/Documentation/infiniband/core_locking.txt	2005-07-09 07:33:43.000000000 -0400
@@ -0,0 +1,114 @@
+INFINIBAND MIDLAYER LOCKING
+
+  This guide is an attempt to make explicit the locking assumptions
+  made by the InfiniBand midlayer.  It describes the requirements on
+  both low-level drivers that sit below the midlayer and upper level
+  protocols that use the midlayer.
+
+Sleeping and interrupt context
+
+  With the following exceptions, a low-level driver implementation of
+  all of the methods in struct ib_device may sleep.  The exceptions
+  are any methods from the list:
+
+    create_ah
+    modify_ah
+    query_ah
+    destroy_ah
+    bind_mw
+    post_send
+    post_recv
+    poll_cq
+    req_notify_cq
+    map_phys_fmr
+
+  which may not sleep and must be callable from any context.
+
+  The corresponding functions exported to upper level protocol
+  consumers:
+
+    ib_create_ah
+    ib_modify_ah
+    ib_query_ah
+    ib_destroy_ah
+    ib_bind_mw
+    ib_post_send
+    ib_post_recv
+    ib_req_notify_cq
+    ib_map_phys_fmr
+
+  are therefore safe to call from any context.
+
+  In addition, the function
+
+    ib_dispatch_event
+
+  used by low-level drivers to dispatch asynchronous events through
+  the midlayer is also safe to call from any context.
+
+Reentrancy
+
+  All of the methods in struct ib_device exported by a low-level
+  driver must be fully reentrant.  The low-level driver is required to
+  perform all synchronization necessary to maintain consistency, even
+  if multiple function calls using the same object are run
+  simultaneously.
+
+  The IB midlayer does not perform any serialization of function calls.
+
+  Because low-level drivers are reentrant, upper level protocol
+  consumers are not required to perform any serialization.  However,
+  some serialization may be required to get sensible results.  For
+  example, a consumer may safely call ib_poll_cq() on multiple CPUs
+  simultaneously.  However, the ordering of the work completion
+  information between different calls of ib_poll_cq() is not defined.
+
+Callbacks
+
+  A low-level driver must not perform a callback directly from the
+  same callchain as an ib_device method call.  For example, it is not
+  allowed for a low-level driver to call a consumer's completion event
+  handler directly from its post_send method.  Instead, the low-level
+  driver should defer this callback by, for example, scheduling a
+  tasklet to perform the callback.
+
+  The low-level driver is responsible for ensuring that multiple
+  completion event handlers for the same CQ are not called
+  simultaneously.  The driver must guarantee that only one CQ event
+  handler for a given CQ is running at a time.  In other words, the
+  following situation is not allowed:
+
+        CPU1                                    CPU2
+
+  low-level driver ->
+    consumer CQ event callback:
+      /* ... */
+      ib_req_notify_cq(cq, ...);
+                                        low-level driver ->
+      /* ... */                           consumer CQ event callback:
+                                            /* ... */
+      return from CQ event handler
+                                        
+  The context in which completion event and asynchronous event
+  callbacks run is not defined.  Depending on the low-level driver, it
+  may be process context, softirq context, or interrupt context.
+  Upper level protocol consumers may not sleep in a callback.
+
+Hot-plug
+
+  A low-level driver announces that a device is ready for use by
+  consumers when it calls ib_register_device(), all initialization
+  must be complete before this call.  The device must remain usable
+  until the driver's call to ib_unregister_device() has returned.
+
+  A low-level driver must call ib_register_device() and
+  ib_unregister_device() from process context.  It must not hold any
+  semaphores that could cause deadlock if a consumer calls back into
+  the driver across these calls.
+
+  An upper level protocol consumer may begin using an IB device as
+  soon as the add method of its struct ib_client is called for that
+  device.  A consumer must finish all cleanup and free all resources
+  relating to a device before returning from the remove method.
+
+  A consumer is permitted to sleep in its add and remove methods.


