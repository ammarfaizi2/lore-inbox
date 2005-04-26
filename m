Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVDZAmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDZAmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDZAmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:42:36 -0400
Received: from waste.org ([216.27.176.166]:11979 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261251AbVDZAlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:41:32 -0400
Date: Mon, 25 Apr 2005 17:41:11 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Mercurial 0.3 vs git benchmarks
Message-ID: <20050426004111.GI21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to announce an updated version of Mercurial. Mercurial is a
scalable, fast, distributed SCM that works in a model similar to BK
and Monotone. It has functional clone/branch and pull/merge support
and a working first pass implementation of network pull. It's also
extremely small and hackable: it's about 1000 lines of code.

 http://selenic.com/mercurial/

Here are the results of checking in the first 12 releases of Linux 2.6
into empty repositories for Mercurial v0.3 (hg) and git-pasky-0.7.
This is on my 512M Pentium M laptop. Times are in seconds.

                 user         system       real        du -sh
ver    files   hg    git    hg    git    hg    git    hg   git

2.6.0  15007 19.949 35.526 3.171 2.264 25.138 87.994 145M   89M
2.6.1    998  5.906  4.018 0.573 0.464 10.267  5.937 146M   99M
2.6.2   2370  9.696 13.051 0.752 0.652 12.970 15.167 150M  117M
2.6.3   1906 10.528 11.509 0.816 0.639 18.406 14.318 152M  135M
2.6.4   3185 11.140  7.380 0.997 0.731 15.265 12.412 156M  158M
2.6.5   2261 10.961  6.939 0.843 0.640 20.564  8.522 158M  177M
2.6.6   2642 11.803 10.043 0.870 0.678 22.360 11.515 162M  197M
2.6.7   3772 18.411 15.243 1.189 0.915 32.397 21.498 165M  227M
2.6.8   4604 20.922 16.054 1.406 1.041 39.622 25.056 172M  262M
2.6.9   4712 19.306 12.145 1.421 1.102 35.663 24.958 179M  297M
2.6.10  5384 23.022 18.154 1.393 1.182 40.947 32.085 186M  338M
2.6.11  5662 27.211 19.138 1.791 1.253 42.605 31.902 193M  379M

tar of .hg/   108175360
tar of .git/  209385920

Full-tree change status (no changes):
hg:  real 0.799s  user 0.607s  sys 0.167s
git: real 0.124s  user 0.051s  sys 0.051s

Check-out time (2.6.0):
hg:  real 34.084s  user 4.069s  sys 2.024s
git: real 30.487s  user 2.393s  sys 1.007s

Full-tree working dir diff (2.6.0 base with 2.6.1 in working dir):
hg:  real 4.920s  user 4.629s  sys 0.260s
git: real 3.531s  user 1.869s  sys 0.862s
(this needed an update-cache --refresh on top of git commit, which
took another: real 2m52.764s  user 2.833s  sys 1.008s)

Merge from 2.6.0 to 2.6.1:
hg:  real 15.507s  user 6.175s  sys 0.442s
git: haven't quite figured this one out yet

Some notes:

- hg has a separate index file for each file checked in, which is why
  the initial check-in is larger
- this also means it touches twice as many files, typically
- neither hg nor git quite fit in cache on my 512M laptop (nor does a
  kernel compile), but the extra indexing makes hg's wall times a bit longer
- hg does a form of delta compression, so each checkin requires
  retrieving a previous version, checking its hash, doing a diff,
  compressing it, and checking in the result
- hg is written in pure Python

Despite the above, it compares pretty well to git in speed and is
quite a bit better in terms of storage space. By reducing the zlib
compression level, it could probably win across the board.

The size numbers will get dramatically more unbalanced with more
history - a conversion of the history in BK to git is expected to take
over 3G, which Mercurial may actually take less space due to storing
compressed binary forward-only deltas.

While disk may be cheap, network bandwidth is not. Given that the
common case usage of git will be to do network pulls, it will find
most of its speed wasted on waiting for the network. Mercurial will
almost certainly win here for typical developer usage as it can do
efficient delta communication (though it currently doesn't attempt any
pipelining so suffers a bit in round trips).

More discussion about Mercurial's design can be found here:

 http://selenic.com/mercurial/notes.txt

-- 
Mathematics is the supreme nostalgia of our time.
