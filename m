Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSHPW66>; Fri, 16 Aug 2002 18:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSHPW66>; Fri, 16 Aug 2002 18:58:58 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:13316 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S317845AbSHPW6y>;
	Fri, 16 Aug 2002 18:58:54 -0400
Date: Sat, 17 Aug 2002 00:02:46 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Scott Kaplan <sfkaplan@cs.amherst.edu>
Cc: Bill Huey <billh@gnuppy.monkey.org>, Rik van Riel <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] rmap 14
In-Reply-To: <40D0F925-B15F-11D6-972F-000393829FA4@cs.amherst.edu>
Message-ID: <Pine.LNX.4.44.0208162247590.874-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Scott Kaplan wrote:

> > start    was run at system startup
> > updatedb is output after updatedb was running 2 minutes
> > withx    is run with the system running X, konqueror and a few eterms
>
> I will acknowledge that you're at the beginning of a long process, and
> that you have much more that you plan to add, but I feel the need to point
> out that this is a *very* small test suite.

It will take a *long* time to develop the full test suite to cover,
faulting, page alloc, slab, vmscan, buffer caches etc.. I have two
choices, I can develop the entire thing and have one large release or I
can release early with updates so people can keep an eye out and make sure
they get what they want as well as what I'm looking for. I choose the
latter. This test is what I can produce *now* but this benchmark isn't
even finished. I put up the three tests an an example of a beginning to
try and show that a test suite is on the way that isn't a simple shell
script.

> You may want to check your code for sanity:  There are only 1,000
> milliseconds in a second, and I'm skeptical that there was a 630 second
> (that is, 10+ minute) reference.  Were there, perhaps, microseconds?

nuts, yeah, microseconds. milliseconds is a typo. Userland counds in
microseconds. kernel code counts in jiffies. The code is sane, my emails
are not.

> There are 1,000,000 of those in a second, so 630,482 would still be half a
> second, which should be enough time for dozens of page faults (approach
> 100 of them), so I'm wondering what could possibly cause this measurement.
>

I'm not sure. I've noticed the odd twitch of long access time on rare
occasions but I'm not sure what causes them yet. I'm not sure if they are real
or confined to my code. All the time measurement stuff is in VMR::Time so at
least the timing code is confined for anyone who wants to verify.

> Or...was this process descheduled, and what you measured is the interval
> between when this process last ran and when the scheduler put it on the
> CPU again?
>

The measure is the time when the script asked the module to read a page.
The page is read by echoing to a mapanon_read proc entry. It's looking
like it takes about 350 microseconds to enter the module and perform the
read. I don't call schedule although it is possible I get scheduled. The only
way to be sure would be to collect all timing information within the module
which is perfectly possible. The only trouble is that if the module collects,
only one test instance can run at a time.

The way it is at the moment, I could run 100 instances of this test at the
same time and see how they interacted. The module is (or should be) SMP safe
and these tests were run on a duel processor. I'm waiting for a quad xeon
xseries to arrive so I can start running tests there.

> > withx shows spikey access times for pages which is consistent with large
> > apps starting up in the background
>
> It is?  Why?  Which is the ``large app'' here?  What does it mean to start
> up in the background, and why would that make the page access times
> inconsistent?
>

I didn't think about this but I suspected that what would happen is that the
apps and the test would compete for memory at the same time. Both would swap
out pages so there would be periods of quick accesses with a block of long
delays as more was swapped. I didnt' think this fully through yet and this is
30 seconds of reasoning so don't shoot me if I'm wrong.

At the time the test was started, 4 instances of konqueror were starting to
run and it hogs physical pages quiet a lot so it stands to reason it would
collide with the test. It's not a large app as such, but my machine isn't
exactly a powerhouse either.

> Noooooooooo!
>
> I can't think of a reason to test the VM under any one of the first three
> distributions.  I've never, *ever* seen or heard of a linear or gaussian
> distribution of page references.

I'm familiar with this problem and believe it or not, I've read a few papers on
the subject. The reason why I would write it is that it will help determine if
the page replacement algorithm is able to detect the working set or not. If
I refer to pages with a smooth distribution on an area about the size of
physical memory, the pages not been referenced should be swapped out.

It is more a test than a benchmark but it is somewhere where rmap should
shine. If I map memory the same size as physical memory, 2.4.20pre2 will
swap out the whole process because it can't reverse lookup pages. I want to
see will rmap selectively swap the correct pages. The timing isn't important
because for the length of the test, a FIFO or random selection isn't going
to be appreciably noticable. We need to see what the present pages were.

The second real reason to have this is that it is very easy to work out
in advance how the VM should perform for a given simple pattern. The test
should back up what the developer has in their head. It's much easier to
work initially with regular data than true trace information.

Lastly, this isn't justification for bad refernce data but even producing
data with a know pattern is more reproducable than running kernel
compiles, big dd's, large mmaps etc and timing the results.

> <Other page reference behaviour>

I see your point and mostly I agree. The problem is generating the correct
type of data is difficult and a full project in itself but generating
exact test data is not my immediate concern. The script is going to be
receiving it's reference data from a VMR::Reference perl module which is
responsible for generating page references. If someone feels that a better
reference pattern should be used, they can add it to the module and re-run
the tests. Either that or they can describe how to generate (or cite a
paper) to me and I'll investigate it if I have the time

> The last suggestion -- real trace data -- is the best one.  I do wonder
> why you put ``real'' in quotes.

Because all programs are real, even VM Regress but testing trace data from it
would be pretty useless. When I said "real", I meant real as in applications
like compilers, database servers, web browsers etc.

> I also wouldn't want trace data taken
> from *one* application or database.  You need a whole suite to represent
> the kinds of reference behavior that a VM system will need to manage.
>

Trace data would be great but I haven't been thinking about it long and
haven't come up with a reliable way of generating it yet. Given a bit of
thought, a patch to the kernel could be developed that would allow processes
to be attached to and read page faults but that is only part of the picture.
Trapping calls to mark_page_accessed might help but I need to think more and
generating real trace data is more important for a much later release. I'm
still working on framework here.

> Again, I recognize that this is a work in progress.  I'd be happy to see
> it yield worthwhile results.  If you use oversimplified models, it won't.
> The results will not be reliable for evaluating performance or making
> comparisons of VM systems.
>

Things have to start with simplified models because they can be easily
understood at a glance. I think it's a bit unreasonable to expect a full
featured suites at first release. As I said I have been working on this
particular benchmark 1 day, *1* day and the suite has only about 8 or 10
days of development time in total. I like to think I'm not a bad
programmer but I'm not God :-)

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

