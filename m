Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269255AbUI3NXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269255AbUI3NXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269259AbUI3NXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:23:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53399 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269255AbUI3NXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:23:33 -0400
Date: Thu, 30 Sep 2004 14:23:10 +0100
Message-Id: <200409301323.i8UDNAR3004753@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 0/10]: Cleanup online reservations for 2.6.9-rc2-mm4.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches to follow clean up a lot of the ext3 online reservation
code in 2.6.9-rc2-mm4.  There are a few minor fixes for things like
loglevels of printks and correcting some error returns, plus
refactoring a bit of existing ext3 code to allow resize to avoid dummy
on-stack inodes. 

There's also a review of the whole SMP locking of the resize.  Locking
is minimised: the impact on the hot path consists of nothing more than
an smp_rmb() before we test sb->s_groups_count.  That's a noop on x86,
but is a bit expensive on archs with a weak memory order; I've tried to
minimise that by reading it just once where previously it was read each
time round a loop, but I don't see how to avoid the cost entirely.

Finally, sb->s_debts is nuked from ext3.  It's broken already, as per my
email a week or two ago --- the per-group s_debt[] counts never get
modified.  We could probably do with nuking it from ext2 too, as it's
(differently) broken there (performs unlocked byte inc/dec operations on
a shared array and is vulnerable to word-tearing problems.)

This should address all of the points akpm had in his review of resize
a while back, except for the documentation/user space side of things
and the lack of error checking in certain ext3_journal_dirty_metadata
calls: I'm still fixing those up (I'll try to push out a working
user-space for this later today.)


