Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTICPzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTICPxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:53:19 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42661 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263440AbTICPwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:52:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Tejun Huh <tejun@aratech.co.kr>
Subject: Re: [PATCH] ide task_map_rq() preempt count imbalance
Date: Wed, 3 Sep 2003 17:53:04 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030903055257.GA31635@atj.dyndns.org>
In-Reply-To: <20030903055257.GA31635@atj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031753.04535.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 of September 2003 07:52, Tejun Huh wrote:
>  Hello,
>
>  2.5 kernel continued to fail on my test machine with a lot of
> scheduling while atomic messages.  The offending function was
> include/linux/ide.h:task_sectors() which calls task_map_rq() followed
> by process_that_request_first(), taskfile_{input|output}_data() and
> task_unmap_rq().
>
> static inline void *task_map_rq(struct request *rq, unsigned long *flags)
> {
> 	/*
> 	 * fs request
> 	 */
> 	if (rq->cbio)
> 		return rq_map_buffer(rq, flags);
>
> 	/*
> 	 * task request
> 	 */
> 	return rq->buffer + blk_rq_offset(rq);
> }
>
> static inline void task_unmap_rq(struct request *rq, char *buffer, unsigned
> long *flags) {
> 	if (rq->cbio)
> 		rq_unmap_buffer(buffer, flags);
> }
>
>  rq_[un]map_buffer() eventually call into k[un]map_atomic() which
> adjust preempt_count().  The problem is that rq->cbio is cleared by
> process_that_request_first() before calling task_unmap_rq(), so the
> preempt_count() isn't decremented properly.

Good catch.

>  As it seems that rq->cbio test is to avoid the cost of calling into
> k[un]map_atomic, I just removed the optimization and it worked for me.
>
>  I'm not familiar with ide and block layer.  If I got something wrong,
> please point out.

As Jens pointed out its not a proper fix.  Please try attached patch.

You are using PIO mode with "IDE taskfile IO" option enabled.
Please also check if this preempt count bug happens with taskfile IO
disabled (from quick look at the code it shouldn't but...).

Do you have any other IDE problems?
Do multi-sector PIO transfers with taskfile IO work for you (hdparm -m)?

--bartlomiej


ide: fix imbalance preempt count with taskfile PIO

Noticed by Tejun Huh <tejun@aratech.co.kr>.

 include/linux/ide.h |   39 +++++++++++++--------------------------
 1 files changed, 13 insertions(+), 26 deletions(-)

diff -puN include/linux/ide.h~ide-tf-pio-preempt-fix include/linux/ide.h
--- linux-2.6.0-test4-bk3/include/linux/ide.h~ide-tf-pio-preempt-fix	2003-09-03 17:50:15.974731504 +0200
+++ linux-2.6.0-test4-bk3-root/include/linux/ide.h	2003-09-03 17:50:15.978730896 +0200
@@ -850,29 +850,6 @@ static inline void ide_unmap_buffer(stru
 	if (rq->bio)
 		bio_kunmap_irq(buffer, flags);
 }
-
-#else /* !CONFIG_IDE_TASKFILE_IO */
-
-static inline void *task_map_rq(struct request *rq, unsigned long *flags)
-{
-	/*
-	 * fs request
-	 */
-	if (rq->cbio)
-		return rq_map_buffer(rq, flags);
-
-	/*
-	 * task request
-	 */
-	return rq->buffer + blk_rq_offset(rq);
-}
-
-static inline void task_unmap_rq(struct request *rq, char *buffer, unsigned long *flags)
-{
-	if (rq->cbio)
-		rq_unmap_buffer(buffer, flags);
-}
-
 #endif /* !CONFIG_IDE_TASKFILE_IO */
 
 #define IDE_CHIPSET_PCI_MASK	\
@@ -1471,9 +1448,19 @@ static inline void task_sectors(ide_driv
 				unsigned nsect, int rw)
 {
 	unsigned long flags;
+	unsigned int bio_rq;
 	char *buf;
 
-	buf = task_map_rq(rq, &flags);
+	/*
+	 * bio_rq flag is needed because we can call
+	 * rq_unmap_buffer() with rq->cbio == NULL
+	 */
+	bio_rq = rq->cbio ? 1 : 0;
+
+	if (bio_rq)
+		buf = rq_map_buffer(rq, &flags);	/* fs request */
+	else
+		buf = rq->buffer + blk_rq_offset(rq);	/* task request */
 
 	/*
 	 * IRQ can happen instantly after reading/writing
@@ -1486,9 +1473,9 @@ static inline void task_sectors(ide_driv
 	else
 		taskfile_input_data(drive, buf, nsect * SECTOR_WORDS);
 
-	task_unmap_rq(rq, buf, &flags);
+	if (bio_rq)
+		rq_unmap_buffer(buf, &flags);
 }
-
 #endif /* CONFIG_IDE_TASKFILE_IO */
 
 extern int drive_is_ready(ide_drive_t *);

_


