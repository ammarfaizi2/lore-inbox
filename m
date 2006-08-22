Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWHVHtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWHVHtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWHVHtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:49:04 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:41856 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932116AbWHVHtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:49:02 -0400
To: David Chinner <dgc@sgi.com>
Cc: Nathan Scott <nathans@sgi.com>, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
In-reply-to: <20060814025901.GE51703024@melbourne.sgi.com>
Message-Id: <20060822164847m-saito@mail.aom.tnes.nec.co.jp>
References: <20060814025901.GE51703024@melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Tue, 22 Aug 2006 16:48:47 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan, David,

I had the vacation too.

David Chinner <dgc@sgi.com> wrote:
>Hmmm - Idon't think we should iput() before we wake up any pinned waiters.
>When we have a waiter on i_ipin_wait (called from xfs_iflush()), we have
>a thread sleeping with the inode locked.
>
>If we then call iput() and it drops the last reference, we can call back
>into the filesystem and start transactions. Those transactions will need
>to lock the inode. Hence I think the above can deadlock when racing against
>an inode flush. 
>
>The code should probably read:
>
>	if (dropped last pincount) {
>		int need_iput = 0;
>		struct inode *inode;
>
>		spin_lock(i_flags_lock)
>		if (!reclaimable) {
>			if (!vp) {
>				if (!(i_state & (NEW|CLEAR))) {
>					inode = igrab(inode)
>					if (inode) {
>						need_iput = 1	
>						mark_inode_dirty_sync(inode)
>					}
>				}
>			}
>		}
>		spin_unlock(i_flags_lock)
>		wake_up(&ip->i_ipin_wait)
>		if (need_iput)
>			iput(inode);
>	}
>
>to avoid this possible deadlock.

OK, I see your point.  There is wait_event(in xfs_iunpin_wait) that should
be wake_up'ed(in xfs_iunpin), so deadlock can occur.

I'll update my patch and test it.  Please wait for a few moments.
