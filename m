Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274997AbTHGAAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275022AbTHGAAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:00:33 -0400
Received: from zok.SGI.COM ([204.94.215.101]:64222 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S274997AbTHGAAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:00:30 -0400
Date: Thu, 7 Aug 2003 09:59:08 +1000
From: Nathan Scott <nathans@sgi.com>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5/2.6] buffer layer error at fs/buffer.c:2800 when unlinking
Message-ID: <20030806235908.GC854@frodo>
References: <20030803145113.GA31715@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803145113.GA31715@hell.org.pl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 04:51:13PM +0200, Karol Kozimor wrote:
> Hi,
> 
> I've recently managed to nail down the problems that have been occuring on 
>  my machine at least since 2.5.59. I use XFS as my rootfs, no other
> filesystems are compiled in, but I doubt the filesystem is to blame, since
> the problem does not appear under 2.4, despite the similar codebase.
> ...
> Here's the guts: upon unlinking files in /var/{run,lock/subsys} (typically
> during shutdown, but not only), and when doing "dd if=/dev/urandom
> of=/etc/random-seed count=1 bs=512" the following traces appear:
> #v+
> buffer layer error at fs/buffer.c:2800
> Call Trace:
>  [<c014f1c6>] drop_buffers+0xb3/0xb9
>  [<c014f208>] try_to_free_buffers+0x3c/0x96
>  [<c01db1a1>] linvfs_release_page+0x74/0x78
>  [<c014d2e6>] try_to_release_page+0x5c/0x6c

Hi there,

This is indeed an XFS issue (thanks for reporting it), the
patch below fixes it.

cheers.

-- 
Nathan


--- /usr/tmp/TmpDir.2013-0/linux/fs/xfs/linux/xfs_aops.c_1.45	2003-08-07 09:55:53.000000000 +1000
+++ linux/fs/xfs/linux/xfs_aops.c	2003-08-07 09:22:10.808194848 +1000
@@ -803,7 +803,7 @@
 		bh = bh->b_this_page;
 	} while (offset < end_offset);
 
-	if (uptodate)
+	if (uptodate && bh == head)
 		SetPageUptodate(page);
 
 	if (startio)
