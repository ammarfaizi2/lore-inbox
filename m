Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbTGDAZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 20:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbTGDAZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 20:25:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45771
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265543AbTGDAZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 20:25:37 -0400
Date: Fri, 4 Jul 2003 02:40:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704004000.GQ23578@dualathlon.random>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random> <20030703201607.GK20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703201607.GK20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 01:16:07PM -0700, William Lee Irwin III wrote:
> I don't know what kind of moron you take me for but I don't care to be
> patronized like that.

If it's such a strong feature, go ahead and show me a patch to a real
life applications (there are plenty of things using hashes or btrees,
feel free to choose the one that according to you will behave closest to
the "exploit" [1]) using remap_file_pages to avoid the pte overhead and
show the huge improvement in the numbers compared to changing the design
of the code to have some sort of locality in the I/O access patterns
(NOTE: I don't care about ram, I care about speed). Given how hard you
advocate for this I assume you at least expect a 1% improvement, right?
Once you make the patch I can volounteer to benchmark it if you don't
have time or hardware for that. After you made the patch and you showed
a >=1% improvement by not keeping the file mapped linearly, but by
mapping it nonlinearly using remap_file_pages, I reserve myself to fix
the app to have some sort of locality of information so that the I/O
side will be able to get a boost too.

the fact is, no matter the VM side, your app has no way to nearly
perform in terms of I/O seeks if you're filling a page per pmd due the
huge seek it will generate with the major faults. And even the minor
faults if has no locality at all and it seeks all over the place in a
non predictable manner, the tlb flushes will kill performance compared
to keeping the file mapped statically, and it'll make it even slower
than accessing a new pte every time.

Until you produce pratical results IMHO the usage you advocated to use
remap_file_pages to avoid doing big linear mappings that may allocate
more ptes, sounds completely vapourware overkill overdesign that won't
last past emails.  All in my humble opinion of course. I've no problem
to be wrong, I just don't buy what you say since it is not obvious at
all given the huge cost of entering exiting kernel, reaching the
pagetable in software, mangling them, flushing the tlb (on all common
archs that I'm assuming this doesn't only mean to flush a range but to
flush it all but it'd be slower even with a range-flush operation),
compared to doing nothing with a static linear mapping (regardless the
fact there are more ptes with a big linear mapping, I don't care to save
ram).

If you really go to change the app to use remap_file_pages, rather than
just compact the vm side with remap_file_pages (which will waste lots of
cpu power and it'll run slower IMHO), you'd better introduce locality
knowledge so the I/O side will have a slight chance to perform too and
the VM side will be improved as well, potentially also sharing the same
page, not only the same pmd (and after you do that if you really need to
save ram [not cpu] you can munmap/mmap at the same cost but this is just
a said note, I said I don't care to save ram, I care to perform the
fastest). reiserfs and other huge btree users have to do this locality
stuff all the time with their trees, for example to avoid a directory to
be completely scattered everywhere in the tree and in turn triggering
an huge amount of I/O seeks that may not even fit in buffercache. w/o
the locality information there would be no way for reiserfs to perform
with big filesystems and many directories, this is just the simples
example I can think of huge btrees that we use everyday.

Again, I don't care about saving ram, we're talking 64bit, I care about
speed, I hope I already made this clear enough in the previous email.

My arguments sounds all pretty strightforward to me.

Andrea

[1] I called the exploit because it was posted originally on bugtraq a
number of years ago, the pmd weren't reclaimed, and Linus fixed it (IIRC
in 2.3) by freeing the pmds when a PGD_SIZE range was completely
released. Of course yours isn't an exploit but it just behaves like
that by wasting lots of ram with pmds compared to the actual mapped
pages.
