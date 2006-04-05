Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWDEJSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWDEJSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDEJSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:18:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751183AbWDEJSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:18:00 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       davem@davemloft.net
Subject: [PATCH] Fix memory barrier docs wrt atomic ops
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 05 Apr 2006 10:17:19 +0100
Message-ID: <29800.1144228639@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the memory barrier documentation to attempt to describe atomic ops
correctly.

atomic_t ops that return a value _do_ imply smp_mb() either side, and so don't
actually require smp_mb__*_atomic_*() special barriers.

Also explains why special barriers exist in addition to normal barriers.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/mb.diff 
 Documentation/memory-barriers.txt |   47 +++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index f855031..822fc45 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -829,8 +829,8 @@ There are some more advanced barrier fun
  (*) smp_mb__after_atomic_inc();
 
      These are for use with atomic add, subtract, increment and decrement
-     functions, especially when used for reference counting.  These functions
-     do not imply memory barriers.
+     functions that don't return a value, especially when used for reference
+     counting.  These functions do not imply memory barriers.
 
      As an example, consider a piece of code that marks an object as being dead
      and then decrements the object's reference count:
@@ -1263,15 +1263,15 @@ else.
 ATOMIC OPERATIONS
 -----------------
 
-Though they are technically interprocessor interaction considerations, atomic
-operations are noted specially as they do _not_ generally imply memory
-barriers.  The possible offenders include:
+Whilst they are technically interprocessor interaction considerations, atomic
+operations are noted specially as some of them imply full memory barriers and
+some don't, but they're very heavily relied on as a group throughout the
+kernel.
+
+Any atomic_t operation, for instance, that returns a value implies an
+SMP-conditional general memory barrier (smp_mb()) on each side of the actual
+operation.  These include:
 
-	xchg();
-	cmpxchg();
-	test_and_set_bit();
-	test_and_clear_bit();
-	test_and_change_bit();
 	atomic_cmpxchg();
 	atomic_inc_return();
 	atomic_dec_return();
@@ -1283,20 +1283,30 @@ barriers.  The possible offenders includ
 	atomic_add_negative();
 	atomic_add_unless();
 
-These may be used for such things as implementing LOCK operations or controlling
-the lifetime of objects by decreasing their reference counts.  In such cases
-they need preceding memory barriers.
 
-The following may also be possible offenders as they may be used as UNLOCK
-operations.
+The following, however, do _not_ imply memory barrier effects:
+
+	xchg();
+	cmpxchg();
+	test_and_set_bit();
+	test_and_clear_bit();
+	test_and_change_bit();
+
+These may be used for such things as implementing LOCK-class operations.  In
+such cases they need explicit memory barriers.
+
+The following are also potential offenders as they may be used as UNLOCK-class
+operations, amongst other things, but do _not_ imply memory barriers either:
 
 	set_bit();
 	clear_bit();
 	change_bit();
 	atomic_set();
 
+With these the appropriate explicit memory barrier should be used if necessary.
+
 
-The following are a little tricky:
+The following also don't imply memory barriers, and so may be a little tricky:
 
 	atomic_add();
 	atomic_sub();
@@ -1322,6 +1332,11 @@ operation is protected by a lock, then i
 there's another operation within the critical section with respect to which an
 ordering must be maintained.
 
+[!] Note that special memory barrier primitives are available for these
+situations because on some CPUs the atomic instructions used imply full memory
+barriers, and so barrier instructions are superfluous in conjunction with them,
+and in such cases the special barrier primitives will be no-ops.
+
 See Documentation/atomic_ops.txt for more information.
 
 
