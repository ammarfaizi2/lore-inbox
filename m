Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbUKWSdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUKWSdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUKWScT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:32:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:27786 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261479AbUKWSbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:31:42 -0500
Date: Tue, 23 Nov 2004 18:31:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Michael Kerrisk <mtk-lkml@gmx.net>, <torvalds@osdl.org>,
       <michael.kerrisk@gmx.net>, <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH 2.6.10-rc2] RLIMIT_MEMLOCK accounting of shmctl() SHM_LOCK
    is broken
In-Reply-To: <20041123090449.1672494f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0411231812180.3050-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Andrew Morton wrote:
> 
> True.  We should make the same change to user_shm_unlock(), and we may as
> well tweak the excessive spinlock coverage in there too.
> ...
> and then ask Hugh and Manfred to double-check.

Looked good to me.

Examining that code for the first time, I did wonder about a couple of
minor irrelevancies with regard to lock_limit - should it too be rounded
up?  Well, not necessarily, you can argue that the limit should be treated
strictly.  And it certainly shouldn't be rounded up (wrapping to 0) if it's
RLIM_INFINITY.  Which raises the question, should we avoid shifting it
down if it's RLIM_INFINITY?  And should there be a wrapping check on
locked + user->locked_shm?  Well, locking that much memory will meet
its own problems, probably not worth worrying here.

> Looking at the callers, we do:
> 
> 	user_shm_lock(inode->i_size, ...);
> 
> then, later:
> 
> 	user_shm_unlock(inode->i_size, ...);
> 
> which does make one wonder "what happens if the file got larger while it
> was locked"?

They're only used on objects created by shmem_file_setup, and for those
(unlike tmpfs files) there's no interface by which they might change
their size after creation; and this isn't the only place which assumes
that characteristic.  So, it's okay (but not at all obvious).

Hugh

