Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbTA2VPx>; Wed, 29 Jan 2003 16:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTA2VPx>; Wed, 29 Jan 2003 16:15:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:2192 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266721AbTA2VPw>;
	Wed, 29 Jan 2003 16:15:52 -0500
Date: Wed, 29 Jan 2003 13:42:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH 2.5] Report write errors to applications
Message-Id: <20030129134205.3e128777.akpm@digeo.com>
In-Reply-To: <20030129162411.GB3186@waste.org>
References: <20030129060916.GA3186@waste.org>
	<20030128232929.4f2b69a6.akpm@digeo.com>
	<20030129162411.GB3186@waste.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2003 21:25:08.0183 (UTC) FILETIME=[E5CB3E70:01C2C7DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> wrote:
>
> > - fsync_buffers_list() will handle them and will return errors to the fsync()
> > caller.  We only need to handle those buffers which were stripped
> > asynchronously by VM activity.
> 
> Are we guaranteed that we'll get a try_to_free_buffers after IO
> completion and before sync? I haven't dug through this path much.

Think so.  That's the only place where buffers are detached.  Otherwise,
fsync_buffers_list() looks at them all.

There's also the prune_icache() buffer-stripper remove_inode_buffers(). 
Nobody knows about the inode by that time, but there's a chance that the
inode will be rescued before it is thrown away, so remove_inode_buffers()
should propagate errors into the address_space as well.

> Another 2.5 change I hadn't noticed. Ok, will look at that. I haven't
> come up with a good test for the writepage ENOSPC, thoughts?

See kswapd-writepage.c from
http://www.zip.com.au/~akpm/linux/patches/2.5/ext3-tools.tar.gz

If you run that over a filesystem which has only a few K of space, apply
memory pressure while it is sleeping then data loss will ensue.

hm, there's also enospc-writepage.c which is designed to exactly demonstrate
this problem.


