Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271121AbTHLVJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271122AbTHLVJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:09:18 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:2030 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S271121AbTHLVJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:09:12 -0400
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
From: Christophe Saout <christophe@saout.de>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3951F1.9040605@tupshin.com>
References: <3F3951F1.9040605@tupshin.com>
Content-Type: text/plain
Message-Id: <1060722538.8344.11.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 12 Aug 2003 23:08:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, 2003-08-12 um 22.45 schrieb Tupshin Harper:

> I have an LVM2 setup with four lvm groups. One of those groups sits on 
> top of a two disk raid 0 array. When writing to JFS partitions on that 
> lvm group, I get frequent, reproducible data corruption. This same setup 
> works fine with 2.4.22-pre kernels. The JFS may or may not be relevant, 
> since I haven't had a chance to use other filesystems as a control. 
> There are a number of instances of the following message associated with 
> the data corruption:
> 
> raid0_make_request bug: can't convert block across chunks or bigger than 
> 8k 12436792 8
> 
> The 12436792 varies widely, the rest is always the same. The error is 
> coming from drivers/md/raid0.c.

Why don't you try using an LVM2 stripe? That's the same as raid0 does.
And I'm sure it doesn't suffer from such problems because it's handling
bios in a very generic and flexible manner.

Looking at the code:

chunk_size = mddev->chunk_size >> 10;
block = bio->bi_sector >> 1;
if (unlikely(chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >>
10))) { ...
/* Sanity check -- queue functions should prevent this happening */
if (bio->bi_vcnt != 1 ||
    bio->bi_idx != 0)
        goto bad_map; /* -> error message */

So, it looks like queue functions don't prevent this from happening.

md.c:
blk_queue_max_sectors(mddev->queue, chunk_size >> 9);
blk_queue_segment_boundary(mddev->queue, (chunk_size>>1) - 1);

I'm wondering, why can't there be more than one bvec?

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

