Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281530AbRLEGGN>; Wed, 5 Dec 2001 01:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281205AbRLEGGE>; Wed, 5 Dec 2001 01:06:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8576 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281245AbRLEGFx>;
	Wed, 5 Dec 2001 01:05:53 -0500
Date: Tue, 04 Dec 2001 22:05:11 -0800 (PST)
Message-Id: <20011204.220511.71088411.davem@redhat.com>
To: lm@bitmover.com
Cc: Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011204192317.N7439@work.bitmover.com>
In-Reply-To: <20011204163646.M7439@work.bitmover.com>
	<20011204.183601.22018455.davem@redhat.com>
	<20011204192317.N7439@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Tue, 4 Dec 2001 19:23:17 -0800

      There is absolutely zero chance that you can get the same level
      of scaling with the same number of locks using the traditional
      approach.  I'll go out on a limb and predict it is at least 100x as many locks.

Coming from the background of having threaded from scratch a complete
networking stack (ie. my shit doesn't stink and I'm here to tell you
about it :-))) I think your claims are pretty much out of whack.

Starting from initial implementation to having all the locking
disappear from the kernel profiles during any given load was composed
of three tasks:

	1) Is this object almost entirely reader based (or the corrolary)?
	   Use special locking that exploits this.  See linux/brlock.h
	   for one such "special locking" we invented to handle these
	   cases optimally.

	   This transformation results in ZERO shared dirty cache
	   lines if the initial analysis is correct.

	2) Can we "fan out" the locking so that people touching
           seperate objects %99 of the time touch different cache
	   lines?

	   This doesn't mean "more per-object locking", it means more
	   like "more per-zone locking".  Per-hashchain locking falls
	   into this category and is very effective for any load I
	   have ever seen.

	3) Is this really a per-cpu "thing"?  The per-cpu SKB header
	   caches are an example of this.  The per-cpu SLAB magazines
	   are yet another.

Another source of scalability problems has nothing to do with whether
you do some kind of clustering or not.  You are still going to get
into situations where multiple cpus want (for example) page 3 of
libc.so :-)  (what I'm trying to say is that it is a hardware issue
in some classes of situations)

Frankly, after applying #1 and/or #2 and/or #3 above to what shows up
to have contention (I claim the ipv4 stack to have had this done for
it) there isn't much you are going to get back.  I see zero reasons to
add any more locks to ipv4, and I don't think we've overdone it in the
networking either.

Even more boldly, I claim that Linux's current ipv4 scales further
than anything coming out of Sun engineering.  From my perspective
Sun's scalability efforts are more in line with "rubber-stamp"
per-object locking when things show up in the profiles than anything
else.  Their networking is really big and fat.  For example the
Solaris per-socket TCP information is nearly 4 times the size of that
in Linux (last time I checked their headers).  And as we all know
their stuff sits on top of some thick infrastructure (ie. STREAMS)
(OK, here is where someone pops up a realistic networking benchmark
where we scale worse than Solaris.  I would welcome such a retort
because it'd probably end up being a really simple thing to fix.)

My main point: I think we currently scale as far as we could in the
places we've done the work (which would include networking) and it
isn't "too much locking".

The problem areas of scalability, for which no real solution is
evident yet, involve the file name lookup tree data structures,
ie. the dcache under Linux.  All accesses here are tree based, and
everyone starts from similar roots.  So you can't per-node or
per-branch lock as everyone traverses the same paths.  Furthermore you
can't use "special locks" as in #1 since this data structure is
neither heavy reader nor heavy writer.

But the real point here is that SMP/cc clusters are not going to solve
this name lookup scaling problem.

The dcache_lock shows up heavily on real workloads under current
Linux.  And it will show up just as badly on a SMP/cc cluster.  SMP/cc
clusters talk a lot about "put it into a special filesystem and scale
that all you want" but I'm trying to show that frankly thats where the
"no solution evident" scaling problems actually are today.

If LLNL was not too jazzed up about your proposal, I right now don't
blame them.  Because with the information I have right now, I think
your claims about it's potential are bogus.

I really want to be shown wrong, simply because the name path locking
issue is one that has been giving me mental gas for quite some time.

Another thing I've found is that SMP scalability changes that help
the "8, 16, 32, 64" cpu case almost never harm the "4, 2" cpu
cases.  Rather, they tend to improve the smaller cpu number cases.
Finally, as I think Ingo pointed out recently, some of the results of
our SMP work has even improved the uniprocessor cases.

Franks a lot,
David S. Miller
davem@redhat.com
