Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281998AbRKZSTC>; Mon, 26 Nov 2001 13:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282013AbRKZSSM>; Mon, 26 Nov 2001 13:18:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49120 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281997AbRKZSQU>;
	Mon, 26 Nov 2001 13:16:20 -0500
Date: Mon, 26 Nov 2001 21:13:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: "David S. Miller" <davem@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <200111261808.fAQI8KK26768@ns.caldera.de>
Message-ID: <Pine.LNX.4.33.0111262106490.17043-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Christoph Hellwig wrote:

>  - do_generic_file_read() now takes an additional integer parameter,
>    'nonblock'.  This one always is zero, though.  Why do you break
>    the interface?

this is just the first, more important half of O_NONBLOCK support for
block IO. Some servers (squid, TUX) rely on it for good performance.

>  - there is a new global function, flush_inode_pages().  It is not
>    used at all.  What is this one supposed to do?

it's for TUX's logfiles - the log file can grow to many gigabytes without
polluting the pagecache. I think a new syscall should also use this:
sys_flushfile(fd,offset,size), so that user-space servers can make use of
this feature as well. If anyone is interested in actually using this new
system-call then i can add those few additional lines. (other applications
could use it as well, eg. clustered databases to invalidate database
caches - but for this purpose the function has to become a bit more
strict.)

>  - file_send_actor() is no more static in mm/filemap.c.  I'm perfectly
>    fine with that as I will need that for the UnixWare sendv64 emulation
>    in Linux-ABI, but again no user outside of filemap.c exists.

a TUX thing again, you are right, it makes no sense otherwise.

>  - you change a number of parameters called 'offset' into 'index',
>    this makes sense to me, but doesn't really belong into this diff..

these are cleanups triggered by a bug i did: 'offset' was not consistently
used as the byte granularity thing, it was used as a page granularity
index once, which caused a bug in an earlier version of the patch.

>  - due to the additional per-bucket spinlock the pagecache size
>    dramatically increases.  Wouldn't it be a good idea to switch to
>    bootmem allocation so very big machines still can have the full
>    size, not limited by __get_free_pages failing?

for this purpose i wrote memarea_alloc() - bootmem IMO should remain a
limited boot-time helper, not a full-blown allocator.

	Ingo

