Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTLDTJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTLDTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:09:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:32183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261827AbTLDTJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:09:51 -0500
Date: Thu, 4 Dec 2003 11:09:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: nathans@sgi.com, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <Pine.LNX.4.58.0312041035530.6638@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312041050050.6638@home.osdl.org>
References: <mnet1.1070562461.26292.pinotj@club-internet.fr>
 <Pine.LNX.4.58.0312041035530.6638@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003, Linus Torvalds wrote:
> > ---
> > kernel BUG at include/linux/mm.h:267!
>
> YEAH! That's "put_page_testzero()", and either the BUG_ON() or the
> atomic_dec_and_test() noticing bad things.

Oh, damn. Looking closer, it appears that it's actually XFS being a bit
too intimate with slab knowledge: the code does

                        if (pb->pb_pages) {
                                /* release the pages in the address list */
                                if (pb->pb_pages[0] &&
                                    PageSlab(pb->pb_pages[0])) {
                                        /*
                                         * This came from the slab
                                         * allocator free it as such
                                         */
                                        kfree(pb->pb_addr);
                                } else {
                                        _pagebuf_freepages(pb);
                                }

and that code gets really confused by the fact that I'm bypassing the slab
logic (and thus the PageSlab flag never gets set).

So the oops it found was apparently triggered by the debugging changes,
not necessarily by a real bug.

Ugh, that XFS code is _broken_. Instead of keeping track of how it got the
memory, it totally forgets where the memory came from, and then it later
asks "oh, btw, how the hell did I allocate this?".

			Linus
