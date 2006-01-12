Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWALIA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWALIA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWALIA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:00:59 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:14209 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932121AbWALIA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:00:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=aNeSUeQTFXf2rx6MmmZ+k+C1c7v4nMt5VdCJob3XpBi79zZju9hZajOeGxm3i5EAI6ryqq9FeiCrk0LDMJWXwMcSBJ5KpB4g4InLA1ZMwol+1w+IoX/o5gmwL5bf8dwmWojqSezsfOTVyNX7/V6gytvkUdLfO6ZN2IyTfYQdSGk=
Date: Thu, 12 Jan 2006 17:00:51 +0900
From: Tejun Heo <htejun@gmail.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>, neilb@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
Message-ID: <20060112080051.GA22783@htj.dyndns.org>
References: <20060111111313.GD3389@suse.de> <43C4EEA4.3050502@reub.net> <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C5D1CA.7000400@reub.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Reuben, Jens and all.

On Thu, Jan 12, 2006 at 04:49:30PM +1300, Reuben Farrelly wrote:
> 
> 
> On 12/01/2006 8:53 a.m., Jens Axboe wrote:
> >On Wed, Jan 11 2006, Jens Axboe wrote:
> >>At least it shows that the problem is indeed barrier related. I don't
> >>have the start of this thread, so can you please send me the output from
> >>dmesg from this kernel boot? I'm curious whether the fallback triggers,
> >>or if it's the barrier that fails instead.
> >
> >Or even better, please boot with this patch applied on top of the kernel
> >you just booted (the new one, with the md patch applied).
> >
> >diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> >index 4c5127e..07aee66 100644
> >--- a/drivers/scsi/sd.c
> >+++ b/drivers/scsi/sd.c
> >@@ -1492,6 +1492,7 @@ static int sd_revalidate_disk(struct gen
> > 		ordered = QUEUE_ORDERED_DRAIN;
> > 
> > 	blk_queue_ordered(sdkp->disk->queue, ordered, sd_prepare_flush);
> >+	printk("%s: ordered set to %d\n", disk->disk_name, ordered);
> > 
> > 	set_capacity(disk, sdkp->capacity);
> > 	kfree(buffer);
> 
> Here it is...
> 
> Linux version 2.6.15-mm3 (root@tornado.reub.net) (gcc version 4.1.0 
> 20060106 (Red Hat 4.1.0-0.14)) #4 SMP Thu Jan 12 16:26:28 NZDT 2006
[--snip--]
> ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA 
> mode
> ahci 0000:00:1f.2: flags: 64bit ncq led slum part
> ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 193
> ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 193
> ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 193
> ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 193
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
> 88:007f
> ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
> ata1: dev 0 configured for UDMA/133
> scsi0 : ahci
> ata2: SATA link up 1.5 Gbps (SStatus 113)
> ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
> 88:007f
> ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
> ata2: dev 0 configured for UDMA/133
> scsi1 : ahci
> ata3: SATA link up 1.5 Gbps (SStatus 113)
> ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
> 88:007f
> ata3: dev 0 ATA-6, max UDMA/133, 156299375 sectors: LBA48
> ata3: dev 0 configured for UDMA/133
> scsi2 : ahci
> ata4: SATA link down (SStatus 0)
> scsi3 : ahci
>   Vendor: ATA       Model: ST380817AS        Rev: 3.42
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: ST380817AS        Rev: 3.42
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: ST380013AS        Rev: 3.18
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> sda: ordered set to 49

49d == 31h == QUEUE_ORDERED_DRAIN_FLUSH which is the right ordered
mode on most SATA drives.  Barrier is performed by

 drain -> pre-flush -> barrier -> post-flush

sequence.  If something went wrong and above sequence got stuck, the
first suspect part would be 'draining'.  I'm attaching a patch which
adds a bunch of debug messages regarding ordered sequencing.  Can you
please apply the patch and post the log message?  The patch is against
v2.6.15-mm2.

I've also tested almost the same setup here - 2 maxtor SATA drives
hanging off AHCI and grouped into /dev/md0 and it works fine here.  It
prints something like the following while mounting /dev/md0 on boot
with the debug patch applied.

[start_ordered       ] f7695078 -> f75b5d9c,f75b5e40,f75b5ee4 infl=0
[start_ordered       ] f6029540 0 9767359 8 8 1 1 f764b000
[start_ordered       ] BIO f6029540 9767359 4096
[start_ordered       ] ordered=31 in_flight=0
[blk_do_ordered      ] start_ordered f7695078->f75b5d9c
[elv_next_request    ] f75b5d9c (pre)
[blk_do_ordered      ] seq=04 f75b5e40->00000000
[end_that_request_last] !ELVPRIV f75b5d9c 02002318
[blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
[blk_do_ordered      ] seq=08 f75b5e40->f75b5e40
[elv_next_request    ] f75b5e40 (bar)
[blk_do_ordered      ] seq=08 f75b5ee4->00000000
[ordered_bio_endio   ] q->orderr=0 error=0
[flush_dry_bio_endio ] BIO f6029540 9767359 4096
[end_that_request_last] !ELVPRIV f75b5e40 000003d9
[blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
[blk_do_ordered      ] seq=10 f75b5ee4->f75b5ee4
[elv_next_request    ] f75b5ee4 (post)
[end_that_request_last] !ELVPRIV f75b5ee4 02002318
[blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
[blk_ordered_complete_seq] sequence complete
[start_ordered       ] f7695078 -> f7d03208,f7d032ac,f7d03350 infl=0
[start_ordered       ] f60294a0 0 9767359 8 8 1 1 f764a000
[start_ordered       ] BIO f60294a0 9767359 4096
[start_ordered       ] ordered=31 in_flight=0
[blk_do_ordered      ] start_ordered f7695078->f7d03208
[elv_next_request    ] f7d03208 (pre)
[blk_do_ordered      ] seq=04 f7d032ac->00000000
[end_that_request_last] !ELVPRIV f7d03208 02002318
[blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
[blk_do_ordered      ] seq=08 f7d032ac->f7d032ac
[elv_next_request    ] f7d032ac (bar)
[blk_do_ordered      ] seq=08 f7d03350->00000000
[ordered_bio_endio   ] q->orderr=0 error=0
[flush_dry_bio_endio ] BIO f60294a0 9767359 4096
[end_that_request_last] !ELVPRIV f7d032ac 000003d9
[blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
[blk_do_ordered      ] seq=10 f7d03350->f7d03350
[elv_next_request    ] f7d03350 (post)
kjournald starting.  Commit interval 5 seconds
[end_that_request_last] !ELVPRIV f7d03350 02002318
[blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
[blk_ordered_complete_seq] sequence complete
 << /dev/md0 got mounted >>
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
[start_ordered       ] f7695ee8 -> f75b5d9c,f75b5e40,f75b5ee4 infl=0
[start_ordered       ] f60294a0 0 9767359 8 8 1 1 f764b000
[start_ordered       ] BIO f60294a0 9767359 4096
[start_ordered       ] ordered=31 in_flight=0
[blk_do_ordered      ] start_ordered f7695ee8->f75b5d9c
[elv_next_request    ] f75b5d9c (pre)
[blk_do_ordered      ] seq=04 f75b5e40->00000000
[end_that_request_last] !ELVPRIV f75b5d9c 02002318
[blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
[blk_do_ordered      ] seq=08 f75b5e40->f75b5e40
[elv_next_request    ] f75b5e40 (bar)
[blk_do_ordered      ] seq=08 f75b5ee4->00000000
[ordered_bio_endio   ] q->orderr=0 error=0
[flush_dry_bio_endio ] BIO f60294a0 9767359 4096
[end_that_request_last] !ELVPRIV f75b5e40 000003d9
[blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
[blk_do_ordered      ] seq=10 f75b5ee4->f75b5ee4
[elv_next_request    ] f75b5ee4 (post)
[end_that_request_last] !ELVPRIV f75b5ee4 02002318
[blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
[blk_ordered_complete_seq] sequence complete
[start_ordered       ] f7695ee8 -> f7d03208,f7d032ac,f7d03350 infl=0
[start_ordered       ] f60294a0 0 9767359 8 8 1 1 f764a000
[start_ordered       ] BIO f60294a0 9767359 4096
[start_ordered       ] ordered=31 in_flight=0
[blk_do_ordered      ] start_ordered f7695ee8->f7d03208
[elv_next_request    ] f7d03208 (pre)
[blk_do_ordered      ] seq=04 f7d032ac->00000000
[end_that_request_last] !ELVPRIV f7d03208 02002318
[blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
[blk_do_ordered      ] seq=08 f7d032ac->f7d032ac
[elv_next_request    ] f7d032ac (bar)
[blk_do_ordered      ] seq=08 f7d03350->00000000
[ordered_bio_endio   ] q->orderr=0 error=0
[flush_dry_bio_endio ] BIO f60294a0 9767359 4096
[end_that_request_last] !ELVPRIV f7d032ac 000003d9
[blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
[blk_do_ordered      ] seq=10 f7d03350->f7d03350
[elv_next_request    ] f7d03350 (post)
[end_that_request_last] !ELVPRIV f7d03350 02002318
[blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
[blk_ordered_complete_seq] sequence complete


And the patch follows.


diff --git a/block/elevator.c b/block/elevator.c
index 1b5b5d9..2bab695 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -37,6 +37,8 @@
 
 #include <asm/uaccess.h>
 
+#define pd(fmt, args...) printk("[%-20s] "fmt, __FUNCTION__ , ##args)
+
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -351,8 +353,10 @@ void __elv_add_request(request_queue_t *
 			q->end_sector = rq_end_sector(rq);
 			q->boundary_rq = rq;
 		}
-	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
+	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT) {
 		where = ELEVATOR_INSERT_BACK;
+		pd("!ELVPRIV %p %08lx inserting back\n", rq, rq->flags);
+	}
 
 	if (plug)
 		blk_plug_device(q);
@@ -528,6 +532,11 @@ struct request *elv_next_request(request
 		}
 	}
 
+	if (rq && (rq == &q->pre_flush_rq || rq == &q->post_flush_rq ||
+		   rq == &q->bar_rq))
+		pd("%p (%s)\n", rq,
+		   rq == &q->pre_flush_rq ?
+			"pre" : (rq == &q->post_flush_rq ? "post" : "bar"));
 	return rq;
 }
 
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index ec27dda..12396e0 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -28,6 +28,8 @@
 #include <linux/writeback.h>
 #include <linux/blktrace_api.h>
 
+#define pd(fmt, args...) printk("[%-20s] "fmt, __FUNCTION__ , ##args)
+
 /*
  * for max sense size
  */
@@ -303,6 +305,8 @@ static inline void rq_init(request_queue
 int blk_queue_ordered(request_queue_t *q, unsigned ordered,
 		      prepare_flush_fn *prepare_flush_fn)
 {
+	pd("%x->%x, ordseq=%x\n", q->next_ordered, ordered, q->ordseq);
+
 	if (ordered & (QUEUE_ORDERED_PREFLUSH | QUEUE_ORDERED_POSTFLUSH) &&
 	    prepare_flush_fn == NULL) {
 		printk(KERN_ERR "blk_queue_ordered: prepare_flush_fn required\n");
@@ -380,6 +384,9 @@ void blk_ordered_complete_seq(request_qu
 	struct request *rq;
 	int uptodate;
 
+	pd("ordseq=%02x seq=%02x orderr=%d error=%d\n",
+	   q->ordseq, seq, q->orderr, error);
+
 	if (error && !q->orderr)
 		q->orderr = error;
 
@@ -392,6 +399,7 @@ void blk_ordered_complete_seq(request_qu
 	/*
 	 * Okay, sequence complete.
 	 */
+	pd("sequence complete\n");
 	rq = q->orig_bar_rq;
 	uptodate = q->orderr ? q->orderr : 1;
 
@@ -446,6 +454,17 @@ static void queue_flush(request_queue_t 
 static inline struct request *start_ordered(request_queue_t *q,
 					    struct request *rq)
 {
+	pd("%p -> %p,%p,%p infl=%u\n",
+	   rq, &q->pre_flush_rq, &q->bar_rq, &q->post_flush_rq, q->in_flight);
+	pd("%p %d %llu %lu %u %u %u %p\n", rq->bio, rq->errors,
+	   (unsigned long long)rq->hard_sector, rq->hard_nr_sectors,
+	   rq->current_nr_sectors, rq->nr_phys_segments, rq->nr_hw_segments,
+	   rq->buffer);
+	struct bio *bio;
+	for (bio = rq->bio; bio; bio = bio->bi_next)
+		pd("BIO %p %llu %u\n",
+		   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
+
 	q->bi_size = 0;
 	q->orderr = 0;
 	q->ordered = q->next_ordered;
@@ -484,6 +503,7 @@ static inline struct request *start_orde
 	} else
 		q->ordseq |= QUEUE_ORDSEQ_PREFLUSH;
 
+	pd("ordered=%x in_flight=%u\n", q->ordered, q->in_flight);
 	if ((q->ordered & QUEUE_ORDERED_TAG) || q->in_flight == 0)
 		q->ordseq |= QUEUE_ORDSEQ_DRAIN;
 	else
@@ -503,8 +523,10 @@ int blk_do_ordered(request_queue_t *q, s
 
 		if (q->next_ordered != QUEUE_ORDERED_NONE) {
 			*rqp = start_ordered(q, rq);
+			pd("start_ordered %p->%p\n", rq, *rqp);
 			return 1;
 		} else {
+			pd("ORDERED_NONE, seen barrier\n");
 			/*
 			 * This can happen when the queue switches to
 			 * ORDERED_NONE while this request is on it.
@@ -521,6 +543,7 @@ int blk_do_ordered(request_queue_t *q, s
 	if (q->ordered & QUEUE_ORDERED_TAG) {
 		if (is_barrier && rq != &q->bar_rq)
 			*rqp = NULL;
+		pd("seq=%02x %p->%p\n", blk_ordered_cur_seq(q), rq, *rqp);
 		return 1;
 	}
 
@@ -544,6 +567,7 @@ int blk_do_ordered(request_queue_t *q, s
 	     rq == &q->post_flush_rq))
 		*rqp = NULL;
 
+	pd("seq=%02x %p->%p\n", blk_ordered_cur_seq(q), rq, *rqp);
 	return 1;
 }
 
@@ -576,6 +600,8 @@ static int flush_dry_bio_endio(struct bi
 	bio->bi_sector -= (q->bi_size >> 9);
 	q->bi_size = 0;
 
+	pd("BIO %p %llu %u\n",
+	   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
 	return 0;
 }
 
@@ -589,6 +615,7 @@ static inline int ordered_bio_endio(stru
 	if (&q->bar_rq != rq)
 		return 0;
 
+	pd("q->orderr=%d error=%d\n", q->orderr, error);
 	/*
 	 * Okay, this is the barrier request in progress, dry finish it.
 	 */
@@ -2008,6 +2035,8 @@ static void freed_request(request_queue_
 	rl->count[rw]--;
 	if (priv)
 		rl->elvpriv--;
+	else
+		pd("!priv, count=%u,%u elvpriv=%u\n", rl->count[0], rl->count[1], rl->elvpriv);
 
 	__freed_request(q, rw);
 
@@ -2074,6 +2103,8 @@ static struct request *get_request(reque
 	priv = !test_bit(QUEUE_FLAG_ELVSWITCH, &q->queue_flags);
 	if (priv)
 		rl->elvpriv++;
+	else
+		pd("!priv, count=%u,%u elvpriv=%u\n", rl->count[0], rl->count[1], rl->elvpriv);
 
 	spin_unlock_irq(q->queue_lock);
 
@@ -2839,6 +2870,7 @@ static int __make_request(request_queue_
 
 	barrier = bio_barrier(bio);
 	if (unlikely(barrier) && (q->next_ordered == QUEUE_ORDERED_NONE)) {
+		pd("ORDERED_NONE, seen barrier\n");
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}
@@ -3394,6 +3426,9 @@ void end_that_request_last(struct reques
 	if (end_io_error(uptodate))
 		error = !uptodate ? -EIO : uptodate;
 
+	if (!(req->flags & REQ_ELVPRIV))
+		pd("!ELVPRIV %p %08lx\n", req, req->flags);
+
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 529ae66..569dd1f 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -551,6 +551,10 @@ static void sil24_qc_prep(struct ata_que
 		BUG();
 	}
 
+	if (qc->tf.command == ATA_CMD_FLUSH_EXT) {
+		printk("sil24: corrupting flush\n");
+		qc->tf.command = 0x3D;
+	}
 	ata_tf_to_fis(&qc->tf, prb->fis, 0);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
@@ -564,6 +568,14 @@ static int sil24_qc_issue(struct ata_que
 	struct sil24_port_priv *pp = ap->private_data;
 	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
 
+	{
+		struct ata_taskfile *tf = &qc->tf;
+		printk("sil24: issuing %02x lba=%02x%02x%02x%02x%02x%02x nsect=%02x%02x f=%02x d=%02x\n",
+		       tf->command, tf->hob_lbah, tf->hob_lbam, tf->hob_lbal,
+		       tf->lbah, tf->lbam, tf->lbal, tf->hob_nsect, tf->nsect,
+		       tf->feature, tf->device);
+	}
+
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
 	return 0;
 }
