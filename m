Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTICRlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTICRlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:41:06 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64907 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264143AbTICRkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:40:06 -0400
Date: Wed, 3 Sep 2003 18:39:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030903173928.GA22555@mail.jlokier.co.uk>
References: <20030903073628.GA19920@mail.jlokier.co.uk> <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> > Good question.  No kernel code seems to check VM_MAYSHARE - the one to
> > check is VM_SHARED.
> 
> Observe fs/procfs/task_mmu.c show_map checking VM_MAYSHARE for 's'.
> Observe mm/mmap.c do_mmap_pgoff vm_flags &= ~(VM_MAYWRITE | VM_SHARED).
> VM_MAYSHARE reflects whether user chose MAP_SHARED, VM_SHARED may not.

Hugh, thank you.  In the case of futex.c, either flag could be used to
mean "is this a shared" mapping, and each choice has a different
user-visible meaning.

Most of the VM code uses VM_SHARED to ask the question "is this a
shared mapping", but it turns out that most of the VM code means
something different by that than what is meant in userspace.  To the
VM code, a "shared mapping" means something which can dirty
backing-file pages, either after mmap() or maybe mprotect() as well.

This is different to the userspace point of view.  The common language
is unfortunate.  (IMHO the flag should be called VM_SHAREDWRITABLE).

With futex.c using VM_SHARED to determine whether to hash on
(inode,offset,index), mappings of read-only file handles will hash on
(mm,uaddr) which is not correct: a FUTEX_WAIT on a shared mapping
using userspace's meaning of "shared mapping" should notice changes in
a different mm.

Therefore, futex.c will use VM_MAYSHARE in my next patch.

Thanks,
-- Jamie
