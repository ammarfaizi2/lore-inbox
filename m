Return-Path: <linux-kernel-owner+w=401wt.eu-S1030376AbWLaRn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWLaRn0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWLaRn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:43:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52259 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030376AbWLaRnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:43:25 -0500
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612311118490.13153@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
	 <200612302149.35752.vda.linux@googlemail.com>
	 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
	 <1167518748.20929.578.camel@laptopd505.fenrus.org>
	 <20061231133902.GA13521@vanheusden.com>
	 <1167572735.20929.750.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612311118490.13153@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 31 Dec 2006 18:43:15 +0100
Message-Id: <1167586995.20929.829.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> arjan, you and i actually agree on this.  i fully accept that the idea
> of a "clear_page()" call might or should have extra semantics,
> compared to the more simple and direct "memset(...,0,PAGE_SIZE)" call
> (such as alignment requirements, for example). my observation is
> simply that this is not what is currently happening.

that's fair
> 
> consider, for example, how many calls there are to clear_page() in the
> drivers directory:
> 
>   $ grep -rw clear_page drivers
> 
> not that many.

the biggest user of clear_page and such is the pagefault code path in
practice.


> i can't believe that at least *some* of those memset() calls couldn't
> be re-written as clear_page() calls.  and that's just for the
> drivers/ directory.

yes I can believe that ....
> 
>   sure, clear_page() might have extra semantics.  but if that's the
> case, and those semantics happen to be in play, i'm suggesting that
> not only *can* one use clear_page() at that point, one *should* use
> it.
> 
>   put another way, if a given situation is appropriate for a call to
> clear_page(), then that's what should be used. 

.... however there is potentially a bigger thing possible.
These places that zero a whole full page may have just allocated it
(that's an assumption on my side), and if that's the case, maybe those
places instead should use the zeroing version of the allocator instead
(which internally uses clear_page() ).

So... yes I fully agree with you that it's worth looking at the
memset( , PAGE_SIZE) users. If they are page aligned, yes absolutely
make it a clear_page(), I think that's a very good idea. However also
please check if they've been very recently allocated in that code, and
if maybe the zeroing allocators are better suited there..
(or maybe there's even double zeroing going on.. that's be a nice gain)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

