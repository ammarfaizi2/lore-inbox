Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268730AbRGZXLN>; Thu, 26 Jul 2001 19:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268731AbRGZXLE>; Thu, 26 Jul 2001 19:11:04 -0400
Received: from congress199.linuxsymposium.org ([209.151.18.199]:25861 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S268730AbRGZXKz>;
	Thu, 26 Jul 2001 19:10:55 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107262310.f6QNASE21283@lynx.adilger.int>
Subject: Re: Weird ext2fs immortal directory bug (all-in-one)
To: wingc@engin.umich.edu (Christopher Allen Wing)
Date: Thu, 26 Jul 2001 17:10:27 -0600 (MDT)
Cc: sentry21@cdslash.net, linux-kernel@vger.kernel.org,
        tytso@mit.edu (Theodore Y. Ts'o)
In-Reply-To: <Pine.LNX.4.33.0107261312450.6405-100000@bayarea.engin.umich.edu> from "Christopher Allen Wing" at Jul 26, 2001 01:21:01 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Wing writes:
> At the very least, ext2 fsck should complain about ext2 attributes set for
> symlinks or device files... I have had this same problem myself many times
> on machines with bad SCSI termination- I end up with unremovable device
> files thanks to a bogus immutable bit and have to use debugfs to get rid
> of them.

I checked, and at least recent versions of e2fsck complain/fix immutable
flags on device files, fifos, and sockets.  The below check disallows
immutable or append-only flags on symlinks (on the grounds that it is not
possible to set these legally).

Now what I need to do is also add an e2fsck test case for this...

Cheers, Andreas
===========================================================================
--- 1.56/e2fsck/pass1.c	Thu Jul 19 14:31:24 2001
+++ edited/e2fsck/pass1.c	Thu Jul 26 16:18:59 2001
@@ -559,6 +563,7 @@
 			check_size(ctx, &pctx);
 			ctx->fs_blockdev_count++;
 		} else if (LINUX_S_ISLNK (inode.i_mode)) {
+			check_immutable(ctx, &pctx);
 			ctx->fs_symlinks_count++;
 			if (!inode.i_blocks) {
 				if (inode.i_size_high ||

-- 
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
