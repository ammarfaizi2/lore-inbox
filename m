Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSHPVZj>; Fri, 16 Aug 2002 17:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317695AbSHPVZj>; Fri, 16 Aug 2002 17:25:39 -0400
Received: from exchange.amherst.edu ([148.85.136.11]:44301 "EHLO
	exchange.amherst.edu") by vger.kernel.org with ESMTP
	id <S317257AbSHPVZh>; Fri, 16 Aug 2002 17:25:37 -0400
Date: Fri, 16 Aug 2002 17:29:31 -0400
Subject: Re: [PATCH] rmap 14
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Bill Huey <billh@gnuppy.monkey.org>, Rik van Riel <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
To: Mel <mel@csn.ul.ie>
From: Scott Kaplan <sfkaplan@cs.amherst.edu>
In-Reply-To: <Pine.LNX.4.44.0208161917540.7684-100000@skynet>
Message-Id: <40D0F925-B15F-11D6-972F-000393829FA4@cs.amherst.edu>
Content-Transfer-Encoding: 7bit
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mel,

I appreciate your efforts; the goal is a good one, but I'm concerned about 
some parts of the direction you seem to be taking.

On Friday, August 16, 2002, at 05:02 PM, Mel wrote:

> start    was run at system startup
> updatedb is output after updatedb was running 2 minutes
> withx    is run with the system running X, konqueror and a few eterms

I will acknowledge that you're at the beginning of a long process, and 
that you have much more that you plan to add, but I feel the need to point 
out that this is a *very* small test suite.  ``start'' is more of a 
curiosity than an interesting data point.  The other two are not 
unreasonable starting points.

> updatedb was fine until near the end. At that stage, buffers could not be
> freed out that were filled by updatedb and it was having to look hard. So
> you can see, times are quick for ages and then suddenly rise to an average
> access time of about 3000 milliseconds with one access at 630482
> milliseconds!!

You may want to check your code for sanity:  There are only 1,000 
milliseconds in a second, and I'm skeptical that there was a 630 second 
(that is, 10+ minute) reference.  Were there, perhaps, microseconds?  
There are 1,000,000 of those in a second, so 630,482 would still be half a 
second, which should be enough time for dozens of page faults (approach 
100 of them), so I'm wondering what could possibly cause this measurement.

Or...was this process descheduled, and what you measured is the interval 
between when this process last ran and when the scheduler put it on the 
CPU again?

> withx shows spikey access times for pages which is consistent with large
> apps starting up in the background

It is?  Why?  Which is the ``large app'' here?  What does it mean to start 
up in the background, and why would that make the page access times 
inconsistent?

> Now... where this is going. I plan to write a module that will generate
> page references to a given pattern. Possible pattern references are
>
> o Linear
> o Pure random
> o Random with gaussian distribution
> o Smooth so the references look like a curve
> o Trace data taken from a "real" application or database

Noooooooooo!

I can't think of a reason to test the VM under any one of the first three 
distributions.  I've never, *ever* seen or heard of a linear or gaussian 
distribution of page references.  As for uniform random (which is what I 
assume you mean by ``pure random''), that's not worth testing.  If a 
workload presents a pure random reference pattern, any on-line policy is 
screwed.  No process can do this on a data set that doesn't fit in memory,
  and if it does, there's no hope.

The fourth suggestion -- some negative exponential distribution -- is the 
kind of thing about which this group had a long discussion just a few 
weeks ago.  It's a mostly-bad idea.  In short:  If you have a negative 
exponential curve for your distribution, the best on-line policy is LRU, 
and nothing else will improve on it -- it's been proven in the literature 
on the LRUSM model of program behavior long ago.  It's when reference 
behavior *deviates* from that smooth curve that a policy may perform 
better than simple LRU.  Moreover, real workloads differ from that smooth 
curve over time, particularly during phase changes, which is where the 
*real* test of a VM policy occurs.  There's been plenty of work done on 
mathematical models for program behavior.  None of it has been sufficient 
for qualitative (that is, rank ordering) or quantitative evaluation of 
memory management policies.  Those models that come close are complex to 
work with, requiring the setting of a large number of parameters.

The last suggestion -- real trace data -- is the best one.  I do wonder 
why you put ``real'' in quotes.  I also wouldn't want trace data taken 
from *one* application or database.  You need a whole suite to represent 
the kinds of reference behavior that a VM system will need to manage.

Again, I recognize that this is a work in progress.  I'd be happy to see 
it yield worthwhile results.  If you use oversimplified models, it won't.  
The results will not be reliable for evaluating performance or making 
comparisons of VM systems.

Scott
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (Darwin)
Comment: For info see http://www.gnupg.org

iD8DBQE9XW6+8eFdWQtoOmgRAqjiAJ0ZlrQGOg3MFzXYyi+SdvKIa/bvOgCeOWak
7put0ihQbEY0wNXD+objEos=
=4IQt
-----END PGP SIGNATURE-----

