Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbTICR4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTICR4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:56:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:18630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263659AbTICR4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:56:12 -0400
Date: Wed, 3 Sep 2003 10:55:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <20030903173928.GA22555@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309031052000.26650-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Sep 2003, Jamie Lokier wrote:
>
> Hugh Dickins wrote:
> > > Good question.  No kernel code seems to check VM_MAYSHARE - the one to
> > > check is VM_SHARED.
> > 
> > Observe fs/procfs/task_mmu.c show_map checking VM_MAYSHARE for 's'.
> > Observe mm/mmap.c do_mmap_pgoff vm_flags &= ~(VM_MAYWRITE | VM_SHARED).
> > VM_MAYSHARE reflects whether user chose MAP_SHARED, VM_SHARED may not.
> 
> Hugh, thank you.  In the case of futex.c, either flag could be used to
> mean "is this a shared" mapping, and each choice has a different
> user-visible meaning.

Actually: the VM_SHARED flag will never change, so testing VM_SHARED is 
actually the _right_ thing from a mm perspective.

The only person who should ever test VM_MAYSHARE is somebody who does
reporting back to user space: VM_MAYSHARE basically ends up meaning "the
user _asked_ for a shared mapping". While "VM_SHARED" means "this mapping
can actually contain a shared dirty page".

The VM itself should only ever care about VM_SHARED. Because that's the 
only bit that has real semantic meaning.

			Linus

