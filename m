Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263268AbSJCKyg>; Thu, 3 Oct 2002 06:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263242AbSJCKyg>; Thu, 3 Oct 2002 06:54:36 -0400
Received: from kim.it.uu.se ([130.238.12.178]:36789 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S263268AbSJCKyf>;
	Thu, 3 Oct 2002 06:54:35 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.9013.244887.809979@kim.it.uu.se>
Date: Thu, 3 Oct 2002 13:00:05 +0200
To: linux-kernel@vger.kernel.org
Subject: initrd breakage in 2.5.38-2.5.40
CC: viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing initrd-related problems since 2.5.38.
It worked like a charm up to 2.5.37.

The initrd itself works (mine allows users to select root
partition, no modules involved), but some time later, the
kernel hangs hard. (No message, NMI watchdog and SysRQ don't
work.) I can trigger the hangs easily by generating a lot of
FS activity, e.g. by unpacking a kernel tarball just after boot.

When booting without an initrd image the kernel is rock solid.

First I thought the problem was caused by a apparently missing
set_capacity() call in 2.5.38's drivers/block/rd.c:

diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Sat Sep 21 21:25:46 2002
+++ b/drivers/block/rd.c	Sat Sep 21 21:25:46 2002
...
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* We ought to separate initrd operations here */
-	register_disk(NULL, mk_kdev(MAJOR_NR,INITRD_MINOR), 1, &rd_bd_op, rd_size<<1);
+	add_disk(&initrd_disk);
 	devfs_register(devfs_handle, "initrd", DEVFS_FL_DEFAULT, MAJOR_NR,
 			INITRD_MINOR, S_IFBLK | S_IRUSR, &rd_bd_op, NULL);
 #endif

Looking at the other register_disk -> add_disk changes, it looks as
if a "set_capacity(&initrd_disk, rd_size * 2);" call should be made
just before the add_disk call. I tried that and it seemed to fix
initrd in 2.5.38, but unfortunately I still get the hangs in 2.5.39
and 2.5.40 with this patch.

/Mikael
