Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161580AbWI2Tm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161580AbWI2Tm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161585AbWI2Tm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:42:26 -0400
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:43701 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1161573AbWI2TmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:42:24 -0400
Date: Fri, 29 Sep 2006 20:41:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Neil Brown <neilb@suse.de>
cc: Andrew Morton <akpm@osdl.org>, "David M. Grimes" <dgrimes@navisite.com>,
       Atal Shargorodsky <atal@codefidence.com>,
       Gilad Ben-Yossef <gilad@codefidence.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 001 of 8] knfsd: Add nfs-export support to tmpfs
In-Reply-To: <17692.49605.248998.607609@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0609292014160.23046@blonde.wat.veritas.com>
References: <20060929130518.23919.patches@notabene> <1060929030839.24024@suse.de>
 <20060928232953.6da08f19.akpm@osdl.org> <17692.49605.248998.607609@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Sep 2006 19:40:55.0911 (UTC) FILETIME=[2E457F70:01C6E3FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Neil Brown wrote:
> On Thursday September 28, akpm@osdl.org wrote:
> > 
> > Why don't other filesystems have the same problem?
> 
> Because most filesystems that hash their inodes do so at the point
> where the 'struct inode' is initialised, and that has suitable locking
> (I_NEW).  Here in shmem, we are hashing the inode later, the first
> time we need an NFS file handle for it.  We no longer have I_NEW to
> ensure only one thread tries to add it to the hash table.
> 
> The comment tries to explain this, but obviously isn't completely
> successful.

That makes sense.

This patch looks mostly good to me, thanks to David and you for it;
and my apologies to Atal and Gilad for never quite getting around
to looking at theirs properly (but the hashing in this new one does
look better than their linear search).  Though I know tmpfs, I
don't know NFS, so I'm glad this is coming from your direction.

But one anxiety, regarding i_ino.  That's an unsigned long originating
from last_inode in fs/inode.c, isn't it?  Here getting cast to a __u32
to make up one part of the file handle, which will then be cast back
to an unsigned long for ilookup later.

So on 64-bit arches, it'll only take one dedicated creator and
deleter of files to advance the last_inode count to the point where
the high int is non-zero, and shmem_get_dentry won't ever recognize
any inodes created thereafter, always reporting -ESTALE?  I'm on
unfamiliar territory, but it looks to me like we need another
__u32 in the file handle to cope with that?

Then there's the lesser but more tiresome problem, of i_ino collisions
on 32-bit arches.  tmpfs hasn't worried about that to date, just taken
whatever new_inode() has given it from last_inode: but perhaps these
file handles now make that more of a concern?

Hugh
