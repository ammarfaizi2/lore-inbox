Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUKFTEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUKFTEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUKFTEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:04:33 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:2013 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261441AbUKFTEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:04:13 -0500
To: Chiaki <ishikawa@yk.rim.or.jp>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Configuration system bug? : tmpfs listing in
 /proc/filesystems when TMPFS was not configured!?
References: <418D0EFB.2040002@yk.rim.or.jp>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Sat, 06 Nov 2004 20:04:11 +0100
In-Reply-To: <418D0EFB.2040002@yk.rim.or.jp> (Chiaki's message of "Sun, 07
 Nov 2004 02:50:51 +0900")
Message-ID: <yw1xekj6ol3o.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chiaki <ishikawa@yk.rim.or.jp> writes:

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
>
> Background:
> I found this hard way. At least one program, namely,
> Debian udev package checks whether the system
> supports tmpfs by looking at the contents of /proc/filesystems.
> Because of this entry in /proc/filesystems, the script fails miserably
> now.
>
> Because of the listing of tmpfs although TMPFS was not configured(!?),
> a system initialization script for udev is fooled into believing that
> tmpfs is supported and tries to mount tmpfs on /dev.

Is this new to 2.6.9?  I don't see anything in the diffs that would
suggest a change.  The reason for the behavior you are seeing is
rather obvious.  In mm/shmem.c, init_tmpfs() always calls
register_filesystem() for tmpfs, irrespective of the CONFIG_TMPFS
setting.  The /proc/filesystems is created by get_filesystem_list() in
fs/filesystems.c, which doesn't (and couldn't without an ugly hack)
know that tmpfs is bogus.

If init_tmpfs() did not register_filesystem(), what would the effects
be?  I can't see that it would hurt shared memory maps, which are
implemented on top of tmpfs, but I haven't looked that closely.

Here's a patch (untested) for the brave.

Signed-off-by: Måns Rullgård <mru@inprovide.com>

===== mm/shmem.c 1.172 vs edited =====
--- 1.172/mm/shmem.c    2004-10-28 09:39:47 +02:00
+++ edited/mm/shmem.c   2004-11-06 20:01:30 +01:00
@@ -2200,12 +2200,12 @@
        if (error)
                goto out3;
 
+#ifdef CONFIG_TMPFS
        error = register_filesystem(&tmpfs_fs_type);
        if (error) {
                printk(KERN_ERR "Could not register tmpfs\n");
                goto out2;
        }
-#ifdef CONFIG_TMPFS
        devfs_mk_dir("shm");
 #endif
        shm_mnt = do_kern_mount(tmpfs_fs_type.name, MS_NOUSER,
@@ -2218,8 +2218,10 @@
        return 0;
 
 out1:
+#ifdef CONFIG_TMPFS
        unregister_filesystem(&tmpfs_fs_type);
 out2:
+#endif
        destroy_inodecache();
 out3:
        shm_mnt = ERR_PTR(error);

-- 
Måns Rullgård
mru@inprovide.com
