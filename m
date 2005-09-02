Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVIBGlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVIBGlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVIBGlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:41:05 -0400
Received: from ns.suse.de ([195.135.220.2]:50142 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030388AbVIBGlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:41:04 -0400
From: Neil Brown <neilb@suse.de>
To: Nathan Scott <nathans@sgi.com>
Date: Fri, 2 Sep 2005 16:40:54 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17175.62454.623678.209697@cse.unsw.edu.au>
Cc: Chris Wedgwood <cw@f00f.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
In-Reply-To: message from Nathan Scott on Friday September 2
References: <20050902003915.GI3657@stusta.de>
	<20050902053356.GA20603@taniwha.stupidest.org>
	<20050902162931.A4496772@wobbly.melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 2, nathans@sgi.com wrote:
> On Thu, Sep 01, 2005 at 10:33:56PM -0700, Chris Wedgwood wrote:
> > On Fri, Sep 02, 2005 at 02:39:15AM +0200, Adrian Bunk wrote:
> > 
> > > 4Kb kernel stacks are the future on i386, and it seems the problems
> > > it initially caused are now sorted out.
> > 
> > Not entirely.
> > 
> > XFS when mixed with raid/lvm/nfs still blows up.  It's probably not
> > alone in this respect but worse than ext2/3.
> 
> To clarify, you mean AND not OR (/) there -- in other words,
> raid[+raid]+dm[+dm]+xfs+nfs can be fatal, yes.

It should be reasonably simple to remove this problem of stacked
drivers.
There really isn't any need for md and dm (or md and md or ..) to use
the stack and the same time.

The following patch, which I posted in November last year, arranges
that if generic_make_request is called recursively, then the instead
of doing anything, it just takes a copy of the 'bio', and deals with
it when the parent request finishes.

So it effectively converts the 'and' back to an 'or'.

It didn't get much of an enthusiastic response then.  Maybe it is time
to try again.  Anyone interested?
(I don't know if the patch still applies, but it should come close).

NeilBrown

==============================================
Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

### Diffstat output
 ./drivers/block/ll_rw_blk.c |   38 +++++++++++++++++++++++++++++++++++++-
 ./include/linux/sched.h     |    3 +++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff ./drivers/block/ll_rw_blk.c~current~ ./drivers/block/ll_rw_blk.c
--- ./drivers/block/ll_rw_blk.c~current~	2004-11-16 15:55:55.000000000 +1100
+++ ./drivers/block/ll_rw_blk.c	2004-11-25 10:05:14.000000000 +1100
@@ -2609,7 +2609,7 @@ static inline void block_wait_queue_runn
  * bi_sector for remaps as it sees fit.  So the values of these fields
  * should NOT be depended on after the call to generic_make_request.
  */
-void generic_make_request(struct bio *bio)
+static inline void __generic_make_request(struct bio *bio)
 {
 	request_queue_t *q;
 	sector_t maxsector;
@@ -2686,6 +2686,42 @@ end_io:
 	} while (ret);
 }
 
+/*
+ * We only want one ->make_request_fn to be active at a time, 
+ * else stack usage with stacked devices could be a problem.
+ * So use current->bio_{list,tail} to keep a list of requests
+ * submited by a make_request_fn function.
+ * current->bio_tail is also used as a flag to say if 
+ * generic_make_request is currently activce in this task or not.
+ * If it is NULL, then no make_request is active.  If it is non-NULL,
+ * then a make_request is active, and new requests should be added
+ * at the tail
+ */
+void generic_make_request(struct bio *bio)
+{
+	if (current->bio_tail) {
+		/* make_request is active */
+		*(current->bio_tail) = bio;
+		bio->bi_next = NULL;
+		current->bio_tail = &bio->bi_next;
+		return;
+	}
+	/* not active yet, make it active */
+	current->bio_list = NULL;
+	current->bio_tail = & current->bio_list;
+	__generic_make_request(bio);
+	while (current->bio_list) {
+		bio = current->bio_list;
+		current->bio_list = bio->bi_next;
+		if (bio->bi_next == NULL)
+			current->bio_tail = &current->bio_list;
+		else
+			bio->bi_next = NULL;
+		__generic_make_request(bio);
+	}
+	current->bio_tail = NULL; /* deactivate */
+}
+	
 EXPORT_SYMBOL(generic_make_request);
 
 /**

diff ./include/linux/sched.h~current~ ./include/linux/sched.h
--- ./include/linux/sched.h~current~	2004-11-25 09:57:07.000000000 +1100
+++ ./include/linux/sched.h	2004-11-25 09:57:34.000000000 +1100
@@ -649,6 +649,9 @@ struct task_struct {
 
 /* journalling filesystem info */
 	void *journal_info;
+	
+/* stacked block device info */
+	struct bio *bio_list, **bio_tail;
 
 /* VM state */
 	struct reclaim_state *reclaim_state;
