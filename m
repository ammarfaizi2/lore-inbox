Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272720AbRIIQy4>; Sun, 9 Sep 2001 12:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272727AbRIIQys>; Sun, 9 Sep 2001 12:54:48 -0400
Received: from colorfullife.com ([216.156.138.34]:268 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272720AbRIIQyk>;
	Sun, 9 Sep 2001 12:54:40 -0400
Message-ID: <3B9B9EE4.4D40AAB6@colorfullife.com>
Date: Sun, 09 Sep 2001 18:55:00 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <E15g7jk-0007Rb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > doesn't matter which free page is used first/last.
> >
> > You're full of crap.
> > LIFO is obviously superior due to cache re-use.
> 
> Interersting question however. On SMP without sufficient per CPU slab caches
> is tht still the case ?

Correct. SMP was perfect LIFO even without Andrea's changes.

I thought Andrea tried to reduce the fragmentation, therefore I wrote
"free is free".

But even for cache re-use his changes are not a big change: The main
fifo/lifo ordering on UP is mandated by the defragmentation property of
the slab allocator. 

Afaics there is exactly one case where my code is not lifo and Andrea's
is: kmem_cache_free frees the last object in slab, each slab contains
more than one object, and there are no further partial slabs.
In all other cases Andrea just adds list_del();list_add() instead of 
changes to the firstnotfull pointer.

full->partial is/was lifo,
partial->partial doesn't change the lists at all
partial->empty was fifo, is now lifo_if_no_partial_slab_exists

--
	Manfred
