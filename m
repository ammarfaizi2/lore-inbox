Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRG3MiZ>; Mon, 30 Jul 2001 08:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268571AbRG3MiK>; Mon, 30 Jul 2001 08:38:10 -0400
Received: from cr821974-a.lndn1.on.wave.home.com ([24.112.53.173]:16134 "EHLO
	megatonmonkey.net") by vger.kernel.org with ESMTP
	id <S268570AbRG3MiE>; Mon, 30 Jul 2001 08:38:04 -0400
Date: Mon, 30 Jul 2001 08:38:29 -0400
From: "Carlos O'Donell Jr." <carlos@baldric.uwo.ca>
To: linux-kernel@vger.kernel.org
Cc: swsnyder@home.com
Subject: Re: What does "Neighbour table overflow" message indicate?
Message-ID: <20010730083829.A7336@megatonmonkey.net>
In-Reply-To: <01072820231401.01125@mercury.snydernet.lan> <20010729133848.A3254@weta.f00f.org> <01072820534802.01125@mercury.snydernet.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01072820534802.01125@mercury.snydernet.lan>; from swsnyder@home.com on Sat, Jul 28, 2001 at 08:53:48PM -0500
X-Useless-Header: oooohhmmm, chant the email mantra...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> network module. In this case it only ensures, that the printk message is not
> printed too often. The actual condition why the message is printed is above
> this if.
> 
> Greetings
> Bernd
> -

Snyder,

Just by looking at your email, @home, I can guess that your
cable modem is connected to an HFC Cable network segment.

In general these segments are extremely large and due to the
nature of the users, can cause large amounts of arp broadcast
traffic during peak times.

The message you are seeing is directly related to your arp cache
overflowing.

I've seen this message during high traffic hours on my 2.2.x 
firewall.

Things to check:

- Is your netmask set correctly?
- Check to see how many hosts are on your segment?

======================================================
Why the kernel spat what it spat : blow by blow
======================================================

N.B. Using 2.4.7 Kernel Source.

I think the critical point is:

In route.c:

639: int err = arp_bind_neighbour(&rt->u.dst);
640:                if (err) {
...			[snip]

Which means that if the binding of an arp neighbour fails, then
we trod down the path closer towards that printk, that has
caused us so much distress.

In arp.c, we look for "arp_bind_neighbour" and find it on line 429:

Right off the bat, we hope that:

434:        if (dev == NULL)
435:                return -EINVAL;

Isn't the case :)

Unless, it's alredy bound, then the next line is the case...

436:        if (n == NULL) {

And the only return that is non-zero is from:

440:                n = __neigh_lookup_errno(
441:#ifdef CONFIG_ATM_CLIP
442:                    dev->type == ARPHRD_ATM ? &clip_tbl :
443:#endif
444:                    &arp_tbl, &nexthop, dev);
445:                if (IS_ERR(n)) 
446:                        return PTR_ERR(n);

So __neigh_lookup_errno is the culprit...

In ./include/net/neighbour.h we have the function defined:

266:static inline struct neighbour *
267:__neigh_lookup_errno(struct neigh_table *tbl, const void *pkey,
268:struct net_device *dev)
...
275:       return neigh_create(tbl, pkey, dev)

Is the interesting point.. since our table is overflowing, we
need to find the point where the entry is created :)

Off we go to line 288 in ./net/core/neighbour.c:
(I love to trace source!)

296:        n = neigh_alloc(tbl);
297:        if (n == NULL)
298:                return ERR_PTR(-ENOBUFS);

Hrm... -ENOBUFS :)

In neigh_alloc, same file:

235:         if (tbl->entries > tbl->gc_thresh3 ||
236:            (tbl->entries > tbl->gc_thresh2 &&
237:             now - tbl->last_flush > 5*HZ)) {
238:                if (neigh_forced_gc(tbl) == 0 &&
239:                    tbl->entries > tbl->gc_thresh3)
240:                        return NULL;
241:        }

Which leads us to note that if the cache is growing faster than
the garbage collecting (ref counting code) is being done, and we
begin to exceed our allocations, we will trigger a table 
overflow.

Can you make the tables bigger?
What type of inpact does this have?
Should we be asking @Home to make segments smaller? 
(Probably not possible)

In ./net/ipv4/arp.c you could change the GC collection parameters...
I'm not sure how they were tuned?

Line 187:
        gc_interval:    30 * HZ,
        gc_thresh1:     128,
        gc_thresh2:     512,
        gc_thresh3:     1024,

Hrm... just pondering.


=================================================================

Cheers,
Carlos O'Donell Jr.
