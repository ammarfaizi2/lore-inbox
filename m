Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVJ1IAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVJ1IAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVJ1IAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:00:13 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:14783 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1751336AbVJ1IAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:00:11 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: <netdev@vger.kernel.org>
Cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.14-rc5-mm1 net/ipv4/route.c: spin_unlock call fails to compile
Date: Fri, 28 Oct 2005 00:08:26 -0700
Message-ID: <001401c5db8e$650bd380$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The spin_unlock call which gets an rt_hash_lock_addr(i)
argument fails to compile on rc5-mm1 uniprocessor with
no CONFIG_DEBUG_SPINLOCK because, in mm1, the spin_unlock
macro expands to a statement of the form:

do { (void)&ptr->raw; } while (0)

and 'ptr' is 'NULL'.  Since the expression is address-of
(therefore not evaluated as an r-value - i.e. no attempt
is made to load the non-existent raw, just take its address)
this expression is harmless.

The patch makes 'ptr' ((spinlock_t*)NULL), which the compiler
can compile (sizeof *ptr is 0 in the case - the spinlock_t
struct is empty - so the patch is particularly safe.)

The patch applies to both 2.6.14 and 2.6.14-rc5-mm1 (although
only the latter requires it.)

Signed-off-by: John Bowler <jbowler@acm.org>

--- linux-2.6.14-rc5/net/ipv4/route.c	2005-10-26 08:37:20.752285410 -0700
+++ patched/net/ipv4/route.c	2005-10-26 12:17:00.761651111 -0700
@@ -231,7 +231,7 @@ static spinlock_t	*rt_hash_locks;
 			spin_lock_init(&rt_hash_locks[i]); \
 		}
 #else
-# define rt_hash_lock_addr(slot) NULL
+# define rt_hash_lock_addr(slot) ((spinlock_t*)NULL)
 # define rt_hash_lock_init()
 #endif
 

