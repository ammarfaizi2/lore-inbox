Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRABJxN>; Tue, 2 Jan 2001 04:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130562AbRABJxD>; Tue, 2 Jan 2001 04:53:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60547 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130476AbRABJwp>;
	Tue, 2 Jan 2001 04:52:45 -0500
Date: Tue, 2 Jan 2001 01:03:48 -0800
Message-Id: <200101020903.BAA14334@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: grundler@cup.hp.com
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        parisc-linux@thepuffingroup.com
In-Reply-To: <200101020811.AAA26525@milano.cup.hp.com> (message from Grant
	Grundler on Tue, 2 Jan 2001 00:11:57 -0800 (PST))
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
In-Reply-To: <200101020811.AAA26525@milano.cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 2 Jan 2001 00:11:57 -0800 (PST)
   From: Grant Grundler <grundler@cup.hp.com>

   Fundemental problem is parisc only supports one atomic operation
   (LDCW/LDCD) and uses spinlocks for all atomic operations including
   xchg/cmpxchg.

Using spinlocks for the implementation of xchg on SMP might be
problematic.

If you implement things like this, several subtle things might
break.  For example, there is code in a few spots (or, at least at one
time there was) which assumed the update of the datum itself is atomic
and uses this assumption to do lock-free read-only accesses of the
data.

If you require an external agent (f.e. your spinlock) because you
cannot implement xchg with a real atomic sequence, this breaks the
above assumptions.

It is very common to do things like:

producer(elem)
{
	elem->next = list->head;
	xchg(&list->head, elem);
}

consumer()
{
	local_list = xchg(&list->head, NULL);
	for_each(elem, local_list)
		do_something(elem);
}

In fact we had code excatly like this in the buffer cache at one
point in time.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
