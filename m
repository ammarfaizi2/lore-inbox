Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSGXPt1>; Wed, 24 Jul 2002 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSGXPt1>; Wed, 24 Jul 2002 11:49:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:28665 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S317355AbSGXPt0>; Wed, 24 Jul 2002 11:49:26 -0400
Date: Wed, 24 Jul 2002 15:48:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM accounting 1/3 trivial
In-Reply-To: <1027463584.31782.148.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0207241453420.1159-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2002, Alan Cox wrote:
> On Tue, 2002-07-23 at 18:27, Hugh Dickins wrote:
> > First of three patches against 2.4.19-rc3-ac3 fixing some VM accounting.
> > Could be split further, but this one too trivial to need much thought.
> > 
> > 1. do_munmap doesn't need an extra acct arg (and rc3-ac3 still leaves
> >    arch files without it): just clear VM_ACCOUNT in mremap's move_vma.
> 
> Are you sure that is correct. I started off on that basis but never got
> it to work reliably when mremap changes multiple vmas ?

Thank you, it is surely incorrect (in the case where the do_munmap does
not cover the whole vma, leaving one or two pieces behind: I think that
must be the case you're remembering).  Would a patch which (if necessary)
reapplies VM_ACCOUNT to the leftover piece(s) be welcome, or would it
just look like an ugly face-saving exercise?

> Can you split out items #2, #4 first of all and submit those alone, then
> I can review each item on its own and run vm_validate tests

Okay, will do, thanks.  And you will also ignore patches 2/3, 3/3 now,
since David has given a clear vote for more MAP_NORESERVE consistency,
and VM_NORESERVE would be more natural to pass from do_mmap_pgoff to
shmem_file_setup than my VM_SHARED|VM_ACCOUNT abuse.

But I'll still have a consistency problem with MAP_NORESERVE versus
sysctl_overcommit_memory, when the latter is changed (> 1 or <= 1).
The closest I can get to a consistent position is that do_mmap_pgoff
only sets VM_NORESERVE if MAP_NORESERVE and sysctl_overcommit_memory
<= 1 (as you wish), but that thereafter (in mprotect and in mremap,
even when extending the mapping) VM_NORESERVE will be respected (and
propagated when splitting) even while sysctl_overcommit_memory > 1.
Mirroring the vice versa situation, of the reservations made when
MAP_NORESERVE is ignored, and thereafter.

You might prefer more draconian enforcment, but I fear it
could behave strangely.  Does the above sound fair to you?

Hugh

