Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRBKVJt>; Sun, 11 Feb 2001 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130464AbRBKVJj>; Sun, 11 Feb 2001 16:09:39 -0500
Received: from colorfullife.com ([216.156.138.34]:30727 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130399AbRBKVJb>;
	Sun, 11 Feb 2001 16:09:31 -0500
Message-ID: <3A86FF8B.FD422B54@colorfullife.com>
Date: Sun, 11 Feb 2001 22:09:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Weinehall <tao@acc.umu.se>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Nick Urbanik <nicku@vtc.edu.hk>,
        Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
In-Reply-To: <E14S3KC-0004yo-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Do you really prefer if drivers contain a
> >
> > static inline void* safe_kmalloc(size, flags)
> > {
> >       if(size > LIMIT)
> >               return NULL;
> >       return kmalloc(size, flags);
> > }
> 
> It isnt that simple. Look at af_unix.c for example. It needs to know the
> maximum safe request size to set values up and is prepared to accept
> smaller values if that fails
>

Ok, I just downloaded -ac9.

Hmm.
What about removing -16 instead of increasing it to 64?
The slab allocator is perfect for power of 2 allocations!
The slab descriptors are stored outside in seperate buffers.

And why KMALLOC_SIZE/2?
"Keep 2 messages in ..."?


Btw, sock_alloc_send_skb() (net/core.c) still uses the wrong allocation
mode for "size":

GFP_BUFFER both sleeps and uses the atomic queue.

skb = alloc_skb(size, sk->allocation & (~__GFP_WAIT));

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
