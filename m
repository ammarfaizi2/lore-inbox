Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRAISgl>; Tue, 9 Jan 2001 13:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130984AbRAISgX>; Tue, 9 Jan 2001 13:36:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56079 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130902AbRAISgR>; Tue, 9 Jan 2001 13:36:17 -0500
Date: Tue, 9 Jan 2001 10:36:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <20010109153119.G9321@redhat.com>
Message-ID: <Pine.LNX.4.10.10101091024150.2070-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> > 
> > It's worse: The issue we are talking about is SYSV IPC_LOCK.
> 
> The issue is locked VA pages.  SysV is just one of the ways in which
> it can happen: the solution has got to address both that and
> mlock()/mlockall().

No, mlock() and mlockall() already works. Exactly because mlocked pages
will never be removed from the VM, the VM layer knows how to deal with
them (or "not deal with them" as the case is more properly stated). They
won't ever get on the inactive list, and because refill_inactive_scan()
won't be able to move handle them (the count is elevated by the VM
mappings), the VM will correctly and gracefully fall back on scanning the
page tables to find some _other_ blocks.

So mlock works fine.

The reason shm locked segments do _not_ work fine is exactly because they
are not locked down in the VM, and for that reason they can end up being
detached from everything and thus moved to the inactive list. That counts
as "progress" as far as the VM is concerned, so we get into this endless
loop where we move the page to the inactive list, then try to write it
out, fail, and move it back to the active list again. The VM _thinks_ it
is making progress, but obviously isn't. 

End result: lockup.

Marking the pages with a magic flag would solve it. Then we could 
just make refill_inactive_scan() ignore such pages. Something like
"PG_Reallydirty".

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
