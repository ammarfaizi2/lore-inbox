Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVBHAtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVBHAtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVBHAtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:49:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47049 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261362AbVBHAtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:49:40 -0500
Date: Mon, 7 Feb 2005 16:49:37 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: prezeroing V6 [2/3]: ScrubD
In-Reply-To: <20050207163035.7596e4dd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502071646170.29971@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
 <20050207163035.7596e4dd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> > called scrubd.
>
> What were the benchmarking results for this work?  I think you had some,
> but this is pretty vital info, so it should be retained in the changelogs.

Look at the early posts. I plan to put that up on the web. I have some
stats attached to the end of this message from an earlier post.

> Having one kscrubd per node seems like the right thing to do.

Yes that is what is happening. Otherwise our NUMA stuff would not work
right ;-)

> Should we be managing the kernel threads with the kthread() API?

What would you like to manage?

------ Earlier post
The scrub daemon is invoked when a unzeroed page of a certain order has
been generated so that its worth running it. If no higher order pages are
present then the logic will favor hot zeroing rather than simply shifting
processing around. kscrubd typically runs only for a fraction of a second
and sleeps for long periods of time even under memory benchmarking.
kscrubd
performs short bursts of zeroing when needed and tries to stay out off the
processor as much as possible.

The result is a significant increase of the page fault performance even
for
single threaded applications (i386 2x PIII-450 384M RAM allocating 256M in
each run):

w/o patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0   1    1    0.006s      0.389s   0.039s157455.320 157070.694
  0   1    2    0.007s      0.607s   0.032s101476.689 190350.885

w/patch
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0   1    1    0.008s      0.083s   0.009s672151.422 664045.899
  0   1    2    0.005s      0.129s   0.008s459629.796 741857.373

The performance can only be upheld if enough zeroed pages are available.
In a heavy memory intensive benchmark the system may run out of these very
fast but the efficient algorithm for page zeroing still makes this a
winner
(2 way system with 384MB RAM, no hardware zeroing support). In the
following
measurement the test is repeated 10 times allocating 256M each in rapid
succession which would deplete the pool of zeroed pages quickly):

w/o patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0  10    1    0.058s      3.913s   3.097s157335.774 157076.932
  0  10    2    0.063s      6.139s   3.027s100756.788 190572.486

w/patch
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0  10    1    0.059s      1.828s   1.089s330913.517 330225.515
  0  10    2    0.082s      1.951s   1.094s307172.100 320680.232

Note that zeroing of pages makes no sense if the application
touches all cache lines of a page allocated (there is no influence of
prezeroing on benchmarks like lmbench for that reason) since the extensive
caching of modern cpus means that the zeroes written to a hot zeroed page
will then be overwritten by the application in the cpu cache and thus
the zeros will never make it to memory! The test program used above only
touches one 128 byte cache line of a 16k page (ia64). Sparsely
populated and accessed areas are typical for lots of applications.

Here is another test in order to gauge the influence of the number of
cache
lines touched on the performance of the prezero enhancements:

 Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
  1  1    1   1    0.01s      0.12s   0.01s500813.853 497925.891
  1  1    1   2    0.01s      0.11s   0.01s493453.103 472877.725
  1  1    1   4    0.02s      0.10s   0.01s479351.658 471507.415
  1  1    1   8    0.01s      0.13s   0.01s424742.054 416725.013
  1  1    1  16    0.05s      0.12s   0.01s347715.359 336983.834
  1  1    1  32    0.12s      0.13s   0.02s258112.286 256246.731
  1  1    1  64    0.24s      0.14s   0.03s169896.381 168189.283
  1  1    1 128    0.49s      0.14s   0.06s102300.257 101674.435

The benefits of prezeroing are reduced to minimal quantities if all
cachelines of a page are touched. Prezeroing can only be effective
if the whole page is not immediately used after the page fault.


