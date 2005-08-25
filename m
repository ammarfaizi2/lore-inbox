Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVHYKlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVHYKlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 06:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVHYKlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 06:41:36 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:27857 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S964929AbVHYKlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 06:41:35 -0400
Message-ID: <430DA052.9070908@cosmosbay.com>
Date: Thu, 25 Aug 2005 12:41:22 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
 atomic_t
References: <20050824214610.GA3675@localhost.localdomain> <1124956563.3222.8.camel@laptopd505.fenrus.org> <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org> <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org>
In-Reply-To: <20050825092322.GA9902@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------020902060705090802010604"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 25 Aug 2005 12:41:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020902060705090802010604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Christoph Hellwig a écrit :
> On Thu, Aug 25, 2005 at 11:17:23AM +0200, Eric Dumazet wrote:
> 
>>>But that's not true.  You need to write you own sysctl handler for it,
>>>probably worth adding a generic atomic_t sysctl handler while you're
>>>at it.
>>>
>>
>>I checked linux-2.6.13-rc7 tree, and atomic_read() is just a wrapper to 
>>read v->counter.
> 
> 
> That doesn't matter.  atomic_t is an opaqueue type and you must use the
> atomic_* interfaces to access it.

OK, here is a new clean patch that address this problem (nothing assumed about 
atomics)

This patch removes filp_count_lock spinlock, used to protect files_stat.nr_files.

Introduce an atomic_t atomic_nr_files to keep the exact count, and mirror its 
value into nr_files.

Forcing atomic_nr_files to be in the same cache line than nr_files makes sure 
we dont dirty two cache lines.

There is still a locked memory operation on SMP, but it saves an sti/cli pair.

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------020902060705090802010604
Content-Type: text/plain;
 name="patch_filp_count_lock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_filp_count_lock"

diff -Nru linux-2.6.13-rc7/fs/file_table.c linux-2.6.13-rc7-ed/fs/file_table.c
--- linux-2.6.13-rc7/fs/file_table.c	2005-08-24 05:39:14.000000000 +0200
+++ linux-2.6.13-rc7-ed/fs/file_table.c	2005-08-25 12:18:02.000000000 +0200
@@ -19,38 +19,28 @@
 #include <linux/fsnotify.h>
 
 /* sysctl tunables... */
-struct files_stat_struct files_stat = {
-	.max_files = NR_FILE
-};
+struct files_stat_struct files_stat;
 
 EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
 
 /* public. Not pretty! */
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
-static DEFINE_SPINLOCK(filp_count_lock);
 
 /* slab constructors and destructors are called from arbitrary
- * context and must be fully threaded - use a local spinlock
- * to protect files_stat.nr_files
+ * context and must be fully threaded
  */
 void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags)
 {
 	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		unsigned long flags;
-		spin_lock_irqsave(&filp_count_lock, flags);
-		files_stat.nr_files++;
-		spin_unlock_irqrestore(&filp_count_lock, flags);
+		files_stat.nr_files = atomic_add_return(1, &files_stat.atomic_nr_files);
 	}
 }
 
 void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
+	files_stat.nr_files = atomic_sub_return(1, &files_stat.atomic_nr_files);
 }
 
 static inline void file_free(struct file *f)
@@ -258,4 +248,5 @@
 	files_stat.max_files = n; 
 	if (files_stat.max_files < NR_FILE)
 		files_stat.max_files = NR_FILE;
+	atomic_set(&files_stat.atomic_nr_files, 0);
 } 
diff -Nru linux-2.6.13-rc7/include/linux/fs.h linux-2.6.13-rc7-ed/include/linux/fs.h
--- linux-2.6.13-rc7/include/linux/fs.h	2005-08-24 05:39:14.000000000 +0200
+++ linux-2.6.13-rc7-ed/include/linux/fs.h	2005-08-25 12:39:07.000000000 +0200
@@ -9,6 +9,8 @@
 #include <linux/config.h>
 #include <linux/limits.h>
 #include <linux/ioctl.h>
+#include <linux/cache.h>
+#include <asm/atomic.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -30,10 +32,12 @@
 
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
-	int nr_files;		/* read only */
+	int nr_files;		/* mirrors atomic_nr_files value */
 	int nr_free_files;	/* read only */
 	int max_files;		/* tunable */
-};
+
+	atomic_t atomic_nr_files;
+} ____cacheline_aligned;
 extern struct files_stat_struct files_stat;
 
 struct inodes_stat_t {

--------------020902060705090802010604--
