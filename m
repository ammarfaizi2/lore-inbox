Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUDONAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDONAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:00:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53679
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263825AbUDONAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:00:24 -0400
Date: Thu, 15 Apr 2004 15:00:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <20040415130028.GB2150@dualathlon.random>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain> <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu> <69200000.1081804458@flay> <Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu> <20040415000529.GX2150@dualathlon.random> <Pine.GSO.4.58.0404142323160.21462@sapphire.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0404142323160.21462@sapphire.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 11:40:52PM -0400, Rajesh Venkatasubramanian wrote:
> 
> > >   2) However, vmas can be added and removed from a vm_set list
> > >      by just holding the read lock and a bit lock (vm_set_lock)
> > >      in the corresponding prio_tree node.
> >
> > no way, you cannot bitflip vm_flags unless you own the mmap_sem, this
> > patch seems very broken to me, it should randomly corrupt memory in
> > vma->vm_flags while racing against mprotect etc.. or am I missing
> > something?
> 
> I don't know why bit_spin_lock with vma->vm_flags should be a problem
> if it is used without mmap_sem. Can you explain ?

you seem not to know all rules about the atomic operations in smp, you
cannot just set_bit on one side and use non-atomic operations on the
other side, and expect the set_bit not to invalidate the non-atomic
operations.

The effect of the mprotect may be deleted by your new concurrent
set_bit and stuff like that.

> If it is really racy to use bit_spin_lock on vm_flags without mmap_sem

it __definitely__ is racy.

> Well. In that case, we can use rwsem as you mentioned below: take
> down_write on all modifications and take down_read on pageout. Here, you

exactly, this also avoids the more complex (and racy, but the racy would
be easy to fix by adding another 4 atomic bytes to the vma) double
locking that you introduced.

> allow multiple parallel page_referenced and try_to_unmap on the same
> inode, however with only one modification at a time.

exactly.

> Wherease my solution will allow multiple modifications at the same
> time (if possible) with only one pageout routine at a time. I chose
> this solution because Martin's SDET took big hit in common cases of
> adding and removing vmas from the i_mmap{_shared} data structure.

you can still fix the smp race condition by trivially adding 4 bytes to
the vma (i.e. a vma->vm_flags_atomic), but I'd be surprised if your
double locking actually improve things, Martin is running on a very
parallel old-numa where cacheline bouncing across nodes pass through a
fibre channel IIRC, and the cacheline bouncing that the semaphore
generates is huge, it's not necessairly huge contention, it's just the
bouncing that hurts, and the down_read won't help at all for the
cacheline trashing, it'll still bounce like before. Though you may gain
something minor, but I doubt it'd be huge.

I'd suggest Martin to give a try to the racy code, it's just good enough
for a pratical experiment (the race shouldn't easily trigger so it
probably passes one run of SDET safely).
