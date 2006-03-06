Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWCFUGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWCFUGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWCFUGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:06:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750782AbWCFUGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:06:30 -0500
Date: Mon, 6 Mar 2006 12:06:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com>
 <Pine.LNX.4.64.0603060956570.13139@g5.osdl.org> <200603061943.35502.jesper.juhl@gmail.com>
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Mar 2006, Linus Torvalds wrote:
> 
> So it's either an aic7xxx bug, or it's generic SCSI.
> 
> Considering that we've had other slab corruption issues (the reason I was 
> looking closely at yours), generic SCSI isn't out of the question.
> 
> If you were a git user, doing a bisection run would be useful since you 
> seem to be able to recreate it at will. Oh, well. Testign that one patch 
> would still help.

Hmm.. This appended patch may or may not help.

It overwrites the SCSI command "req" pointer when the request has been 
done. The request cannot be used afterwards, so anybody accessing it would 
be a bug. I think.

HOWEVER. I noticed something else strange. Your slab corruption report 
says

	Slab corruption: start=f72948a0, len=64
	Redzone: 0x5a2cf071/0x5a2cf071.
	Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
	...

and the scary thing is that "len=64". 

The thing is, SCSI uses "SCSI_SENSE_BUFFERSIZE" to determine the maximum 
sense size to copy, and what do we have, if not

	include/scsi/scsi_cmnd.h:#define SCSI_SENSE_BUFFERSIZE  96

ie a 64-byte buffer is simply TOO DAMN SMALL!

Now, the thing is, the 64 comes from "sizeof(struct request_sense)", which 
is what "struct packet_command *" uses. We can change that sizeof() to 
just use SCSI_SENSE_BUFFERSIZE, but that still makes me worry about 
somebody else having allocated a "packed_command->sense" using just the 
same 64-byte "struct request_sense".

Can a SCSI sense-buffer really be 96? If so, why is "struct request_sense" 
the wrong size? This looks likea really nasty bug.

		Linus

----
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 701a328..296ac8e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -788,6 +788,9 @@ static struct scsi_cmnd *scsi_end_reques
 		}
 	}
 
+	/* Poison the request pointer: it is done and no longer exists after this */
+	cmd->request = (void *) 0x5a5a5a5a;
+
 	add_disk_randomness(req->rq_disk);
 
 	spin_lock_irqsave(q->queue_lock, flags);
