Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbTCGSOz>; Fri, 7 Mar 2003 13:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261710AbTCGSOz>; Fri, 7 Mar 2003 13:14:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:25996 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261708AbTCGSOw>; Fri, 7 Mar 2003 13:14:52 -0500
Date: Fri, 07 Mar 2003 10:34:29 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Minutes from LSE Call March 7
Message-ID: <17720000.1047062069@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	LSE Con Call Minutes March 7th

Minutes compiled by Hanna Linder. All mistakes are my own.
Please send corrections/comments to the list. And if you start
a huge thread with hundreds of responses, please change
the subject ;)

-------


I. Martin Bligh - hlist has patch from andi kleen
Andi Kleen change the hlist hash to be a singly linked list
from a doubly linked list. The code is smaller but the
performance is the same. It has been accepted by Linus
and is in 2.5.64.

II. Hanna Linder - hiding projects on lse 
Going to hide the scheduler and the apic routing projects 
in the lse.sf.net site. Also planning on moving the 2.5 
lse work to an osdl site since the existing sourceforge
site is filled up with a lot of 2.4 stuff.

III. Hanna Linder - lockmeter port beta ready
Hanna got the lockmeter port to 2.5.64 booted and
working. But she only ported the i386 architecture
and needs to finish the basic port for the other
archs. She is going to do more testing today and
will send out the code later. John Hawkes (the
author) said he is about half way done with
kernprof and will look at the lockmeter port when
Hanna is done.

IV. Paul Larson - gcov patch
http://sourceforge.net/project/showfiles.php?group_id=3382&release_id=108054

 resync of gcov patch that hubertus franke did.
neet little profiling program that provides better
granularity than some ofther profilers. it give you
per file and per line code coverage info. this is good
for the ltp project so we can see how much of the code
our tests hit. martin- are there big performance
impacts with this code? paul, not sure really.

Problem with config mod versions so make sure to
turn it off. also profiling of loaded modules isnt
working correctly so if you want to profile it
compile it into the kernel. other than that it is
working pretty well.

lcov - another tool on the ltp site that goes out and
looks at all the gcov data and pulls it into a web
page to let you browse the source tree. both
user and kernel level info. This is where it will
be when it is packaged up:
http://sourceforge.net/project/showfiles.php?group_id=3382&release_id=108054

Bill asked what the scheme is for accounting? sampling
or incrementing/decrementing counters? Are the counters
per cpu? no. be default that is not handled well. 
You wont run into an issue where it says you didnt
run something because it was on another procesor but
there are some locking issues. Nigel Hines is workig
on this problem. the preferred solution is a hack 
using an awk script to look at the assembly and add
locks where needed.

Martin - why dont you just use per cpu locks? paul-
need to look into it. But the problem is with the compiler
not the kernel so it might not help.

Martin is going to include it in his -mjb tree since it
is a config option you can turn on and off.

V. Bill Irwin - Page Clustering

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/

If we have a 16 byte struct page for every 512 bytes we
are wasting a lot of memory. so try to keep track of
every 1 kb or larger region. To make sure we have our
accounting straight. The end result is when we are
walking page tables you walk them in hardware page
size and everything else ignores it and keeps track
of sw page size. end up with an interesting relationship
where every struct page is pointed to by a factor
of ptes.

Bill has made a lot of recent progress. things like
swap have been restored to functionality. It boots
on most the machines he has tried it on. Also working
on performance aspects of it right now. The real
danger of all this is that you get internal (not
external) fragmentation. Basically allocate a whole
sw page of pte page size and dont get to use all of
it because you are missing some logging somewhere
to take advantage of it. Bill has been keeping some
strategies in the back of his mind to interoperate
with some things that are being kicked around.

Bill is using some simplified heuristics to search
for pages to fault in. Turns out those heuristics 
suck so he needs to go in and do a different set.
The ones originally done in Hugh's patch did something
in the order of scanning acros an entire vma looking
for pte's pointing to a particular page. It didnt
have any alignment restrictions. Bill does have
alignment restrictions and Hugh's solution would
break down pretty quickly (kernel compiles swapping).

The one that hurts is the one that crosses page table
pages. shared pages doesnt really like that. the way
it works with rmap is it is on a per page basis. Still
crossing the page table page is bad.

That is the main gist of it. Currently Bill is workig
on tweaking the heuristics.

hanna- how much memory do you need to get the benefit
of this?

bill - two benefits- larger page table size. and
the arrays of all the struct pages in the system is
smaller.

hanna asked if akpm put it in his tree and bill said
it is not the kind of thing akpm is going to hang on
to right now. Bill wants to get it allworking first.
he is going to break it off in chunks and send it in
piecewise.

The ols talk is going to be mainly about this work.
there are some pretty hairy bugs in there to wrestle
with. Should make for an interesting talk.

The people testing it right now are mainly Muli Ben-Yehuda,
Zwane, Badari, Paul Larson. Bill is interested in having 
more people look at it or run it.

Bill thinks he is at critical mass now for main changes.

Muli - is going to work with Bill on a bug he found.

Bill - Testing it as far as it being effective. He has
shown it reduces the core map on a 48 gig machine.
by a factor of 16. well I picked the factor, you
do it at compile time. The dmesg are in his ftp 
dir on kernel.org so you can look at the difference
between zone normal and high mem.







