Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSKHUuo>; Fri, 8 Nov 2002 15:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSKHUuo>; Fri, 8 Nov 2002 15:50:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:16789 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262385AbSKHUun>;
	Fri, 8 Nov 2002 15:50:43 -0500
Message-ID: <3DCC252F.65C0F70B@digeo.com>
Date: Fri, 08 Nov 2002 12:57:19 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ross Biro <rossb@google.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Failed writes marked clean?
References: <3DCC1EB5.4020303@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2002 20:57:19.0427 (UTC) FILETIME=[6D43C930:01C28769]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:
> 
> Perhaps I'm reading the code incorrectly, but in kernel versions 2.4.18
> and 2.5.46 it looks to me like in the case of a write, ll_rw_block
> always clears the dirty bit.  In the event of an error, nothing resets
> the dirty bit and the uptodate flag is cleared.  This means that if the
> same block needs to be read again, the buffer cache will see that the
> buffer is not uptodate and attempt to read the old contents of the
> buffer off of the device.  If the read suceeds the kernel ends up
> corrupting data.

That's correct, for metadata.  It may not be fully accurate for
file data, where the page state comes into play as well.

The handling of IO errors is very weird.  Especially for writes.
And poorly tested.  It needs a big revamp and testing.

> It seems to me that a better solution would be to mark the buffer as
> dirty and uptodate and then attempt to propogate the error as far back
> as possible.  Ideally something can be done to correct the problem at a
> higher level.  Before I dive in and attempt to do something about this,
> I wanted to make sure I was not missing anything important.  So am I
> full of it, or could this really be a problem?
> 

Well before going and changing stuff, we need to decide what to
change it _to_.  What do we want to happen if there's a read error?
And a write error?

For reads, it makes sense for the page/buffer to be left not uptodate,
and return an error.

For write errors, marking the page/buffer not uptodate doesn't make
a lot of sense.  Marking it clean makes sense if we're not going to retry
the write.  Marking it dirty, uptodate and unmapped would make sense
if we want to go and try a different part of the disk.  But it
doesn't make sense if the whole disk is dead.

Also, think about what a write error _means_.  Unless the disk is truly
ancient, it means that the device has run out of alternate space for
the block, or all writes are failing.  ie: it is a serious failure.

So perhaps the appropriate strategy on write errors is to mark the
device readonly and to drop all write data on the floor.  That means
clean+mapped+uptodate.

So yes, I think I agree with myself.  Write errors should leave the
page/buffer clean, uptodate, mapped, PageError (whatever the latter
maens...)
