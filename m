Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSKYGYk>; Mon, 25 Nov 2002 01:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSKYGYk>; Mon, 25 Nov 2002 01:24:40 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:52489
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262464AbSKYGYj>; Mon, 25 Nov 2002 01:24:39 -0500
Subject: [patch] 2.5: kill PF_MEMDIE
From: Robert Love <rml@tech9.net>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1038205919.17472.48.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Nov 2002 01:32:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PF_MEMDIE seems to serve no needed purpose in 2.5.  In fact, it seems it
has no point in 2.4, either.

Attached patch, against 2.5.49-mm1, makes PF_MEMDIE die.

	Robert Love


 include/linux/sched.h |    1 -
 mm/oom_kill.c         |    2 +-
 mm/page_alloc.c       |    2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)


diff -urN linux-2.5.49-mm1/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.49-mm1/include/linux/sched.h	2002-11-25 01:06:22.000000000 -0500
+++ linux/include/linux/sched.h	2002-11-25 00:54:12.000000000 -0500
@@ -421,7 +421,6 @@
 #define PF_DUMPCORE	0x00000200	/* dumped core */
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
-#define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FLUSHER	0x00002000	/* responsible for disk writeback */
 #define PF_NOWARN	0x00004000	/* debug: don't warn if alloc fails */
 
diff -urN linux-2.5.49-mm1/mm/oom_kill.c linux/mm/oom_kill.c
--- linux-2.5.49-mm1/mm/oom_kill.c	2002-11-25 01:13:53.000000000 -0500
+++ linux/mm/oom_kill.c	2002-11-25 01:05:08.000000000 -0500
@@ -146,7 +146,7 @@
 	 * exit() and clear out its resources quickly...
 	 */
 	p->time_slice = HZ;
-	p->flags |= PF_MEMALLOC | PF_MEMDIE;
+	p->flags |= PF_MEMALLOC;
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
diff -urN linux-2.5.49-mm1/mm/page_alloc.c linux/mm/page_alloc.c
--- linux-2.5.49-mm1/mm/page_alloc.c	2002-11-25 01:13:53.000000000 -0500
+++ linux/mm/page_alloc.c	2002-11-25 00:55:39.000000000 -0500
@@ -613,7 +613,7 @@
 	/* here we're in the low on memory slow path */
 
 rebalance:
-	if ((current->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
+	if ((current->flags & PF_MEMALLOC) && !in_interrupt()) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; zones[i] != NULL; i++) {
 			struct zone *z = zones[i];



