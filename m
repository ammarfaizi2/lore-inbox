Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283613AbRLEAhM>; Tue, 4 Dec 2001 19:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283620AbRLEAhE>; Tue, 4 Dec 2001 19:37:04 -0500
Received: from bitmover.com ([192.132.92.2]:12006 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S283613AbRLEAgs>;
	Tue, 4 Dec 2001 19:36:48 -0500
Date: Tue, 4 Dec 2001 16:36:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <20011204163646.M7439@work.bitmover.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Lars Brinkhoff <lars.spam@nocrew.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	hps@intermeta.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com> <2457910296.1007480257@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2457910296.1007480257@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Tue, Dec 04, 2001 at 03:37:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 03:37:37PM -0800, Martin J. Bligh wrote:
> >> > Premise 3: it is far easier to take a bunch of operating system images
> >> >    and make them share the parts they need to share (i.e., the page
> >> >    cache), than to take a single image and pry it apart so that it
> >> >    runs well on N processors.
> >> 
> >> Of course it's easier. But it seems like you're left with much more
> >> work to reiterate in each application you write to run on this thing.
> >> Do you want to do the work once in the kernel, or repeatedly in each
> >> application?
> > 
> > There seems to be a little misunderstanding here; from what
> > I gathered when talking to Larry, the idea behind ccClusters
> > is that they provide a single system image in a NUMA box, but
> > with separated operating system kernels.

Right except NUMA is orthogonal, ccClusters work fine on a regular SMP 
box.

> OK, then I've partially misunderstood this ... can people provide some 
> more reference material? Please email to me, and I'll collate the results
> back to the list (should save some traffic).

I'll try and type in a small explanation, I apologize in advance for the
bervity, I'm under a lot of pressure on the BK front these days...

The most recent set of slides are here:

    http://www.bitmover.com/ml/slide01.html

A couple of useful papers are at

    http://www.bitmover.com/llnl/smp.pdf
    http://www.bitmover.com/llnl/labs.pdf

The first explains why I think fine grained multi threading is a mistake
and the second is a paper I wrote to try and get LLNL to push for what
I called SMP clusters (which are not a cluster of SMPs, they are a 
cluster of operating system instances on a single SMP).

The basic idea is this: if you consider the usefulness of an SMP versus a
cluster, the main thing in favor of the SMP is

    all processes/processors can share the same memory at memory speeds.
    I typically describe this as "all processes can mmap the same data".
    A cluster loses here, even if it provides DSM over a high speed
    link, it isn't going to have 200 ns caches misses, it's orders of
    magnitude slower.  For a lot of MPI apps that doesn't matter, but
    there are apps for which high performance shared memory is required.

There are other issues like having a big fast bus, load balancing, etc.,
but the main thing is that you can share data quickly and coherently.
If you don't need that performance/coherency and you can afford to 
replicate the data, a traditional cluster is a *much* cheaper and 
easier answer.  Many problems, such as web server farms, are better
done on Beowulf style clusters than an SMP, they will actually scale
better.

OK, so suppose we focus on the SMP problem space.  It's a requirement
that all the processes on all the processors need to be able to access
memory coherently.  DSM and/or MPI isn't an answer for this problem 
space.

The traditional way to use an SMP is to take a single OS image and 
"thread" it such that all the CPUs can be in the OS at the same time.
Pretty much all the data structures need to get a lock and each CPU
takes the lock before it uses the data structure.  The limit of the
ratio of locks to cache lines is 1:1, i.e., each cache line will need
a lock in order to get 100% of the scaling on the system (yes, I know
this isn't quite true but it is close and you get the idea).

Go read the "smp.pdf" paper for my reasons on why this is a bad approach,
I'll assume for now you are willing to agree that it is for the purposes
of discussion.

If we want to get the most use out of big SMP boxes but we also want to
do the least amount of "damage" in the form of threading complexity in
the source base.  This is a "have your cake and eat it too" goal, one
that I think is eminently reachable.

So how I propose we do this is by booting multiple Linux images on
a single box.  Each OS image owns part of the machine, 1-4 CPUs, 0 or
more devices such as disk, ethernet, etc., part of memory.  In addition,
all OS images share, as a page cache, part of main memory, typically
the bulk of main memory.

The first thing to understand that the *only* way to share data is in
memory, in the globally shared page cache.  You do not share devices,
devices are proxied.  So if I want data from your disk or file system,
I ask you to put it in memory and then I mmap it.  In fact, you really
only share files and you only share them via mmap (yeah, read and write
as well but that's the uninteresting case).

This sharing gets complex because now we have more than one OS image
which is managing the same set of pages.  One could argue that the 
code complexity is just as bad as a fine grained multi threaded OS
image but that's simply incorrect.  I would hide almost 100% of this
code in a file system, with some generic changes (as few as possible)
in the VM system.  There are some changes in the process layer as well,
but we'll talk about them later.

If you're sitting here thinking about all the complexity involved in
sharing pages, it is really helpful to think about this in the following
way (note you would not actually implement it like this in the long
run but you could start this way):

Imagine that for any given file system there is one server OS image and N
client os images.  Imagine that for each client, there is a proxy process
running on behalf of the client on the server.  Sort of like NFS biods.
Each time the client OS wants to do an mmap() it asks the proxy to do
the mmap().  There are some corner cases but if you think about it, by
having the proxies do the mmaps, we *know* that all the server OS data
structures are correct.  As far as the server is concerned, the remote
OS clients are no different than the local proxy process.  This is from
the correctness point of view, not the performance point of view.

OK, so we've handled setting up the page tables, but we haven't handled
page faults or pageouts.  Let's punt on pageouts for the time being,
we can come back to that.  Let's figure out a pagefault path that will
give correct, albeit slow, behaviour.  Suppose that when the client faults
on a page, the client side file system sends a pagefault message to the
proxy, the proxy faults in the page, calls a new vtop() system call to
get the physical page, and passes that page descriptor back to the client
side.  The client side loads up the TLB & page tables and away we go.
Whoops, no we don't, because the remote OS could page out the page and
the client OS will get the wrong data (think about a TLB shootdown that
_didn't_ happen when it should have; bad bad bad).  Again, thinking 
just from the correctness point of view, suppose the proxy mlock()ed
the page into memory.  Now we know it is OK to load it up and use it.
This is why I said skip pageout for now, we're not going to do them 
to start with anyway.

OK, so start throwing stones at this.  Once we have a memory model that
works, I'll go through the process model.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
