Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUIMMnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUIMMnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUIMMnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:43:04 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15534 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266626AbUIMMmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:42:47 -0400
Date: Mon, 13 Sep 2004 13:42:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Alex Zarochentsev <zam@namesys.com>
cc: Paul Jackson <pj@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined
    atomic_sub_and_test
In-Reply-To: <20040912194839.GV6294@backtop.namesys.com>
Message-ID: <Pine.LNX.4.44.0409131327350.17673-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, Alex Zarochentsev wrote:
> On Sun, Sep 12, 2004 at 11:49:48AM -0700, Paul Jackson wrote:
> > 
> > I also saw an email from Bill Irwin go by, explaining that he did not
> > choose to add atomic_sub_and_test to include/asm-sparc/atomic.h, which
> > email is consistent with my observation that sparc atomic.h does not
> > define atomic_sub_and_test.
> 
> I think adding the wrappers for atomic_sub_and_test() wouldn't be wrong:

But Bill already said he doesn't want it, and there are several other
architectures than sparc which don't have it - it's unclear why any do.

Several people were working to get atomic_add_return and its friends into
the remaining architectures (such as i386), Andrew's taken those patches
into -mm5, so it would make sense for reiser4 to use atomic_sub_return now.

Oh, except that particular variant is missing from s390: better add it in.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.9-rc1-mm5/fs/reiser4/flush_queue.c	2004-09-13 12:22:11.472865432 +0100
+++ linux/fs/reiser4/flush_queue.c	2004-09-13 13:15:50.505877800 +0100
@@ -447,7 +447,7 @@ end_io_handler(struct bio *bio, unsigned
 
 		/* If all write requests registered in this "fq" are done we up
 		 * the semaphore. */
-		if (atomic_sub_and_test(bio->bi_vcnt, &fq->nr_submitted))
+		if (atomic_sub_return(bio->bi_vcnt, &fq->nr_submitted) == 0)
 			up(&fq->io_sem);
 	}
 
--- 2.6.9-rc1-mm5/include/asm-s390/atomic.h	2004-06-16 06:20:36.000000000 +0100
+++ linux/include/asm-s390/atomic.h	2004-09-13 13:18:33.456105600 +0100
@@ -61,6 +61,10 @@ static __inline__ void atomic_sub(int i,
 {
 	       __CS_LOOP(v, i, "sr");
 }
+static __inline__ int atomic_sub_return(int i, atomic_t * v)
+{
+	return __CS_LOOP(v, i, "sr");
+}
 static __inline__ void atomic_inc(volatile atomic_t * v)
 {
 	       __CS_LOOP(v, 1, "ar");

