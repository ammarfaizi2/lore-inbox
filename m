Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUD3VKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUD3VKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUD3VEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:04:52 -0400
Received: from sitemail3.everyone.net ([216.200.145.37]:55467 "EHLO
	omta12.mta.everyone.net") by vger.kernel.org with ESMTP
	id S261298AbUD3U77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:59:59 -0400
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Fri, 30 Apr 2004 13:59:50 -0700 (PDT)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: VM/Swap performance ideas
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.185.81]
X-Eon-Sig: AQHDJlhAkr5GAAbv9wEAAAAB,017f3982c8dfe0c78dc6e9b49b401fb3
Message-Id: <20040430205950.74B9F3946@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know it's slashdot, but this guy has a valid idea.  Don't just chuck
it, consider it a bit.

If you read the comment on slashdot at:
http://slashdot.org/comments.pl?sid=105934&cid=9018548

You'll see that this person is proposing to allow disk cache pages to
exist in ram for a given amount of time before dropping them in favor
of swapping application data back in.  This is a good idea, and could
probably be refined quite a bit.

The first thing to note is that sticking swap in page cache is NOT a
good solution to retrieving data in swap.  It works for a while,
yeah; you can fault a page back in by mapping the area of swap that
it exists in into the pagecache, and then mapping that area of ram
to the application.  But in this case, you eat up BOTH ram and swap.
This doubles ram usage.  I want 512M ram and 512M swap to let me
put 1G of data into memory.

For swapping back in, I suggest that you first map the swap pages
into the page cache.  After that's remained valid for a while, pull
it from the disk and make it exist purely in ram.  This will free
up swap.  Add a sysctl, vm.pagecache.swap_grace, to specify how
long swap pages must remain in pagecache before being pulled from
swap and placed back into ram.  0 should mean infinite.  Value is
in seconds.

Second, this person suggested to give page cache data a max
lifetime.  This is a good idea, because after a really long time,
we can assume that we no longer care about the page cache data
and would rather use that ram to quickly activate an application.

I suggest you add a sysctl, vm.pagecache.max_life, to specify the
maximum page cache dormancy period in seconds.  Purge entries in
page cache that haven't been accessed for that long, except for
swap page cache entries.  0 should be infinite.

Third, we need to fasttrack useless page cache entries out of
page cache.  Think about moving music around.  You read it in,
it goes to page cache, you spit it back out.  Now you have it
in page cache for no reason.  We no longer care about this
data.

For this, two syscalls should be added.
vm.pagecache.fasttrack_life should be the time in seconds to
allow a page cache entry to be deemed as useful.  The second,
vm.pagecache.fasttrack_access, should be the number of
accesses to the page cache entry that must occur in this time
to make it appear useful.  For example, setting these to
vm.pagecache.fasttrack_life=15 and
vm.pagecache.fasttrack_access=3 will usually ensure that a
simple copy or move of files between partitions is quickly
purged from the page cache; in the first 3 seconds, the
original file is read (1 access), the new file is written (1
access), the original file is deleted (2 access to the inode
data).  Then it's not bothered anymore.  12 seconds later,
the page cache entry is purged in favor of some data from
swap.  This could also be linked to inodes, and whether
they're still open or not after the fasttrack_life.


I must say that I AM NOT CODING THIS.  I'll give you guys
ideas, but I have my own coding projects and college classes
and can't be devoting time to keeping up with you while
bending the vm around.

Also, I haven't actually reviewed the VM code in depth.
Some of the stuff I and the slashdot poster suggested may
already be implimented.  Good job if so.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
