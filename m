Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSEUQp2>; Tue, 21 May 2002 12:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315206AbSEUQp1>; Tue, 21 May 2002 12:45:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63245 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315202AbSEUQp1>; Tue, 21 May 2002 12:45:27 -0400
Date: Tue, 21 May 2002 09:45:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: paulus@samba.org, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.44.0205210857590.2249-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205210934340.2471-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2002, Linus Torvalds wrote:
>
> For example, in the exit_mmap() case, we should tear down the page tables
> in top-to-bottom order, and that makes all the "tlb->pages[]" stuff
> entirely unnecessary: we can just remove the _top_ pgd, and once that is
> done (and the TLB invalidated), we can remove the pmd's and the pte's at
> our leisure without any fear of races.

Hmm.. We could simplify it even further by moving the exit_mmap() from
mmput() into mmdrop(), at which point we know that we exit the mm only
after nobody is using the thing any more at all, and it has been flushed
from the TLB's.

The only downside of that is that we currently do the mmdrop in the middle
of the context switch, and we'd have to move it to _after_ the context
switch. Which is slightly complicated. The other problem is that with lazy
TLB's, we might delay actually freeing the pages for a longish time
especially on big SMP machines (if the MM ends up being lazy on an idle
CPU for long)..

So while this approach would be absolutely wonderful from a TLB behaviour
approach, it might not be the best approach in some other ways. Ideas?

		Linus

