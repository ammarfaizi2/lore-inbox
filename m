Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbTJDPe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTJDPe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 11:34:57 -0400
Received: from ns.xdr.com ([209.48.37.1]:27269 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S262183AbTJDPez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 11:34:55 -0400
Date: Sat, 4 Oct 2003 08:34:57 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200310041534.h94FYv0X007015@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Idea for improving linux buffer cache behaviour
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if this has already been thought of, or is obsolete, or is just
plain a bad idea, but here it is:

When I am doing large block device operations, such as ripping a DVD, the
cache gets loaded with all this data I don't care about (the contents of the
DVD itself). The cache data I care about is glibc, other shared libraries, and
binary executables like xterm + whatnot that I am constantly using. After
doing the large block operations, all that important data is no longer in the
cache, so it has to be reloaded from disk. It is then annoyingly slow to use
the machine for a while, especially each new executable that has to be loaded.
Performance is so much better when the stuff is sitting there in a ram cache.

Here's the idea: For each cache item, keep a count of how many times it has
been accessed (read). Also keep a count of how old the cache entry is. When
looking for cache data to free up to make space for a new cache entry, throw
out the data based on
1) Lowest access count looked at first to toss
2) If access counts equal, throw out oldest first

Actually you could have a "keep" rating on each cache entry. The higher the
rating the more you want to keep it in the cache. It could be this:
A * (access_count) - B * (age)
where A and B are positive numbers. Every time you go to cache something new
you increment a counter and store that in with the cache entry. The age of
the cache entry is the current value of the counter minus the cache entry's
value. A could be much larger than B.

The net result is commonly used items you very much want to remain in cache
always quickly get rated very highly as the system is used.

I'm using 2.4.20. Maybe 2.[5|6] does much more intelligent cache handling.

-Dave
PS cc me on replies, I don't read this group normally.
