Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUBTCdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267710AbUBTCdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:33:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:6088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267702AbUBTCcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:32:53 -0500
Date: Thu, 19 Feb 2004 18:32:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: miquels@cistron.nl, axboe@suse.de, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: [PATCH] per process request limits (was Re: IO scheduler, queue
 depth, nr_requests)
Message-Id: <20040219183218.2b3c4706.akpm@osdl.org>
In-Reply-To: <40356599.3080001@cyberone.com.au>
References: <20040216133047.GA9330@suse.de>
	<20040217145716.GE30438@traveler.cistron.net>
	<20040218235243.GA30621@drinkel.cistron.nl>
	<20040218172622.52914567.akpm@osdl.org>
	<20040219021159.GE30621@drinkel.cistron.nl>
	<20040218182628.7eb63d57.akpm@osdl.org>
	<20040219101519.GG30621@drinkel.cistron.nl>
	<20040219101915.GJ27190@suse.de>
	<20040219205907.GE32263@drinkel.cistron.nl>
	<40353E30.6000105@cyberone.com.au>
	<20040219235303.GI32263@drinkel.cistron.nl>
	<40355F03.9030207@cyberone.com.au>
	<20040219172656.77c887cf.akpm@osdl.org>
	<40356599.3080001@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Andrew Morton wrote:
> 
> >Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> >>Even with this patch, it might still be a good idea to allow
> >>pdflush to disregard the limits...
> >>
> >
> >Has it been confirmed that pdflush is blocking in get_request_wait()?  I
> >guess that can happen very occasionally because we don't bother with any
> >locking around there but if it's happening a lot then something is bust.
> >
> >
> 
> Miquel's analysis is pretty plausible, but I'm not sure if
> he's confirmed it or not, Miquel? Even if it isn't happening
> a lot, and something isn't bust it might be a good idea to
> do this.

Seems OK from a quick check.  pdflush will block in get_request_wait()
occasionally, but not at all often.  Perhaps we could move the
write_congested test into the mpage_writepages() inner loop but it hardly
seems worth the risk.

Maybe things are different on Miquel's clockwork controller.



 drivers/block/ll_rw_blk.c |    2 ++
 fs/fs-writeback.c         |    2 ++
 2 files changed, 4 insertions(+)

diff -puN drivers/block/ll_rw_blk.c~pdflush-blockage-check drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~pdflush-blockage-check	2004-02-19 18:16:33.000000000 -0800
+++ 25-akpm/drivers/block/ll_rw_blk.c	2004-02-19 18:16:33.000000000 -0800
@@ -1651,6 +1651,8 @@ static struct request *get_request_wait(
 		if (!rq) {
 			struct io_context *ioc;
 
+			WARN_ON(current_is_pdflush());
+
 			io_schedule();
 
 			/*
diff -puN fs/fs-writeback.c~pdflush-blockage-check fs/fs-writeback.c
--- 25/fs/fs-writeback.c~pdflush-blockage-check	2004-02-19 18:22:25.000000000 -0800
+++ 25-akpm/fs/fs-writeback.c	2004-02-19 18:22:43.000000000 -0800
@@ -279,6 +279,8 @@ sync_sb_inodes(struct super_block *sb, s
 		}
 
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
+			if (current_is_pdflush())
+				printk("saved pdflush\n");
 			wbc->encountered_congestion = 1;
 			if (sb != blockdev_superblock)
 				break;		/* Skip a congested fs */

_

