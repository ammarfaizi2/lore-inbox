Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161834AbWKVIDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161834AbWKVIDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161835AbWKVIDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:03:24 -0500
Received: from brick.kernel.dk ([62.242.22.158]:13110 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161834AbWKVIDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:03:23 -0500
Date: Wed, 22 Nov 2006 09:03:13 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Message-ID: <20061122080312.GL8055@kernel.dk>
References: <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org> <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com> <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org> <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com> <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org> <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com> <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com> <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com> <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21 2006, Linus Torvalds wrote:
> I don't think we use any irq-disable locking in the VM itself, but I could 
> imagine some nasty situation with the block device layer getting into a 
> deadlock with interrupts disabled when it runs out of queue entries and 
> cannot allocate more memory..

Not likely. Request allocation is done with GFP_NOIO and backed by a
memory pool, so as long the vm doesn't go totally nuts because
__GFP_WAIT is set, we should be safe there. If it did go crazy, I
suspect a sysrq-t would still work.

If bouncing is involved for swap, we do have a potential deadlock issue
that isn't fixed yet. I just whipped up this completely untested patch,
it should shed some light on that issue.

diff --git a/mm/bounce.c b/mm/bounce.c
index e4b62d2..f75eb37 100644
--- a/mm/bounce.c
+++ b/mm/bounce.c
@@ -20,6 +20,7 @@ #define POOL_SIZE	64
 #define ISA_POOL_SIZE	16
 
 static mempool_t *page_pool, *isa_page_pool;
+static struct bio_set *bounce_bio_set;
 
 #ifdef CONFIG_HIGHMEM
 static __init int init_emergency_pool(void)
@@ -31,6 +32,9 @@ static __init int init_emergency_pool(vo
 	if (!i.totalhigh)
 		return 0;
 
+	bounce_bio_set = bioset_create(1, 1, 0);
+	BUG_ON(!bounce_bio_set);
+
 	page_pool = mempool_create_page_pool(POOL_SIZE, 0);
 	BUG_ON(!page_pool);
 	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
@@ -190,6 +194,11 @@ static int bounce_end_io_read_isa(struct
 	return 0;
 }
 
+static void bounce_bio_destructor(struct bio *bio)
+{
+	bio_free(bio, bounce_bio_set);
+}
+
 static void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig,
 			       mempool_t *pool)
 {
@@ -210,8 +219,10 @@ static void __blk_queue_bounce(request_q
 		/*
 		 * irk, bounce it
 		 */
-		if (!bio)
-			bio = bio_alloc(GFP_NOIO, (*bio_orig)->bi_vcnt);
+		if (!bio) {
+			bio = bio_alloc_bioset(GFP_NOIO, (*bio_orig)->bi_vcnt, bounce_bio_set);
+			bio->bi_destructor = bounce_bio_destructor;
+		}
 
 		to = bio->bi_io_vec + i;
 

-- 
Jens Axboe

