Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131921AbRABVJG>; Tue, 2 Jan 2001 16:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131907AbRABVI4>; Tue, 2 Jan 2001 16:08:56 -0500
Received: from palrel1.hp.com ([156.153.255.242]:5127 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S131889AbRABVIr>;
	Tue, 2 Jan 2001 16:08:47 -0500
Message-Id: <200101022039.MAA27208@milano.cup.hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        parisc-linux@thepuffingroup.com
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h 
In-Reply-To: Your message of "Tue, 02 Jan 2001 01:03:48 PST."
             <200101020903.BAA14334@pizda.ninka.net> 
Date: Tue, 02 Jan 2001 12:39:46 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,
Sorry for being dense - but I don't see the problem in using
a spinlock to implement xchg(). The example algorithm looks broken.
Or am I missing something obvious here?

"David S. Miller" wrote:
> It is very common to do things like:
> 
> producer(elem)
> {
> 	elem->next = list->head;
> 	xchg(&list->head, elem);
> }
> 
> consumer()
> {
> 	local_list = xchg(&list->head, NULL);
> 	for_each(elem, local_list)
> 		do_something(elem);
> }

producer() looks broken. The problem is two producers can race and
one will put the wrong value of list->head in elem->next.

I think prepending to list->head needs to either be protected by a spinlock
or be a per-cpu data structure. consumer() should be ok assuming the code
can tolerate picking up "late arrivals" in the next pass.
Or am I missing something obvious here?

It's worse if producer were inlined: the arch specific optimisers might
re-order the "elem->next = list->head" statement to be quite a bit more
than 1 or 2 cycles from the xchg() operation.

thanks,
grant

Grant Grundler
Unix Systems Enablement Lab
+1.408.447.7253
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
