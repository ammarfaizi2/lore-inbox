Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSGMNJ5>; Sat, 13 Jul 2002 09:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSGMNJ4>; Sat, 13 Jul 2002 09:09:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50363 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312254AbSGMNJx>; Sat, 13 Jul 2002 09:09:53 -0400
Date: Sat, 13 Jul 2002 14:11:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: davidm@hpl.hp.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: MAP_NORESERVE with MAP_SHARED
In-Reply-To: <200207122039.g6CKdnV3004060@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.21.0207131308400.1572-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, David Mosberger wrote:
> Is there a good reason why the MAP_NORESERVE flag is ignored when
> MAP_SHARED is specified?  (Hint: it's the call to vm_enough_memory()
> in shmem_file_setup() that's causing MAP_NORESERVE to be ignored.)

Normally MAP_NORESERVE has no effect when MAP_SHARED is specfied,
since mods will be written out to file, so don't need memory+swap.

You're looking at the special case of a tmpfs file (actually,
the even more special case of an internally created tmpfs file),
which of course needs memory+swap, since it has no disk backing.

But (for whatever this jesuitical argument is worth: probably not
much) it's the object which needs that memory+swap, not the shared
mapping of that object.  Should MAP_NORESERVE apply to the object
in this case?  At this moment, I'm uncertain (but since the object
has been created internally purely to provide that mapping, it may
be unhelpful to deny it).

You were writing of mainline 2.4 or 2.5, where reservation isn't
taken seriously anyway.  It becomes more serious in the -ac tree,
or with rml's patch, where it's more than a question of MAP_NORESERVE.
Check /proc/meminfo Committed_AS and you'll find we reserve twice the
size of a shared anonymous mapping (in this tree, do_mmap_pgoff
is calling vm_enough_memory even when MAP_SHARED but file NULL,
then it's called again as you found in shmem_file_setup).
But at least the numbers do balance out when unmapping.

I'll take another look at this in a few days, right now I'm a
little confused by it.  Just dropping check from shmem_file_setup
won't be the answer, I believe SysV IPC SHM needs it, and in
ac/rml it's needed to balance removal of the object.
Thanks for raising the issue.

Hugh

