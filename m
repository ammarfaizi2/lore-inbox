Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264218AbRFHQx2>; Fri, 8 Jun 2001 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264221AbRFHQxT>; Fri, 8 Jun 2001 12:53:19 -0400
Received: from www.wen-online.de ([212.223.88.39]:28944 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264218AbRFHQxD>;
	Fri, 8 Jun 2001 12:53:03 -0400
Date: Fri, 8 Jun 2001 18:51:37 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Tobias Ringstrom <tori@unhappy.mine.nu>
cc: Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106081532140.2013-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.33.0106081835200.227-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Tobias Ringstrom wrote:

> On Fri, 8 Jun 2001, Mike Galbraith wrote:
> > I gave this a shot at my favorite vm beater test (make -j30 bzImage)
> > while testing some other stuff today.
>
> Could you please explain what is good about this test?  I understand that
> it will stress the VM, but will it do so in a realistic and relevant way?

Can you explain what is bad about this test? ;)  It spins the same VM wheels
as any other load does.  What's the difference if I have a bunch of httpd
allocating or a bunch of cc1/as/ld?  This load has a modest cachable data
set and is compute bound.. and above all gives very repeatable results.

I use it to watch reaction to surge.  I watch for the vm to build to a
solid maximum throughput without thrashing.  That's the portion of VM
that I'm interested in, so that's what I test.  Besides :) I simply don't
have the hardware to try to simulate hairy chested server loads.  There
are lots of folks with hairy chested boxes.. they should test that stuff.

I've been repeating ~this test since 2.0 times, and have noticed a 1:1
relationship.  When I notice that my box is ~happy doing this load test,
I also notice very few VM gripes hitting the list.

> Isn't the interesting case when you have a number of processes using lots
> of memory, but only a part of all that memory is beeing actively used, and
> that memory fits in RAM.  In that case, the VM should make sure that the
> not used memory is swapped out.  In RAM you should have the used memory,
> but also disk cache if there is any RAM left.  Does the current VM handle
> this case fine yet?  IMHO, this is the case most people care about.  It is
> definately the case I care about, at least. :-)

The interesting case is _every_ case.  Try seeing my particular test as
a simulation of a small classroom box with 30 students compiling their
assignments and it'll suddenly become quite realistic.  You'll notice
by the numbers I post that I was very careful to not overload the box in
a rediculous manner when selecting the total size of the job.. it's just
a heavily loaded box.  This test does not overload my IO resources, so
it tests the VM's ability to choose and move the right stuff at the right
time to get the job done with a minimum of additional overhead.

The current VM handles things generally well imho, but has problems
regulating itself under load.  My test load hits the VM right in it's
weakest point (not _that_ weak, but..) by starting at zero and building
rapidly to max.. and keeping it _right there_.

> I'm not saying that it's a completely uninteresting case when your active
> memory is bigger than you RAM of course, but perhaps there should be other
> algorithms handling that case, such as putting some of the swapping
> processes to sleep for some time, especially if you have lots of processes
> competing for the memory. I may be wrong, but it seems to me that your
> testcase falls into this second category (also known as thrashing).

Thrashing?  Let's look some numbers. (not the ugly ones, the ~ok ones;)

real    9m12.198s  make -j 30 bzImage
user    7m41.290s
sys     0m34.840s
user  :       0:07:47.69  76.8%  page in :   452632
nice  :       0:00:00.00   0.0%  page out:   399847
system:       0:01:17.08  12.7%  swap in :    75338
idle  :       0:01:03.97  10.5%  swap out:    88291

real    8m6.994s  make bzImage
user    7m34.350s
sys     0m26.550s
user  :       0:07:37.52  78.4%  page in :    90546
nice  :       0:00:00.00   0.0%  page out:    18164
system:       0:01:26.13  14.8%  swap in :        1
idle  :       0:00:39.69   6.8%  swap out:        0

...look at cpu utilization.  One minute +tiny change to complete the
large job vs the small (VM footprint) job.

The box is not thrashing, it's working it's little silicon butt off.
What I'm testing is the VM's ability to handle load without thrashing
so badly that it loses throughput bigtime, stalls itself whatever..
it's ability to regulate itself.  I consider a minute and a half to
be ~acceptable, a minute to be good, and 30 seconds to be excellent.
That's just my own little VM performance thermometer.

> An at last, a humble request:  Every problem I've had with the VM has been
> that it either swapped out too many processes and used too much cache, or
> the other way around.  I'd really enjoy a way to tune this behaviour, if
> possible.

Tunables aren't really practical in VM (imho).  If there were a dozen
knobs, you'd have to turn a dozen knobs a dozen times a day.  VM has
to be self regulating.

In case you can't tell (the length of this reply) I like my fovorite
little generic throughput test a LOT :-)

	-Mike

