Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTB0TyQ>; Thu, 27 Feb 2003 14:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTB0TyP>; Thu, 27 Feb 2003 14:54:15 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:46539 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S266443AbTB0TyO>;
	Thu, 27 Feb 2003 14:54:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Date: Fri, 28 Feb 2003 03:55:37 +0100
X-Mailer: KMail [version 1.3.2]
References: <11490000.1046367063@[10.10.2.4]>
In-Reply-To: <11490000.1046367063@[10.10.2.4]>
Cc: ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       chrisl@vmware.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030227200425.253F03FE26@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 February 2003 18:31, Martin J. Bligh wrote:
> Problem Description:
> I created a directory ("test") with 32000 (ok, 31998) directories in it,
> and  put a file called 'foo' in each of them (for i in `ls`; do cd $i &&
> touch bar  && cd .. ; done). Then I took that ext3 partion, umounted it,
> did a 'tune2fs -O  dir_index', then 'fsck -fD', and remounted. I then did a
> 'time du -hs' on the  test directory, and here are the results.
>
> ext3+htree:
> bwindle@razor:/giant/inodes$ time du -hs
> 126M    .
>
> real    7m21.756s
> user    0m2.021s
> sys     0m22.190s
>
> I then unmounted, tune2fs -O ^dir_index, e2fsck -fD /dev/hdb1, remounted,
> and  did another du -hs on the test directory. It took 1 minute, 48
> seconds.
>
> bwindle@razor:/giant/test$ time du -hs
> 126M    .
>
> real    1m48.760s
> user    0m1.986s
> sys     0m21.563s
>
>
> I thought htree was supposed to speed up access with large numbers of
> directories?

The du just does getdents and lstats in physical storage order, so there's no 
possible benefit from indexing in this case, and unindexed ext3 avoids long
search times by caching the position at which it last found an entry.  That 
answers the question "why doesn't it speed up", however, "why did it slow way 
down" is harder.

The single-file leaves of your directory tree don't carry any index (it's not 
worth it with only one file) and therfore use the same code path as unindexed 
ext3, so there's no culprit there.  I'm looking suspiciously at 
ext3_dx_readdir, which is apparently absorbing about 11 ms per returned 
entry. To put this in perspective, I'm used to seeing individual directory 
operation times well below 100 us, so even if each dirent cost as much as a 
full lookup, you'd see less than 3 seconds overhead for your 30,000 
directories.

11 ms sounds like two seeks for each returned dirent, which sounds like a bug.

Regards,

Daniel
