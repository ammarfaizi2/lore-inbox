Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVC1NaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVC1NaD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVC1N3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:29:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:61920 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261813AbVC1N1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:48 -0500
Subject: [RFC/PATCH 17/17][Kdump] Cleanups for dump file access in linear
	raw format
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-ZQ9TDLJND40NmOAk9GxC"
Date: Mon, 28 Mar 2005 18:57:39 +0530
Message-Id: <1112016459.4001.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZQ9TDLJND40NmOAk9GxC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-ZQ9TDLJND40NmOAk9GxC
Content-Disposition: attachment; filename=crashdump-linear-raw-format-dump-file-access-cleanup.patch
Content-Type: text/x-patch; name=crashdump-linear-raw-format-dump-file-access-cleanup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



o Removed the dependency on backup region. Now all the information is encoded
  in ELF format. /dev/oldmem is a dummy interface. User space tool need to be
  intelligent enough to parse the elf headers and read the relevant memory
  areas with the help of /dev/oldmem.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm3-1M-root/drivers/char/mem.c |   51 +++++++-----------------
 1 files changed, 15 insertions(+), 36 deletions(-)

diff -puN drivers/char/mem.c~crashdump-linear-raw-format-dump-file-access-cleanup drivers/char/mem.c
--- linux-2.6.12-rc1-mm3-1M/drivers/char/mem.c~crashdump-linear-raw-format-dump-file-access-cleanup	2005-03-27 18:37:14.000000000 +0530
+++ linux-2.6.12-rc1-mm3-1M-root/drivers/char/mem.c	2005-03-27 18:37:14.000000000 +0530
@@ -26,6 +26,7 @@
 #include <linux/highmem.h>
 #include <linux/crash_dump.h>
 #include <linux/backing-dev.h>
+#include <linux/bootmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -278,55 +279,33 @@ static int mmap_kmem(struct file * file,
 #ifdef CONFIG_CRASH_DUMP
 /*
  * Read memory corresponding to the old kernel.
- * If we are reading from the reserved section, which is
- * actually used by the current kernel, we just return zeroes.
- * Or if we are reading from the first 640k, we return from the
- * backed up area.
  */
-static ssize_t read_oldmem(struct file * file, char * buf,
+static ssize_t read_oldmem(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	unsigned long pfn;
-	unsigned backup_start, backup_end, relocate_start;
-	size_t read=0, csize;
-
-	backup_start = CRASH_BACKUP_BASE / PAGE_SIZE;
-	backup_end = backup_start + (CRASH_BACKUP_SIZE / PAGE_SIZE);
-	relocate_start = (CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE) / PAGE_SIZE;
+	unsigned long pfn, offset;
+	size_t read = 0, csize;
+	int rc = 0;
 
 	while(count) {
 		pfn = *ppos / PAGE_SIZE;
+		if (pfn > saved_max_pfn)
+			return read;
 
-		csize = (count > PAGE_SIZE) ? PAGE_SIZE : count;
-
-		/* Perform translation (see comment above) */
-		if ((pfn >= backup_start) && (pfn < backup_end)) {
-			if (clear_user(buf, csize)) {
-				read = -EFAULT;
-				goto done;
-			}
-
-			goto copy_done;
-		} else if (pfn < (CRASH_RELOCATE_SIZE / PAGE_SIZE))
-			pfn += relocate_start;
-
-		if (pfn > saved_max_pfn) {
-			read = 0;
-			goto done;
-		}
-
-		if (copy_oldmem_page(pfn, buf, csize, 1)) {
-			read = -EFAULT;
-			goto done;
-		}
+		offset = (unsigned long)(*ppos % PAGE_SIZE);
+		if (count > PAGE_SIZE - offset)
+			csize = PAGE_SIZE - offset;
+		else
+			csize = count;
 
-copy_done:
+		rc = copy_oldmem_page(pfn, buf, csize, offset, 1);
+		if (rc < 0)
+			return rc;
 		buf += csize;
 		*ppos += csize;
 		read += csize;
 		count -= csize;
 	}
-done:
 	return read;
 }
 #endif
_

--=-ZQ9TDLJND40NmOAk9GxC--

