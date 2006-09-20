Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWITNUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWITNUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWITNUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:20:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4028 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751250AbWITNUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:20:15 -0400
Date: Wed, 20 Sep 2006 15:20:11 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060920132011.GA4612@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060601184938.GA31376@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, Olaf Hering wrote:

> ...
> Error -3 while decompressing!
> c0000000009592a2(2649)->c0000000edf87000(4096)
> Error -3 while decompressing!
> c000000000959298(2520)->c0000000edbc7000(4096)
> Error -3 while decompressing!
> c000000000959c70(2489)->c0000000f1482000(4096) 
> Error -3 while decompressing!
> c00000000095a629(2355)->c0000000edaff000(4096)
> Error -3 while decompressing!
> ...

Today I looked at this bug again and found that 2.6.18-rc6-git2 has
fix for this. Is the patch below supposed to fix the cramfs corruption
or does it just paper over the bug?

...
cramfs_read() clears parts of the src buffer because the page is not
uptodate. invalidate_bdev() called from block_ioctl(BLKFLSBUF) will set
ClearPageUptodate() after cramfs_read() got the page from read_cache_page()
...

/root/cramfscrash.sh
#!/bin/bash
# cd /dev/shm/
# tar xfz /mounts/mirror/kernel/v2.6/linux-2.6.18.tar.gz
# cd linux-2.6.18/
# mkfs.cramfs drivers /tmp/cramfs.image
mount -vnt proc proc /proc
echo 1 > /proc/sys/kernel/panic
echo 9 > /proc/sysrq-trigger
mount -vnt sysfs sysfs /sys
modprobe -v loop
mount -vnt cramfs -o loop /tmp/cramfs.image /mnt
while :;do /sbin/blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
while :;do /usr/bin/find /mnt -type f -print0|xargs -0 cat &>/dev/null;done


kernel cmdline
xmon=off panic=1 sysrq=1 quiet root=/dev/disk/by-uuid/d50e4029-2e91-4332-bb16-24f946a74d3f ro init=/root/cramfscrash.sh



 016eb4a0ed06a3677d67a584da901f0e9a63c666.patch
From: Andrew Morton <akpm@osdl.org>

If a CPU faults this page into pagetables after invalidate_mapping_pages()
checked page_mapped(), invalidate_complete_page() will still proceed to remove
the page from pagecache.  This leaves the page-faulting process with a
detached page.  If it was MAP_SHARED then file data loss will ensue.

Fix that up by checking the page's refcount after taking tree_lock.

Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/truncate.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff -puN mm/truncate.c~invalidate_complete_page-race-fix mm/truncate.c
--- a/mm/truncate.c~invalidate_complete_page-race-fix
+++ a/mm/truncate.c
@@ -68,10 +68,10 @@ invalidate_complete_page(struct address_
 		return 0;
 
 	write_lock_irq(&mapping->tree_lock);
-	if (PageDirty(page)) {
-		write_unlock_irq(&mapping->tree_lock);
-		return 0;
-	}
+	if (PageDirty(page))
+		goto failed;
+	if (page_count(page) != 2)	/* caller's ref + pagecache ref */
+		goto failed;
 
 	BUG_ON(PagePrivate(page));
 	__remove_from_page_cache(page);
@@ -79,6 +79,9 @@ invalidate_complete_page(struct address_
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
+failed:
+	write_unlock_irq(&mapping->tree_lock);
+	return 0;
 }
 
 /**
_
