Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRCJTLP>; Sat, 10 Mar 2001 14:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131134AbRCJTLH>; Sat, 10 Mar 2001 14:11:07 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:41476 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S131133AbRCJTK7>;
	Sat, 10 Mar 2001 14:10:59 -0500
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: Helge Hafting <helgehaf@idb.hist.no>, Manoj Sontakke <manojs@sasken.com>,
        linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
In-Reply-To: <200103091152.MAA31645@cave.bitwizard.nl>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 10 Mar 2001 19:09:46 +0000
Message-ID: <y7r7l1xl9tx.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R.E.Wolff@BitWizard.nl (Rogier Wolff) writes:
> Quicksort however is an algorithm that is recursive. This means that
> it can use unbounded amounts of stack -> This is not for the kernel.

The implementation of Quicksort for arrays demands a recursive
implementation, but for doubly-linked lists there is a trick that
leads to an iterative implementation.  You can implement Quicksort
recursively for singly linked lists, so in a doubly-linked list you
have a spare link in each node while you are doing the sort.  You can
hide the stack in those links, so the implementation doesn't need to
be explicitly recursive.  At the end of the sort, the "next" links are
correct, so you have to go through and fix up the "prev" links.

> Quicksort however is an algorithm that is good for large numbers of
> elements to be sorted: the overhead of a small set of items to sort is
> very large. Is the "normal" case indeed "large sets"?

Good implementations of Quicksort actually give up on Quicksort when
the list is short, and use an algorithm that is faster for that case
(measurements are required to find out where the boundary between a
short list and a long list lies).  If the full list to be sorted is
short, Quicksort will never be involved.  If that happens to be the
common case, then fine.

> Quicksort has a very bad "worst case": quadratic sort-time. Are you
> sure this won't happen?

Introsort avoids this by modifying quicksort to resort to a mergesort
when the recursion gets too deep.

For modern machines, I'm not sure that quicksort on a linked list is
typically much cheaper than mergesort on a linked list.  The majority
of the potential cost is likely to be in the pointer chasing involved
in bringing the lists into cache, and that will be the same for both.
Once the list is in cache, how much pointer fiddling you do isn't so
important.  For lists that don't fit into cache, the advantages of
mergesort should become even greater if the literature on tape and
disk sorts applies (though multiway merges rather than simple binary
merges would be needed to minimize the impact of memory latency).

Given this, mergesort might be generally preferable to quicksort for
linked lists.  But I haven't investigated this idea thoroughly.  (The
trick described above for avoiding an explicit stack also works for
mergesort.)

> Isn't it easier to do "insertion sort": Keep the lists sorted, and
> insert the item at the right place when you get the new item.

Easier?  Yes.  Slower?  Yes.  Does its being slow matter?  Depends on
the context.


David Wragg
