Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWIFL0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWIFL0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIFL0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:26:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18647 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750793AbWIFL0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:26:41 -0400
Date: Wed, 6 Sep 2006 13:16:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Subject: [patch] lockdep core: improve the lock-chain-hash
Message-ID: <20060906111601.GA23826@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

With CONFIG_DEBUG_LOCK_ALLOC turned off i was getting sporadic
failures in the locking self-test:

------------>
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |FAILED|  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |FAILED|

after much debugging it turned out to be caused by accidental chain-hash
key collisions. The current hash is:

 #define iterate_chain_key(key1, key2) \
	(((key1) << MAX_LOCKDEP_KEYS_BITS/2) ^ \
	((key1) >> (64-MAX_LOCKDEP_KEYS_BITS/2)) ^ \
 	(key2))

where MAX_LOCKDEP_KEYS_BITS is 11. This hash is pretty good as it will
shift by 5 bits in every iteration, where every new ID 'mixed' into the
hash would have up to 11 bits. But because there was a 6 bits overlap
between subsequent IDs and their high bits tended to be similar, there
was a chance for accidental chain-hash collision for a low number of
locks held.

the solution is to shift by 11 bits:

 #define iterate_chain_key(key1, key2) \
	(((key1) << MAX_LOCKDEP_KEYS_BITS) ^ \
	((key1) >> (64-MAX_LOCKDEP_KEYS_BITS)) ^ \
 	(key2))

This keeps the hash perfect up to 5 locks held, but even above that the
hash is still good because 11 bits is a relative prime to the total 64
bits, so a complete match will only occur after 64 held locks (which
doesnt happen in Linux). Even after 5 locks held, entropy of the 5 IDs
mixed into the hash is already good enough so that overlap doesnt
generate a colliding hash ID.

which this change the false positives went away.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 kernel/lockdep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -121,8 +121,8 @@ static struct list_head chainhash_table[
  * unique.
  */
 #define iterate_chain_key(key1, key2) \
-	(((key1) << MAX_LOCKDEP_KEYS_BITS/2) ^ \
-	((key1) >> (64-MAX_LOCKDEP_KEYS_BITS/2)) ^ \
+	(((key1) << MAX_LOCKDEP_KEYS_BITS) ^ \
+	((key1) >> (64-MAX_LOCKDEP_KEYS_BITS)) ^ \
 	(key2))
 
 void lockdep_off(void)
