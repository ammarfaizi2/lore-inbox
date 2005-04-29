Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVD2RYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVD2RYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVD2RYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:24:05 -0400
Received: from groover.houseafrikarecords.com ([12.162.17.52]:18248 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262844AbVD2RX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:23:59 -0400
Date: Fri, 29 Apr 2005 10:23:58 -0700
From: Libor Michalek <libor@topspin.com>
To: Roland Dreier <roland@topspin.com>
Cc: Caitlin Bestler <caitlin.bestler@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       hch@infradead.org, Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: RDMA memory registration (was: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation)
Message-ID: <20050429102358.B13041@topspin.com>
References: <52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com> <426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org> <5ebee0d105042907265ff58a73@mail.gmail.com> <469958e005042908566f177b50@mail.gmail.com> <52d5sdjzup.fsf_-_@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <52d5sdjzup.fsf_-_@topspin.com>; from roland@topspin.com on Fri, Apr 29, 2005 at 09:45:50AM -0700
X-OriginalArrivalTime: 29 Apr 2005 17:23:58.0979 (UTC) FILETIME=[3A9EAD30:01C54CE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 09:45:50AM -0700, Roland Dreier wrote:
> Is there anything wrong with the following plan?
> 
> 1) For memory registration, use get_user_pages() in the kernel.  Use
>    locked_vm and RLIMIT_MEMLOCK to limit the amount of memory pinned
>    by a given process.  One disadvantage of this is that the
>    accounting will overestimate the amount of pinned memory if a
>    process pins the same page twice, but this doesn't seem that bad to
>    me -- it errs on the side of safety.

  I think the overestimate will be fine in practice. If a process is
locking a lot of memory it will most likely be in big chunks, so not
much page overlap there. If the process is locking lots of tiny buffers
with lots of page overlap, the total locked amount will most likely be
small. Although it is odd that you could end up with a total locked
amount larger then the number of physical pages in the system...

> 2) For fork() support:
> 
>    a) Extend mprotect() with PROT_DONTCOPY so processes can avoid
>       copy-on-write problems.
> 
>    b) (maybe someday?) Add a VM_ALWAYSCOPY flag and extend mprotect()
>       with PROT_ALWAYSCOPY so processes can mark pages to be
>       pre-copied into child processes, to handle the case where only
>       half a page is registered.
> 
> I believe this puts the code that must be trusted into the kernel and
> gives userspace primitives that let apps handle the rest.

  I'm assuming that for libibverbs memory registration you plan on hiding
the mprotect in the library? Without reference counting at the kernel
level this could yield unexpected results in a perfectly legitimate app.

  For example if the app is managing a buffer it will pass to another
device, but also want's to move data in/out with RDMA hardware, the user
marks it themselves with DONTCOPY, registers with libibverbs, performs
IO, unregisters with libibverbs. At this point the user expects the buffer
to have DONTCOPY set, but it does not because of the unregister... Not
that it's likely, but it's a valid thing to do. However, since I don't
have a better suggestion, I'm in favour of using mprotect as you outlined. 


-Libor
