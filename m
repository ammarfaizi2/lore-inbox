Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbTITBZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 21:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTITBZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 21:25:20 -0400
Received: from dyn-ctb-210-9-246-80.webone.com.au ([210.9.246.80]:35844 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261290AbTITBZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 21:25:07 -0400
Message-ID: <3F6BAC5F.503@cyberone.com.au>
Date: Sat, 20 Sep 2003 11:24:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       maryedie@osdl.org
Subject: Re: 2.6.0-test5-mm3 as-iosched Oops running dbt2 workload
References: <20030919185621.GA18666@osdl.org>
In-Reply-To: <20030919185621.GA18666@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010409070902000203010701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010409070902000203010701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sigh. Sorry, I'm an idiot...

If a request is merged with another, it sometimes has to be repositioned
on the rbtree - you just do a delete then an add. This is a quite
uncommon case though.

I changed the way adding works, so collisions must be handled by the
caller instead of being dumbly fixed by the add routine. Unfortunately
the uncommon callers weren't handling it properly. Try this please.



Dave Olien wrote:

>Andrew,
>
>Attached is console output containing a stack trace from an Oops, followed
>by a Fatal exception, and LOTS of APIC errors.  The machine was hung,
>printing APIC error messages forever.
>
>This looks like another as-iosched problem.  So, I'm copying Nick Piggin
>on this email.  But the Fatal exception and APIC errors following
>that are a mystery to me.
>
>Mary encountered this running the sapdb dbt2 cached database workload on her
>project machine.  The project machine was running 2.6.0-test5-mm3.
>This same test passes on the stp machines.  But Mary's project machine
>has more processors, and more disks, and a different disk controller type.
>
>At this stage, the database has gotten past the database restore phase.
>That's where it was failing prior to last night's mm3 patch.  Now, the
>database itself has been running for about 30 minutes.  In the cached
>case, much of that first 30 minutes is spent loading the cache.
>
>This Oops seems to have occurred at about the time the database is
>transitioning to using its cache.  Most of the I/O after this point
>is to the log, doing LOTS of sequential writes, with the occasional
>random read/write.
>
>Since this machine has more processors, it's doing transactions
>more quickly than the same workload on STP machines.  So the log write
>traffic is probably a lot heavier.
>
>
>------------[ cut here ]------------
>kernel BUG at drivers/block/as-iosched.c:1230!
>invalid operand: 0000 [#1]
>SMP 
>CPU:    3
>EIP:    0060:[<c0228146>]    Not tainted VLI
>EFLAGS: 00010046
>EIP is at as_dispatch_request+0x236/0x2f0
>eax: 00000000   ebx: f7a451a0   ecx: 00000000   edx: 00000000
>esi: 00000000   edi: 00000001   ebp: 00000000   esp: f5f67ef8
>ds: 007b   es: 007b   ss: 0068
>Process kernel (pid: 2283, threadinfo=f5f66000 task=f62760a0)
>Stack: f7a451a0 f5900820 f7a28000 f7a02600 c0235c23 f7a451a0 00000000 f7836000 
>       f5f67fc4 c0228238 f7a451a0 f7a08420 f7836000 c021fbb6 f7836000 f77e0000 
>       f7a28000 f7a08420 f7a28000 c023a128 f7836000 f5f02de0 f77e0090 0000000a 
>Call Trace:
> [<c0235c23>] DAC960_BA_QueueCommand+0x43/0xb0
> [<c0228238>] as_next_request+0x38/0x50
> [<c021fbb6>] elv_next_request+0x16/0x110
> [<c023a128>] DAC960_ProcessRequest+0x38/0x190
> [<c023cd40>] DAC960_BA_InterruptHandler+0x90/0xb0
> [<c010e899>] handle_IRQ_event+0x49/0x80
> [<c010ec0f>] do_IRQ+0x9f/0x150
> [<c030cb0c>] common_interrupt+0x18/0x20
> [<c030007b>] rpcauth_free_credcache+0xbb/0x100
>
>Code: 43 50 00 00 00 00 8b 43 54 8b 6b 1c c7 43 5c 00 00 00 00 89 43 58 e9 95 fe ff ff c7 43 48 01 00 00 00 c7 43 4c 00 00 00 00 eb d4 <0f> 0b ce 04 fd da 32 c0 eb c7 8b 43 50 e9 61 ff ff ff 0f 0b b6 
> <0>Kernel panic: Fatal exception in interrupt
>In interrupt handler - not syncing
> <6>APIC error on CPU3: 00(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>APIC error on CPU3: 08(08)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

--------------010409070902000203010701
Content-Type: text/plain;
 name="as-oops-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-oops-fix.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff -puN drivers/block/as-iosched.c~as-oops-fix drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-oops-fix	2003-09-20 11:13:26.000000000 +1000
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-09-20 11:22:55.000000000 +1000
@@ -1303,7 +1303,7 @@ static struct request *as_next_request(r
  * Add arq to a list behind alias
  */
 static inline void
-as_add_aliased_request(struct as_rq *arq, struct as_rq *alias)
+as_add_aliased_request(struct as_data *ad, struct as_rq *arq, struct as_rq *alias)
 {
 	/*
 	 * Another request with the same start sector on the rbtree.
@@ -1312,6 +1312,11 @@ as_add_aliased_request(struct as_rq *arq
 	 */
 	list_add_tail(&arq->request->queuelist,	&alias->request->queuelist);
 
+	/*
+	 * Don't want to have to handle merges.
+	 */
+	as_remove_merge_hints(ad->q, arq);
+
 }
 
 /*
@@ -1353,7 +1358,7 @@ static void as_add_request(struct as_dat
 		as_update_arq(ad, arq); /* keep state machine up to date */
 
 	} else {
-		as_add_aliased_request(arq, alias);
+		as_add_aliased_request(ad, arq, alias);
 		/*
 		 * have we been anticipating this request?
 		 * or does it come from the same process as the one we are
@@ -1553,8 +1558,10 @@ static void as_merged_request(request_qu
 		 * currently don't bother. Ditto the next function.
 		 */
 		as_del_arq_rb(ad, arq);
-		if ((alias = as_add_arq_rb(ad, arq)) )
-			as_add_aliased_request(arq, alias);
+		if ((alias = as_add_arq_rb(ad, arq)) ) {
+			list_del_init(&arq->fifo);
+			as_add_aliased_request(ad, arq, alias);
+		}
 		/*
 		 * Note! At this stage of this and the next function, our next
 		 * request may not be optimal - eg the request may have "grown"
@@ -1586,8 +1593,10 @@ as_merged_requests(request_queue_t *q, s
 	if (rq_rb_key(req) != arq->rb_key) {
 		struct as_rq *alias;
 		as_del_arq_rb(ad, arq);
-		if ((alias = as_add_arq_rb(ad, arq)) )
-			as_add_aliased_request(arq, alias);
+		if ((alias = as_add_arq_rb(ad, arq)) ) {
+			list_del_init(&arq->fifo);
+			as_add_aliased_request(ad, arq, alias);
+		}
 	}
 
 	/*

_

--------------010409070902000203010701--

