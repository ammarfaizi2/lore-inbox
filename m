Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130788AbRBVDKR>; Wed, 21 Feb 2001 22:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131023AbRBVDKH>; Wed, 21 Feb 2001 22:10:07 -0500
Received: from hermes.mixx.net ([212.84.196.2]:44295 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130788AbRBVDJ6>;
	Wed, 21 Feb 2001 22:09:58 -0500
Message-ID: <3A9482C9.65A51FEF@innominate.de>
Date: Thu, 22 Feb 2001 04:08:57 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <3A9469D8.DB4679DB@innominate.de> <200102220203.f1M237Z20870@webber.adilger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> Daniel Phillips writes:
> > Easy, with average dirent reclen of 16 bytes each directory leaf block
> > can holds up to 256 entries.  Each index block indexes 512 directory
> > blocks and the root indexes 511 index blocks.  Assuming the leaves are
> > on average 75% full this gives:
> >
> >       (4096 / 16) * 512 * 511 * .75 = 50,233,344
> >
> > I practice I'm getting a little more than 90,000 entries indexed by a
> > *single* index block (the root) so I'm not just making this up.
> 
> I was just doing the math for 1k ext2 filesystems, and the numbers aren't
> nearly as nice.  We get:
> 
>         (1024 / 16) * 127 * .75 = 6096          # 1 level
>         (1024 / 16) * 128 * 127 * .75 = 780288  # 2 levels
> 
> Basically (IMHO) we will not really get any noticable benefit with 1 level
> index blocks for a 1k filesystem - my estimates at least are that the break
> even point is about 5k files.  We _should_ be OK with 780k files in a single
> directory for a while.  Looks like we will need 2-level indexes sooner than
> you would think though.  Note that tests on my workstation showed an average
> filename length of 10 characters (excluding MP3s at 78 characters), so this
> would give 20-byte (or 88-byte) dirents for ext3, reducing the files count
> to 4857 and 621792 (or 78183 and 40029696 for 4k filesystems) at 75% full.

But you are getting over 3/4 million files in one directory on a 1K
blocksize system, and you really shouldn't be using 1K blocks on a
filesystem under that big a load.  Is it just to reduce tail block
fragmentation?  That's what tail merging is for - it does a much better
job than shrinking the block size.

But if you are *determined* to use 1K blocks and have more than 1/2
million files in one directory then I suppose a 3rd level is what you
need.  The uniform-depth tree still works just fine and still doesn't
need to be rebalanced - it's never out of balance.

--
Daniel
