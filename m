Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbULIB6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbULIB6D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbULIB6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:58:03 -0500
Received: from THUNK.ORG ([69.25.196.29]:46210 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261441AbULIB5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:57:17 -0500
Date: Wed, 8 Dec 2004 20:57:05 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: Bernard Normier <bernard@zeroc.com>, linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041209015705.GB6978@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>, Bernard Normier <bernard@zeroc.com>,
	linux-kernel@vger.kernel.org
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208215614.GA12189@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 01:56:14PM -0800, Matt Mackall wrote:
> 
> Ted, I think this is a bit more straightforward than your patch, and
> safer as it protects get_random_bytes() and internal extract_entropy()
> users. And I'd be leery of your get_cpu() trick due to preempt
> issues.
> 

I'm concerned that turning off interrupts during even a single SHA-1
transform will put us above the radar with respect to the preempt
latency statistics again.  We could use a separate spinlock that only
pretects the mix_ptr and mixing access to the pool, so we're at least
not disabling interrupts, but we still are holding a spinlock across a
cryptographic operation.

So I've come up with another trick which I think avoids needing to add
additional locking altogether.  What we do is we diddle the initial
HASH input values with the following values: initial the processor ID,
the current task pointer, and preempt_count().  On an UP system with
preemption, it won't matter if we get preempted, since on a UP system
access to the pool is by definition serialized :-).  On a SMP system
with preemption, while we could theoretically get preempted away and
then scheduled on another CPU, just in time for another process to
call extract_entropy(), the task identifier is enough to guarantee a
unique starting point.  The reason for adding preempt_count() is so we
can deal with the case where a process gets interrupted, and the
bottom half handler calls get_random_bytes(), and at the same time
said process gets preempted away to another CPU().  I think this
covers all of the cases.....

Yeah, it would be simper to reason about things if we were to just put
it under the spinlock, but everyone seems tp be on a reduce latency at
all costs kick as of late.  :-)

Comments?

							- Ted

Signed-off-by: Theodore Ts'o <tytso@mit.edu>

===== drivers/char/random.c 1.60 vs edited =====
--- 1.60/drivers/char/random.c	2004-11-18 17:23:14 -05:00
+++ edited/drivers/char/random.c	2004-12-08 20:51:18 -05:00
@@ -1402,10 +1402,19 @@ static ssize_t extract_entropy(struct en
 				  sec_random_state->entropy_count);
 		}
 
-		/* Hash the pool to get the output */
-		tmp[0] = 0x67452301;
-		tmp[1] = 0xefcdab89;
-		tmp[2] = 0x98badcfe;
+		/* 
+		 * Hash the pool to get the output.
+		 *
+		 * We diddle the initial inputs so that if two
+		 * processors are executing extract_entropy
+		 * concurrently, they will get different results.
+		 * Even if we get preempted and moved to another CPU,
+		 * the combination of initial CPU, task pointer, and
+		 * preempt count is good enough to avoid duplication.
+		 */
+		tmp[0] = 0x67452301 ^ smp_processor_id();
+		tmp[1] = 0xefcdab89 ^ (__u32) current;
+		tmp[2] = 0x98badcfe ^ preempt_count();
 		tmp[3] = 0x10325476;
 #ifdef USE_SHA
 		tmp[4] = 0xc3d2e1f0;
