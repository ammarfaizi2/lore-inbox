Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319082AbSHFM3g>; Tue, 6 Aug 2002 08:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319083AbSHFM3g>; Tue, 6 Aug 2002 08:29:36 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62983 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319082AbSHFM3f>; Tue, 6 Aug 2002 08:29:35 -0400
Message-ID: <3D4FC0DE.9050608@evision.ag>
Date: Tue, 06 Aug 2002 14:28:14 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.30 IDE 114
Content-Type: multipart/mixed;
 boundary="------------040902050309030502050400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902050309030502050400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix allocation problem introduced in 113 as suggested by Jens.
   (Thanks go to  Jens for providing info how to use properly
    blk_get_request in  this case. Nevermind I just got confused by
    __blk_get_request in TCQ  code, which made me worry about queue depth
    strain.)
   (Note: SCSI should propably be using the same mechanism instead of
    sr_request. At least we should check the code in question there.)

--------------040902050309030502050400
Content-Type: text/plain;
 name="ide-114.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-114.diff"

diff -durNp -X /tmp/diff.WY9PFG linux-2.5.30/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.30/drivers/ide/ide-taskfile.c	2002-08-06 14:15:07.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-08-06 14:02:37.000000000 +0200
@@ -188,18 +188,20 @@ static ide_startstop_t special_intr(stru
 
 int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar, char *buf)
 {
-	struct request *rq = &drive->srequest;
+	struct request *rq;
+	int errors;
 	struct ata_channel *ch = drive->channel;
 	request_queue_t *q = &drive->queue;
 	DECLARE_COMPLETION(wait);
 
 #ifdef CONFIG_BLK_DEV_PDC4030
+	/* special drive cmds not supported */
 	if (ch->chipset == ide_pdc4030 && buf)
-		return -ENOSYS;  /* special drive cmds not supported */
+		return -ENOSYS;
 #endif
 
+	rq = blk_get_request(q, READ, __GFP_WAIT);
 	memset(rq, 0, sizeof(*rq));
-
 	rq->buffer = buf;
 	rq->rq_status = RQ_ACTIVE;
 	rq->waiting = &wait;
@@ -208,9 +210,12 @@ int ide_raw_taskfile(struct ata_device *
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	blk_insert_request(q, rq, 1, ar);
-	wait_for_completion(&wait);	/* wait for it to be serviced */
+	wait_for_completion(&wait);
 
-	return rq->errors ? -EIO : 0;	/* return -EIO if errors */
+	errors = rq->errors;
+	blk_put_request(rq);
+
+	return errors ? -EIO : 0;
 }
 
 EXPORT_SYMBOL(ata_read);
diff -durNp -X /tmp/diff.WY9PFG linux-2.5.30/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.30/include/linux/ide.h	2002-08-06 14:15:07.000000000 +0200
+++ linux/include/linux/ide.h	2002-08-06 14:04:32.000000000 +0200
@@ -763,7 +763,6 @@ struct ata_device {
 
 	request_queue_t	queue;		/* per device request queue */
 	struct request *rq;		/* current request */
-	struct request srequest;	/* special requests */
 
 	u8	 retry_pio;		/* retrying dma capable host in pio */
 	u8	 state;			/* retry state */

--------------040902050309030502050400--

