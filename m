Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUKVNFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUKVNFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUKVNEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:04:05 -0500
Received: from dp.samba.org ([66.70.73.150]:12222 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262091AbUKVNDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:03:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16801.58215.621386.125280@samba.org>
Date: Tue, 23 Nov 2004 00:02:31 +1100
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-fsdevel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041119101600.GM1974@schnapps.adilger.int>
References: <1098383538.987.359.camel@new.localdomain>
	<16797.41728.984065.479474@samba.org>
	<20041119101600.GM1974@schnapps.adilger.int>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put up graphs of the first set of dbench3 results for various
filesystems at:

   http://samba.org/~tridge/xattr_results/

All the tests were run on a 2.6.10-rc2 kernel with the patch from
Andreas to add support to ext3 for large inodes. I needed to tweak the
patch for 2.6.10-rc2, but not by much. Full details on the setup are
in the README, and the scripts for reproducing the results yourself
(and the graphs) are in the same directory.

The results show that the ext3 large inode patch is extremely
worthwhile. Using a 256 byte inode on ext3 gained a factor of up to 7x
in performance, and only lost a very small amount when xattrs were not
used. It took ext3 from a very mediocre performance to being the clear
winner among current Linux journaled filesystems for performance when
xattrs are used. Eventually I think that larger inodes should become
the default.

Similarly on xfs, using the large inode option (512 bytes this time)
made a huge difference, gaining a factor of 6x in the best case. If
all versions of the xfs code can handle large inodes then I think it
would be good to change the default, especially as it seems to have
almost no cost when xattrs are not used.

Without xattrs reiser3 did extremely well under heavier load, where it
is less of a in-memory test, just as Hans thought it
would. Unfortunately I wasn't able to try reiser4 in these runs due to
the lockups I reported earlier, but I look forward to trying it once
those are fixed.

Reiser3 was also the best "out of the box" journaled filesystem with
xattrs, but it was easily beaten by xfs and ext3 once large inodes
were enabled in those.

jfs wins the award for consistency. As I watched the results develop I
was tempted to just disable the jfs tests as it was so slow, but
eventually it overtook xfs at very large loads. Maybe if I run large
enough loads it will be the overall winner :)

The massive gap between ext2 and the other filesystems really shows
clearly how much we are paying for journaling. I haven't tried any
journal on external device or journal on nvram card tricks yet, but it
looks like those will be worth pursuing.

I'll leave the test script running overnight generating some more
results for even higher loads. I'll update the graphs in the morning.

Cheers, Tridge
