Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287366AbRL3Jeu>; Sun, 30 Dec 2001 04:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287365AbRL3Jel>; Sun, 30 Dec 2001 04:34:41 -0500
Received: from fep03.swip.net ([130.244.199.131]:24032 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S287367AbRL3Je3>; Sun, 30 Dec 2001 04:34:29 -0500
To: Greg KH <greg@kroah.com>
Cc: Jens Axboe <axboe@suse.de>, mdharm-usb@one-eyed-alien.net,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Dec 2001 10:31:11 +0100
In-Reply-To: <20011223112249.B4493@kroah.com>
Message-ID: <m23d1trr4w.fsf@pengo.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sun, Dec 23, 2001 at 06:44:43PM +0100, Peter Osterlund wrote:
> > 
> > So, what changes are needed to make CD support work?
> 
> The usb-storage driver needs some changes to get it to work properly in
> the 2.5.1 kernel due to the changes in the SCSI and bio layer.  I've
> gotten a few other reports of problems, so you aren't alone :)
> 
> As for when the changes will be done, any volunteers?

This patch seems to work for me. I hope it is correct. The ide-scsi
driver is basically doing the same thing already.

--- linux-2.5-packet/drivers/usb/storage/scsiglue.c.old	Sun Dec 30 02:10:01 2001
+++ linux-2.5-packet/drivers/usb/storage/scsiglue.c	Sun Dec 30 02:09:05 2001
@@ -145,9 +145,19 @@
 static int queuecommand( Scsi_Cmnd *srb , void (*done)(Scsi_Cmnd *))
 {
 	struct us_data *us = (struct us_data *)srb->host->hostdata[0];
+	struct scatterlist *sg;
+	int i;
 
 	US_DEBUGP("queuecommand() called\n");
 	srb->host_scribble = (unsigned char *)us;
+
+	/* Set up address field in the scatterlist. HighMem pages have
+	 * already been bounced at this point. */
+	sg = (struct scatterlist *) srb->request_buffer;
+	for (i = 0; i < srb->use_sg; i++) {
+		BUG_ON(PageHighMem(sg[i].page));
+		sg[i].address = page_address(sg[i].page) + sg[i].offset;
+	}
 
 	/* get exclusive access to the structures we want */
 	down(&(us->queue_exclusion));

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
