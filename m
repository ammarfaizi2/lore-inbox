Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267522AbSKTHk6>; Wed, 20 Nov 2002 02:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbSKTHk5>; Wed, 20 Nov 2002 02:40:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:65165 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267656AbSKTHjz>;
	Wed, 20 Nov 2002 02:39:55 -0500
Message-ID: <3DDB3DED.A4C9DC56@digeo.com>
Date: Tue, 19 Nov 2002 23:46:53 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: the random driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2002 07:46:53.0933 (UTC) FILETIME=[FE6CB1D0:01C29068]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing a context switch rate of 150/sec just writing a
big file to disk at 20 megabytes/sec.

It is coming out of add_disk_randomness()'s invokation of
batch_entropy_store().

That function is setting up deferred punt-to-process-context
for every disk request, and has the potential to cause 1000
context switches per second.  This is clearly excessive.

There is a 256 slot buffer in the random driver for this,
and we are not using it at all effectively.  I do intend
to submit the below patch which will cause one context switch
per 128 requests.

But this is a minimal fix.  The batch_entropy_pool handling
in there needs work.

a) It's racy.  The head and tail pointers have no SMP protection
   and a race will cause it to dump 128 already-processed items
   back into the entropy pool.

b) It's weird.  What's up with this?

        batch_entropy_pool[2*batch_head] = a;
        batch_entropy_pool[(2*batch_head) + 1] = b;

   It should be an array of 2-element structures.

c) The ring-buffer handling is awkward.  It shouldn't be masking
   the head and tail pointers to always remain within bounds.

   A better technique is to allow these indices to wrap at
   0xffffffff and only mask their values when you actually use
   them as a subscript.  This allows you to distinguish the
   completely-full case from the completely-empty one.  See
   LOG_BUF* in kernel/printk.c.

d) It's punting work up to process context which could be performed
   right there in interrupt context.

My suggestion, if anyone cares, is to convert the entropy pool
into smaller per-cpu buffers, protected by local_irq_save() only.
This way the global lock (which isn't there yet) only needs to
be taken when a CPU is actually dumping its buffer.



--- 25/drivers/char/random.c~reduce-random-context-switch-rate	Tue Nov 19 23:17:12 2002
+++ 25-akpm/drivers/char/random.c	Tue Nov 19 23:18:11 2002
@@ -663,7 +663,7 @@ void batch_entropy_store(u32 a, u32 b, i
 	batch_entropy_credit[batch_head] = num;
 
 	new = (batch_head+1) & (batch_max-1);
-	if (new != batch_tail) {
+	if ((new - batch_tail) >= batch_max / 2) {
 		/*
 		 * Schedule it for the next timer tick:
 		 */

_
