Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWDFJyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWDFJyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 05:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWDFJyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 05:54:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6534 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750938AbWDFJyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 05:54:13 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <44338EA9.3020102@yahoo.com.au> 
References: <44338EA9.3020102@yahoo.com.au>  <29800.1144228639@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, davem@davemloft.net
Subject: [PATCH] Futher fix memory barrier docs wrt atomic ops 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 06 Apr 2006 10:53:33 +0100
Message-ID: <27908.1144317213@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Further fix the memory barrier documents to portray bitwise operation memory
barrier effects correctly following Nick Piggin's comments.

It makes the point that any atomic op that both modifies some state in memory
and returns information on that state implies memory barriers on both sides.

This patch depends on:

	[PATCH] Fix memory barrier docs wrt atomic ops 

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/mb.diff 
 Documentation/memory-barriers.txt |   39 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 822fc45..92f0056 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1282,10 +1282,12 @@ operations are noted specially as some o
 some don't, but they're very heavily relied on as a group throughout the
 kernel.
 
-Any atomic_t operation, for instance, that returns a value implies an
-SMP-conditional general memory barrier (smp_mb()) on each side of the actual
-operation.  These include:
+Any atomic operation that modifies some state in memory and returns information
+about the state (old or new) implies an SMP-conditional general memory barrier
+(smp_mb()) on each side of the actual operation.  These include:
 
+	xchg();
+	cmpxchg();
 	atomic_cmpxchg();
 	atomic_inc_return();
 	atomic_dec_return();
@@ -1296,31 +1298,31 @@ operation.  These include:
 	atomic_sub_and_test();
 	atomic_add_negative();
 	atomic_add_unless();
-
-
-The following, however, do _not_ imply memory barrier effects:
-
-	xchg();
-	cmpxchg();
 	test_and_set_bit();
 	test_and_clear_bit();
 	test_and_change_bit();
 
-These may be used for such things as implementing LOCK-class operations.  In
-such cases they need explicit memory barriers.
+These are used for such things as implementing LOCK-class and UNLOCK-class
+operations and adjusting reference counters towards object destruction, and as
+such the implicit memory barrier effects are necessary.
+
 
-The following are also potential offenders as they may be used as UNLOCK-class
-operations, amongst other things, but do _not_ imply memory barriers either:
+The following operation are potential problems as they do _not_ imply memory
+barriers, but might be used for implementing such things as UNLOCK-class
+operations:
 
+	atomic_set();
 	set_bit();
 	clear_bit();
 	change_bit();
-	atomic_set();
 
-With these the appropriate explicit memory barrier should be used if necessary.
+With these the appropriate explicit memory barrier should be used if necessary
+(smp_mb__before_clear_bit() for instance).
 
 
-The following also don't imply memory barriers, and so may be a little tricky:
+The following also do _not_ imply memory barriers, and so may require explicit
+memory barriers under some circumstances (smp_mb__before_atomic_dec() for
+instance)):
 
 	atomic_add();
 	atomic_sub();
@@ -1341,10 +1343,7 @@ specific order.
 
 
 Basically, each usage case has to be carefully considered as to whether memory
-barriers are needed or not.  The simplest rule is probably: if the atomic
-operation is protected by a lock, then it does not require a barrier unless
-there's another operation within the critical section with respect to which an
-ordering must be maintained.
+barriers are needed or not.
 
 [!] Note that special memory barrier primitives are available for these
 situations because on some CPUs the atomic instructions used imply full memory
