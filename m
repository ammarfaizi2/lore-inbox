Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbRAOCyI>; Sun, 14 Jan 2001 21:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRAOCx6>; Sun, 14 Jan 2001 21:53:58 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:17904 "EHLO
	lappi.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S130539AbRAOCxn>; Sun, 14 Jan 2001 21:53:43 -0500
Date: Mon, 15 Jan 2001 00:53:15 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010115005315.D1656@bacchus.dhis.org>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m17l40hhtd.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Jan 12, 2001 at 09:10:54AM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:10:54AM -0700, Eric W. Biederman wrote:

> > Having a reverse mappings is the least sucky way to handle virtual aliases
> > of certain types of MIPS caches.
> 
> Hmm.  I would think that increasing the logical page size in the kernel would
> be the trivial way to handle virtual aliases.  (i.e.) with a large enough page
> size you can't actually have a virtual alias.

That's a possible solution; I'm not clear how bad the overhead would be.
Right now a virtual alias is a relativly rare event and we don't want the
common case of no virtual alias to make pay a high price.  Or?

> You could also play some games with simply allocating pages only with the
> proper proper high bits.   These games might also be useful on architectures
> for L2 caches who have significant physical bits than PAGE_SHIFT bits.

An alternative but less efficient solution.  I tried to implement it; I ran
into problems with running out of larger pages soon as I had to split order 2
pages into 4 order 0 pages to implement this; the fragmentation was _really_
bad.

> But how does a reverse mapping help to handle virtual aliases?  What are those
> caches doing?

You leave only mappings of one color accessible.  All other mappings are made
unaccessible in the page table, so accessing will result in a TLB fault.
The TLB fault handler then flushes the active mappings, makes them
unaccessible by clearing the MIPS hw dirty / accessible bits, then makes the
mapping of the new color accessible in the page table.  This is already
possible right now but doing the necessary reverse mappings can be rather
inefficient as is.

> The only model in my head is having a virtually indexed cache where you
> have more index bits than PAGE_SHIFT bits.

Which is exactly what many MIPS implementations are suffering from.  At
least they're tagged with the physical address, so no flushes on context
switch necessary.

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
