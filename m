Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbTBECc7>; Tue, 4 Feb 2003 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbTBECc7>; Tue, 4 Feb 2003 21:32:59 -0500
Received: from 4-088.ctame701-1.telepar.net.br ([200.193.162.88]:54454 "EHLO
	4-088.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267677AbTBECc6>; Tue, 4 Feb 2003 21:32:58 -0500
Date: Wed, 5 Feb 2003 00:42:19 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Andy Chou <acc@CS.Stanford.EDU>,
       "" <mc@cs.stanford.edu>, James Bottomley <James.Bottomley@steeleye.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] Re: [CHECKER] 112 potential memory leaks in 2.5.48
In-Reply-To: <Pine.LNX.4.50L.0302050037280.32328-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.50L.0302050037460.32328-100000@imladris.surriel.com>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
 <Pine.LNX.4.50L.0302050037280.32328-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Rik van Riel wrote:
> On Tue, 4 Feb 2003, Andy Chou wrote:

Thanks for the checker output.  First patch below...

> > [BUG]
> > u1/acc/linux/2.5.48/drivers/scsi/sr_ioctl.c:188:sr_do_ioctl:
> > ERROR:LEAK:85:188:Memory leak [Allocated from:
> > /u1/acc/linux/2.5.48/drivers/scsi/sr_ioctl.c:85:scsi_allocate_request]
>
> Bug indeed, I've created a patch to fix the possible leak of
> a scsi request, but can't figure out the bounce buffer logic...

The patch below fixes the scsi request leak. I'm not sure
how the bounce buffer thing is supposed to work (Christoph?
James?) so I'm not touching that at the moment.

Linus, could you please apply this patch (against today's
bk tree) ?

thank you,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


===== drivers/scsi/sr_ioctl.c 1.27 vs edited =====
--- 1.27/drivers/scsi/sr_ioctl.c	Sat Jan  4 14:21:59 2003
+++ edited/drivers/scsi/sr_ioctl.c	Tue Feb  4 23:37:02 2003
@@ -99,7 +99,7 @@
 		if (bounce_buffer == NULL) {
 			printk("SCSI DMA pool exhausted.");
 			err = -ENOMEM;
-			goto out;
+			goto out_free;
 		}
 		memcpy(bounce_buffer, cgc->buffer, cgc->buflen);
 		cgc->buffer = bounce_buffer;
@@ -107,7 +107,7 @@
       retry:
 	if (!scsi_block_when_processing_errors(SDev)) {
 		err = -ENODEV;
-		goto out;
+		goto out_free;
 	}

 	scsi_wait_req(SRpnt, cgc->cmd, cgc->buffer, cgc->buflen,
@@ -179,6 +179,7 @@
 		memcpy(cgc->sense, SRpnt->sr_sense_buffer, sizeof(*cgc->sense));

 	/* Wake up a process waiting for device */
+      out_free:
 	scsi_release_request(SRpnt);
 	SRpnt = NULL;
       out:
