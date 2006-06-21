Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWFUSvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWFUSvc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFUSvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:51:32 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:50714 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932342AbWFUSvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:51:31 -0400
Subject: Re: statistics infrastructure (in -mm tree) review
From: Martin Peschke <mp3@de.ibm.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: greg@kroah.com, akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060620095015.532901b4.rdunlap@xenotime.net>
References: <20060613232131.GA30196@kroah.com>
	 <20060613234739.GA30534@kroah.com>
	 <20060613171827.73cd0688.rdunlap@xenotime.net> <4490923D.10904@de.ibm.com>
	 <20060619221238.GA20018@kroah.com> <449816D1.3040104@de.ibm.com>
	 <20060620095015.532901b4.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 20:51:17 +0200
Message-Id: <1150915877.2938.133.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 09:50 -0700, Randy.Dunlap wrote:
> On Tue, 20 Jun 2006 17:40:01 +0200 Martin Peschke wrote:
> > Greg KH wrote:
> > >> 7) With regard to the delivery of statistic data to user land,
> > >> a library maintaining statistic counters, histograms or whatever
> > >> on behalf of exploiters doesn't need any help from the exploiter.
> > >> We can avoid the usual callbacks and code bloat in exploiters
> > >> this way.
> > > 
> > > I don't really understand what you are stating here.
> > 
> > Sorry.
> > 1,$s/exploiter/client/g
> > 
> > Any device driver or whatever gathering statistics data currently
> > has code dealing with showing the data. Usually, they have some
> > callbacks for procfs, sysfs or whatever.
> > 
> > My point is that, if a library keeps track of statistics on behalf
> > of its clients, no client needs to be called back in order to
> > merge, format, copy, etc. data being shown to users. The library
> > can handle as a background operation without disturbing clients.
> 
> That could be a good thing.  OTOH, it means that the library
> has to be either all-ways flexible or willing to change to
> accommodate clients since you can't predict the universe of all
> clients' requirements.

Right. I have made provisions for that to some degree.


First, I could imagine that the statistics data of a client requires
a new way its data should be aggregated and, therewith, requires
a new form of statistic result being shown to users.

I have scanned through the kernel sources for ways of aggregating
and showing statistics data. The usual constructs appear to be:

- counter
- histogram (for intervals), linear scale
- histogram (for intervals), logarithmic scale
- "histogram" for discrete and sparse values
- "utilisation indicator" or "fill level indicator" (num-min-avg-max)

These are implemented in my patches. I would expect these to cover most
requirements of possible new clients.

If another construct would be needed anyway, it can be added to the
statistics library by implemententing about half a dozen routines
described by struct statistic_discipline. I might be wrong, but I don't
think we would see an inflationary growth there.


Second, if a client needs to know anyway when users read statistics
data, e.g. because it wants to update some statistic then, it can
register an optional callback with the statistic infrastructure. This
callback is described in struct statistic_interface().


Third, if a client preferred its data being exported to user land
through a transport other than debugfs ... okay, then I will need to
enhance the statistics library. Moderate effort, I guess. Actually, I
already had a private patch that made the library use the evil procfs
instead of debugfs.


Fourth, if a client would like to take advantage of the library's
existing aggregation code, e.g. the library compiles a histogram on
behalf of the client, _but_ the client doesn't like the way the result
is shown, e.g. the client wants a sysfs file for each bucket instead of
a single debugfs file containing all data... well, that would defeat the
purpose of the library, if this kind of requirement gets out of hand.

OTOH, I don't see a real need for allowing that. Data can be reformatted
and rearranged in any possible way in user space.

> > >> 8) If some library functions are responsible for showing data, and the
> > >> exploiter is not, we can achieve a common format for statistics data.
> > >> For example, a histogram about block I/O has the same format as
> > >> a histogram about network I/O.
> > >> This provides ease of use and minimises the effort of writing
> > >> scripts that could do further processing (e.g. formatting as
> > >> spreadsheats or bar charts, comparison and summarisation of
> > >> statistics, ...)
> > > 
> > > Common functionality and formats would be wonderful.  But I'm not sure
> > > you can guarantee that we really want the network io and block io
> > > statistics in the same format, as they are fundimentally different
> > > things.
> > 
> > Subsystems are free to gather as many/few statistics as required.
> > And I am not trying to enforce semantics.
> > 
> > All I am saying is that, if two statistics are aggregated using similar
> > algorithms, then the results should be presented or formatted in a
> > similar way.
> 
> Am I reading this correctly?  Are you trying to put presentation
> format in the statistics library in the kernel???

Aehm, no.

What's needed is simply an understanding between kernel and user space
on how statistics data reads.

If the interface were ioctl-based, I would need to define some
structures containing the data.
If the interface was netlink based, I would need to define some packet
headers and fields (see taskstats, for example).
And so on...

