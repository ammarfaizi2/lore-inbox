Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293556AbSCLWuM>; Tue, 12 Mar 2002 17:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293726AbSCLWt4>; Tue, 12 Mar 2002 17:49:56 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:37518 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293556AbSCLWtd>; Tue, 12 Mar 2002 17:49:33 -0500
Date: Tue, 12 Mar 2002 17:48:47 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org, aviro@math.psu.edu
Subject: Re: [RFC] write_super is for syncing
Message-ID: <212850000.1015973327@tiny>
In-Reply-To: <3C8E7E0C.816A3527@zip.com.au>
In-Reply-To: <205630000.1015970453@tiny> <3C8E7E0C.816A3527@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, March 12, 2002 02:15:40 PM -0800 Andrew Morton <akpm@zip.com.au> wrote:

> Chris Mason wrote:
>> 
>> Hi everyone,
>> 
>> The fact that write_super gets called for both syncs and periodic
>> commits causes problems for the journaled filesystems, since we
>> need to trigger commits on write_super to have sync() behave
>> properly.
>> 
>> So, this patch adds a new super operation called commit_super,
>> and extends struct super.s_dirt a little so the filesystem
>> can say: call me on sync() but don't call me from kupdate.
>> 
>> if (s_dirt & S_SUPER_DIRTY) call me from kupdate and on sync
>> if (s_dirt & S_SUPER_DIRTY_COMMIT) call me on sync only.
>> 
> 
> I'm not quite sure why these flags exist?  Would it not be
> sufficient to just call ->write_super() inside kupdate,
> and ->commit_super in fsync_dev()?  (With a ->write_super
> fallback, of course).

fsync_dev(dev != 0) is easy, you can ignore the dirty flag
and call commit_super on the proper device.

But, the loop in sync_supers(dev == 0) is harder, it expects
some flag it can check, and it expects the callback to the FS
will clear that flag.  Adding a new flag seemed like more fun
than redoing the locking and super walk.  I'm curious to hear what 
Al thinks of it though.

-chris

