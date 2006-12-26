Return-Path: <linux-kernel-owner+w=401wt.eu-S932480AbWLZGkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWLZGkS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 01:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWLZGkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 01:40:18 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:60263 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932480AbWLZGkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 01:40:17 -0500
X-Greylist: delayed 1342 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 01:40:16 EST
Date: Tue, 26 Dec 2006 15:16:52 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [PATCH] Sanely size hash tables when using large base pages.
Message-ID: <20061226061652.GA598@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment both the pidhash and inode/dentry cache hash tables (common
by way of alloc_large_system_hash()) are incorrectly sized by their
respective detection logic when we attempt to use large base pages on
systems with little memory.

This results in odd behaviour when using a 64kB PAGE_SIZE, such as:

PID hash table entries: 512 (order: 9, 2048 bytes)
...
Dentry cache hash table entries: 8192 (order: -1, 32768 bytes)
Inode-cache hash table entries: 4096 (order: -2, 16384 bytes)

The mount cache hash table is seemingly the only one that gets this right
by directly taking PAGE_SIZE in to account.

The following patch attempts to catch the bogus values and round it up to
at least 0-order (or down, in the PID hash case).

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 kernel/pid.c    |   17 +++++++++++++----
 mm/page_alloc.c |    4 ++++

 2 files changed, 17 insertions(+), 4 deletions(-)
diff --git a/kernel/pid.c b/kernel/pid.c
index 2efe9d8..198c6a9 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -383,20 +383,29 @@ void free_pid_ns(struct kref *kref)
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
- * more.
+ * more.  As a safety net for large base page on small memory systems
+ * the hash table is scaled to a 0-order allocation in the event that the
+ * initial detection logic sizes the table incorrectly (which can result
+ * in a very large number of slots).
  */
 void __init pidhash_init(void)
 {
-	int i, pidhash_size;
+	int i, pidhash_size, size;
 	unsigned long megabytes = nr_kernel_pages >> (20 - PAGE_SHIFT);
 
 	pidhash_shift = max(4, fls(megabytes * 4));
 	pidhash_shift = min(12, pidhash_shift);
 	pidhash_size = 1 << pidhash_shift;
 
+	size = pidhash_size * sizeof(struct hlist_head);
+	if (unlikely(size < PAGE_SIZE)) {
+		size = PAGE_SIZE;
+		pidhash_size = size / sizeof(struct hlist_head);
+		pidhash_shift = 0;
+	}
+
 	printk("PID hash table entries: %d (order: %d, %Zd bytes)\n",
-		pidhash_size, pidhash_shift,
-		pidhash_size * sizeof(struct hlist_head));
+		pidhash_size, pidhash_shift, size);
 
 	pid_hash = alloc_bootmem(pidhash_size *	sizeof(*(pid_hash)));
 	if (!pid_hash)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8c1a116..4a9a83f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3321,6 +3321,10 @@ void *__init alloc_large_system_hash(con
 			numentries >>= (scale - PAGE_SHIFT);
 		else
 			numentries <<= (PAGE_SHIFT - scale);
+
+		/* Make sure we've got at least a 0-order allocation.. */
+		if (unlikely((numentries * bucketsize) < PAGE_SIZE))
+			numentries = PAGE_SIZE / bucketsize;
 	}
 	numentries = roundup_pow_of_two(numentries);
 
