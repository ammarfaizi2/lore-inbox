Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270505AbTHHBOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 21:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271134AbTHHBOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 21:14:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:50308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270505AbTHHBOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 21:14:33 -0400
Date: Thu, 7 Aug 2003 18:16:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: dan@debian.org, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 badness in 2.6.0-test2
Message-Id: <20030807181631.2962dfca.akpm@osdl.org>
In-Reply-To: <16178.63046.43567.551323@gargle.gargle.HOWL>
References: <20030804142245.GA1627@nevyn.them.org>
	<20030804132219.2e0c53b4.akpm@osdl.org>
	<16176.41431.279477.273718@gargle.gargle.HOWL>
	<20030805235735.4c180fa4.akpm@osdl.org>
	<16178.63046.43567.551323@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> On Tuesday August 5, akpm@osdl.org wrote:
> > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > > ...
> > > Aug  6 15:22:05 adams kernel: EXT3-fs error (device md1): ext3_add_entry: bad entry in directory #41
> > > 009295: rec_len is smaller than minimal - offset=0, inode=3265411686, rec_len=0, name_len=0
> > 
> > It looks like we had a block full of zeroes come back from the device
> > driver.  I find it distinctly fishy how this happens so much with
> > ext3-on-md, and so little with ext3-on-just-a-disk.
> 
> Well, they're not *all* zero.....
> 
> I can reproduce this easily with various configurations of ext3 over
> raid5, and get a similar problem with ext2 over raid5 (corrupt inodes
> rather than directory entries) but ext3 over raid0 is rock-solid.

Good news that it is reproducible.

Have you tried running fsx-linux?  It is good at picking up data loss.

> So I guess the finger points generally in the direction of raid5.
> Now I've just got to figure if it is a bug in r5, or some assumption
> that it makes that is no longer valid (I was briefly suspicious of
> PF_READAHEAD which could have made a real mess of raid5, but that
> wouldn't have this symptom)

The PF_READAHEAD things was a huge bug.  Make sure that it is fixed before
proceeding.  Linus's tree has the fix.  This is the relevant patch:

 drivers/block/ll_rw_blk.c |    2 +-
 fs/buffer.c               |    3 +--
 include/linux/sched.h     |    1 -
 mm/readahead.c            |   11 +++--------
 4 files changed, 5 insertions(+), 12 deletions(-)

diff -puN mm/readahead.c~remove-PF_READAHEAD mm/readahead.c
--- 25/mm/readahead.c~remove-PF_READAHEAD	2003-08-06 19:53:14.000000000 -0700
+++ 25-akpm/mm/readahead.c	2003-08-06 19:53:14.000000000 -0700
@@ -298,15 +298,10 @@ int force_page_cache_readahead(struct ad
 int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			unsigned long offset, unsigned long nr_to_read)
 {
-	int ret = 0;
-
-	if (!bdi_read_congested(mapping->backing_dev_info)) {
-		current->flags |= PF_READAHEAD;
-		ret = __do_page_cache_readahead(mapping, filp,
+	if (!bdi_read_congested(mapping->backing_dev_info))
+		return __do_page_cache_readahead(mapping, filp,
 						offset, nr_to_read);
-		current->flags &= ~PF_READAHEAD;
-	}
-	return ret;
+	return 0;
 }
 
 /*
diff -puN fs/buffer.c~remove-PF_READAHEAD fs/buffer.c
--- 25/fs/buffer.c~remove-PF_READAHEAD	2003-08-06 19:53:14.000000000 -0700
+++ 25-akpm/fs/buffer.c	2003-08-06 19:53:14.000000000 -0700
@@ -506,8 +506,7 @@ static void end_buffer_async_read(struct
 		set_buffer_uptodate(bh);
 	} else {
 		clear_buffer_uptodate(bh);
-		if (!(current->flags & PF_READAHEAD))
-			buffer_io_error(bh);
+		buffer_io_error(bh);
 		SetPageError(page);
 	}
 
diff -puN drivers/block/ll_rw_blk.c~remove-PF_READAHEAD drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~remove-PF_READAHEAD	2003-08-06 19:53:14.000000000 -0700
+++ 25-akpm/drivers/block/ll_rw_blk.c	2003-08-06 19:53:14.000000000 -0700
@@ -1833,7 +1833,7 @@ static int __make_request(request_queue_
 
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
 
-	ra = bio_flagged(bio, BIO_RW_AHEAD) || current->flags & PF_READAHEAD;
+	ra = bio_flagged(bio, BIO_RW_AHEAD);
 
 again:
 	insert_here = NULL;
diff -puN include/linux/sched.h~remove-PF_READAHEAD include/linux/sched.h
--- 25/include/linux/sched.h~remove-PF_READAHEAD	2003-08-06 19:53:14.000000000 -0700
+++ 25-akpm/include/linux/sched.h	2003-08-06 19:53:14.000000000 -0700
@@ -487,7 +487,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
-#define PF_READAHEAD	0x00400000	/* I am doing read-ahead */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, unsigned long new_mask);

_

