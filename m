Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWIDG4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWIDG4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 02:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWIDG4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 02:56:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:3526 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932388AbWIDG4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 02:56:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=avZqcS3C/vgYhGsLQTuUT+kRGY+XdT6i2oyPjGUJAYy1mcbv+qh5LocfWJT6Hnp2/pv+xGmamMohVdVAle2ASxHnFOomledgcSCdGjS5bjuQPQ0a8PR4PoLZkQu5gZip8YoU+qeSLL3TdfIyBWmz0V27VobPF5uxnM/tFu09QXI=
Message-ID: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com>
Date: Mon, 4 Sep 2006 14:56:33 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUGs when removing largish files with the SLOB allocator
Cc: mpm@selenic.com, dhowells@redhat.com, davidm@snapgear.com,
       gerg@snapgear.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm working on the nommu blackfin uclinux(2.6.16) platform and  get a
kernel BUG! at mm/nommu.c:124 when removing largish file with the SLOB
allocator.

root:~> df -k
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/mtdblock3            3008      1264      1744  42% /
root:~> cp /bin/busybox /busy
root:~> df -k
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/mtdblock3            3008      1532      1476  51% /
root:~> ls -l /bin/busybox /busy
-rwxr-xr-x    1 0        0          423904 /bin/busybox
-rwxr-xr-x    1 0        0          423904 /busy
root:~> md5sum /bin/busybox
7db253a2259ab71bc854c9e5dac544d6  /bin/busybox
root:~> md5sum /busy
7db253a2259ab71bc854c9e5dac544d6  /busy
root:~> rm /busy
kernel BUG at mm/nommu.c:124!
Kernel panic - not syncing: BUG!

Bug comes from  mm/nommu.c:
=======================================
        if (!objp || !((page = virt_to_page(objp))) ||
           (unsigned long)objp >= memory_end)
                return 0;

        if (PageSlab(page))
                return ksize(objp);

        BUG_ON(page->index < 0);
124:    BUG_ON(page->index >= MAX_ORDER);
=======================================

This seems that the SLOB allocator doesn't set the SLAB page flag
while nommu.c seem to be written for SLAB only.

On my side the following patch seems to work around the issue
============================================================
--- nommu.c     2006-06-26 14:49:28.000000000 +0800
+++ nommu.c.new 2006-06-26 14:47:20.000000000 +0800
@@ -18,7 +18,9 @@
 #include <linux/file.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-#include <linux/slab.h>
+#ifdef CONFIG_SLAB
+# include <linux/slab.h>
+#endif
 #include <linux/vmalloc.h>
 #include <linux/ptrace.h>
 #include <linux/blkdev.h>
@@ -117,7 +119,9 @@
        if (!objp || !((page = virt_to_page(objp))) || (unsigned
long)objp >= memory_end)
                return 0;

+#ifdef CONFIG_SLAB
        if (PageSlab(page))
+#endif
                return ksize(objp);

        BUG_ON(page->index < 0);
============================================================

Is there any solution/patch to fix the issue?

Any suggestions are really appreciated.

Thanks,
-Aubrey

-- 
VGER BF report: U 0.498985
