Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292108AbSCDH4M>; Mon, 4 Mar 2002 02:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292122AbSCDH4D>; Mon, 4 Mar 2002 02:56:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37899 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292108AbSCDHzp>;
	Mon, 4 Mar 2002 02:55:45 -0500
Message-ID: <3C83280A.A8CF7CC8@zip.com.au>
Date: Sun, 03 Mar 2002 23:53:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com>,
		<20020304050450.GF353@matchmail.com>; from mfedyk@matchmail.com on Sun, Mar 03, 2002 at 09:04:50PM -0800 <20020303223103.J4188@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> Actually, there are a whole bunch of performance issues with 1kB block
> ext2 filesystems.

I don't see any new problems with file tails here.  They're catered for
OK.  What I have not catered for is file holes.    With the delalloc
patches, whole pages are always written out (except for at eof).  So
if your file has lots of very small non-holes in it, these will become
larger non-holes.

If we're serious about 64k PAGE_CACHE_SIZE then this becomes more of
a problem.  In the worst case, a file which used to consist of

4k block | (1 meg - 4k) hole | 4k block | (1 meg - 4k) hole | ...

will become:

64k block | (1 meg - 64k) hole | 64k block | (1 meg - 64k hole) | ...

Which is a *lot* more disk space.  It'll happen right now, if the
file is written via mmap.  But with no-buffer-head delayed allocate,
it'll happen with write(2) as well.

Is such space wastage on sparse files a showstopper?    Maybe,
but probably not if there is always at least one filesystem
which handles this scenario well, because it _is_ a specialised
scenario.

-
