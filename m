Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVAKJDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVAKJDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVAKJDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:03:41 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:22248 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262621AbVAKJC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:02:57 -0500
Date: Tue, 11 Jan 2005 19:43:57 +1100
To: akpm@osdl.org
Subject: [PATCH 1/2] ppc64: Fix iseries_veth module unload race and memory leak
Cc: paulus@au1.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
From: Michael Ellerman <michael@ellerman.id.au>
Message-Id: <20050111084357.7C3F317DDF@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

When the iseries_veth driver module is unloaded there is the potential for an
oops and also some memory leakage.

Because the HvLpEvent_unregisterHandler() function did no synchronisation, it
was possible for the handler that was being unregistered to be running on another
CPU *after* HvLpEvent_unregisterHandler() had returned. This could cause the
iseries_veth driver to leave work in the events work queue after the module
had been unloaded. When that work was eventually executed we got an oops.

In addition some of the data structures in the iseries_veth driver were not
being correctly freed when the module was unloaded.

This is the first patch, which makes HvLpEvent_unregisterHandler() work.

 arch/ppc64/kernel/HvLpEvent.c         |    8 ++++++++
 include/asm-ppc64/iSeries/HvLpEvent.h |    3 +++
 2 files changed, 11 insertions(+)


Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

diff -urN 2.6.10-ppc64-stock/arch/ppc64/kernel/HvLpEvent.c 2.6.10-ppc64-work/arch/ppc64/kernel/HvLpEvent.c
--- 2.6.10-ppc64-stock/arch/ppc64/kernel/HvLpEvent.c	2004-06-16 17:12:51.000000000 +1000
+++ 2.6.10-ppc64-work/arch/ppc64/kernel/HvLpEvent.c	2005-01-10 16:13:33.381994263 +1100
@@ -34,10 +34,18 @@
 int HvLpEvent_unregisterHandler( HvLpEvent_Type eventType )
 {
 	int rc = 1;
+
+	might_sleep();
+
 	if ( eventType < HvLpEvent_Type_NumTypes ) {
 		if ( !lpEventHandlerPaths[eventType] ) {
 			lpEventHandler[eventType] = NULL;
 			rc = 0;
+
+			/* We now sleep until all other CPUs have scheduled. This ensures that
+			 * the deletion is seen by all other CPUs, and that the deleted handler
+			 * isn't still running on another CPU when we return. */
+			synchronize_kernel();
 		}
 	}
 	return rc;
diff -urN 2.6.10-ppc64-stock/include/asm-ppc64/iSeries/HvLpEvent.h 2.6.10-ppc64-work/include/asm-ppc64/iSeries/HvLpEvent.h
--- 2.6.10-ppc64-stock/include/asm-ppc64/iSeries/HvLpEvent.h	2004-02-04 14:44:05.000000000 +1100
+++ 2.6.10-ppc64-work/include/asm-ppc64/iSeries/HvLpEvent.h	2005-01-10 16:11:18.899255131 +1100
@@ -75,6 +75,9 @@
 extern int HvLpEvent_registerHandler( HvLpEvent_Type eventType, LpEventHandler hdlr);
 
 // Unregister a handler for an event type
+//  This call will sleep until the handler being removed is guaranteed to
+//  be no longer executing on any CPU. Do not call with locks held.
+//
 //  returns 0 on success
 //  Unregister will fail if there are any paths open for the type
 extern int HvLpEvent_unregisterHandler( HvLpEvent_Type eventType );
