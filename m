Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275189AbRIZNkI>; Wed, 26 Sep 2001 09:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275196AbRIZNj7>; Wed, 26 Sep 2001 09:39:59 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:42244 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S275189AbRIZNjq>; Wed, 26 Sep 2001 09:39:46 -0400
Date: Wed, 26 Sep 2001 06:38:48 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: <linux-kernel@vger.kernel.org>
Subject: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)
Message-ID: <Pine.LNX.4.33.0109260617450.3929-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As requested, here are a number of tests of the latest VM patches.  Tests
are described in a previous post, archived here:

    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0109.3/0033.html


Results:

2.4.10 performance is great compared to 2.4.[7-9], but these tests
still seem to point out some room for improvement in the 2.4.10 VM tree.
2.4.10 and 2.4.10(+00_vm-tweaks-1) performed similarly.  The vm-tweaks
patch improved the swap smoothness, but the number of pages swapped out
didn't change measurably, nor did the large number of swap-ins.  Clogging
the system with dirty pages via 'dd' still causes XMMS to skip badly.

Let's push the aging/list-order code more by driving the system a bit
harder in step d), namely adding mozilla to the common user application
test.  We will also stream mp3 audio throughout the entire test.

2.4.10(+00_vm-tweaks-1)
	48 sec StarOffice load time
	28 sec 2560x2560 GIMP image rotation
	82400 KB swapped out, 92148 KB swapped back in

2.4.9-ac14 + aging
	33 sec StarOffice load time
	25 sec GIMP image rotation
	30072 KB swapped out, 22252 KB swapped back in

2.4.9-ac15 + aging + launder
	33 sec StarOffice load time
	24 sec GIMP image rotation
	57556 KB swapped out, 25900 KB swapped back in

'vmstat 1' sessions for these three cases are available at:
	http://loke.as.arizona.edu/~ckulesa/kernel/


2.4.10+ is clearly working a LOT harder to keep dentry and inode caches
in memory, and is swapping out harder to compensate.  The ac14/ac15 tree
frees those caches more freely, and don't page application working sets
out so readily.

Let's test this statement by not pre-filling the inode and dentry caches
with 'slocate' and performing the same test:

2.4.10(+00_vm-tweaks)
	26 sec StarOffice load time
	24 sec GIMP image rotation
	48332 KB swapped out, 33521 KB swapped back in

2.4.9-ac14 + aging
	32 sec StarOffice load time
	26 sec GIMP image rotation
	37392 KB swapped out, 11952 KB swapped back in

2.4.9-ac15 + aging + launder
	32 sec StarOffice load time
	22 second GIMP image rotation
	23884 KB swapped out, 10828 KB swapped back in

2.4.10 does much better this time; in particular the StarOffice loading
that was so plagued by swapouts, pressured by dentry/inode caching last
time, went smoothly.  But there's still more paging than with
2.4.9-ac1[4-5].


Let's try one more aging/list-order experiment.  Instead of creating a
2560x2560 GIMP image first, then loading StarOffice and many other
applications after (to start swapping, and cause GIMP pages to be
candidates for reaping) -- this time let's load StarOffice first and then
create the GIMP image.  This should keep the GIMP image at a 'younger' age
and presumably shouldn't page back into memory (rotation should be
faster).  StarOffice may swap itself entirely out however.

2.4.10(+00_vm-tweaks)
	25 sec StarOffice load time
	29 sec GIMP image rotation
	64427 KB swapped out, 77422 KB swapped back in

2.4.9-ac14 + aging
	30 sec StarOffice load time
	24 sec GIMP image rotation
	22147 KB swapped out, 8922 swapped back in

2.4.9-ac15 + aging + launder
	31 sec StarOffice load time
	21 second GIMP image rotation
	17204 KB swapped out, 8224 swapped back in

The 2.4.10 behavior surprised me.  The GIMP pages are younger in memory,
yet the rotation was slowed by swapin & swapout activity --  slower than
before. Plus more StarOffice pages were swapped out, so it had to be paged
back in order to close the application.  I'm puzzled.  The ac14/ac15
behavior was closer to what I expected; the GIMP pages were young and
unswapped, only the earliest StarOffice pages had to be recalled.

These are samples of rather 'ordinary' loads which 2.4.10 needs some work
handling; the ac15 tree is doing a better job with this particular set
right now (ac15 tree also doesn't skip XMMS with the creation of lots of
dirty pages via 'dd').  But all three kernels tested kept the user
interface relatively responsive, which is an improvement over previous
2.4 releases.  Very cool.

A note on page_launder().  ac14 has the smoothest swapping, with small
chunks laundered at a time.  ac14+aging and ac15+aging+launder both swap
out huge (10-20 MB) chunks at a time.  Admittedly, the user interface is
responsive and XMMS doesn't skip a beat, but most of the 60 MB of
actual swapout in the first test in ac15+stuff came from only THREE
lines of 'vmstat 1' output.  Otherwise there was no swapout activity.

Best regards, and thanks for the excellent work!


Craig Kulesa
Steward Observatory, Univ. of Arizona

