Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbTCLBWg>; Tue, 11 Mar 2003 20:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbTCLBWg>; Tue, 11 Mar 2003 20:22:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:53397 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261707AbTCLBWf>;
	Tue, 11 Mar 2003 20:22:35 -0500
Date: Tue, 11 Mar 2003 17:28:15 -0800
From: Andrew Morton <akpm@digeo.com>
To: Luben Tuikov <luben@splentec.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] fix kernel oops in generic_unplug_device() for md
Message-Id: <20030311172815.46ac305d.akpm@digeo.com>
In-Reply-To: <3E6E8B6D.1000501@splentec.com>
References: <3E6E8B6D.1000501@splentec.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2003 01:33:08.0960 (UTC) FILETIME=[565D5E00:01C2E837]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov <luben@splentec.com> wrote:
>
> The following patch fixes a kernel oops when doing
> blk_unplug_work() (oopses in generic_unplug_device()) for md.
> 
> The oops and the original report are here:
> http://MARC.10East.com/?l=linux-kernel&m=104706400705154&w=2
> 

Yup, is a bug.  I received the below fix from Neil today which looks
simpler.

diff -puN drivers/block/ll_rw_blk.c~auto-unplugging-fix drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~auto-unplugging-fix	Tue Mar 11 15:04:00 2003
+++ 25-akpm/drivers/block/ll_rw_blk.c	Tue Mar 11 15:04:00 2003
@@ -1004,7 +1004,8 @@ void generic_unplug_device(void *data)
 
 static void blk_unplug_work(void *data)
 {
-	generic_unplug_device(data);
+	request_queue_t *q = data;
+	q->unplug_fn(q);
 }
 
 static void blk_unplug_timeout(unsigned long data)

_

