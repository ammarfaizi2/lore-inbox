Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWE2VkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWE2VkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWE2VkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:40:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:48058 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751424AbWE2VkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:40:14 -0400
Date: Mon, 29 May 2006 23:40:11 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060529214011.GA417@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This script will cause cramfs decompression errors, on SMP at least:

#!/bin/bash
while :;do blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
while :;do ps faxs  </dev/null &>/dev/null&done </dev/null &>/dev/null&
while :;do dmesg    </dev/null &>/dev/null&done </dev/null &>/dev/null&
while :;do find /mounts/instsys -type f -print0|xargs -0 cat &>/dev/null;done

...
Error -3 while decompressing!
c0000000009592a2(2649)->c0000000edf87000(4096)
Error -3 while decompressing!
c000000000959298(2520)->c0000000edbc7000(4096)
Error -3 while decompressing!
c000000000959c70(2489)->c0000000f1482000(4096)
Error -3 while decompressing!
c00000000095a629(2355)->c0000000edaff000(4096)
Error -3 while decompressing!
...

evms_access does the ioctl (lots of them) on the loop device.
Its a long standing bug, 2.6.5 fails as well. cramfs_read() clears parts
of the src buffer because the page is not uptodate. invalidate_bdev()
touched the page last.
cramfs_read() was called from line 480 or 490 when the
PageUptodate(page) test fails.

...
    464 static int cramfs_readpage(struct file *file, struct page * page)
..
    479                 if (page->index)
    480                         start_offset = *(u32 *) cramfs_read(sb, blkptr_offset-4, 4);
..
    488                         bytes_filled = cramfs_uncompress_block(pgdata,
    489                                  PAGE_CACHE_SIZE,
    490                                  cramfs_read(sb, start_offset, compr_len),
    491                                  compr_len);
...

There are rumors that cramfs is not smp safe...
Maybe the only hope is to tell evms to not do that ioctl for loop.