Since my proposed interface uses debugfs, I have defined a minimal set
of rules describing the ASCII output (compare sample output below):

- A file contains all statistics of the measured entity.
  So, each output line is labeled with the name of the statistic
  it belongs to.

- Each statistic may consist of several pieces, that is, output lines.
  So, each line of a multi-line statistic has another label,
  e.g. ">256" marking a histogram's bucket for values >256.

These rules merely strive for unambiguousness of the file content.
Coincidentally, readability isn't that bad, as well.

> > My assumption is that the format of results doesn't depend on the
> > the semantics of the data feeding a statistic. But it depends on the
> > way we aggregate data.
> > 
> > For example, there is no reason why statistic A of subsystem 1
> > aggregated in the form of a histogram should have a different format
> > than statistic B of subsystem 2 also being aggregated in the form
> > of a histogram.
> > 
> > A <=0 0
> > A <=1 0
> > A <=2 3
> > A <=4 7
> > A <=8 29
> > A <=16 285
> > A <=32 295
> > A <=64 96
> > A <=128 52
> > A <=256 3
> > A >256 1
> > 
> > 
> > B <=10 1 
> > B <=20 3
> > B <=30 92
> > B <=40 251
> > ...
> > B <=490 34462
> > B <=500 23434
> > B >500 0
> > 
> > Semantics are different; statistic names are different;
> > number of buckets, "diameter" of buckets, scale etc. might be different;
> > basic format of results is identical - as long as both statistics are
> > aggregated the same way (as histograms, in this case).
> > 
> > A library can provide a common format, because semantics just don't
> > matter. Its statistic_add() function (or whatever we want to call it)
> > has no idea about the actual semantics of the incremental statistic data
> > it accepts and processes according to abstract rules.
> > 
> > And I think a library should provide a common format, because it
> > makes it fun poking in the aggregated data, and writing a script that
> > does further processing of that data.
> 
> Do you mean a userspace library here?  The statements still apply
> to a userspace library.

No, I am still talking about the kernel's statistic library functions.

> > > Also, you will have to live with the existing interfaces, as we can't
> > > break them, so porting them will not happen.
> > 
> > Okay.
> > A library could help to avoid a further proliferation of interfaces.
> > 
> > >> 9) For performance reasons, per-cpu data and minimal locking
> > >> (local_irq_save/restore) should be used.
> > >> Adds to complexity, though.
> > > 
> > > If necessary.  Is this really necessary?
> > 
> > I would think so.
> 
> Do your converted clients use all of the stat. infrastructure
> interfaces or are some of them added just to round out the
> full API?

My client patches for zfcp and scsi together use all of the
statistic infrastructure's features and interfaces, except for
the optional callback in statistic_interface and the related
statistic_set().

> > >> 21) Processing of (X, Y) according to abstract rules imposed by
> > >> counters, histograms etc. doesn't require any knowledge about the
> > >> semantics of X or Y.
> > >>
> > >> 22) There might be statistic counters that exploiters want to use and
> > >> maintain on their own, and which users still may want to have a look at
> > >> along with other statistics. Statistic_set() fits in here nicely.
> > > 
> > > 
> > > Ok, these are all implementation details.
> > 
> > Maybe. But at least 21) is fundamental, as it provides a base for
> > writing such a library: The library deals with a defined form of
> > data, regardless of the semantics of the data.
> 
> Does 22) make the library somewhat extensible?  If not, does
> anything do that?

21) or 22) ??

I don't understand what you are asking. Extensible in what regard?
 
> > >>>> And what does this mean for relayfs?  Those developers tuned that code
> > >>>> to the nth degree to get speed and other goodness, and here you go just
> > >>>> ignoring that stuff and add yet another way to get stats out of the
> > >>>> kernel.  Why should I use this instead of my own code with relayfs?
> > >>> Good questions.
> > >> Relayfs is a nice feature, but not appropriate here.
> > >>
> > >> For example, during a performance measurements I have seen
> > >> SCSI I/O related statistics being updated millions of times while
> > >> I was just having a short lunch break. Some of them just increased
> > >> a counter, which is pretty fast if done immediately in the kernel.
> > >> If all these updates update would have to be relayed to user space
> > >> to just increase a counter maintained in user space.. urgh, surely
> > >> more expensive and not the way to go.
> 
> Oh really, I wouldn't expect such a poor design (of pushing each
> counter update to userspace) to be considered seriously.
> It should be more like a procfs^W sysfs entry at least, or something
> similar to a MIB, or what iostat does.

We are in agreement.

> Does iostat not even
> come close to what you want for SCSI I/O statistics?

Not really.

First, it measures from __make_request to end_that_request_last.
So it's not very close to the point in time when I/Os hit the wire.

Second, it merely provides sums and average values for all requests of a
device. It doesn't provide much detail about the actual traffic pattern,
like histograms for request latencies and request sizes.

Thanks, Martin

