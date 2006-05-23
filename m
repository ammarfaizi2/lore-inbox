Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWEWJWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWEWJWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 05:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWEWJWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 05:22:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36110 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932137AbWEWJWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 05:22:01 -0400
Date: Tue, 23 May 2006 11:23:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Devera <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong in_flight diskstat in 2.6.16.1
Message-ID: <20060523092324.GO26261@suse.de>
References: <4472CD62.5060906@cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4472CD62.5060906@cdi.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23 2006, Martin Devera wrote:
> Hello,
> 
> I see weird output from /sys/block/sd{a,b}/stat on our AMD64-X2 smp 
> machine with HT1000 (Broadcom) SATA with 2 WD 250GB HDDs in MD raid1. AS 
> scheduler was used, change to noop didn't change anything. It is vanilla 
> 2.6.16.1 and here are absolute values in hex and one second differences 
> below:
> 
> 132CDF 56D62 61753C0 6966BC 165A8EB 5FF5B6C 3B32D6C0 1110594C FFCA89A4 
> FEE85878 49FF74E4
> 132CDF 56D62 61753C0 6966BC 165A8EF 5FF5B6C 3B32D6E0 111059D0 FFCA89A1 
> FEE85C60 79291244
>  0: 0
>  1: 0
>  2: 0
>  3: 0
>  4: 4
>  5: 0
>  6: 32
>  7: 132
>  8: -3
>  9: 1000
> 10: 791256416
> 
> As you can see in_flight is constantly negative and it is DECREASING 
> slowly all the time.
> I can't find any reason for it :-\

Are you using io barriers?

[PATCH] blk: fix gendisk->in_flight accounting during barrier sequence

While executing barrrier sequence, the bar_rq which carries actual
write was accounted as normal IO on completion, while it wasn't on
queueing.  This caused gendisk->in_flight to be decremented by 1 after
each barrier thus messed up statistics.

This patch makes bar_rq not accounted as normal IO.  As the containing
barrier request as a whole is accounted, part of it shouldn't be.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index eac48be..7eb36c5 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3452,7 +3452,12 @@ void end_that_request_last(struct reques
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
 
-	if (disk && blk_fs_request(req)) {
+	/*
+	 * Account IO completion.  bar_rq isn't accounted as a normal
+	 * IO on queueing nor completion.  Accounting the containing
+	 * request is enough.
+	 */
+	if (disk && blk_fs_request(req) && req != &req->q->bar_rq) {
 		unsigned long duration = jiffies - req->start_time;
 		const int rw = rq_data_dir(req);
 

-- 
Jens Axboe

