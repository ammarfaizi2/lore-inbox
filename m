Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbTAKEGI>; Fri, 10 Jan 2003 23:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTAKEGI>; Fri, 10 Jan 2003 23:06:08 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:1801 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267035AbTAKEGG>;
	Fri, 10 Jan 2003 23:06:06 -0500
Date: Fri, 10 Jan 2003 23:14:47 -0500 (EST)
Message-Id: <200301110414.h0B4El8138492@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: daniel.ritz@gmx.ch, wli@holomorphy.com, hugh@veritas.com, ak@suse.de
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> a patch to speed up the kallsyms_lookup() function while
>> still doing compression.

First a few different ideas for the internals:

There won't be that many names actually getting used.
Hash with space for a few hundred, and gzip the rest.
You'll almost never take the hit of decompression.

Have the waitable things put addresses into a special
ELF section. During the build, process this data to
reduce the number of names that go into the table.

Addresses and string pointers have lots of redundancy.

WCHAN doesn't change if a process doesn't run. Cache the
number in the task_struct if it helps greatly.

> In earlier mail, Andi highlighted the performance criticality of top
> reading /proc/<pid>/wchan. I think we have to decide which way to
> jump on that: either withdraw that functionality as too expensive,
...
> or speed kallsyms_lookup as much as possible (binary chop or whatever
> algorithm to locate symbol from address). The current linear search
> through 6000(?) addresses is not nice, but of course the strncpy is
> making it much worse.

To fix the interface:

1. Add a full /proc/ksyms, containing all waitable locations.
2. Implement st_mtime for /proc/ksyms. (Really important!!!)
3. Add addresses to wchan files ("c013a0c0 do_select")

The above would eliminate a race condition that prevents
the /proc/*/wchan files from being cached and would allow
semi-traditional WCHAN processing (no System.map) as an option.


--- more details ---

Consider this:
ps -eo pid,nwchan,wchan

The /proc/*/stat file is needed for that, even on a 2.5.xx kernel.
Without it, nwchan (the number) would not be available.

User code would like to cache a nwchan-to-wchan mapping, so that
the wchan files wouldn't be needed so often. This can not be done
due to race conditions though. If the numbers were provided in the
/proc/*/wchan files, then a number-to-name mapping could be cached.

The /proc/*/wchan method has a high per-process cost, and a low
start-up cost. Thus it would be nice to have old-style WCHAN
available for long-running apps like top, gtop, ktop, and ncps.

For traditional WCHAN determination, /proc/ksyms needs to
contain the following:

a. the function names NOT found in System.map (from modules)
b. enough of the other function names to sanity-check

Alternately, it could contain all function names and an
indication that this is the case. This would eliminate the
error-prone search for a System.map file that seems to be
a decent match.

Two things for long-term consideration:

The problem of multiple WCHAN entries needs to be considered
for new-style threads and AIO.

I'm told that a simple "ls -lR /proc" will crash a NUMA box
with more than about 4000 tasks. Locks get held for a long
time, and then the NMI watchdog causes a reboot. In spite of
this, reading /proc/ksyms and /proc/kcore would work fine.
You know what I'm thinking.  :-(  For the really big systems,
this is the only path to take. So I'll be needing addresses
of various data structures as well. The LKCD patches would
be really helpful.



