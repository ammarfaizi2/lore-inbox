Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273268AbRIRJjb>; Tue, 18 Sep 2001 05:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273272AbRIRJjV>; Tue, 18 Sep 2001 05:39:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38256 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273268AbRIRJjQ>; Tue, 18 Sep 2001 05:39:16 -0400
Date: Tue, 18 Sep 2001 11:39:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918113938.B2723@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com> <Pine.GSO.4.21.0109180527450.25323-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109180527450.25323-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 18, 2001 at 05:31:48AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:31:48AM -0400, Alexander Viro wrote:
> 
> 
> On Mon, 17 Sep 2001, Linus Torvalds wrote:
> 
> > This also merges the blkdev in page cache patch, and that will hopefully
> > make it noticeably easier to do the "do bread() with page cache too", at
> > which point a lot of the current ugly synchronization issues will go away.
> 
> Umm...  Linus, had you actually read through the fs/block_device.c part
> of that?  It's not just ugly as hell, it's (AFAICS) not hard to oops
> if you have several inodes sharing major:minor.  ->bd_inode and its

can you show an exploit? I cannot reproduce any problem here:

root@athlon:/tmp > cp -a /dev/hda hda.1
root@athlon:/tmp > cp -a /dev/hda hda.2
root@athlon:/tmp > cp hda.1 /dev/null & cp hda.2 /dev/null &
[1] 24981
[2] 24982
root@athlon:/tmp > fg
cp hda.2 /dev/null

root@athlon:/tmp > fg
cp hda.1 /dev/null

root@athlon:/tmp > 

> treatment are bogus.  Please, read it through and consider reverting -
> in its current state code is an ugly mess.

what other design solution do you propose rather both inodes sharing the
i_mapping across the different inodes like I did?

I found more handy to just bump the i_count of the first inode and
referencing it from the bd_inode, rather than dynamically allocating the
i_mapping and have a bd_mapping, but if you prefer to dynamically
allocate the i_mapping rather than using the i_data of the fist inode we
can change that of course. Not sure what's the mess in the patch you're
talking about, could you elaborate?

Andrea
