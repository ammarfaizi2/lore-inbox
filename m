Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132777AbRDOS0w>; Sun, 15 Apr 2001 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbRDOS0c>; Sun, 15 Apr 2001 14:26:32 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:27800 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132777AbRDOS01>; Sun, 15 Apr 2001 14:26:27 -0400
Date: Sun, 15 Apr 2001 14:26:22 -0400 (EDT)
From: Scott Murray <scott@spiteful.org>
X-X-Sender: <scottm@godzilla.spiteful.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Can't free the ramdisk (initrd, pivot_root)
In-Reply-To: <9bbfib$qu4$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104151251500.4284-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Apr 2001, H. Peter Anvin wrote:

> Hello friends,
>
> I am trying the following setup, and it works beautifully, *except*
> that I don't seem to be able to free the ramdisk memory at the end.

Heh, sounds familiar, I was in exactly the same situation a month ago.
I meant to post something about it, but kept forgetting.

> This successfully runs init, and I can umount /initrd in the new
> setup, but I cannot then destroy the ramdisk contents by calling
> ioctl([/dev/ram0], BLKFLSBUF, 0) -- it always returns EBUSY.  What is
> holding this ramdisk busy, especially since I could successfully
> umount the filesystem?  Seems like a bug to me.

Indeed it is.  This fix for drivers/block/rd.c (excerpted from 2.4.3-ac6):

@@ -690,6 +690,7 @@
 done:
        if (infile.f_op->release)
                infile.f_op->release(inode, &infile);
+       blkdev_put(out_inode->i_bdev, BDEV_FILE);
        set_fs(fs);
        return;
 free_inodes: /* free inodes on error */

has been in Alan's tree since some time in November (it first appeared
in the 2.4.0test11ac1 Change Log).

Another ramdisk gotcha that also still exists is that cramfs still seems to
be hosing the ramdisk superblock if it's compiled into the kernel.  I had to
not only switch to romfs for my initrd, but also compile cramfs support out
of the kernel.  There was a big discussion about this exact problem back in
January, but none of the suggested fixes seem to have been incorporated.

Scott


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.spiteful.org (coming soon)                 ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"


