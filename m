Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWFNXsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWFNXsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWFNXsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:48:20 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:24568 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S965045AbWFNXsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:48:19 -0400
Message-ID: <44909ED0.3060402@comcast.net>
Date: Wed, 14 Jun 2006 19:42:08 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       linux-c-programming <linux-c-programming@vger.kernel.org>
Subject: Group ordering and comparison
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I need a little help proving a conjecture I've come up with in relation
to ordering and sorting.. not sure where else to go with this but since
I'm using it in kernel code I might as well ask.

I am currently working on an in-memory compression patch for Linux 2.6,
and need a way to determine which compressed data to throw into the swap
file.  I decided to do it by the least compressible pages first, LCI
(lowest compression index, where CI == PAGE_SIZE - COMPRESSED_PAGE_SIZE).

To this end I have the problem of ordering pages, grouping them for
efficient compression, and destroying and regrouping groups to increase
efficiency.  I have come up with an algorithm, but it relies on a
logical conjecture I came up with in about 5 minutes and spent the past
hour attempting to disprove.  As it stands I believe it is true but I
lack proper numerical theory to prove it.

The conjecture is as follows:

 - For X a multiple of N
 - For a set of X unique elements
 - For groups of N elements
 - For "sorted" meaning sorted ascending or descending, but being
consistent through the whole of this conjecture
 - For groups in which the elements contained are sorted
 - For list L containing the set of all elements sorted
 - For list G containing the set of all groups
 - For list K containing the expansion of all groups in list G into
their elements

 Starting at the beginning of lists L and K, only the index representing
the first and last element of each group must be compared to determine
the location of the first group in which list K is no longer following
the sorted order of list L.


That is to say:

01 02 03 04 05 06 07 08 09 10 11 12 13 14 15

Mix these up in random order; group them in groups of 3; order the
groups ascending; and rewrite into a list:

Group:
02 01 03 | 05 06 04 | 07 09 10 | 14 13 15 | 11 08 12

Sorted groups:
01 02 03 | 04 05 06 | 07 09 10 | 13 14 15 | 08 11 12

Lists compared:
01 02 03   04 05 06   07 08 09   10 11 12   13 14 15
01 02 03 | 04 05 06 | 07 09 10 | 13 14 15 | 08 11 12
 ^     ^    ^     ^    ^     ^-- Fail
_|_____|____|_____|____|_____|

As illustrated above, we know the failure to sort is in group 3.  This
means, in our case, that one of elements 7, 8, or 9 reside in groups 4
or 5.  We know they're not in groups 1, 2, or 3 by conjecture.

I believe this conjecture is true for all lists of unique elements, for
all group sizes >0, and for sparse lists.

This conjecture becomes useful in a modified form with greater restrictions:

 - For groups being "valued" as the mean value of their elements
 - For list G containing the set of all groups sorted

In this form, the groups above are valued as below:

Values:
01 02 03 | 04 05 06 | 07 09 10 | 08 11 12 | 13 14 15
6/3=2      15/3=5     26/3=8.7   31/3=10.3  42/3=14

This allows for fast comparison of two lists to determine where the
lists are out of order.  This is extremely useful for sorting lists
where the elements are grouped in a physical sense and action must be
taken to ungroup the elements, sort them, and regroup them.

In the case of my compression system, I group pages into sets of 32KiB,
which becomes 8 pages (ignore huge pages for this discussion, I know
already).  It is detrimental for pages to be ill-grouped; so I keep the
groups sorted by compression index (average of the CI of the pages) and
attempt to find the least compressible group of pages (LCI) that is out
of order from the LCI of pages.  (think about the above conjecture,
you'll get it).

This is important because the changes made compress "swapped" pages in
memory.  When memory pressure is too high, I throw the LCI groups out
into the swap file for the pure purpose of maximizing the overall
compression ratio of in-memory compressed pages.  By getting rid of the
absolutely hardest to compress pages, this goal is reached; after all,
if I compress 32KiB to 1KiB and then ditch that only to keep a chunk of
32KiB stored as 31KiB in memory, I just wasted space for potentially 31
times more memory to be compressed and not sent to swap!

At any rate, I can cut the search space (and thus the CPU intensity) of
the algorithm down to O(X/(2N)) in comparison to brute forcing, which
isn't really much strictly speaking (it's still a linear algorithm, as N
is fixed and X is the workload), but in my case it will be 25% as
intensive.  This assumes my conjecture is true... any takers?  :)

(Note that you can theoretically execute this kind of comparison in a
sort of tree using groups of groups of ... groups of elements, giving
you a polynomial or exponential time complexity; but I don't feel like
thinking about it right now)
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRJCezgs1xW0HCTEFAQIkdA//f58BRhEhreZLnrW+Zp4lkYlOofuuVfKp
0QyA82iiam13Onvt4qunHHJQXsK8ESzxaSaYOw3ZwBMHcBNfYb9OTdBlZ0CUOFo4
rYAbJZXQjOlCuJXgoaHeJ0/FNetcLIDd7RB3L0BAN32PHBoOjfEImB9lWFvq2WFn
CuziMnBtv1kldBuBu0Va8CI+F8ZiOGE0ELrqGPgk11WSOBjlN9cCJXCfpnsXjXx5
pLo4RHnu0uFg2smX5uwPzfaEsBMvsGwMaIWCV/aMlDvys1XwNrlAJtd7pzWzAym4
XtksAKqmpwzkksLgqYxdZA94F6megh3INK1PzJ8Jj/eTkuZ5vRIbDnSp56RSs7o1
BjmyMCPMZTYOiVdTKs7r1+t1LnH+Qxth37KAk3zkndhSrY08llqhIn1bbp0rtb2E
UwqVWMXy1D74eqHPhW0P55MrwgAlQR1+K+hWIM1Y1x6aL4BkJDC35vfCDbziwYnN
t0PbRdTKrCEsgcjDCME+mBAdrNQb4+ZAnhM9+zPrMmp/+NdYJ/KjoeO9HBdb1p9C
PLtbPXVY46Tw5C0HqL0AlHXm6VMp4Te1/g6sGBQ9TIMUivxLEebZtHBnA2vUlyYm
1p96RsPnqjgcNpMPheiVZVKDv/MWFEOuLK2llO9Z1Ph4xQUGOiHnEGhG1AkJhZGM
cZ9+vGdfpmY=
=u+er
-----END PGP SIGNATURE-----
