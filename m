Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTIDMSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTIDMSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:18:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3858 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264940AbTIDMSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:18:51 -0400
Date: Thu, 4 Sep 2003 13:20:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309040127370.20151-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309041230020.3647-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Linus Torvalds wrote:
> On Thu, 4 Sep 2003, Rusty Russell wrote:
> > 
> > However, Jamie's futex code will see !VM_SHARED on the mapping, and
> > compare futexes by mm + uaddr (rather than inode + file offset), so
> > this is NOT the case.  Using VM_MAYSHARE instead would make the
> > MAP_SHARED readonly case work as above, though.
> 
> But that is WORSE!
> 
> Now MAP_SHARED works, but MAP_PRIVATE does not. That's still the same bug, 
> but now it' san inconsistent bug!
> 
> I'd rather have a consistent bug than one that makes no sense.

Aren't we arguing back and forth about a totally pointless case?

I've at last read the futex manpages and looked at Rusty's futex-2.2,
to repair my understanding of the userspace end.

Isn't it the case that to use sys_futex (in the way it's intended),
userspace needs write access to the futex?  FUTEX_WAIT and FUTEX_WAKE
are used (depending on condition) after decrementing or incrementing
the futex in userspace.  FUTEX_FD is not such a clear case, but again
it appears that you'd use it for an async wait after decrementing.
FUTEX_REQUEUE seems to be a move or remap, doesn't change the picture.

So, isn't discussing sys_futex behaviour on a readonly mapping just
academic?  I'd like us to define that behaviour precisely by returning
-EACCES if sys_futex is attempted on a !VM_WRITE mapping, but it's
not worth arguing over.  And it doesn't matter whether Jamie tests
VM_MAYSHARE (as I argued) or VM_SHARED (as you insist): they're
set or clear together on all the writable mappings.

The particular case above: if it's !PROT_WRITE MAP_PRIVATE, I'm
saying that's not an area you can manipulate mutexes in anyway;
if it's PROT_WRITE MAP_PRIVATE but the page readonly while shared
with parent, child or sibling, the prior decrement or increment
on the futex in userspace will break COW, so it's private to the
mm by the time sys_futex WAIT or WAKE is called, in either the
old or the new implementation.

(But you can construct fork-with-futex examples in which the old
implementation would share private futex between parent and child,
because no write after fork to break the COW.)

Hugh

