Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263381AbRFEWTp>; Tue, 5 Jun 2001 18:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263392AbRFEWTf>; Tue, 5 Jun 2001 18:19:35 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:61474 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S263381AbRFEWTQ>;
	Tue, 5 Jun 2001 18:19:16 -0400
Message-ID: <3B1D5ADE.7FA50CD0@illusionary.com>
Date: Tue, 05 Jun 2001 18:19:10 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Break 2.4 VM in five easy steps
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After reading the messages to this list for the last couple of weeks and
playing around on my machine, I'm convinced that the VM system in 2.4 is
still severely broken.  

This isn't trying to test extreme low-memory pressure, just how the
system handles recovering from going somewhat into swap, which is a real
day-to-day problem for me, because I often run a couple of apps that
most of the time live in RAM, but during heavy computation runs, can go
a couple hundred megs into swap for a few minutes at a time.  Whenever
that happens, my machine always starts acting up afterwards, so I
started investigating and found some really strange stuff going on.

To demonstrate this to a co-worker, I cooked up this really simple,
really stupid, very effective test.  (Note that this all is probably
specific to IA32, which is the platform on which I'm running.)

-- How to Break your 2.4 kernel VM in 5 easy steps

1) compile the following code:

#include <stdlib.h>
void main(void) {
   /* allocate a buttload of memory and try to touch it all */
   void *ptr = (void *)calloc(100000000, sizeof(int)) ;

   /* sleep for a bit to let the system quiesce */
   sleep(20);

   /* let it all go away now */
   free(ptr);
}

2) depending on the amount of RAM/swap available in your machine, you
might need to adjust the calloc to allocate a different amount.  This
allocates about 400MB.  

3) Run the program, or more than one copy at once.  You want to put your
machine somewhat into swap, but not totally overwhelmed.  On the system
I'm using to write this, with 512MB of RAM and 512MB of swap, I run two
copies of this program simultaneously and it puts me a couple hundred
megs into swap.

4) Let the program exit, run "free" or cat /proc/memstat or something to
make sure your machine has paged a bunch of stuff out into swap.

5) try to "swapoff" your swap partition and watch the machine become
completely and entirely unresponsive for several minutes.

--

If I do this on my machine, which is a K7-700 on an ASUS K7M motherboard
with 512MB each of swap and RAM where I'm writing this (but I can make
any machine running 2.4 behave the same way, and any version I've tried
it with from 2.4.2 on up through most of the -ac kernels too), the
machine will become _entirely_ unresponsive for several minutes.  The HD
comes on for a few seconds at the very start of the "swapoff", CPU
utilization immediately pegs up to 100% system time, and then for a few
minutes after, as far as anyone can tell, the machine is TOTALLY locked
up.  No console response, no response from anything on the machine. 
However, after a few minutes of TOTAL catatonia, it will mysteriously
come back to life, having finally released all its swap.

Now, this is a VERY contrived test, but there are a couple of things
about doing this against 2.4 compared with 2.2 that seem VERY BROKEN to
me.

1) Running this against a machine running a 2.2-series kernel does
nothing out of the ordinary.  You hit a bunch of swap, exit the
"allocate" program, swapoff, and everything is fine after a few seconds
of disk activity as it pages everything back into RAM.  Least surprise. 
Under 2.4, when you "swapoff" it appears as far as anyone can tell that
the machine has locked up completely.  Very surprising.  In fact, the
first time it happened to me, I hit the Big Red Switch thinking the
machine _had_ locked up.  It wasn't until I started playing around with
memory allocation a bit more and read some of the problems on LKML that
I started to realize it wasn't locked up - just spinning.

2) Under 2.2, when the "allocate" programs exit, the amount of mem and
swap that show up in the "used" column are quite small - about what
you'd expect from all the apps that are actually running. No surprise
there.  Under 2.4, after running the "allocate" program, "free" shows
about 200MB each under mem and swap as "used".  A lot of memory shows up
in the "cached" column, so that explains the mem usage, (although not
what's cached, unless it's caching swap activity, which is odd) but what
the heck is in that swap space?  Very surprising.

Now, I'm sure some of the response will be "Don't run 2.4.  If you want
to run a stable kernel run 2.2."  That may be a reasonable, but there
are a couple of features and a couple of drivers that make the 2.4 very
appealing, and somewhat necessary, to me.  Also, I want to help FIX
these problems.  I don't know if my hokey test is an indication of
something for real, but hopefully it's something that's simple enough
that a lot of people can run it and see if they experience similar
things.  

And, AFAIC, a truly stable kernel (like 2.2) should be able to go deep
into swap, and once the applications taking up the memory have exited,
be able to turn off that swap and not have something utterly surprising,
like the machine becoming comatose for several minutes, happen.  If it
does, that's an indication to me that there is something severely wrong.

Now, with that being said, is there anything I can do to help?  Run
experimental patches?  Try things on different machines?  I have access
to a number of different computers (all IA32) with widely varying memory
configurations and am willing to try test patches to try to get this
working correctly.

Or am I completely smoking crack and the fact that my machine hoses up
for several minutes after this very contrived test is only an indication
that the test is very contrived and in fact the kernel VM is perfectly
fine and this is totally expected behaviour and I just should never try
to "swapoff" a swap partition under 2.4 if I want my machine to behave
itself?

Please respond to me directly, as I'm not subscribed to the list.  I
have tried to keep current via archives in the last couple of weeks, but
with the PSI/C&W disconnect going down, it seems like I'm unable to
reach some of the online archives.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
