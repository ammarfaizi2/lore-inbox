Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318732AbSHLQCo>; Mon, 12 Aug 2002 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSHLQCn>; Mon, 12 Aug 2002 12:02:43 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:24588 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S318732AbSHLQCk>;
	Mon, 12 Aug 2002 12:02:40 -0400
Date: Mon, 12 Aug 2002 17:06:22 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@arcor.de>,
       Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
In-Reply-To: <Pine.LNX.4.44L.0208121101090.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208121637100.16360-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Rik van Riel wrote:

> On the other hand, if somebody could code up some scriptable
> benchmarks that approximate real workloads better than the
> current benchmarks do, I'd certainly appreciate it.
>

This looks like an overall system benchmark again and while it would be
great to have, it is not what I aim to provide here with VM Regress.

> For web serving, for example, I wouldn't mind a benchmark that:
>
> <Benchmark snipped>

That benchmarks like it would be more likely to test network throughput
than VM performance although I could be misunderstanding your benchmark,
apologies if I am. The 20 images would either get mmaped by the server or
else will be read from the buffer cache. Once it's in memory, it's just a
case of retransmitting each time which doesn't appear particularly
interesting to me from a VM perspective.

In VM Regress land, I would be much more likely to provide a benchmark
that did something like the folllowing. (Remember that VM Regress aims to
provide more than been a pure benchmarking tool. Benchmarking is just one
aspect)

1) Memory map with MAP_SHARED a number of regions
   1a) Each region is 512 pages large (2MB on a x86)
   1b) Create a number of regions until a percentage of memoryt is used
       that would hit the various watermarks of the zones

2) Over 1 hour do, reference regions with a gaussion pattern to simulate
   popular pages and images

3) At the end, give the best, worst and average time to read a region.
   Print out what regions are still resident in memory and compare that to
   the references. Regions referenced often should still be in memory and
   dead regions should be in swap

4) Repeat the test altering the following parameters
   - The percentage of physical memory consumed to see what gets swapped out
   - Simulate disk buffer usage instead of mmap'ing regions

With a low percentage of physical memory used, there shouldn't be anything
too interesting happening because cache should be doing most of the work.
With more regions, it should be noted how the VM holds up, how well it
selects regions to swap out and how long it takes to find the proper pages
and so on.

This type of benchmark is far away but I already do most of this work with
the fault.o module. I memory map a region of which the size is related to
the amount of physical memory (more accuratly it's related to the zone
watermarks for the zone known to be affected by the test) and touch every
page in the region. For n passes, I check if each page is present, if it's
swapped out, I touch it to swap it back in. I then print out how many
pages were swapped in, how many pages are physically present in the region
and how long that pass took in milliseconds.

That is most of the work there so this isn't quiet vapourware, more a
really dense fog. I just need a few more bits and pieces such as printing
graphs of present pages vs references and meaningful data is easily
accessible

> Then we can plot both kinds of response time against the number
> of users and we have an idea of the web serving performance of
> a particular system ... without focussing on, or even measuring,
> the unrealistic "servers N pages per minute" number.
>
> Volunteers ? ;)
>

Not for that particular benchmark, but how useful would the VM Regress
equivilant be?

--
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

