Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752425AbWCFVII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbWCFVII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWCFVII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:08:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752426AbWCFVIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:08:06 -0500
Date: Mon, 6 Mar 2006 13:07:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
  <200603062136.17098.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Mar 2006, Jesper Juhl wrote:
> 
> Hmm, is it just me or should that len= have read len=96 ???
> 
> This is the change I made :
> 
> --- linux-2.6.16-rc5-mm2/block/scsi_ioctl.c~    2006-03-06
> 21:43:56.000000000 +0100
> +++ linux-2.6.16-rc5-mm2/block/scsi_ioctl.c     2006-03-06
> 21:43:56.000000000 +0100
> @@ -568,7 +568,7 @@ int scsi_cmd_ioctl(struct file *file, st
>                         hdr.dxferp = cgc.buffer;
>                         hdr.sbp = cgc.sense;
>                         if (hdr.sbp)
> -                               hdr.mx_sb_len = sizeof(struct request_sense);
> +                               hdr.mx_sb_len = SCSI_SENSE_BUFFERSIZE;
>                         hdr.timeout = cgc.timeout;
>                         hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
>                         hdr.cmd_len = sizeof(cgc.cmd);
> 
> did I mess up?

That's not the one to change. It's the one in "sr_do_ioctl()", where it 
uses "sizeof(*sense)".

		Linus

----
diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index 5d02ff4..b65462f 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -192,7 +192,7 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
 	SDev = cd->device;
 
 	if (!sense) {
-		sense = kmalloc(sizeof(*sense), GFP_KERNEL);
+		sense = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
 		if (!sense) {
 			err = -ENOMEM;
 			goto out;
