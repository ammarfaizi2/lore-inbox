Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbUCODxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUCODxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:53:55 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:49614 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262234AbUCODxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:53:53 -0500
Date: Mon, 15 Mar 2004 04:53:51 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04
Message-ID: <20040315035350.GA30948@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!

The following patch extends the 'noatime', 'nodiratime' and 
last but not least the 'ro' (read only) mount option to the 
vfs --bind mounts, allowing them to behave like any other 
mount, by honoring those mount flags (which are silently 
ignored by the current implementation)

an older version of this patch was included in 2.6.0-test6-mm2, 
and it is currently used by several people, without any issues, 
so I'd kindly request to consider it for inclusion into mainline.

if the size of the patch is an issue, I can break it down into
three parts, one preparing the existing structures, one adding
noatime/nodiratime and one doing the read only stuff.


the patch makes the following syscalls behave like expected

 - open (read/write/trunc), create
 - link, symlink, unlink
 - mknod (reg/block/char/fifo), mkfifo
 - mkdir, rmdir
 - (f)chown, (f)chmod, utime
 - access, truncate, mmap
 - ioctl (gen/ext2/ext3/reiser)


the following cases where verified for --bind ro (test tool) 
and showed no difference to a 'real' ro mounted filesystem:

 - open()
 - O_RDONLY: 	file, dir, symlink, broken, cdev, bdev, fifo, new
 - O_WRONLY: 	file, dir, symlink, broken, cdev, bdev, fifo, new
 - O_RDWR: 	file, dir, symlink, broken, cdev, bdev, fifo, new
 - O_CREAT: 	file
 
 - mkdir()  	dir, new, invalid
 - mkfifo() 	fifo, new, invalid

 - mknod()  	
 - S_IFREG: 	file, new, invalid
 - S_IFCHR: 	cdev, new, invalid
 - S_IFBLK: 	bdev, new, invalid
 - S_IFIFO: 	fifo, new, invalid
 
 - chown()  	file, invalid		 - fchown()	file
 - chmod()	file, invalid		 - fchmod()	file

 - link()   	file/file, file/invalid, invalid/file
 - symlink()	file/file, file/invalid, invalid/file
 
 - rename() 	file/file, file/invalid, invalid/file
 - rmdir()  	dir, new, invalid
 - truncate()	file, new invalid   	 - ftruncate()	file
 
 - unlink() 	file, bdev, cdev, fifo, new, invalid


you can download them here, if you prefer that over 
extracting them from emails ...

  http://www.13thfloor.at/patches/

TIA,
Herbert


