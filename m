Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSHPU7L>; Fri, 16 Aug 2002 16:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHPU7K>; Fri, 16 Aug 2002 16:59:10 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:48394 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S317181AbSHPU7E>;
	Fri, 16 Aug 2002 16:59:04 -0400
Date: Fri, 16 Aug 2002 22:02:53 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH] rmap 14
In-Reply-To: <20020816022119.GA1629@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0208161917540.7684-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Bill Huey wrote:

> Again, the combination of a kind of felt increase in intelligence in
> swap decisions and increase in interactivity made my machine feel
> substantally smoother, but it needs to be backed up by other people's
> experiences with it.
>
> I wish there was a test for this kind of thing.
>

Blatant plug but it's what I'm working on with VM Regress. At the version
I'm working on, I've started the first benchmark but I've only been
working on it a day so it's a bit to go yet. As a start, we'll be able to
benchmark page access times and swap decisions. These are three live tests
run against 2.4.20pre2 but the suite is known to compile with the latest
2.5 kernel and with 2.4.19-rmap14.

http://www.csn.ul.ie/~mel/projects/vmregress/2.4.20pre2/start/mapanon.html
http://www.csn.ul.ie/~mel/projects/vmregress/2.4.20pre2/updatedb/mapanon.html
http://www.csn.ul.ie/~mel/projects/vmregress/2.4.20pre2/withx/mapanon.html

start    was run at system startup
updatedb is output after updatedb was running 2 minutes
withx    is run with the system running X, konqueror and a few eterms

The information is still a bit sparse but still, things can be told. The
test works by using three kernel modules

mapanon - Will mmap, read/write, close mmaped regions for a caller
pagemap - Print out pages swapped/present in all VMA's
zone    - Print out all zone information

A perl script uses these from userspace to benchmark how quickly data can
be referenced for a given reference pattern. The benchmark isn't finished
yet so all that is done is a linear read through memory once, hence all
page references are 1.

The reports have three sections. The first is details of the test. The
second is a graph showing how long it took to read/write a page in
milliseconds. Note that they are fixed at a min access time of 350 because
of module overhead and test overhead. This could be "removed" easily
enough to give a more realistic view of real page access. The third is a
graph showing page reference counts in green and pages present in read.
The reference line is flat because it's one scan through the region.

start shows that page access times were pretty much constant, not
suprising

updatedb was fine until near the end. At that stage, buffers could not be
freed out that were filled by updatedb and it was having to look hard. So
you can see, times are quick for ages and then suddenly rise to an average
access time of about 3000 milliseconds with one access at 630482
milliseconds!!

withx shows spikey access times for pages which is consistent with large
apps starting up in the background

Now... where this is going. I plan to write a module that will generate
page references to a given pattern. Possible pattern references are

o Linear
o Pure random
o Random with gaussian distribution
o Smooth so the references look like a curve
o Trace data taken from a "real" application or database

The real application could be cool if I could acquire the data and would
produce "real" info. If we could simulate a database accessing for
instance, it could be shown exactly how the VM performed. But as it is,
some benchmarks can be easily adjusted to use VM Regress. If they just
read /proc/vmregress/pagemap, they will know what pages are present in
memory and what got swapped. A perl library VMR::Pagemap is provided to
decode the information.

Once the test can be run on the stock kernel, it can be run against rmap,
aa, 2.5.x or whatever other sort kernels are out there so emperical data
can be produced. The first major benchmark that will be produced will be
something like Rik's webserver benchmark.

Instead of the module memory mapping a region, it will memory map a set of
web pages and images. A set of bots will then act like users browsing. The
bot will say how long it took to retrive pages with a best, slowest and
average access time. The kernel modules will dump out what pages were
present, kernel statistics and so on.

The release date for the next version with this benchmark is next week at
some stage. I'm not working on this over the weekend so I estimate I'll
have this bench ready by Wednesday and I'll give rmap a run with it to
make sure it works correctly. Either way "your wish" is on the way

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

