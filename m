Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNOBp>; Wed, 14 Feb 2001 09:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNOBf>; Wed, 14 Feb 2001 09:01:35 -0500
Received: from www.wen-online.de ([212.223.88.39]:35335 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129051AbRBNOBX>;
	Wed, 14 Feb 2001 09:01:23 -0500
Date: Wed, 14 Feb 2001 15:01:00 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patchlet] cramfs incompatible with initrd..
Message-ID: <Pine.Linu.4.10.10102141445001.2324-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(If the initrd is other than PAGE_CACHE_SIZE blocksize)

Hi,

I found that merely having cramfs configured into the kernel
precludes mounting a ramdisk root after cramfs_read_super() has
been called.  The problem is that cramfs changes the blocksize
of the ramdisk to PAGE_CACHE_SIZE after we've loaded the initrd
at 1k blocksize.

The patchlet below effectively works around the problem.  Question
being does it do it in an acceptable manner?  Can refusing to change
blocksize of a device with a registered hard blocksize cause problems
elsewhere?

	-Mike

--- linux-2.4.1.ac12/fs/buffer.c.org	Wed Feb 14 14:01:54 2001
+++ linux-2.4.1.ac12/fs/buffer.c	Wed Feb 14 14:19:13 2001
@@ -686,7 +686,7 @@
 	int i, nlist, slept;
 	struct buffer_head * bh, * bh_next;
 
-	if (!blksize_size[MAJOR(dev)])
+	if (!blksize_size[MAJOR(dev)] || get_hardblocksize(dev))
 		return;
 
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */

