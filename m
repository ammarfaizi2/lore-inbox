Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262516AbRENVzc>; Mon, 14 May 2001 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262524AbRENVzW>; Mon, 14 May 2001 17:55:22 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:51215 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262516AbRENVzN>; Mon, 14 May 2001 17:55:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Mon, 14 May 2001 23:50:59 +0200
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105141833.f4EIXrQs001765@webber.adilger.int>
In-Reply-To: <200105141833.f4EIXrQs001765@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051423505900.24410@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 May 2001 20:33, Andreas Dilger wrote:
> Daniel, you write:
> > Now, if the check routine tells us how much good data it found we
> > could use that to set a limit for the dirent scan, thus keeping the
> > same robustness as the old code but without having all the checks
> > in the inner loop.  Or.  We could have separate loops for good
> > blocks and bad blocks, it's just a very small amount of code.
>
> Yes, I was thinking about both of those as well.  I think the latter
> would be easiest, because we only need to keep a single error bit per
> buffer.

Today's patch has the first part of that fix:

    http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-6

I broke up Al's check_page routine into the page-specific part and the 
dirent-specific part, which I call every time a buffer is brought 
uptodate in ext2_bread.  This is roughly as efficient as Al's 
page-oriented check.  I could get rid of the code in Al's check_page 
that initializes sets the rec_lens of a new dir page to blocksize 
because I do that explicitly in ext2_add_entry now.  This will make it 
a little cleaner.

The next step is to try and incorporate the intelligence about the good 
parts of a bad dirent block into the entry lookup code cleanly.

I moved ext2_bread and ext2_append into dir.c because of their 
dir-specific nature.  (I have some plans for ext2_getblk that have 
nothing to do with directories, which is why I'm trying to keep it 
generic.)

--
Daniel
