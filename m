Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135883AbREFWB5>; Sun, 6 May 2001 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135888AbREFWBi>; Sun, 6 May 2001 18:01:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41990 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135883AbREFWBY>;
	Sun, 6 May 2001 18:01:24 -0400
Date: Mon, 7 May 2001 00:01:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux-KERNEL <linux-kernel@vger.kernel.org>
Cc: Phil Stracchino <alaric@babcom.com>
Subject: Re: CDROM troubles
Message-ID: <20010507000116.D506@suse.de>
In-Reply-To: <20010506030500.A26278@babylon5.babcom.com> <20010506144228.B13711@babylon5.babcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20010506144228.B13711@babylon5.babcom.com>; from alaric@babcom.com on Sun, May 06, 2001 at 02:42:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 06 2001, Phil Stracchino wrote:
> On Sun, May 06, 2001 at 03:05:00AM -0700, Phil Stracchino wrote:
> > Hey folks,
> > I'm seeing a problem with mounting CDs using a Toshiba XM-6401TA CDROM
> > drive attached to an Adaptec AHA1542CF controller (scsi1) on kernel 2.4.3
> > and 2.4.4.  The behavior seems to be fairly consistent as follows:
> > 
> > first mount and unmount works normally, no unusual events logged
> > second mount and unmount works normally, no unusual events logged
> > third mount locks up the machine.  looks like a kernel panic.
> > 
> > Any ideas?
> 
> 
> Panic is confirmed.  This time, it lived long enough to log:
>  
> May  6 14:05:05 babylon5 kernel: Kernel panic: scsi_free:Bad offset
> 
> Since it involves the CDROM, the aha1542 driver is implicated.  Why it's
> getting a bad offset, I don't understand enough about the SCSI drivers to
> know; all the scsi_free calls in aha1542.c look identical to me.
>  
> Would any Linux SCSI gurus care to let me know any diagnostic procedures
> recommended for nailing this one?

The panic should be fixed with attached patch.

-- 
Jens Axboe


--gatW/ieO32f1wygP
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


--gatW/ieO32f1wygP--
