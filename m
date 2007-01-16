Return-Path: <linux-kernel-owner+w=401wt.eu-S1750837AbXAPS5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXAPS5o (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbXAPS5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:57:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34338 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbXAPS5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:57:43 -0500
Date: Tue, 16 Jan 2007 13:57:38 -0500
Message-Id: <200701161857.l0GIvcaA016196@dantu.rdu.redhat.com>
From: Jeff Layton <jlayton@redhat.com>
To: akpm@osdl.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] i_ino uniqueness: alternate approach -- hash the inodes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there's been no further comment on these patches, I'm going to resend
them one more time and ask Andrew to commit these to -mm. Once they're in
place there, I'll start working on and sending out follow-on patches to
clean up the other filesystems and ensure that they properly hash their
inodes.

------[snip]-----

Since Joern mentioned that he thought that hashing the inodes might be simpler
and not have a drastic performance impact, I took the liberty of whipping up
some patches that use that approach. They follow in the next set of emails.

To reiterate, the problems are:

1) on filesystems w/o permanent inode numbers, i_ino values can be
larger than 32 bits, which can cause problems for some 32 bit userspace
programs on a 64 bit kernel. We can't do anything for filesystems that have
actual >32-bit inode numbers, but on filesystems that generate i_ino
values on the fly, we should try to have them fit in 32 bits. We could
trivially fix this by making the static counters in new_inode and iunique
32 bits, but...

2) many filesystems call new_inode and assume that the i_ino values they
are given are unique. They are not guaranteed to be so, since the static
counter can wrap. This problem is exacerbated by the fix for #1.

3) after allocating a new inode, some filesystems call iunique to try to
get a unique i_ino value, but they don't actually add their inodes to
the hashtable, and so they're still not guaranteed to be unique if that
counter wraps.

This patch set takes the simpler approach of simply using iunique and
hashing the inodes afterward. Christoph H. previously mentioned that he
thought that this approach may slow down lookups for filesystems that
currently hash their inodes.

The questions are:

1) how much would this slow down lookups for these filesystems?
2) is it enough to justify adding more infrastructure to avoid it?

What might be best is to start with this approach and then only move to using
IDR or some other scheme if these extra inodes in the hashtable prove to be
problematic.

I've done some cursory testing with this patch and the overhead of hashing
and unhashing the inodes with pipefs is pretty low -- just a few seconds of
system time added on to the creation and destruction of 10 million pipes (very
similar to the overhead that the IDR approach would add).

The hard thing to measure is what effect this has on other filesystems. I'm
open to ways to try and gauge this.

Again, I've only converted pipefs as an example. If this approach is
acceptable then I'll start work on patches to convert other filesystems.

Comments and suggestions welcome...

-- Jeff

