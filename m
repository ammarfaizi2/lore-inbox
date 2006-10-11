Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030630AbWJKGJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030630AbWJKGJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030647AbWJKGJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:09:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6090 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030630AbWJKGJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:09:16 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 11 Oct 2006 16:09:01 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 000 of 4] Introduction
Message-ID: <20061011155522.7915.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following 4 patches address issues with lockdep, particularly around bd_mutex.

They are against 2.6.18-mm3 and do *not* apply against -linus as -mm already has
some changes to the handling of bd_mutex nesting.  2-4 probably apply on top of -linus plus
-mm/broken-out/remove-the-old-bd_mutex-lockdep-annotation.patch  

I believe they are probably ok for 2.6.19.

The core issue is that blkdev_get when called on a partition needs to
lock (bd_mutex) the partition and the whole device.  lockdep would
normally see this as a possible deadlock and needs to be told that
this particular nesting is known to be safe.

The code to do this is in -linus is rather messy, largely because the
locking itself is messy.  The bd_mutex for the whole is taken several
times while bd_mutex for the partition is held, and it is taken at
both levels of the recursion (blkdev_get calls blkdev_get - only to
one level).

As key observation to simplifying the locking is to observer that a
lot of the locking is there to protect the updating of bd_part_count.
If those updates are moved, the locking can become simpler.

The first patch removes the current approach in -mm to handling this
nesting and explains why it is not ideal.
This reverts new-bd_mutex-lockdep-annotation.patch

The second simplifies the locking as explained above.

The third adds the mutex_lock_nested annotations, which are now trivial.

The last fixes a tangentially related lockdep problem in md - there is
a false relationship between bd_mutex and md->reconfig_mutex which
needs to be clarified.

 [PATCH 000 of 4] Introduction
 [PATCH 001 of 4] Remove lock_key approach to managing nested bd_mutex locks.
 [PATCH 002 of 4] Simplify some aspects of bd_mutex nesting.
 [PATCH 003 of 4] Use mutex_lock_nested for bd_mutex to avoid  lockdep warning.
 [PATCH 004 of 4] Avoid lockdep warning in md.
