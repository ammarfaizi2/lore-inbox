Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752438AbWCFVy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbWCFVy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWCFVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:54:07 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:58101 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751669AbWCFVyD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:54:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VseXuL9L95smp91X9BeZ5M3WXBau9A/mGxlrjKW1lMyBcAo+T8k3kppurfj4VO2NrVgDVs4J6sDir5LJ69PHwkZSMczblF1vJfj6YleK+xvabKPvNGRLcfhQY1AuifsPkkIYx7ZuRTMN/i5XzJQRdlCIwhv0S4N3WnJBtSP2Fak=
Message-ID: <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
Date: Mon, 6 Mar 2006 22:54:02 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jens Axboe" <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
[.snip.]
>
> That's not the one to change. It's the one in "sr_do_ioctl()", where it
> uses "sizeof(*sense)".
>
>                 Linus
>
> ----
> diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
> index 5d02ff4..b65462f 100644
> --- a/drivers/scsi/sr_ioctl.c
> +++ b/drivers/scsi/sr_ioctl.c
> @@ -192,7 +192,7 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
>         SDev = cd->device;
>
>         if (!sense) {
> -               sense = kmalloc(sizeof(*sense), GFP_KERNEL);
> +               sense = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
>                 if (!sense) {
>                         err = -ENOMEM;
>                         goto out;
>

Ok, booting a plain 2.6.16-rc5-mm2 kernel with the above being the
only change made results in this :

Slab corruption: start=f4f6a11c, len=128
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f4f6a090, len=128
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c01f4a26>](alloc_as_io_context+0x16/0xd0)
000: 01 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff
010: ff ff ff ff b0 49 1f c0 c0 49 1f c0 07 00 00 00
Next obj: start=f4f6a1a8, len=128
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c01f4a26>](alloc_as_io_context+0x16/0xd0)
000: 01 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff
010: ff ff ff ff b0 49 1f c0 c0 49 1f c0 07 00 00 00
Slab corruption: start=f4f6a11c, len=128
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f4f6a090, len=128
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c01f4a26>](alloc_as_io_context+0x16/0xd0)
000: 01 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff
010: ff ff ff ff b0 49 1f c0 c0 49 1f c0 07 00 00 00
Next obj: start=f4f6a1a8, len=128
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c01f4a26>](alloc_as_io_context+0x16/0xd0)
000: 01 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff
010: ff ff ff ff b0 49 1f c0 c0 49 1f c0 07 00 00 00


Where do we go from here ?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
