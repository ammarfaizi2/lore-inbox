Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273823AbRIXMKC>; Mon, 24 Sep 2001 08:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273867AbRIXMJw>; Mon, 24 Sep 2001 08:09:52 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:18180 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S273823AbRIXMJq>; Mon, 24 Sep 2001 08:09:46 -0400
Date: Mon, 24 Sep 2001 05:08:49 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.10 VM vs. 2.4.9-ac14 (+ ac14-aging)
Message-ID: <Pine.LNX.4.33.0109232255250.14107-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Well, things are looking up.  The split trees of 2.4 VM seem to be both
performing "pretty well" here.  Following are some tests and comments
about recent kernels that I hope will be vaguely illuminative toward
further improvement.

Description of tests:

- Streaming IO test:
  dbench, 'dd if=/dev/zero of=dummy.dat bs=1024k count=512' and
  'cat dummy.dat > /dev/null' while performing streaming tasks like
  mp3's and general interactive use.  This is obscene, but dirty
  page overloading needs to be handled at least *acceptably*, without
  resorting to low-latency or preemptible patches

- Common user application test: the idea is to load a mix of applications
  to drive the system into different kinds of memory loads.  [sequential]

	a) fill dentry/inode caches with slocate
	b) create lots of anonymous pages w/ a large blank image in GIMP
	   [make sure GIMP's tile cache is set to a high value to test
	     kernel VM and not GIMP's 'temp' file handling]
	c) loading StarOffice w/file creates lots of disk i/o,
	   stretches VM cache and then allocates lots of user
	   memory... [report loading time]
	d) load suite of apps to drive the system into mild
	   swap *activity* (not just swap allocation in 2.4.9-ac)
	e) Now that some pages have aged a bit, try to rotate that GIMP
	   image (major use of "older" anon pages and creation of many
	   more)   [time the rotation]
	f) note WHO's paged out w/ ps, log to file
	g) close all apps sequentially, sorta LIFO, note swap-ins

	vmstat & periodic dumps from /proc/meminfo and /proc/slabinfo log
	all statistics throughout the tests


Summary of Results:

- Test machines ranged from 32 MB to 192 MB, the latter is described
  here.

- 2.4.8 and 2.4.9 were poor, degenerating to _awful_ somewhere in
  2.4.10-pre. Example: it was darn near impossible to evict dentry and
  inode caches in 2.4.8.  Also, freshly loaded apps were paged out under
  load, then repeatedly paged back in, then back out... (poor interaction
  and/or balancing between the various inactive lists, coupled presumably
  w/ broken aging).

2.4.8 streaming IO test: failed (stutters, huge gaps in playback)
2.4.8 app test:  45524 kB swapped out; 29638 kB swapped in (cumulative)
		 28 second StarOffice load time; 10 sec GIMP img rotate


- 2.4.10-pre11 changed the nature of the VM problems, but most major
  issues seem to have been fixed by pre14 (certainly 2.4.10 final).  pre11
  would spin in kswapd & 'somewhere else' (balance classzone?) --
  sometimes loading StarOffice 5.2 would take 50% longer due partly to
  kswapd; no pages were actually swapped out.  Fixed by/before pre14.
  Even in 2.4.10 final, choice of evicted pages is not always good (many
  more cumulative swapins than ac14 when apps are closed).  Performance is
  otherwise pretty impressive.

2.4.10 streaming IO test: failed (stutters, frequent gaps in playback)
2.4.10 app test: 30020 kB swapped out; 22308 kB swapped in (cumulative)
		 22 second StarOffice load time; 6-7 sec GIMP img rotate


- 2.4.9-ac1* has pretty consistent, functioning VM.  Looks like aging is
  still mildly broken. Performance however is quite excellent for the most
  part; cache contains the "right pages" and what is paged out is "mostly
  the right pages".  Recent 2.4.9-ac (ac14 tested) had the best streaming
  I/O interactivity; it also outperforms everything else until lots of
  anonymous pages have to be allocated in swapcache (esp. when you're
  talking about a large scientific simulation on a HIGHMEM box; see Dirk
  Wetter's posts from around 12 July 2001 and Marcelo's comments).

2.4.9-ac14 streaming IO test:  passed, skip-less playback
			       (ac14-aging patch results identical)
2.4.9-ac14 app test: 30968 kB swapped out; 12900 kB swapped back in
		 18 second StarOffice load time; 8 sec GIMP img rotate
ac14+aging, app test: 31664 kB swapped out; 14604 kB swapped back in
		 18 second StarOffice load time; 8 sec GIMP img rotate


As above, Rik's latest ac14-aging was tested.  It, like ac12-aging, has
performed pretty well.  I'm not sure that it's doing all the right things
in detail.  For example, plain ac14 swapped out just as many pages,
but swapped fewer of them back in when the apps were closed.  Inactive
daemons loaded at boot time are among the oldest pages on the system;
ac14 swapped them entirely out.  2.4.10 and ac14+aging had similar
behavior and only paged them a little (ex. out of 2 MB=SIZE, 0.5 MB was
still RSS) and hit loaded 'younger' loaded apps (with big RSS)
somewhat harder instead.  Not sure if that's right; pure aging should
presumably page the unused daemons first, but drawing from big, idle hogs
might be more fruitful?  The aging patch simplifies the code a bit, and I
think that's a good thing.

ac14-aging easily collapses the dentry and inode caches under load.  This
works well here, but others might want to check to see if it's _too_
aggressive.  Suspect it's okay...

Rik's page launder patch for ac12 was also applied to ac14; it failed
the streaming IO test.  ac14 and ac14+aging were the only tested
kernels to pass.  No preemptive kernel patches were applied.


Comments:

I dunno what to think about the split VM trees.  The traditional
2.4 VM looks quite good in latest 2.4.9-ac, could stand addn'l careful
analysis & pruning.  I suspect most of the problems relate to inactive
lists interacting/balancing badly with each other, but the overall design
seems sensible.  Much of it is pretty well documented (even *I* can
follow it in some kind of coarse sense) & that effort is deeply
appreciated.  Andrea's classzone approach reduces inactive list
complexity, but I remain confused about the classzone design itself.
[Have to look at it more; rather new at this.]

I mean, I look at 'traditional' 2.4 VM and wonder why it sometimes
doesn't work like it should; in contrast, I look at classzone and wonder
how/why it manages to work so well. :)

Totally IMHO, my VM wishlist for 2.5 would be to see the return of some
aspects of 2.4 VM that got nixed.  I liked the overall design, although
implementation of inactive-lists/anon-pages needs to be made more
maintainable.  In particular, so-called 'anonymous' pages *have* to be
handled in a more sensible way.  Dump them in the active list (?),
allocate them in a separate fs from what-will-hopefully-become-swapfs-in-
2.5, or *something*.  Improved get_swap_page(), swap_out() & associates
probably should be on that list somewhere.

But things are looking *much* better now -- a real huge 'thank you' is in
order. :)  And looking forward to testing patches, and 2.5...

Best regards to all,

Craig Kulesa
Univ. of Arizona, Steward Observatory

