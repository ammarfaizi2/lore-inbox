Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbUKQTmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUKQTmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUKQTkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:40:35 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:52249 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262491AbUKQThq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:37:46 -0500
Date: Wed, 17 Nov 2004 19:37:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Terence Ripperda <tripperda@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: loops in get_user_pages() for VM_IO
In-Reply-To: <20041117164037.GD5114@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0411171841190.1767-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Andrea Arcangeli wrote:
> On Wed, Nov 17, 2004 at 02:44:08PM +0100, Andrea Arcangeli wrote:
> > this would be the full port against mainline:
> 
> while it's not necessary with mlockall (since we walk each vma in
> mlock.c before calling make_pages_present), I've to agree having a more
> generic implementation of get_user_pages that doesn't stop on VM_IO with
> pages = NULL, sounds a nicer API (even if nobody uses that
> functionality). Still I'd leave make_pages_present void.  Andrew's patch
> had two bugs: it didn't check for "len" underflow and it used vm_start
> instead of start to calculated the current page walk under VM_IO, plus
> it did the same checks more than once for no good reason.  I also
> believe it's broken to have "len" as an int, should be unsigned long
> even if it's in page_size units (64bit would overflow with huge user
> address space). This is my current status. Comments? (still I don't see
> any value in returning any error from make_pages_present, nobody is
> checking that anyways, in my tree the only error that could really
> happen in find_vma was turned down for some unknown reason by some
> random patch, I mean, mlock.c already does all the checks and returns
> -ENOMEM if the mlock range is outside vmas, make_pages_present should
> just do its job, we're under the mmap sem so nothing can change to
> prevent make_pages_present to do its job)

I pretty much agree with everything you've said here, but...

It's three patches: void make_pages_present(), stepping over VM_IO
in get_user_pages(), and unsigned long nr_pages to get_user_pages.

I love the void make_pages_present(): at present it returns 0,
error code or -1 - was that really supposed to mean -EPERM?
What happens if someone tries to make_pages_present() more than
is physically available?  I think get_user_pages() returns -ENOMEM,
the intervening levels ignore that, the process then gets OOM-killed.
If that's acceptable, then I'd think just go with the simple patch,
void make_pages_present(), for 2.6.10.

Stepping over VM_IO in get_user_pages(): yes, I agreed with Andrew's
take on that (mlockall must not fail just because there's a VM_IO in
the address space), and I agree with your fixes to his draft.  But
if we accept your void make_pages_present(), then we're left with
no uses for that code right now.  Better leave out the additonal
complexity until it's needed?  make_pages_present() already has a
BUG for end > vma->vm_end.

The unsigned long nr_pages to get_user_pages().  That looks incomplete
to me: isn't there an mm/nommu.c version which needs patching too?
and I think you'd better make it a long rather than an unsigned long,
because you also need to change the return value from int to long
(though most callers are safe to stick with assigning it to an int).
Is this a change that 2.6.10 would really need?

I've copied Terence partly to allow me to apologize: it wasn't until
DaveM's mail that I realized that most of these problems suddenly
arose from my copying vma->vm_flags back to vm_flags at the end of
do_mmap_pgoff - I was trying to avoid vm_stat inconsistencies and
vma_merge mismerges, was quite unconscious of this side-effect at
the time - sorry.  But Andrea's mlock and mlockall considerations
show that it was a latent problem even without my change there.

It is a good idea not to put VM_LOCKED on the VM_IO regions, since
their pages get counted out of locked_vm (without a prior check).
We could fix that by carefully checking for VM_IO everywhere we
manipulate VM_LOCKED, but tiresome, let's not bother until someone
complains of a real case where VM_IO is really using up too much
locked_vm.  We certainly shouldn't hang on VM_LOCKED|VM_IO areas.

(I do wonder whether the VM_IO added in remap_pfn_range will stop
someone from doing a get_user_pages on an area they could do it on
before - the rvmalloc'ed cases, for example, don't really need VM_IO
protection.  But that's a different issue, no complaints heard yet.)

Hugh

