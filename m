Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVBVBrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVBVBrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 20:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBVBrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 20:47:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:35536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbVBVBrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 20:47:37 -0500
Date: Mon, 21 Feb 2005 17:48:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Merging fails reading /dev/uba1
In-Reply-To: <20050221164151.0a63f906@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502211726510.2378@ppc970.osdl.org>
References: <20050220200059.53db7b1e@localhost.localdomain>
 <20050221075131.GT4056@suse.de> <20050221102431.64de6c6c@localhost.localdomain>
 <Pine.LNX.4.58.0502211152330.2378@ppc970.osdl.org>
 <20050221164151.0a63f906@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Feb 2005, Pete Zaitcev wrote:
> 
> I am surprised too. Jens says "ub effectively disables merging by setting
> max hw/phys segment limit of 1." But surely this ought not to be a problem
> for reads within the same page.

Hmm.. Why does it do that anyway? Jens - will merging take place at all
with that setting, even for physically contiguous segments? It appears 
not, from the timings.

Anyway, I _think_ the bug is in the BIOVEC_VIRT_MERGEABLE() usage, which
doesn't seem to make much sense. In particular, look at 
"ll_merge_requests_fn()", and notice how it first checks whether something 
is physically mergeable, but even if it _is_ able to merge physically, it 
will still check virtual mergeability too - which makes no sense at all.

If it was physically mergeable, there _is_ no virtual merge. In 
particular, a device (or system) that doesn't support virtual merges, or 
only supports them on a page boundary, will always _fail_ to virtually 
merge within the same page, so it's guaranteed to never merge 512-byte 
entries.

Jens, that just _has_ to be wrong. If a physical merge was possible, we 
shouldn't check the virtual merge, we should just return 1.

> > 	int size = 4096;
> > 	ioctl(fd, BLKBSZSET, &size);
> 
> Thank you for the tip. This works fine, 4KB I/O is restored for dd.
> However, I still have this problem with people who use ub to read CF sticks
> from their cameras, mounted as FAT or VFAT. I verified that the effect of
> this ioctl disappears at mount time, just as you said.

Yes. The FAT filesystem needs to set the buffer size to 512 bytes, since 
it will actually act in 512-byte blocks.

> I'll think what I can do about it.

Enable merging is the thing to do. Why does UB have any merging limits at 
all, since USB has to scatter-gather the fragments anyway? 

Anyway, I think you can work around the above virtual merge bug (assuming 
I'm right, and it _is_ a bug, which Jens may or may be able to correct me 
on, depending on just how deep into baby-diapers he is), by just saying 
that UB supports only _one_ physical segment, but can take any number of 
virtual segments.

Ie do

	blk_queue_max_hw_segments(q, 100);
	blk_queue_max_phys_segments(q, 1);

which tells the block layer that you don't care about how hard it is to 
merge things virtually, but you only ever want _one_ physical segment. (At 
which point you will also only really ever get one virtual segment, of 
course, but the point is that you'll avoid the bug that says "I can't 
merge these two things virtually" when you don't care).

Maybe that works, maybe it doesn't. Give it a try.

		Linus
