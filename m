Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTLBN0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLBN0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:26:45 -0500
Received: from r-maa.spacetown.ne.jp ([210.130.136.40]:26839 "EHLO
	r-maa.spacetown.ne.jp") by vger.kernel.org with ESMTP
	id S262129AbTLBN0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:26:41 -0500
Date: Tue, 02 Dec 2003 22:26:29 +0900 (JST)
Message-Id: <20031202.222629.24608383.jet@gyve.org>
To: linux-kernel@vger.kernel.org
Cc: oliver@neukum.org
Subject: hfs on scsi device
From: Masatake YAMATO <jet@gyve.org>
X-Mailer: Mew version 3.1.52 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.23 kernel shows oops when I've tried to mount hfs file system
on a CDROM in scsi CDROM drive. (Strictly speaking I'm using ide-scsi
kernel parameter.) I inspect this issue. 

This issue was reported and discussed this April:
http://www.ussg.iu.edu/hypermail/linux/kernel/0304.0/0365.html
http://marc.theaimsgroup.com/?l=linux-kernel&m=102890250915062&w=2


The symptom of oops is appeared in dmesg:

    kernel BUG at buffer.c:2518!
    ...

The line is in grow_buffers() function:

	/* Size must be multiple of hard sectorsize */
	if (size & (get_hardsect_size(dev)-1))
		BUG();

It seems that setting the block size is failed before the control reaches
this line.

With the following patch for linux-2.4.23/fs/hfs/super.c, you can avoid
the oops. The patch just checks the return value from set_blocksize.
If set_blocksize is failed, just return from the function(hfs_read_super). 

Masatake YAMATO
jet@gyve.org

397a398
> 	int dev_blocksize;
409c410,415
< 	set_blocksize(dev, HFS_SECTOR_SIZE);
---
> 	if (set_blocksize(dev, HFS_SECTOR_SIZE) < 0) {
> 		dev_blocksize = get_hardsect_size(dev);
> 		hfs_warn("hfs_fs: unsupported device block size: %d\n",
> 			 dev_blocksize);
> 		goto bail3;
> 	}

