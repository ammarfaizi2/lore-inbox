Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVDRMbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVDRMbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVDRMbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:31:16 -0400
Received: from [213.170.72.194] ([213.170.72.194]:35487 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262048AbVDRMbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:31:08 -0400
Subject: Re: [PATC] small VFS change for JFFS2
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@lists.infradead.org
In-Reply-To: <20050418115220.GA22750@infradead.org>
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
	 <20050418085121.GA19091@infradead.org>
	 <1113814730.31595.6.camel@sauron.oktetlabs.ru>
	 <20050418105301.GA21878@infradead.org>
	 <1113824781.2125.12.camel@sauron.oktetlabs.ru>
	 <20050418115220.GA22750@infradead.org>
Content-Type: text/plain
Organization: MTD
Date: Mon, 18 Apr 2005 16:31:06 +0400
Message-Id: <1113827466.2125.47.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 12:52 +0100, Christoph Hellwig wrote:
> Oh, I thought the problem is that JFFS2 thought an inode was freed when
> it still was in use.  So you're problem is actually that it's no in the
> hash anymore but you don't know yet?
Yes, exactly. VFS developers may always say "it is your problem -
redesign JFFS2", but I think it is too late to redesign it.

> Anyway, please explain in detail why you need all this information, what
> errors you see, etc so we can find a way to fix it properly.
Well, I suspect I explained why I need the mutex. If people will find
the explanation vague, I'll make another attempt.

The error I see is:

Eep. Trying to read_inode #15601 when it's already in state 2!

I debugged this a lot before I've realized the reason. And I believe I
know JFFS2 very well to claim that redesigning it is very painful. 

The erroneous  code flow is like this:

kswapd: removes the inode 15601 from the inode hash (inode.c:478).
kswapd: is preempted at inode.c:485
JFFS2 writer: awakes, runs GC to reclaim some space.
JFFS2 writer: picks a JFFS2 node belonging to the inode 15601
JFFS2 writer: looks at the inode state, realizes it is in state PRESENT,
i.e. it is in the inode cache (which is wrong).
JFFS2 writer: runs iget() to acquire a pointer to the struct inode of
the inode 15601.
JFFS2 writer: iget() calls ->read_inode(), i.e., jffs2_read_inode().
JFFS2 writed: JFFS2 is surprised why read_inode() is called for the
already built inode 15601.

Or may be VFS is buggy, I'm not sure. May be it shouldn't remove inode
from the inode hash in that point (inode.c:487). It sets the I_FREENG
state to the inode being freed, and iget() may wait in find_inode_fast()
while the inode is actually destroyed (inode.c:562). The inode may be
removed from the inode hash later, in dispose_list() (inode.c:292).

Or may be this isn't a bug but a feature to make the inode_lock less
contended. Not sure, I'm not a VFS guru.

In that above described case the code flow would be:

kswapd: remove inode 15601 from the inode hash (inode.c:478).
kswapd: preempted at inode.s:485
JFFS2 writer: awakes, runs GC to reclaim some space.
JFFS2 writer: picks a JFFS2 node belonging to inode 15601
JFFS2 writer: looks at the inode state, realizes it is in state PRESENT,
i.e. it is in the inode cache (which is wrong).
JFFS2 writer: runs iget() to get the pointer to the struct inode of the
inode 15601.
JFFS2 writer goes sleep in find_inode_fast(), waiting for freeing
completion.
kswapd: calls dispose_list(), calls clear_inode() for 15601.
JFFS2 writed: read_inode() is called and all is OK since clear_inode()
was called before.

The latter scenario looks very logical for me.

Cheers, Artem.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

