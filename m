Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBFTVe>; Tue, 6 Feb 2001 14:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129138AbRBFTVZ>; Tue, 6 Feb 2001 14:21:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12036 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129066AbRBFTVP>; Tue, 6 Feb 2001 14:21:15 -0500
Date: Tue, 6 Feb 2001 11:20:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061338380.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.10.10102061059100.1474-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Ben LaHaise wrote:
> On Tue, 6 Feb 2001, Ingo Molnar wrote:
> 
> > If you are merging based on (device, offset) values, then that's lowlevel
> > - and this is what we have been doing for years.
> >
> > If you are merging based on (inode, offset), then it has flaws like not
> > being able to merge through a loopback or stacked filesystem.
> 
> I disagree.  Loopback filesystems typically have their data contiguously
> on disk and won't split up incoming requests any further.

Face it.

You NEED to merge and sort late. You _cannot_ do a good job early. Early
on, you don't have any concept of what the final IO pattern will be: you
will only have that once you've seen which requests are still pending etc,
something that the higher level layers CANNOT do.

Do you really want the higher levels to know about per-controller request
locking etc? I don't think so. 

Trust me. You HAVE to do the final decisions late in the game. You
absolutely _cannot_ get the best performance except for trivial and
uninteresting cases (ie one process that wants to read gigabytes of data
in one single stream) otherwise.

(It should be pointed out, btw, that SGI etc were often interested exactly
in the trivial and uninteresting cases. When you have the DoD asking you
to stream satellite pictures over the net as fast as you can, money being
no object, you get a rather twisted picture of what is important and what
is not)

And I will turn your own argument against you: if you do merging at a low
level anyway, there's little point in trying to do it at a higher level. 

Higher levels should do high-level sequencing. They can (and should) do
some amount of sorting - the lower levels will still do their own sort as
part of the merging anyway, and the lower level sorting may actually end
up being _different_ from a high-level sort because the lower levels know
about the topology of the device, but higher levels giving data with
"patterns" to it only make it easier for the lower levels to do a good
job. So high-level sorting is not _necessary_, but it's probably a good
idea.

High-level merging is almost certainly not even a good idea - higher
levels should try to _batch_ the requests, but that's a different issue,
and is again all about giving lower levels "patterns". It's can also about
simple issues like cache locality - batching things tends to make for
better icache (and possibly dcache) behaviour.

So you should separate out the issue of batching and merging. An dyou
absolutely should realize that you should NOT ignore Ingo's arguments
about loopback etc just because they don't fit the model you WANT them to
fit. The fact is that higher levels should NOT know about things like RAID
striping etc, yet that has a HUGE impact on the issue of merging (you do
_not_ want to merge requests to separate disks - you'll just have to split
them up again).

> Here are the points I'm trying to address:
> 
> 	- reduce the overhead in submitting block ios, especially for
> 	  large ios. Look at the %CPU usages differences between 512 byte
> 	  blocks and 4KB blocks, this can be better.

This is often a filesystem layer issue. Design your filesystem well, and
you get a lot of batching for free.

You can also batch the requests - this is basically what "readahead" is.
That helps a lot. But that is NOT the same thing as merging. Not at all.
The "batched" read-ahead requests may actually be split up among many
different disks - and they will each then get separately merged with
_other_ requests to those disks. See?

And trust me, THAT is how you get good performance. Not by merging early.
By merging late, and letting the disk layers do their own thing.

> 	- make asynchronous io possible in the block layer.  This is
> 	  impossible with the current ll_rw_block scheme and io request
> 	  plugging.

I'm surprised you say that. It's not only possible, but we do it all the
time. What do you think the swapout and writing is? How do you think that
read-ahead is actually _implemented_? Right. Read-ahead is NOT done as a
"merge" operation. It's done as several asynchronous IO operations that
the low-level stuff can choose (or not) to merge.

What do you think happens if you do a "submit_bh()"? It's a _purely_
asynchronous operation. It turns synchronous when you wait for the bh, not
before.

Your argument is nonsense.

> 	- provide a generic mechanism for reordering io requests for
> 	  devices which will benefit from this.  Make it a library for
> 	  drivers to call into.  IDE for example will probably make use of
> 	  it, but some high end devices do this on the controller.  This
> 	  is the important point: Make it OPTIONAL.

Ehh. You've just described exatcly what we have.

This is what the whole elevator thing _is_. It's a library of routines.
You don't have to use them, and in fact many things DO NOT use them. The
loopback driver, for example, doesn't bother with sorting or merging at
all, because it knows that it's only supposed to pass the request on to
somebody else - who will do a hell of a lot better job of it.

Some high-end drivers have their own merging stuff, exactly because they
don't need the overhead - you're better off just feeding the request to
the controller as soon as you can, as the controller itself will do all
the merging and sorting anyway.

> You mentioned non-spindle base io devices in your last message.  Take
> something like a big RAM disk.  Now compare kiobuf base io to buffer head
> based io.  Tell me which one is going to perform better.

Buffer heads? 

Go and read the code.

Sure, it has some historical baggage still, but the fact is that it works
a hell of a lot better than kiobufs and it _does_ know about merging
multiple requests and handling errors in the middle of one request etc.
You can get the full advantage of streaming megabytes of data in one
request, AND still get proper error handling if it turns out that one
sector in the middle was bad.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
