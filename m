Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVC1NjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVC1NjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVC1Niy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:38:54 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1724 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261791AbVC1N1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:23 -0500
Subject: [RFC/PATCH 12/17][Kdump] Routines for copying dump pages - more
	fixes
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-8eKcRon0YWSER1PhZ4VU"
Date: Mon, 28 Mar 2005 18:57:20 +0530
Message-Id: <1112016440.4001.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8eKcRon0YWSER1PhZ4VU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-8eKcRon0YWSER1PhZ4VU
Content-Disposition: attachment; filename=crashdump-routines-for-copying-dump-pages-more-fixes.patch
Content-Type: message/rfc822; name=crashdump-routines-for-copying-dump-pages-more-fixes.patch

From: 
Date: Mon, 28 Mar 2005 17:49:54 +0530
Subject: No Subject
Message-Id: <1112012394.4001.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: "Vivek Goyal" <vgoyal@in.ibm.com>

o Enable copy_oldmem_page() to read from a specific offset, with in a page.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm1-1M-root/include/linux/crash_dump.h |    3 ++-
 linux-2.6.12-rc1-mm1-1M-root/kernel/crash_dump.c        |   10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN include/linux/crash_dump.h~crashdump-routines-for-copying-dump-pages-more-fixes include/linux/crash_dump.h
--- linux-2.6.12-rc1-mm1-1M/include/linux/crash_dump.h~crashdump-routines-for-copying-dump-pages-more-fixes	2005-03-22 16:15:55.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/include/linux/crash_dump.h	2005-03-22 16:15:55.000000000 +0530
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/proc_fs.h>
 
-extern ssize_t copy_oldmem_page(unsigned long, char *, size_t, int);
+extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
+						unsigned long, int);
 #endif /* CONFIG_CRASH_DUMP */
 #endif /* LINUX_CRASHDUMP_H */
diff -puN kernel/crash_dump.c~crashdump-routines-for-copying-dump-pages-more-fixes kernel/crash_dump.c
--- linux-2.6.12-rc1-mm1-1M/kernel/crash_dump.c~crashdump-routines-for-copying-dump-pages-more-fixes	2005-03-22 16:15:55.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/kernel/crash_dump.c	2005-03-22 16:15:55.000000000 +0530
@@ -20,7 +20,7 @@
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-				size_t csize, int userbuf)
+				size_t csize, unsigned long offset, int userbuf)
 {
 	void *page, *vaddr;
 
@@ -36,14 +36,14 @@ ssize_t copy_oldmem_page(unsigned long p
 	kunmap_atomic(vaddr, KM_PTE0);
 
 	if (userbuf) {
-		if (copy_to_user(buf, page, csize)) {
+		if (copy_to_user(buf, (page + offset), csize)) {
 			kfree(page);
 			return -EFAULT;
 		}
 	} else {
-		memcpy(buf, page, csize);
+		memcpy(buf, (page + offset), csize);
 	}
-	kfree(page);
 
-	return 0;
+	kfree(page);
+	return csize;
 }
_

--=-8eKcRon0YWSER1PhZ4VU--

