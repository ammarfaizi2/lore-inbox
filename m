Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbRBVCEU>; Wed, 21 Feb 2001 21:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRBVCEK>; Wed, 21 Feb 2001 21:04:10 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:2294 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130152AbRBVCDz>; Wed, 21 Feb 2001 21:03:55 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102220203.f1M237Z20870@webber.adilger.net>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <3A9469D8.DB4679DB@innominate.de> from Daniel Phillips at "Feb 22,
 2001 02:22:32 am"
To: Daniel Phillips <phillips@innominate.de>
Date: Wed, 21 Feb 2001 19:03:07 -0700 (MST)
CC: "H. Peter Anvin" <hpa@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> Easy, with average dirent reclen of 16 bytes each directory leaf block
> can holds up to 256 entries.  Each index block indexes 512 directory
> blocks and the root indexes 511 index blocks.  Assuming the leaves are
> on average 75% full this gives:
> 
> 	(4096 / 16) * 512 * 511 * .75 = 50,233,344
> 
> I practice I'm getting a little more than 90,000 entries indexed by a
> *single* index block (the root) so I'm not just making this up.

I was just doing the math for 1k ext2 filesystems, and the numbers aren't
nearly as nice.  We get:

	(1024 / 16) * 127 * .75 = 6096		# 1 level
	(1024 / 16) * 128 * 127 * .75 = 780288	# 2 levels

Basically (IMHO) we will not really get any noticable benefit with 1 level
index blocks for a 1k filesystem - my estimates at least are that the break
even point is about 5k files.  We _should_ be OK with 780k files in a single
directory for a while.  Looks like we will need 2-level indexes sooner than
you would think though.  Note that tests on my workstation showed an average
filename length of 10 characters (excluding MP3s at 78 characters), so this
would give 20-byte (or 88-byte) dirents for ext3, reducing the files count
to 4857 and 621792 (or 78183 and 40029696 for 4k filesystems) at 75% full.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
