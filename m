Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266166AbRGLQZp>; Thu, 12 Jul 2001 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266169AbRGLQZf>; Thu, 12 Jul 2001 12:25:35 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:45560 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266166AbRGLQZR>; Thu, 12 Jul 2001 12:25:17 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107121621.f6CGLrTj027296@webber.adilger.int>
Subject: Re: [Ext2-devel] Re: Filesystem can be marked clear when it is not
In-Reply-To: <01071201564408.00409@starship> "from Daniel Phillips at Jul 12,
 2001 01:56:44 am"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Thu, 12 Jul 2001 10:21:53 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>, viro@math.psu.edu,
        torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> I weighed in on that one too:
> 
>     http://marc.theaimsgroup.com/?l=ext2-devel&m=99090670900520&w=2
> 
> with a very simple sort-of patch, which I just made into a real patch.  

Ok, your patch works in this case (it is leaving sb->s_dirt = 1, however, so
the superblock will be written out again shortly).  In fact, the whole
thing can be replaced with a call to ext2_write_super() in my code, which
also turns off EXT2_VALID_FS and sets s_mtime, and writes it synchronously
to disk.  This means we can remove 2! lines from ext2_setup_super().

It makes me wonder, though, if we clear EXT2_VALID_FS synchronously in
ext2_setup_super() if we also need it in ext2_write_super().  If people
mount their root fs read-write e2fsck will clear EXT2_VALID_FS and we
may never hit ext2_setup_super() again to clear it, so I guess it needs
to stay there.

One of the other changes from my patch is that errors are also written
out synchronously to disk, for the same reason - in case we crash shortly
after having an error, and before dirty buffers are flushed to disk.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
