Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUKFVJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUKFVJq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbUKFVJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:09:46 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40104 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261472AbUKFVJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:09:43 -0500
Date: Sat, 6 Nov 2004 21:09:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Chiaki <ishikawa@yk.rim.or.jp>
cc: mru@inprovide.com, <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Configuration system bug? : tmpfs listing in /proc/filesystems
    when TMPFS was not configured!?
In-Reply-To: <418D0EFB.2040002@yk.rim.or.jp>
Message-ID: <Pine.LNX.4.44.0411062044120.4132-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004, Chiaki wrote:

> (Please cc: me since I am not subscribed to linux-kernel list.)
> 
> I think there is something fishy about kernel 2.6.9.
> 
> I failed to enable TMPFS during configuration of
> my linux kernel 2.6.9.
> 
> However, somehow /proc/filesystems lists "nodev tmpfs" line !?
> 
> Is this to be expected?

It's been like that since 2.4.4.  I suspect it started out as a mistake,
but it's been like that for so long, I've been reluctant to change it
for fear of what might break instead.

> Background:
> I found this hard way. At least one program, namely,
> Debian udev package checks whether the system
> supports tmpfs by looking at the contents of /proc/filesystems.
> Because of this entry in /proc/filesystems, the script fails miserably
> now.

That seems a reasonable thing to do, and it may be okay even
despite the misleading advertizement of tmpfs in /proc/filesystems,
if the mount fails as it should.

> Because of the listing of tmpfs although TMPFS was not configured(!?),
> a system initialization script for udev is fooled into believing that
> tmpfs is supported and tries to mount tmpfs on /dev.
> 
> Worse. Somehow the mount command doesn't complain
> about tmpfs not supported, and returns succcess code to the
> invoking shell. (I checked.)
> (If mount fails, then we can probably fix the script to detect the
> internal consistency problem and quits.)

This is the really bad part, that is new behaviour in 2.6.9, and
my fault for not thinking harder about MS_NOUSER.  Worse than that,
it leaves the directory in a bizarre state, "Not a directory" when
you try to list it for example - Anton reported this weeks ago, but
we couldn't reproduce it, not knowing it needed CONFIG_TMPFS off.

Please try the patch below (against 2.6.9, I'll send Andrew and Linus
the same for 2.6.10-rc later, with proper comment), it fixes mount to
fail cleanly when CONFIG_TMPFS is off.  Let us (or Debian) know if it
also then fixes the Debian udev initialization in this case.

Thanks,
Hugh

--- 2.6.9/mm/shmem.c	2004-10-18 22:56:29.000000000 +0100
+++ linux/mm/shmem.c	2004-11-06 21:04:41.743173040 +0000
@@ -1904,6 +1904,8 @@ static int shmem_fill_super(struct super
 		sbinfo->max_inodes = inodes;
 		sbinfo->free_inodes = inodes;
 	}
+#else
+	sb->s_flags |= MS_NOUSER;
 #endif
 
 	sb->s_maxbytes = SHMEM_MAX_BYTES;

