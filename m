Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbTDAB2W>; Mon, 31 Mar 2003 20:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbTDAB2W>; Mon, 31 Mar 2003 20:28:22 -0500
Received: from [12.47.58.55] ([12.47.58.55]:12001 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261975AbTDAB2U>;
	Mon, 31 Mar 2003 20:28:20 -0500
Date: Mon, 31 Mar 2003 17:39:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
Message-Id: <20030331173920.3ab5a53f.akpm@digeo.com>
In-Reply-To: <3E88EB3D.6020409@cyberone.com.au>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
	<20030328231248.GH5147@zaurus.ucw.cz>
	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>
	<3E8845A8.20107@aitel.hist.no>
	<3E88BAF9.8040100@cyberone.com.au>
	<20030331144500.17bf3a2e.akpm@digeo.com>
	<87el4ngi8l.fsf@enki.rimspace.net>
	<20030331170927.013a0d4a.akpm@digeo.com>
	<3E88EB3D.6020409@cyberone.com.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 01:39:38.0188 (UTC) FILETIME=[8E9FD8C0:01C2F7EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Would the writeout on disk idle solve this without using the fadvise?

Yes it would schedule the I/O in the desired manner.  But it would do that
for _all_ files, not just the desired one.

And that app needs to be changed to use fadvise anyway, to take down the
useless pagecache.

> How often is balance_dirty_pages called? Enough to keep an otherwise
> idle disk busy?

Approximately once per 1000 dirtied pages per cpu.  Say 4 megs.  A nice
chunk.

> Would it be possible to fix the /tmp files case? Could you cancel IO
> to a file that gets deleted?

Well...  One could place a hint in the inode somewhere. 
balance_dirty_pages() is given the inode, so it could notice that this is an
"early sync" inode and flush it every 4 megabytes.

That would be appropriate for O_STREAMING, which is a better and more
efficient interface than fadvise.

But really, the right thing to do here is to modify the app to use fadvise.

> On a similar note, would it be useful and not difficult to do
> speculative LIFO swapin in case of lots of free memory and an idle
> disk? Probably too hard. I guess lowering swapiness would help.

Might do.  I'm not sure how though.

Another possibility would be to perform speculative writes.  Write some
random data to a disk block and later see if that was the data which the
application actually wanted to write.  If so, we can optimise away the later
I/O.

