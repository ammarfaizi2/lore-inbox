Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272792AbTHKQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272773AbTHKQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:14:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:2821 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S267952AbTHKQCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:02:16 -0400
Date: Mon, 11 Aug 2003 17:03:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH ?] iprune_sem
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B014053AE@mesadm.epl.prov-liege.be>
Message-ID: <Pine.LNX.4.44.0308111647060.1218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003, Frederick, Fabian wrote:
> 
> 	Someone could tell me why we don't use iprune_sem in get_new_inode
> like this ?
> 	http://fabian.unixtech.be/kernel/inode060803.diff

1. iprune_sem was introduced for a specific umount versus prune race,
   see the comment upon it: no bearing on get_new_inode whatsoever.
2. How would downing a semaphore just before the spin_lock,
   upping it just after the spin_unlock, serve any purpose?
3. If it were useful, it should be upped on the exceptional path too.
4. Don't change "locked inode" comment to "inode unlocked": I_LOCK is set.
5. But worst of all, you remove the whole point of the old = find_inode.

I think you're trying to say, a semaphore (not placed where you have it)
could be used to prevent two tasks from allocating the same inode at the
same time.  Yes, but would single-thread inode allocation disastrously:
much more efficient for both to try and check - as get_new_inode does.

Hugh

