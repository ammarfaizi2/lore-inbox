Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280161AbRKEDc5>; Sun, 4 Nov 2001 22:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280162AbRKEDcs>; Sun, 4 Nov 2001 22:32:48 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6642
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280161AbRKEDcm>; Sun, 4 Nov 2001 22:32:42 -0500
Date: Sun, 4 Nov 2001 19:32:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011104193232.A16679@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 06:13:19PM -0800, Andrew Morton wrote:
> I've been taking a look at one particular workload - the creation
> and use of many smallish files.  ie: the things we do every day
> with kernel trees.
> 
> There are a number of things which cause linux to perform quite badly
> with this workload.  I've fixed most of them and the speedups are quite
> dramatic.  The changes include:
> 
> - reorganise the sync_inode() paths so we don't do
>   read-a-block,write-a-block,read-a-block, ...
>

Why can't the elevator do that?  I'm all for better performance, but if
the elevator can do it, then it will work for other file systems too.

> - asynchronous preread of an ext2 inode's block when we
>   create the inode, so:
> 
>   a) the reads will cluster into larger requests and
>   b) during inode writeout we don't keep stalling on
>      reads, preventing write clustering.
>

This may be what is inhibiting the elevator...

> The above changes are basically a search-and-destroy mission against
> the things which are preventing effective writeout request merging.
> Once they're in place we also need:
> 
> - Alter the request queue size and elvtune settings
>

What settings are you suggesting?  The 2.4 elevator queue size is an
order of magnatide larger than 2.2...

> 
> The time to create 100,000 4k files (10 per directory) has fallen
> from 3:09 (3min 9second) down to 0:30.  A six-fold speedup.
>

Nice!

> 
> All well and good, and still a WIP.  But by far the most dramatic
> speedups come from disabling ext2's policy of placing new directories
> in a different blockgroup from the parent:
[snip]
> A significant thing here is the improvement in read performance as well
> as writes.  All of the other speedup changes only affect writes.
> 
> We are paying an extremely heavy price for placing directories in
> different block groups from their parent.  Why do we do this, and
> is it worth the cost?
>

My God!  I'm no kernel hacker, but I would think the first thing you would
want to do is keep similar data (in this case similar because of proximity
in the dir tree) as close as possible to reduce seeking...

Is there any chance that this will go into ext3 too?

Mike
