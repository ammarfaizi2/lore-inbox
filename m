Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283019AbRLDJuT>; Tue, 4 Dec 2001 04:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282976AbRLDJuJ>; Tue, 4 Dec 2001 04:50:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43024 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283000AbRLDJtv>;
	Tue, 4 Dec 2001 04:49:51 -0500
Date: Tue, 4 Dec 2001 10:49:28 +0100
From: Jens Axboe <axboe@suse.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS]: Linux-2.5.1-pre5
Message-ID: <20011204104928.E13391@suse.de>
In-Reply-To: <3C0BA978.A26EF6C0@delusion.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <3C0BA978.A26EF6C0@delusion.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 03 2001, Udo A. Steinberg wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 00000028
> c01d0538
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c01d0538>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 00000000   ebx: c1be11c0   ecx: 00000030   edx: 00000200
> esi: 00000001   edi: c1be14c0   ebp: c10688ac   esp: cac1bdb0
> ds: 0018   es: 0018   ss: 0018
> Process kdeinit (pid: 223, stackpage=cac1b000)
> Stack: 00000030 00000001 c1be11c0 00000000 c0135af7 00000001 c1be11c0 c010820c
>        0000000b c1101ad4 000001f0 00000020 00000a0e c010a238 c1101ad4 c1be14c0
>        c10688ac c1be14c0 c0135b5c c1be14c0 000001f0 00000018 00000018 ffffff0b
> Call Trace: [<c0135af7>] [<c010820c>] [<c010a238>] [<c0135b5c>] [<c01346bc>]
>    [<c012c328>] [<c012c5e0>] [<c012c64c>] [<c012cf51>] [<c012d19c>] [<c012d230>]
>    [<c013f8d3>] [<c02638d5>] [<c022177f>] [<c013fb03>] [<c013fed2>] [<c01c9b5f>]
>    [<c0106d1b>]
> Code: 8b 48 28 66 c1 ea 09 0f b7 d2 0f af 53 04 89 10 0f b7 53 0c
> 
> >>EIP; c01d0538 <submit_bh+48/d0>   <=====

This should fix it.

-- 
Jens Axboe


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bio-pre5-1

--- /opt/kernel/linux-2.5.1-pre5/fs/bio.c	Tue Dec  4 04:42:00 2001
+++ fs/bio.c	Tue Dec  4 04:45:56 2001
@@ -35,7 +35,7 @@
 #include <asm/uaccess.h>
 
 kmem_cache_t *bio_cachep;
-static spinlock_t __cacheline_aligned bio_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t __cacheline_aligned_in_smp bio_lock = SPIN_LOCK_UNLOCKED;
 static struct bio *bio_pool;
 static DECLARE_WAIT_QUEUE_HEAD(bio_pool_wait);
 static DECLARE_WAIT_QUEUE_HEAD(biovec_pool_wait);
@@ -74,7 +74,7 @@
 	struct bio *bio;
 
 	if ((bio = bio_pool)) {
-		BUG_ON(bio_pool_free <= 0);
+		BIO_BUG_ON(bio_pool_free <= 0);
 		bio_pool = bio->bi_next;
 		bio->bi_next = NULL;
 		bio_pool_free--;
@@ -90,7 +90,7 @@
 
 	spin_lock_irqsave(&bio_lock, flags);
 	bio = __bio_pool_get();
-	BUG_ON(!bio && bio_pool_free);
+	BIO_BUG_ON(!bio && bio_pool_free);
 	spin_unlock_irqrestore(&bio_lock, flags);
 
 	return bio;
@@ -121,8 +121,7 @@
 	}
 }
 
-#define BIO_CAN_WAIT(gfp_mask)	\
-	(((gfp_mask) & (__GFP_WAIT | __GFP_IO)) == (__GFP_WAIT | __GFP_IO))
+#define BIO_CAN_WAIT(gfp_mask)	((gfp_mask) & __GFP_WAIT)
 
 static inline struct bio_vec *bvec_alloc(int gfp_mask, int nr, int *idx)
 {
@@ -198,13 +197,15 @@
 {
 	struct biovec_pool *bp = &bvec_list[bio->bi_max];
 
-	BUG_ON(bio->bi_max >= BIOVEC_NR_POOLS);
+	BIO_BUG_ON(bio->bi_max >= BIOVEC_NR_POOLS);
 
 	/*
 	 * cloned bio doesn't own the veclist
 	 */
-	if (!(bio->bi_flags & (1 << BIO_CLONED)))
+	if (!(bio->bi_flags & (1 << BIO_CLONED))) {
 		kmem_cache_free(bp->bp_cachep, bio->bi_io_vec);
+		wake_up_nr(&bp->bp_wait, 1);
+	}
 
 	bio_pool_put(bio);
 }
@@ -212,13 +213,13 @@
 inline void bio_init(struct bio *bio)
 {
 	bio->bi_next = NULL;
-	atomic_set(&bio->bi_cnt, 1);
 	bio->bi_flags = 0;
 	bio->bi_rw = 0;
 	bio->bi_vcnt = 0;
 	bio->bi_idx = 0;
 	bio->bi_size = 0;
 	bio->bi_end_io = NULL;
+	atomic_set(&bio->bi_cnt, 1);
 }
 
 static inline struct bio *__bio_alloc(int gfp_mask, bio_destructor_t *dest)
@@ -314,14 +315,13 @@
  **/
 void bio_put(struct bio *bio)
 {
-	BUG_ON(!atomic_read(&bio->bi_cnt));
+	BIO_BUG_ON(!atomic_read(&bio->bi_cnt));
 
 	/*
 	 * last put frees it
 	 */
 	if (atomic_dec_and_test(&bio->bi_cnt)) {
-		BUG_ON(bio->bi_next);
-
+		BIO_BUG_ON(bio->bi_next);
 		bio_free(bio);
 	}
 }

--6c2NcOVqGQ03X4Wi--
