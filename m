Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317921AbSGKWSy>; Thu, 11 Jul 2002 18:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317922AbSGKWSx>; Thu, 11 Jul 2002 18:18:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46606 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317921AbSGKWSx> convert rfc822-to-8bit; Thu, 11 Jul 2002 18:18:53 -0400
Date: Thu, 11 Jul 2002 18:27:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jochen Suckfuell <jo-lkml@suckfuell.net>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Re: Disk IO statistics still buggy
In-Reply-To: <20020709190019.A19394@ds217-115-141-141.dedicated.hosteurope.de>
Message-ID: <Pine.LNX.4.44.0207111826470.21365-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

Can you take a look at this one ?

On Tue, 9 Jul 2002, Jochen Suckfuell wrote:

> And it hasn't been removed either. Only the output has been removed; the
> data is still collected. Meanwhile I found the bug that leads to wrong
> ios_in_flight values on SCSI systems:
>
> The accounting was done on a copy of the request _after_ the request has
> been dequeued and the irq_request_lock released. I fixed this by taking
> this lock again while calling the accounting function (see the patch
> below).
>
> ** This patch is relevant regardless where the statistics will finally
> be printed. **
>
> One issue is still left: on my non-SCSI machine, the ios_in_flight value
> is at -1 when although requests are running. It doesn't get any more
> wrong than that it seems, and I'm not sure where that happened. Maybe
> something went wrong when initializing this value at boot time? I have a
> workaround that corrects negative ios_in_flight values to zero each time
> /proc/partitions is read. After further testing I will post it to the
> list.
>
> Bye
> Jochen Suckfüll
>
> --
> Jochen Suckfuell  ---  http://www.suckfuell.net/jochen/  ---
>
> --- linux/drivers/scsi/scsi_lib.c Mon Jul  8 16:15:27 2002
> +++ linux_work/drivers/scsi/scsi_lib.c Tue Jul  9 17:56:39 2002
> @@ -426,7 +426,9 @@
>    if (req->waiting != NULL) {
>     complete(req->waiting);
>    }
> +  spin_lock_irq(&io_request_lock);
>    req_finished_io(req);
> +  spin_unlock_irq(&io_request_lock);
>    add_blkdev_randomness(MAJOR(req->rq_dev));
>
>          SDpnt = SCpnt->device;

