Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWFKIWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWFKIWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 04:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWFKIWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 04:22:17 -0400
Received: from science.horizon.com ([192.35.100.1]:46150 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750820AbWFKIWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 04:22:17 -0400
Date: 11 Jun 2006 04:22:15 -0400
Message-ID: <20060611082215.7622.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We seem to be lagging behind "the industry" in some areas - handling large
> devices, high bandwidth IO, sophisticated on-disk data structures, advanced
> manageability, etc.

Er... I would like to point out that "sophisticated on-disk data
structures" are, in and of themselves, a Bad Thing.  It's only when
they provide some desirable capability that they earn their cost in
implementation difficulty, code size, and bug rate.


ZFS is interesting, and I Really Really Like its reliability guarantees,
but I notice that, due to the append-only nature of its operation,
it's extraordinarily difficult to move data once it's been written.
This makes migrating a file system off of old nasty disks to big new
disks rather annoying.  If you know before you add the new drives, you
can physically mirror the old disks and avoid changing block pointers,
but I'd wish for something more flexible.

Because block pointers are physical, and all checksummed, moving a
single block requires rewriting the root block of every snapshot that
contains that block.  Now, you can keep an index of "old block X is now
in new location Y" while walking the entire file system until you're
sure that all the old pointers are gone, but it's hard to preallocate
that index, because you also have to know that "old pointer block X
has been recreated at new location Y, but its contents are different;
only the logical content is the same", and there's no obvious way to
bound the number of such forwarding notes that need to be made.

You must have such an index, or you can't preserve sharing while you
migrate the data.

H'm... for sane efficiency, you also need to keep track of all metadata
blocks that have been examined and NOT changed, so when you hit them again
traversing the file system structure DAG, you know that you can stop.
Between the two, this amounts to every metadata block on the file system.
Wow!

Well, at least that gives you an upper limit on the size needed.
One block forwarding entry per data block on the migrated-from disk,
plus one index-forwarding entry (which may be larger, if it contains
the new block checksum) for each index block on the entire file system.

Ouch.

(And, of course, all of this has to be done on a live file system.)
