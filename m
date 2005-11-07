Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVKGARM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVKGARM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 19:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVKGARL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 19:17:11 -0500
Received: from ns1.suse.de ([195.135.220.2]:5331 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932380AbVKGARK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 19:17:10 -0500
From: Neil Brown <neilb@suse.de>
To: device-mapper development <dm-devel@redhat.com>
Date: Mon, 7 Nov 2005 11:16:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.40176.342746.634262@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, aherrman@de.ibm.com, bunk@stusta.de,
       cplk@itee.uq.edu.au
Subject: Re: [dm-devel] Re: [PATCH resubmit] do_mount: reduce stack consumption
In-Reply-To: message from Neil Brown on Saturday November 5
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
	<20051104084829.714c5dbb.akpm@osdl.org>
	<20051104212742.GC9222@osiris.ibm.com>
	<20051104235500.GE5368@stusta.de>
	<20051104160851.3a7463ff.akpm@osdl.org>
	<Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>
	<20051104173721.597bd223.akpm@osdl.org>
	<17260.17661.523593.420313@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday November 5, neilb@suse.de wrote:
> 
> Ok, I'll dust it off, make sure it seems to work (at the time I first
> wrote it, I think it caused 'md' to deadlock) and submit it.
> 
> NeilBrown
> 

For your consideration and testing (it works for me, but I'd like to
see it tested a bit more heavily in a variety of configurations).

NeilBrown

--
Reduce stack usage with stacked block devices

When stacked block devices are in-use (e.g. md or dm), the recursive
calls to generic_make_request can use up a lot of space, and we would
rather they didn't.

As generic_make_request is a void function, and as it is generally not
expected that it will have any effect immediately, it is safe to delay
any call to generic_make_request until there is sufficient stack space
available.

As ->bi_next is reserved for the driver to use, it can have no valid
value when generic_make_request is called, and as __make_request
implicitly assumes it will be NULL (ELEVATOR_BACK_MERGE fork of
switch) we can be certain that all callers set it to NULL.  We can
therefore safely use bi_next to link pending requests together,
providing we clear it before making the real call.

So, we choose to allow each thread to only be active in one
generic_make_request at a time.  If a subsequent (recursive) call is
made, the bio is linked into a per-thread list, and is handled when
the active call completes.

As the list of pending bios is per-thread, there are no locking issues
to worry about.

I say above that it is "safe to delay any call...".  There are,
however, some behaviours of a make_request_fn which would make it
unsafe.  These include any behaviour that assumes anything will have
changed after a recursive call to generic_make_request.

These could include:
 - waiting for that call to finish and call it's bi_end_io function.
   md use to sometimes do this (marking the superblock dirty before
   completing a write) but doesn't any more
 - inspecting the bio for fields that generic_make_request might
   change, such as bi_sector or bi_bdev.  It is hard to see a good
   reason for this, and I don't think anyone actually does it.
 - inspecing the queue to see if, e.g. it is 'full' yet.  Again, I
   think this is very unlikely to be useful, or to be done.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/block/ll_rw_blk.c |   53 +++++++++++++++++++++++++++++++++++++++++++-
 ./include/linux/sched.h     |    3 ++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff ./drivers/block/ll_rw_blk.c~current~ ./drivers/block/ll_rw_blk.c
--- ./drivers/block/ll_rw_blk.c~current~	2005-11-07 10:01:36.000000000 +1100
+++ ./drivers/block/ll_rw_blk.c	2005-11-07 10:33:47.000000000 +1100
@@ -2957,7 +2957,7 @@ static void handle_bad_sector(struct bio
  * bi_sector for remaps as it sees fit.  So the values of these fields
  * should NOT be depended on after the call to generic_make_request.
  */
-void generic_make_request(struct bio *bio)
+static inline void __generic_make_request(struct bio *bio)
 {
 	request_queue_t *q;
 	sector_t maxsector;
@@ -3038,6 +3038,57 @@ end_io:
 	} while (ret);
 }
 
+/*
+ * We only want one ->make_request_fn to be active at a time,
+ * else stack usage with stacked devices could be a problem.
+ * So use current->bio_{list,tail} to keep a list of requests
+ * submited by a make_request_fn function.
+ * current->bio_tail is also used as a flag to say if
+ * generic_make_request is currently active in this task or not.
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
+	/* following loop may be a bit non-obvious, and so deserves some
+	 * explantion.
+	 * Before entering the loop, bio->bi_next is NULL (as all callers
+	 * ensure that) so we have a list with a single bio.
+	 * We pretend that we have just taken it off a longer list, so
+	 * we assign bio_list to the next (which is NULL) and bio_tail
+	 * to &bio_list, thus initialising the bio_list of new bios to be
+	 * added.  __generic_make_request may indeed add some more bios
+	 * through a recursive call to generic_make_request.  If it
+	 * did, we find a non-NULL value in bio_list and re-enter the loop
+	 * from the top.  In this case we really did just take the bio
+	 * of the top of the list (no pretending) and so fixup bio_list and
+	 * bio_tail or bi_next, and call into __generic_make_request again.
+	 *
+	 * The loop was structured like this to make only one call to
+	 * __generic_make_request (which is important as it is large and inlined)
+	 * and to keep the structure simple.
+	 */
+	BUG_ON(bio->bi_next);
+	do {
+		current->bio_list = bio->bi_next;
+		if (bio->bi_next == NULL)
+			current->bio_tail = &current->bio_list;
+		else
+			bio->bi_next = NULL;
+		__generic_make_request(bio);
+		bio = current->bio_list;
+	} while (bio);
+	current->bio_tail = NULL; /* deactivate */
+}
+
 EXPORT_SYMBOL(generic_make_request);
 
 /**

diff ./include/linux/sched.h~current~ ./include/linux/sched.h
--- ./include/linux/sched.h~current~	2005-11-07 10:01:36.000000000 +1100
+++ ./include/linux/sched.h	2005-11-07 10:02:23.000000000 +1100
@@ -829,6 +829,9 @@ struct task_struct {
 /* journalling filesystem info */
 	void *journal_info;
 
+/* stacked block device info */
+	struct bio *bio_list, **bio_tail;
+
 /* VM state */
 	struct reclaim_state *reclaim_state;
 

