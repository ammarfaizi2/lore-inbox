Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274839AbTHFFkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274858AbTHFFkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:40:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:45802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274839AbTHFFkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:40:18 -0400
Date: Tue, 5 Aug 2003 22:41:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grant Miner <mine0057@mrs.umn.edu>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-Id: <20030805224152.528f2244.akpm@osdl.org>
In-Reply-To: <3F306858.1040202@mrs.umn.edu>
References: <3F306858.1040202@mrs.umn.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Miner <mine0057@mrs.umn.edu> wrote:
>
> I tested the performace of various filesystems with a mozilla build tree 
>  of 295MB, with primarily writing and copying operations.  The test 
>  system is Linux 2.6.0-test2, 512MB memory, 11531.85MB partition for 
>  tests.  Sync is run a few times throughout the test (for full script see 
>  bottom of this email).  I ran mkfs on the partition before every test. 
>  Running the tests again tends to produces similar times, about +/- 3 
>  seconds.
> 
>  The first item number is time, in seconds, to complete the test (lower 
>  is better).  The second number is CPU use percentage (lower is better).
> 
>  reiser4 171.28s, 30%CPU (1.0000x time; 1.0x CPU)
>  reiserfs 302.53s, 16%CPU (1.7663x time; 0.53x CPU)
>  ext3 319.71s, 11%CPU	(1.8666x time; 0.36x CPU)
>  xfs 429.79s, 13%CPU (2.5093x time; 0.43x CPU)
>  jfs 470.88s, 6%CPU (2.7492x time 0.02x CPU)

But different filesystems will leave different amounts of dirty, unwritten
data in memory at the end of the test.  On your machine, up to 200MB of
dirty data could be sitting there in memory at the end of the timing
interval.  You need to decide how to account for that unwritten data in the
measurement.  Simply ignoring it as you have done is certainly valid, but
is only realistic in a couple of scenarios:

a) the files are about the be deleted again

b) the application which your benchmark simulates is about to spend more
   than 30 seconds not touching the disk.

This discrepancy is especially significant with ext3 which, in ordered data
mode, will commit all that data every five seconds.  If the test takes more
than five seconds then ext3 can appear to take a _lot_ longer.

But it is somewhat artificial: that data has to be written out sometime.

Solutions to this inaccuracy are to make the test so long-running (ten
minutes or more) that the difference is minor, or to include the `sync' in
the time measurement.


And when benching things, please include ext2.  It is the reference
filesystem, as it were.  It tends to be the fastest, too.

