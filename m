Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSJMSYV>; Sun, 13 Oct 2002 14:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261580AbSJMSYV>; Sun, 13 Oct 2002 14:24:21 -0400
Received: from packet.digeo.com ([12.110.80.53]:3231 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261576AbSJMSYU>;
	Sun, 13 Oct 2002 14:24:20 -0400
Message-ID: <3DA9BBA6.5F6575AD@digeo.com>
Date: Sun, 13 Oct 2002 11:29:58 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       wagnerjd@prodigy.net, robm@fastmail.fm, hahn@physics.mcmaster.ca,
       linux-kernel@vger.kernel.org, jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <p73elaupzrj.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0210131244110.1242-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 18:29:59.0165 (UTC) FILETIME=[89515AD0:01C272E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On 13 Oct 2002, Andi Kleen wrote:
> >
> > Still in 2.4 the VFS takes the big kernel lock unnecessarily for
> > a few VFS operations (no matter if the underlying FS needs it or not).
> > That's fixed in 2.5.
> 
> Something I was a bit surprised to notice recently: 2.5 still holds
> big kernel lock around the potentially very lengthy vmtruncate() -
> is that one still really necessary at VFS level?
> 

eww..  Truncating 1G of pagecache takes 2.5 seconds on my testbox.
Probably 4 seconds if that pagecache got there via write() (need to
crunch on buffer_heads as well).

There's a cond_resched() after every 16th page in truncate_inode_pages(),
so it won't be very visible to humans.  But a multi-second holdtime is
rather rude.

Certainly we don't need to hold it across truncate_inode_pages(), which
is where the heavy lifting happens.  Probably, we can just push it down
to vmtruncate(), around the i_op->truncate() callout.

But as ever, it's not really clear what the thing is protecting.
