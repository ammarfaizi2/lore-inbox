Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUCVOtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUCVOtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:49:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33718
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262042AbUCVOt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:49:28 -0500
Date: Mon, 22 Mar 2004 15:50:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa1
Message-ID: <20040322145019.GZ3649@dualathlon.random>
References: <20040322141439.GY3649@dualathlon.random> <Pine.LNX.4.44.0403221421410.11500-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403221421410.11500-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 02:31:15PM +0000, Hugh Dickins wrote:
> On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
> > On Mon, Mar 22, 2004 at 09:07:54AM -0500, Rik van Riel wrote:
> > > 
> > > Most people seem to be talking about "pte based rmap" vs
> > > "object based rmap".  So far you're the only one who I've
> > > seen using "rmap" to mean just "pte based rmap" and not
> > > also "object based rmap".
> > 
> > then I'm the only one and I could have been biased because rmap.c is
> > including 99% of code for the pte based rmap, and my objrmap.c is including
> > 99% of code for the objrect based _reverse_mappings_, still objrmap.c is
> > a more appropriate name for that stuff IMO (especially if somebody else
> > is mistaken as I am using the word rmap to mean the current 2.6 code in
> > mm/rmap.c).
> 
> I agree with Rik and Christoph (I agreed with all of Christoph's points,
> but most can be left until later on): mm/rmap.c and include/linux/rmap.h
> (the latter a name change from include/linux/rmap-locking.h).
> 
> objrmap is the particular implementation found within that file in your
> tree, but Rik imagined right from the start that there would be various
> implementations:
> 
>  * This is kept modular because we may want to experiment
>  * with object-based reverse mapping schemes.
> 
> (Aaargh, now we can expect someone to propose
> CONFIG_PTE_CHAIN_RMAP, CONFIG_ANON_VMA_RMAP, CONFIG_ANONMM_RMAP etc)

obviously I read that comment, but I definitely hope he meant people
adding objrmap.c w/o necessairly deleting rmap.c too like me and you did
(i.e. we don't provide a CONFIG_RMAP to go back), and to have the
CONFIG_ in a Makefile _definitely_not_ in rmap.c mixing everything
unrelated in the same file.

Separating the entry points from the rest of the mm/*.c is sure a good
idea, and infact I left those separated in objrmap.c, like they were
separated in rmap.c, so you can go ahead and add an anobjrmap.c and we
can have a CONFIG_ option to select if to compile with objrmap.c or with
anobjrmap.c.

your example of having multiple methods in the same tree selectable as a
config option is the very best example where keeping the objrmap.c code
separated from the rmap.c code in two different files is a MUST (or at
the very least a SHOULD to avoid a mess of #ifdefs in the middle of C
code since there's nothing to share except the function parameters).
