Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUJDRgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUJDRgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUJDRgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:36:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13199 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268336AbUJDRgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:36:41 -0400
Date: Mon, 4 Oct 2004 19:36:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Message-ID: <20041004173620.GA5707@suse.de>
References: <20040929214637.44e5882f.akpm@osdl.org> <200410012042.02628.petkov@uni-muenster.de> <200410030951.44040.petkov@uni-muenster.de> <200410041754.25677.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410041754.25677.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04 2004, Borislav Petkov wrote:
> Ok here we go,
> 
> final results:
> 
>  2.6.8-rc1: OK
>  2.6.8-rc2: OK
>  2.6.8-rc3: OK
>  2.6.8-rc3-bk1: OK
>  2.6.8-rc3-bk2: OK
>  2.6.8-rc3-bk3: OK
>  2.6.8-rc3-bk4: OK
>  2.6.8-rc4: BUG!
> 
> So, assuming that everything went fine during testing, the bug got introduced 
> in the transition between 2.6.8-rc3-bk4 and 2.6.8-rc4.

That's some nice testing, thank you. Try backing out this hunk:

diff -urp linux-2.6.8-rc3-bk4/drivers/block/scsi_ioctl.c linux-2.6.8-rc4/drivers/block/scsi_ioctl.c
--- linux-2.6.8-rc3-bk4/drivers/block/scsi_ioctl.c	2004-08-03 23:28:51.000000000 +0200
+++ linux-2.6.8-rc4/drivers/block/scsi_ioctl.c	2004-08-10 04:24:08.000000000 +0200
@@ -90,7 +90,7 @@ static int sg_set_reserved_size(request_
 	if (size < 0)
 		return -EINVAL;
 	if (size > (q->max_sectors << 9))
-		return -EINVAL;
+		size = q->max_sectors << 9;
 
 	q->sg_reserved_size = size;
 	return 0;

It's the only thing that sticks out, and it could easily explain it if
your cd ripper starts issuing requests that are too big. Maybe even add
a printk() here, so it will look like this in the kernel you test:

	if (size > (q->sectors << 9)) {
		printk("%u rejected\n", size);
		return -EINVAL;
	}

to verify.

-- 
Jens Axboe

