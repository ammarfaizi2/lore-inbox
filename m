Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVI1VCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVI1VCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVI1VCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:02:20 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:27532 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750820AbVI1VCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:02:20 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
	<m3slvtzf72.fsf@telia.com>
	<Pine.LNX.4.60.0509252026290.3089@poirot.grange>
	<m34q873ccc.fsf@telia.com>
	<Pine.LNX.4.60.0509262122450.4031@poirot.grange>
	<m3slvr1ugx.fsf@telia.com>
	<Pine.LNX.4.60.0509262358020.6722@poirot.grange>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Sep 2005 23:02:14 +0200
In-Reply-To: <Pine.LNX.4.60.0509262358020.6722@poirot.grange>
Message-ID: <m3hdc4ucrt.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Mon, 26 Sep 2005, Peter Osterlund wrote:
> 
> > OK. Another option since you have one good and one bad kernel, is to
> > try to find the point in time where it broke. If you are a git user,
> 
> No, I am not.
> 
> > you can use the "git bisect" method. If not, you can use -rc releases
> > from ftp.kernel.org.
> 
> I think, I have an easier test - I just replaced the pktcdvd.[hc] in 
> 2.6.13.1 with respective files from 2.6.12, and it worked. The diff is 
> pretty small, so, it should be possible to actually find the culprit 
> there. E.g., here's the comment, that came in with 2.6.13:
> 
> - * - Optimize for throughput at the expense of latency. This means that streaming
> - *   writes will never be interrupted by a read, but if the drive has to seek
> - *   before the next write, switch to reading instead if there are any pending
> - *   read requests.

That's quite disturbing unfortunately.

The driver works by sending reads, writes, and synchronize cache
commands to the real CD/DVD driver, which then forwards them to the
drive firmware. Except during startup, the driver will send one or
more read requests, followed by one or more write requests, followed
by exactly one synchronize cache request, and then start over with
read requests.

That patch changes the logic that decides when the driver should
change between reading and writing. However, the read/write/sync
sequence that makes your drive fail in 2.6.13 could theoretically
happen in 2.6.12 as well if you are unlucky.

I think some trial and error will be required to figure out what
causes your drive to fail. If you apply this patch to 2.6.12, does it
still work?

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2131,7 +2131,7 @@ static int pkt_make_request(request_queu
 		cloned_bio->bi_private = psd;
 		cloned_bio->bi_end_io = pkt_end_io_read_cloned;
 		pd->stats.secs_r += bio->bi_size >> 9;
-		pkt_queue_bio(pd, cloned_bio, 1);
+		pkt_queue_bio(pd, cloned_bio, 0);
 		return 0;
 	}
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
