Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311296AbSCLRDS>; Tue, 12 Mar 2002 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311294AbSCLRDF>; Tue, 12 Mar 2002 12:03:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56837 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311292AbSCLRCt>;
	Tue, 12 Mar 2002 12:02:49 -0500
Date: Tue, 12 Mar 2002 14:46:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Karsten Weiss <knweiss@gmx.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020312134631.GE1473@suse.de>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva> <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12 2002, Karsten Weiss wrote:
> > Here goes -pre3, with the new IDE code. It has been stable enough time in

Oh good god, the nr_sectors/current_nr_sectors for the pio data phases
haven't been fixed _yet_?!

task_in_intr()
{
	...
	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
}

And that's just one instance. Good luck running 2.4.19-pre3, this is
just so badly broken I can't find words to explain it (again). It's
really puzzling why this is still broken. I fixed it in 2.5 when the
merge happened there, the issue has been known for at least that long. I
can only recommend that no one uses 2.4.19-pre3!

Marcelo, at least apply the noop patch here. If I get motivated I'll fix
the interrupt handlers as well, can't say I really want to though...

--- drivers/ide/Config.in~	Tue Mar 12 14:22:01 2002
+++ drivers/ide/Config.in	Tue Mar 12 14:22:17 2002
@@ -159,8 +159,6 @@
 	 bool '    UMC-8672 support' CONFIG_BLK_DEV_UMC8672
       fi
    fi
-
-   bool '  Use the NOOP Elevator (WARNING)' CONFIG_BLK_DEV_ELEVATOR_NOOP
 else
    bool 'Old hard disk (MFM/RLL/IDE) driver' CONFIG_BLK_DEV_HD_ONLY
    define_bool CONFIG_BLK_DEV_HD $CONFIG_BLK_DEV_HD_ONLY
--- drivers/ide/ide-probe.c~	Tue Mar 12 14:22:06 2002
+++ drivers/ide/ide-probe.c	Tue Mar 12 14:22:23 2002
@@ -606,12 +606,6 @@
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
-
-	if (drive->media == ide_disk) {
-#ifdef CONFIG_BLK_DEV_ELEVATOR_NOOP
-		elevator_init(&q->elevator, ELEVATOR_NOOP);
-#endif
-	}
 }
 
 /*


-- 
Jens Axboe

