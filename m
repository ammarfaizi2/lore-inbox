Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSHYWSq>; Sun, 25 Aug 2002 18:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHYWSq>; Sun, 25 Aug 2002 18:18:46 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:63748 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S317619AbSHYWSp>;
	Sun, 25 Aug 2002 18:18:45 -0400
Date: Sun, 25 Aug 2002 23:22:54 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19 Vs 2.4.19-rmap14a with anonymous mmaped memory
Message-ID: <Pine.LNX.4.44.0208252220030.31523-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran a brief series of tests on a small crash box. the intention was to
see what sort of figures and conclusions could be gathered with VM Regress
in it's current public release. VM Regress is the beginnings of a tool
that ultimatly aims to answer questions about the VM by testing and
benchmarking individual parts of it. The conclusions drawn here are
extremly ad-hoc so take them with a very large grain of salt.

4 tests were run on each machine each related to anonymous memory used in
a mmaped region. Two reference patterns were used. smooth_sin and
smooth_sin-random . Both sets show a sin curve when the number of times
each page is referenced is graphed (See the green line in the graph Pages
Present/Swapped). With smooth_sin, the pages are reffered to in order.
With smooth_sin-random, the pages are referenced in a random order but the
amount of times a page is referenced.

Both patterns are tested with 2,000,000 page references made to a mmaped
region. The first memory mapped region is 25000 pages large, about the
size of physical memory on the machine. The second was with 50000.
Unfortunatly detailed statistical information is unavailable, but some
conclusions can still be drawn. Statistical information is aimed to be
available at least by 0.9

Test 1 - smooth-sin_25000
http://www.csn.ul.ie/~mel/vmr/2.4.19/smooth_sin_25000/mapanon.html
http://www.csn.ul.ie/~mel/vmr/2.4.19-rmap14a/smooth_sin_25000/mapanon.html

Behaviour is pretty much comparable. The average page access times look
roughly the same so at the very least the performance is similiar. rmap14a
did perform faster but hte test wasn't long enough to be conclusive. All
in all, when enough physical memory is avilable, rmap14a and stock will
perform roughly the same with a linear reference pattern and enough memory
is available.

Test 2 - smooth-sin-random_25000
http://www.csn.ul.ie/~mel/vmr/2.4.19/smooth_sin-random_25000/mapanon.html
http://www.csn.ul.ie/~mel/vmr/2.4.19-rmap14a/smooth_sin-random_25000/mapanon.html

here, the average performanceremains roughly the same. It is interesting
to note that rmap14a had periodic large access times to pages and it's
unclea. Despite this, rmap14a still completed the test faster. So again,
with enough memory available, the performance remains roughly the same
even with a relatively random page reference pattern

Test 3 - smooth_sin_50000
http://www.csn.ul.ie/~mel/vmr/2.4.19/smooth_sin_50000/mapanon.html
http://www.csn.ul.ie/~mel/vmr/2.4.19-rmap14a/smooth_sin_50000/mapanon.html

This test is interesting. Remember that the references are linear in
memory. At about the 1,000,000 page reference, physical memory is
exhausted. Both tests completed in the same time so in "raw performance"
they would appear the same but not so. The time access graph shows that
for most of the test, rmap14a performed much better on average except
for the occasional large spikes. At the end, it degrades very quickly but
is still faster than the stock kernel about about 300000 microseconds to
access a page which the unscaled graphs show

http://www.csn.ul.ie/~mel/vmr/2.4.19/smooth_sin_50000/mapanon-time-unscaled.png
http://www.csn.ul.ie/~mel/vmr/2.4.19-rmap14a/smooth_sin_50000/mapanon-time-unscaled.png

This would appear consistent with reports that the stock kernel degrades
slowly where rmap seems to fall apart really quickly in some situations.

It is suspected that the large periodic spikes are where the proper page
to select out is found but it's pure guesswork and VM Regress is not at
the point where it can investigate more.

The second point of note is the present pages at the end of the test.
stock makes no attempt to keep certain pages in memory. When physical
memory is out, it swaps out enitre processes unconditionally. rmap14a
tries to keep the proper pages in memory and the page reference vs
presense graph shows that it did. stock has a large block of pages
present, rmap14a had swapped out some pages from the beginning of the
test.

In this case, stock just happened to swap out correctly because the pages
remove were not going to be used again in this particular case

Test 4 - smooth_sin-random
http://www.csn.ul.ie/~mel/vmr/2.4.19/smooth_sin-random_50000/mapanon.html
http://www.csn.ul.ie/~mel/vmr/2.4.19-rmap14a/smooth_sin-random_50000/mapanon.html

With this test, the page references are in random order so determining
which page to remove is much more difficult. rmap14a completed this test
almost 10 minutes quicker than stock.

The average time for the stock kernel is consistently bad. I am guessing
that this is because the kernel consistently ends up swapping out the
entire process. rmap has periods of quick accesses with unfortunatly large
spikes because it is trying to keep the right pages in memory and a lot of
the time gets it right. This is better than stock kernel which never keeps
the right pages in memory.

Conclusion

It is hard to draw solid conclusions because large gaps still exist in the
data but some can be drawn. I am sure an experienced VM developer will be
able to draw much more reliable conclusions :-)

First, when enough physical memory is available, rmap and stock perform
more or less the same so appreciatable overhead is not introduced for
normal anonymous memory use.

Second, when memory is tight, the type of memory reference behaviour will
determine how good or bad the two will perform. With a strictly linear
pattern, stock will perform better because it just dumps all the old pages
en-mass. I seriously doubt this reference is common.

For other patterns with large anonymous page use, rmap is more likely to
perform better because it tries to keep anonymous pages in memory. Even
with a totally random pattern, it'll perform reasonably well.

Lastly, it is obvious from the tests that for deciding which page to swap,
age is more important than frequency but that is already known. The page
age graphs are on the way and will be available in VM Regress 0.7

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

