Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTDECNS (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 21:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTDECNS (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 21:13:18 -0500
Received: from [12.47.58.55] ([12.47.58.55]:9050 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261773AbTDECNO (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 21:13:14 -0500
Date: Fri, 4 Apr 2003 18:25:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error whilst running "tune2fs -j"
Message-Id: <20030404182536.64e120b2.akpm@digeo.com>
In-Reply-To: <5750000.1049507953@flay>
References: <5880000.1049498738@flay>
	<20030404155633.29ed6f8a.akpm@digeo.com>
	<5750000.1049507953@flay>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 02:24:38.0271 (UTC) FILETIME=[81A6D0F0:01C2FB1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > Can you reproduce it?
> 
> Not easily, I fear ... since it's a pain in the butt to remove an ext3
> journal on the root fs once mounted. I suppose I could boot from CD
> or something ... will try to recreate on a less valuable box over
> the weekend ;-)
> 
> I had been having some other trouble with the fs (power cycled a couple
> of times for silly reasons), but it had just ext2 fscked. I suppose there
> *might* have been some corruption, but seems unlikely.
> 

OK.  Please add the below to your patchset.  I've had this in -mm for *ages*,
precisely because this problem was reported a single time, maybe four months
ago.

I have not had a report of it triggering since then.  I'd like to know what
block number it was.

diff -puN fs/buffer.c~buffer-debug fs/buffer.c
--- 25/fs/buffer.c~buffer-debug	2003-04-02 22:24:27.000000000 -0800
+++ 25-akpm/fs/buffer.c	2003-04-02 22:24:27.000000000 -0800
@@ -397,6 +397,9 @@ __find_get_block_slow(struct block_devic
 		bh = bh->b_this_page;
 	} while (bh != head);
 	buffer_error();
+	printk("block=%llu, b_blocknr=%llu\n",
+		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
+	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
 	page_cache_release(page);

_

