Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947544AbWLIABP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947544AbWLIABP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947540AbWLIABB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:01:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37577 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761295AbWLIAAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:00:19 -0500
Message-Id: <20061209000207.057219000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mingo@elte.hu, ak@suse.de
Subject: [patch 24/32] add bottom_half.h
Content-Disposition: inline; filename=add-bottom_half.h.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andrew Morton <akpm@osdl.org>

With CONFIG_SMP=n:

drivers/input/ff-memless.c:384: warning: implicit declaration of function 'local_bh_disable'
drivers/input/ff-memless.c:393: warning: implicit declaration of function 'local_bh_enable'

Really linux/spinlock.h should include linux/interrupt.h.  But interrupt.h
includes sched.h which will need spinlock.h.

So the patch breaks the _bh declarations out into a separate header and
includes it in bothj interrupt.h and spinlock.h.

Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andi Kleen <ak@suse.de>
Cc: <stable@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 include/linux/bottom_half.h |    5 +++++
 include/linux/interrupt.h   |    7 +------
 include/linux/spinlock.h    |    1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

--- /dev/null
+++ linux-2.6.19/include/linux/bottom_half.h
@@ -0,0 +1,5 @@
+extern void local_bh_disable(void);
+extern void __local_bh_enable(void);
+extern void _local_bh_enable(void);
+extern void local_bh_enable(void);
+extern void local_bh_enable_ip(unsigned long ip);
--- linux-2.6.19.orig/include/linux/interrupt.h
+++ linux-2.6.19/include/linux/interrupt.h
@@ -11,6 +11,7 @@
 #include <linux/hardirq.h>
 #include <linux/sched.h>
 #include <linux/irqflags.h>
+#include <linux/bottom_half.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -217,12 +218,6 @@ static inline void __deprecated save_and
 #define save_and_cli(x)	save_and_cli(&x)
 #endif /* CONFIG_SMP */
 
-extern void local_bh_disable(void);
-extern void __local_bh_enable(void);
-extern void _local_bh_enable(void);
-extern void local_bh_enable(void);
-extern void local_bh_enable_ip(unsigned long ip);
-
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
    frequency threaded job scheduling. For almost all the purposes
    tasklets are more than enough. F.e. all serial device BHs et
--- linux-2.6.19.orig/include/linux/spinlock.h
+++ linux-2.6.19/include/linux/spinlock.h
@@ -52,6 +52,7 @@
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
+#include <linux/bottom_half.h>
 
 #include <asm/system.h>
 

--
