Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbULGCBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbULGCBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 21:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbULGCBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 21:01:31 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:54348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261732AbULGCBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 21:01:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=able1MdiV9+v1mEcxpYc0LXhze+l3g2LwWSRxeBP6NCHqMqyCbprGhpo+hpvjQB1pUuSqREyXX9jGEIyDezQrshaf9kd1q9AVn9JLR2la6LoNerjwEAZrAC3bkbjzBfuEWrZMY9SmgzBxMYBOCI6STctR0P6ofyay4dKcOSXFws=
Message-ID: <cce9e37e041206180179f3b010@mail.gmail.com>
Date: Tue, 7 Dec 2004 02:01:06 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Designing Another File System
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200412022218.54182.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ABF7C5.5070609@comcast.net>
	 <cce9e37e041130112243beb62d@mail.gmail.com>
	 <200412022218.54182.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2004 22:18:53 +0200, Jan Knutar <jk-lkml@sci.fi> wrote:
> My old-style newsspool longs for a fast filesystem. Once I did something
> stupid, did a backup with mkisofs, and tried a ls -lR on the resulting CD.
> After a few hours, I decided that I needed the box to do some work instead
> of the 100% uninterruptable sys cpu usage, and rebooted it. I wonder how
> long that operation would've taken on isofs :) Mind, the cd drive wasnt really
> active during that time, so it wasn't an issue of seek-limited IO blocking
> the ide bus.

Sorry for the delay in replying, I've been readying Squashfs 2.1 for release...

Anyway, your experience with isofs/zisofs parallels my experience with
Squashfs 2.0 and isofs/zisofs.  Someone reported an 'ls' time of 15+
hours with Squashfs 2.0 (I can't remember the directory size but it
was 100,000 + files)!  Very embarassing...

As you mentioned the problem isn't due to seek overhead but relates to
the way applications like ls and find interact with the VFS file
layer.   ls (to console) by default in most distributions colours the
filenames according to type.  Unfortunately, this results in a
separate file lookup for each file within a directory. 
Isofs/squashfs2.0 (and others) for each file lookup need to scan the
directory from the start to find the filename.  For a directory which
is for example 5 MB in size, this means on average 2.5 MB is scanned
for each and every filename.  A 5 MB directory may have 100,000 files,
which means 100,000 * 2.5 MB (roughly 250 GB) must be scanned  for the
'ls'.  The directory is quickly pulled into the cache, and so the
operation isn't seek-time bound, but the constant rescanning results
in a high CPU overhead.

> 
> Currently the thing lives on a Reiser3 partition, previously ext3. They seem
> to be about the same speed for this in practice. A "du -sh" takes about 15
> minutes to execute, tarring it into a tar.bz2 seems to take about as long as
> that, too. Using Theodore Tso's spd_readdir.c, the tar backup case ran in
> 5 minutes once upon a time. spr_readdir throws segfaults at me now with
> 2.6 kernels though :-(
> 

You don't mention the size of each directory or how many files per
directory.  I did a test with zisofs and Squashfs 2.1 to test the
efficiency of the directory improvements in Squashfs 2.1.

The one directory had 72,784 files (2.6 MB directory size).  Each file
was 10 bytes in size (the test was directory lookup and so the file
size wasn't an issue).  The ext3 directory size was 288 MB (presumably
because of one file per block), the zisofs size 154 MB and the
Squashfs 2.1 size 616 K...  The massively different size of the
Squashfs 2.1 filesystem is because it packs on byte alignments and
because it packs multiple files into shared blocks which it compresses
in one go.  The compression achieved isn't the issue here but it does
nicely show some other aspects of Squashfs' compression ability...

Zisofs takes 34m21 seconds to do an ls on the directory.  Squashfs 2.1
takes 19 seconds !  The improvements in Squashfs 2.1 seem to do the
trick.  Once Squashfs 2.1 is released, and if you try it, I'll be
interested in any performance results you obtain with real-world data
(rather than artificial filesystems)...?

Regards

Phil Lougher
