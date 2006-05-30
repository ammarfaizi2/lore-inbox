Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWE3NTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWE3NTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWE3NTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:19:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:14255 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751091AbWE3NTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:19:36 -0400
Date: Tue, 30 May 2006 15:19:34 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060530131934.GA6400@suse.de>
References: <20060529214011.GA417@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060529214011.GA417@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, May 29, Olaf Hering wrote:

> This script will cause cramfs decompression errors, on SMP at least:
> 
> #!/bin/bash
> while :;do blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
> while :;do ps faxs  </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do dmesg    </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do find /mounts/instsys -type f -print0|xargs -0 cat &>/dev/null;done
> 
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

This change works for me, the added BUG() does not trigger.
read_cache_page() returns the page in PageUptodate() state.
But a few ticks later, invalidate_complete_page() calls ClearPageUptodate(),
on another cpu.
The SetPageDirty() works for my testcase, but not without the mb().
Does anyone know what sideeffects the SetPageDirty() has for the
loopmounted cramfs?



---
 fs/cramfs/inode.c      |    2 ++
 fs/cramfs/uncompress.c |    1 +
 2 files changed, 3 insertions(+)

Index: linux-2.6.16.16-1.6/fs/cramfs/inode.c
===================================================================
--- linux-2.6.16.16-1.6.orig/fs/cramfs/inode.c
+++ linux-2.6.16.16-1.6/fs/cramfs/inode.c
@@ -186,6 +186,8 @@ static void *cramfs_read(struct super_bl
 			/* synchronous error? */
 			if (IS_ERR(page))
 				page = NULL;
+			SetPageDirty(page);
+			mb();
 		}
 		pages[i] = page;
 	}
Index: linux-2.6.16.16-1.6/fs/cramfs/uncompress.c
===================================================================
--- linux-2.6.16.16-1.6.orig/fs/cramfs/uncompress.c
+++ linux-2.6.16.16-1.6/fs/cramfs/uncompress.c
@@ -50,6 +50,7 @@ int cramfs_uncompress_block(void *dst, i
 err:
 	printk("Error %d while decompressing!\n", err);
 	printk("%p(%d)->%p(%d)\n", src, srclen, dst, dstlen);
+	BUG_ON(1);
 	return 0;
 }
 
