Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132050AbRAIW7h>; Tue, 9 Jan 2001 17:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132414AbRAIW7b>; Tue, 9 Jan 2001 17:59:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10763 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132050AbRAIW7W>; Tue, 9 Jan 2001 17:59:22 -0500
Date: Tue, 9 Jan 2001 14:59:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <m3vgroe6qo.fsf@linux.local>
Message-ID: <Pine.LNX.4.10.10101091447540.2633-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jan 2001, Christoph Rohland wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
> > 
> > Note that this would be solved very cleanly if the SHM code would use the
> > "VM_LOCKED" flag, and actually lock the pages in the VM, instead of trying
> > to lock them down for writepage().
> 
> here comes the patch. (lightly tested)

I'd really like an opinion on whether this is truly legal or not? After
all, it does change the behaviour to mean "pages are locked only if they
have been mapped into virtual memory". Which is not what it used to mean.

Arguably the new semantics are perfectly valid semantics on their own, but
I'm not sure they are acceptable.

In contrast, the PG_realdirty approach would give the old behaviour of
truly locked-down shm segments, with not significantly different
complexity behaviour.

What do other UNIXes do for shm_lock()?

The Linux man-page explicitly states for SHM_LOCK that

	The user must fault in any pages that are required to be present
	after locking is enabled.

which kind of implies to me that the VM_LOCKED implementation is ok.
HOWEVER, looking at the HP-UX man-page, for example, certainly implies
that the PG_realdirty approach is the correct one. The IRIX man-pages in
contrast say

				Locking occurs per address space;
        multiple processes or sprocs mapping the area at different
        addresses each need to issue the lock (this is primarily an
        issue with the per-process page tables).

which again implies that they've done something akin to a VM_LOCKED
implementation.

Does anybody have any better pointers, ideas, or opinions?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
