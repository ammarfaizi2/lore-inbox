Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271797AbRIHSG1>; Sat, 8 Sep 2001 14:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbRIHSGR>; Sat, 8 Sep 2001 14:06:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6152 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271797AbRIHSGD>; Sat, 8 Sep 2001 14:06:03 -0400
Date: Sat, 8 Sep 2001 11:01:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010908195730.D11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109081055440.936-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Sep 2001, Andrea Arcangeli wrote:
>
> First of all I just __block_fsync + truncate_inode_pages(inode->i_mapping, 0) so
> all pagecache updates are commited to disk after that, so the latest uptodate
> data is on disk and nothing uptodate is in memory.

Hmm. And if two openers have the device open at the same time? One dirties
data after the first one has done __block_fsync? And the truncate will
throw the dirtied page away?

Now, I don't think we need to be _too_ careful about cache coherency: it's
probably ok to do something like

	__block_fsync(dev) - sync _our_ changes
	invalidate_inode_pages(dev) - this will only invalidate unused pages
	invalidate_device(dev)

But I'd just like to feel really comfortable about it. And part of that is
probably to be simpler rather than be clever..

		Linus

