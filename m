Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTAXTDV>; Fri, 24 Jan 2003 14:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbTAXTDV>; Fri, 24 Jan 2003 14:03:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:45781 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261934AbTAXTDU>;
	Fri, 24 Jan 2003 14:03:20 -0500
Date: Fri, 24 Jan 2003 11:12:49 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: bzzz@tmi.comex.ru, linux-kernel@alex.org.uk, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
Message-Id: <20030124111249.227a40d6.akpm@digeo.com>
In-Reply-To: <m3lm1au51v.fsf@lexa.home.net>
References: <20030123195044.47c51d39.akpm@digeo.com>
	<946253340.1043406208@[192.168.100.5]>
	<20030124031632.7e28055f.akpm@digeo.com>
	<m3d6mmvlip.fsf@lexa.home.net>
	<20030124035017.6276002f.akpm@digeo.com>
	<m3lm1au51v.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 19:12:25.0218 (UTC) FILETIME=[876E7620:01C2C3DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> >>>>> Andrew Morton (AM) writes:
> 
>  AM> That's correct.  Reads are usually synchronous and writes are
>  AM> rarely synchronous.
> 
>  AM> The most common place where the kernel forces a user process to
>  AM> wait on completion of a write is actually in unlink (truncate,
>  AM> really).  Because truncate must wait for in-progress I/O to
>  AM> complete before allowing the filesystem to free (and potentially
>  AM> reuse) the affected blocks.
> 
> looks like I miss something here.
> 
> why do wait for write completion in truncate? 

We cannot free disk blocks until I/O against them has completed.  Otherwise
the block could be reused for something else, then the old IO will scribble
on the new data.

What we _can_ do is to defer the waiting - only wait on the I/O when someone
reuses the disk blocks.  So there are actually unused blocks with I/O in
flight against them.

We do that for metadata (the wait happens in unmap_underlying_metadata()) but
for file data blocks there is no mechanism in place to look them up.
