Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291818AbSBYSE6>; Mon, 25 Feb 2002 13:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292082AbSBYSEu>; Mon, 25 Feb 2002 13:04:50 -0500
Received: from ns.caldera.de ([212.34.180.1]:15495 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291818AbSBYSEm>;
	Mon, 25 Feb 2002 13:04:42 -0500
Date: Mon, 25 Feb 2002 19:04:01 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] block_dev.c: fsync() on close() considered harmful
Message-ID: <20020225190401.A32415@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I don't see any standard specifying that fsync should be done on
every blockdevice close.

Any chance you could add the below patch to the next -ac release?

	Christoph


Date: Thu, 22 Nov 2001 14:34:50 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] block_dev.c: fsync() on close() considered harmful
Message-ID: <20011122143450.A28020@cistron.nl>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-NCC-RegID: nl.cistron

I'm running an INN usenet news server that uses raw partitions for
storage. I.e. it opens /dev/sda7 etc. and mmap()s [which finally
works in 2.4, hurray]

Even though the server is keeping those devices open, when a utility
program (sm) opens that file/device and closes() it the close() causes
a fsync() on the device, something that is not wanted.

I applied the following patch which fixes it for me, it prevents
the sync-after-close if it was close() calling blkdev_put()
and we're not the last one to call blkdev_put().

That means fsync() will still be done on unmounts or when the
last user of the device closes it, but not otherwise.

Is this correct or am I overlooking something?

--- linux-2.4.15-pre8/fs/block_dev.c.orig	Thu Oct 25 22:58:35 2001
+++ linux-2.4.15-pre8/fs/block_dev.c	Wed Nov 21 13:32:16 2001
@@ -603,7 +603,7 @@
 
	down(&bdev->bd_sem);
	lock_kernel();
-	if (kind == BDEV_FILE)
+	if (kind == BDEV_FILE && bdev->bd_openers == 1)
		__block_fsync(bd_inode);
	else if (kind == BDEV_FS)
		fsync_no_super(rdev);


Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

