Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbSLaAUx>; Mon, 30 Dec 2002 19:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSLaAUx>; Mon, 30 Dec 2002 19:20:53 -0500
Received: from alb-24-29-45-178.nycap.rr.com ([24.29.45.178]:2564 "EHLO
	ender.tmmz.net") by vger.kernel.org with ESMTP id <S267090AbSLaAUw>;
	Mon, 30 Dec 2002 19:20:52 -0500
Date: Mon, 30 Dec 2002 19:33:59 -0500 (EST)
From: Matthew Zahorik <matt@albany.net>
X-X-Sender: matt@ender.tmmz.net
To: linux-kernel@vger.kernel.org
Subject: How does the disk buffer cache work?
Message-ID: <Pine.BSF.4.43.0212301918280.370-100000@ender.tmmz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I wrote to the list where my SS10 hung on the partition check
if a bad disk was installed.

This behavior is new to the 2.4.20 kernel.  I previously ran 2.2.20 on the
machine. (the default in a Debian 3.0r0 install)  I can't vouch for 2.4
kernels previous to 2.4.20.

I have traced the problem to a hang in the one of the disk buffer caches.

Can anyone tell me how to correct the behavior so that I:

1.  Don't break things for other parts of the kernel
2.  The disk cache will return with an error for a hung disk?

Here's the tail of the console with debugging printk's inserted:

sda: Spinning up disk.......................................................................................................not responding...
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 28
Current sd00:00: sense key Not Ready
Additional sense indicates Logical unit is in process of becoming ready
sda : block size assumed to be 512 bytes, disk size 1GB.
Partition check:
 sda:sun.c/sun_partition: Before read_dev_sector
check.c/read_dev_sector: offset = 0
check.c/read_dev_sector: passing page filler function @ f004fd14
filemap.c/read_cache_page: enter
filemap.c/read_cache_page: before __read_cache_page
filemap.c/__read_cache_page: enter
block_dev.c/block_read_full_page: before first do
block_dev.c/block_read_full_page: before if (!nr)
block_dev.c/block_read_full_page: before stage two
block_dev.c/block_read_full_page: before starting I/O
block_dev.c/block_read_full_page: returning
filemap.c/read_cache_page: after __read_cache_page
filemap.c/read_cache_page: after mark_page_accessed

[.. the next function call in read_cache_page() is lock_page(), which we
hang forever on ..]

Can those more familiar with the buffer caches advise me on a solution?
Errors on cached devices should propagate up to higher layers.  As is, the
machine hangs forever when reading sector 0 to check the partition table.

Thanks!

- Matt

