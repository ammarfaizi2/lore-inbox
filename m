Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbRE2KM0>; Tue, 29 May 2001 06:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbRE2KMR>; Tue, 29 May 2001 06:12:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42249 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261482AbRE2KMJ>;
	Tue, 29 May 2001 06:12:09 -0400
Date: Tue, 29 May 2001 12:11:53 +0200
From: Jens Axboe <axboe@kernel.org>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] panic in scsi_free/sr_scatter_pad
Message-ID: <20010529121153.I26871@suse.de>
In-Reply-To: <3B133ADC.974A76A@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <3B133ADC.974A76A@yahoo.com>; from p_gortmaker@yahoo.com on Tue, May 29, 2001 at 01:59:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29 2001, Paul Gortmaker wrote:
> I think I recall seeing something reported like this on the list(?):
> 
>   sr: ran out of mem for scatter pad
>   Kernel panic: scsi_free: bad offset

Here's a better patch, it also gets the freeing right. It's been fixed
for long, just haven't been sent to Linus yet. It's in Alan's tree, and
in fact I think I've send it to this list more than once :)

-- 
Jens Axboe


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sr-scatter-1

diff -urN --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.4-pre2/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- /opt/kernel/linux-2.4.4-pre2/drivers/scsi/sr.c	Mon Feb 19 19:25:17 2001
+++ linux/drivers/scsi/sr.c	Mon Apr  9 09:18:46 2001
@@ -262,7 +262,7 @@
 static int sr_scatter_pad(Scsi_Cmnd *SCpnt, int s_size)
 {
 	struct scatterlist *sg, *old_sg = NULL;
-	int i, fsize, bsize, sg_ent;
+	int i, fsize, bsize, sg_ent, sg_count;
 	char *front, *back;
 
 	back = front = NULL;
@@ -290,17 +290,24 @@
 	/*
 	 * extend or allocate new scatter-gather table
 	 */
-	if (SCpnt->use_sg)
+	sg_count = SCpnt->use_sg;
+	if (sg_count)
 		old_sg = (struct scatterlist *) SCpnt->request_buffer;
 	else {
-		SCpnt->use_sg = 1;
+		sg_count = 1;
 		sg_ent++;
 	}
 
-	SCpnt->sglist_len = ((sg_ent * sizeof(struct scatterlist)) + 511) & ~511;
-	if ((sg = scsi_malloc(SCpnt->sglist_len)) == NULL)
+	i = ((sg_ent * sizeof(struct scatterlist)) + 511) & ~511;
+	if ((sg = scsi_malloc(i)) == NULL)
 		goto no_mem;
 
+	/*
+	 * no more failing memory allocs possible, we can safely assign
+	 * SCpnt values now
+	 */
+	SCpnt->sglist_len = i;
+	SCpnt->use_sg = sg_count;
 	memset(sg, 0, SCpnt->sglist_len);
 
 	i = 0;


--ZGiS0Q5IWpPtfppv--
