Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbUKXXgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbUKXXgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUKXXe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:34:59 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:45729 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262900AbUKXXT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:19:56 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 25 Nov 2004 10:12:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16805.5470.892995.589150@cse.unsw.edu.au>
Cc: Phil Dier <phil@dier.us>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
In-Reply-To: message from Andrew Morton on Monday November 22
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 22, akpm@osdl.org wrote:
> > <http://www.icglink.com/cluster-debug-info.html> (~235kb)
> 
> yow.  The dread combination of XFS, LVM, software RAID and bloaty scsi
> drivers.  Looks like a stack overrun.
> 
> Can you rebuild the kernel with CONFIG_4KSTACKS=n?
> 

Would the following (untested-but-seems-to-compile -
explanation-of-concept) patch be at all reasonable to avoid stack
depth problems with stacked block devices, or is adding stuff to
task_struct frowned upon? 

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
