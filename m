Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbSJTNH3>; Sun, 20 Oct 2002 09:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbSJTNH3>; Sun, 20 Oct 2002 09:07:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57913 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262490AbSJTNH2>; Sun, 20 Oct 2002 09:07:28 -0400
Date: Sun, 20 Oct 2002 14:14:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: mingming cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>
Subject: Re: [PATCH]IPC locks breaking down with RCU
In-Reply-To: <3DAF5266.3F606821@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210201346180.1710-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, mingming cao wrote:
> Hi Linus,
> 
> This is the latest version of the ipc lock patch.  It breaks down the
> three global IPC locks into one lock per IPC ID,  also addresses the
> cache line bouncing problem  introduced in the original patch. The
> original post could be found at:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102980357802682&w=2
> 
> The original patch breaks down the global IPC locks, yet added another
> layer of locking to protect the IPC ID array in case of resizing. Some
> concern was raised that the read/write lock may cause cache line
> bouncing.
> 
> Since write lock is only used when the array is dynamically resized, 
> RCU seems perfectly fit for this situation.  By doing so it could reduce
> the possible lock contention in some applications where the IPC
> resources are heavily used, without introducing cache line bouncing.
> 
> Besides the RCU changes, it also remove the redundant ipc_lockall() and
> ipc_unlockall() as suggested by Hugh Dickins.
> 
> Patch is against 2.5.43 kernel. It requires Dipankar Sarma's
> read_barrier_depends RCU helper patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103479438017486&w=2
> 
> We use the ipc lock on OracleApps and it gave us the best number. 
> Please include.

This looks very good to me: I'm glad you found the RCU idea works out.
No need for performance numbers, this is now clearly the right way to
go.  And read_barrier_depends is in 2.5.44, so no problem there.

I'm ignorant of RCU, and my mind goes mushy around memory barriers,
but I expect you've consulted the best there; and I'll be wanting to
refer to this implementation as a nice example of how to use RCU.
But please make a couple of small cleanups, unless you disagree.

Now delete spinlock_t ary and all references to it: only grow_ary
is using it, and it's already protected by sem, and we'd be in
trouble with concurrent allocations if it were not.

And I'd be happier to see ipc_unlock without those conditionals i.e.
delete the "if(lid >= ids->size) return;" and the "if (out)" - they
seem to encourage calling ipc_unlock where ipc_lock did not succeed,
but that would be unsafe.  If you found somewhere that's being done,
I think we need to fix that place, not work around it in ipc_unlock.

Linus is away this week (so I've left him off, to avoid clogging up
/dev/null): perhaps Andrew could take your patch into his -mm tree
when you've made those changes (or persuaded us against)?

Hugh

