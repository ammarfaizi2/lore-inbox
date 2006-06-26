Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWFZMvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWFZMvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWFZMvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:51:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:31794 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751122AbWFZMvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:51:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jsnVA3sbKGjeSHfH7Ukji/L5lkldtvluAyUw26RE2RELbE5lfeId1ARNUajcPz0LCjk4JaKynlBy8LWAOitiS1NwNc7UwUAhpj632riaxBkPsLb8AO3345ViRDa10K55YzAptowwC4pkvPEx+WkUCEfnN2QnHhVblehMz/KJL/w=
Message-ID: <6d6a94c50606260551n666a62d0ue578ce3c70fae1@mail.gmail.com>
Date: Mon, 26 Jun 2006 20:51:01 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix kernel BUGs when enable SLOB allocator
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When enable the SLOB allocator on a nommu system(uClinux), the
following bug occurs when remove a large file.
=========================================================
root:~> cp /bin/busybox /busy
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
=========================================================

The root cause is the slob allocator get the pages but does not set
the PageSlab bit.
So when kobjsize is called, the bug occurs.

My patch found a simple way to fix the issue. When SLOB is enabled, we
don't need to set the PageSlab bit, and don't need to check the
PageSlab bit(PageSlab(page)) in the kobjsize routine call.

Signed-off-by: Aubrey Li <aubrey.adi@gmail.com>

------
diff --git a/mm/nommu.c b/mm/nommu.c
index 029fada..8a54391 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -18,7 +18,9 @@ #include <linux/swap.h>
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
@@ -112,7 +114,9 @@ unsigned int kobjsize(const void *objp)
        if (!objp || !((page = virt_to_page(objp))))
                return 0;

+#ifdef CONFIG_SLAB
        if (PageSlab(page))
+#endif
                return ksize(objp);

        BUG_ON(page->index < 0);
------
