Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUIPWmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUIPWmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268303AbUIPWmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:42:50 -0400
Received: from mail.tmr.com ([216.238.38.203]:37125 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268294AbUIPWlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:41:31 -0400
Date: Thu, 16 Sep 2004 18:34:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jan Kara <jack@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] inotify 0.9
In-Reply-To: <20040916164622.GA28276@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Jan Kara wrote:

> > John McCutchan wrote:
> > >Hello,
> > >
> > >I am releasing a new version of inotify. Attached is a patch for
> > >2.6.8.1.
> <snip>
> 
> > >--MEMORY USAGE--
> > >
> > >The inotify data structures are light weight:
> > >
> > >inotify watch is 40 bytes
> > >inotify device is 68 bytes
> > >inotify event is 272 bytes
> > >
> > >So assuming a device has 8192 watches, the structures are only going
> > >to consume 320KB of memory. With a maximum number of 8 devices allowed
> > >to exist at a time, this is still only 2.5 MB
> > >
> > >Each device can also have 256 events queued at a time, which sums to
> > >68KB per device. And only .5 MB if all devices are opened and have
> > >a full event queue.
> > >
> > >So approximately 3 MB of memory are used in the rare case of 
> > >everything open and full.
> > >
> > >Each inotify watch pins the inode of a directory/file in memory,
> > >the size of an inode is different per file system but lets assume
> > >that it is 512 byes. 
> > >
> > >So assuming the maximum number of global watches are active, this would
> > >pin down 32 MB of inodes in the inode cache. Again not a problem
> > >on a modern system. 
> > 
> > Did you work for Microsoft? Bloat doesn't count? And is this going to be 
> >  low memory you pin? And is every file create or delete (or update of 
> > atime) going to blast this mess through cache looking for people to notify?
> > >
> > >On smaller systems, the maximum watches / events could be lowered
> > >to provide a smaller foot print.
> > 
> > Let's rethink this and say the max is by default and by use of proc or 
> > sys or whatever's in vogue today you can enable the feature by setting a 
> > non-zero value.
>   As I understand the patch it won't have any nontrivial memory
> footprint in case you won't use inotify. Only in case someone wants to
> watch inode, appropriate structure is allocated, inode pined etc. The
> numbers above are in the case you watch maximum possible number of
> inodes etc...

The point I was making is that this doesn't scale well, because it eats
resources which may be unavailable on many systems, and which others are
trying to conserve. Since this may limit the use it presents a problem
with usefulness.

>   Maybe you should not be so fast in using your flamethrower;)

I didn't intend this as a flame, but I do feel this implementation doesn't
scale. I offered another approach off the top of my head, which appears to
me to be more scalable. I claimed no expertise, I just made a suggestion,
based on my first thought on how I would attack the problem in a way which
appears more scalable.

If we are going to 4k stack because larger memory blocks are hard to find,
I have to suspect that anything which locks up blocks size in MB is going
to cause problems. I didn't even ask what would happen on NUMA machines,
because that's not my usual concern.

I'm still horified by the memory requirements :-(

> -- 
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
> 

Thanks for taking the time to note that my tone may have been harsh even
if my point was valid.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

