Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266866AbUBQXYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUBQXYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:24:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:20661 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266866AbUBQXXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:23:02 -0500
Date: Tue, 17 Feb 2004 15:24:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Limit hash table size
Message-Id: <20040217152451.7e1796d9.akpm@osdl.org>
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2AADF@scsmsx401.sc.intel.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2AADF@scsmsx401.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> OK, here is another revision on top of what has been discussed.  It adds
> 4 boot time parameters so user can override default size as needed to
> suite special needs.

You've set the default to 2M entries, with an option for this to be
increased via a boot parameter.  This means that people whose machines have
lots of memory and a sane number of zones may suddenly wonder why their
app-which-uses-a-zillion-files is running like crap.

I think it would be better to leave things as they are, with a boot option
to scale the tables down.  The below patch addresses the inode and dentry
caches.  Need to think a bit more about the networking ones.

> I will sent a separate patch for
> kernel-parameters.txt if everyone is OK with this one.

Yes please.


diff -puN fs/dcache.c~limit-hash-table-sizes-boot-options-restore-defaults fs/dcache.c
--- 25/fs/dcache.c~limit-hash-table-sizes-boot-options-restore-defaults	Tue Feb 17 15:11:09 2004
+++ 25-akpm/fs/dcache.c	Tue Feb 17 15:11:29 2004
@@ -49,7 +49,6 @@ static kmem_cache_t *dentry_cache; 
  */
 #define D_HASHBITS     d_hash_shift
 #define D_HASHMASK     d_hash_mask
-#define D_HASHMAX	(2*1024*1024UL)	/* max number of entries */
 
 static unsigned int d_hash_mask;
 static unsigned int d_hash_shift;
@@ -1567,12 +1566,11 @@ static void __init dcache_init(unsigned 
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
-	if (!dhash_entries) {
+	if (!dhash_entries)
 		dhash_entries = PAGE_SHIFT < 13 ?
 				mempages >> (13 - PAGE_SHIFT) :
 				mempages << (PAGE_SHIFT - 13);
-		dhash_entries = min(D_HASHMAX, dhash_entries);
-	}
+
 	dhash_entries *= sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < dhash_entries; order++)
 		;
diff -puN fs/inode.c~limit-hash-table-sizes-boot-options-restore-defaults fs/inode.c
--- 25/fs/inode.c~limit-hash-table-sizes-boot-options-restore-defaults	Tue Feb 17 15:11:09 2004
+++ 25-akpm/fs/inode.c	Tue Feb 17 15:11:47 2004
@@ -53,7 +53,6 @@
  */
 #define I_HASHBITS	i_hash_shift
 #define I_HASHMASK	i_hash_mask
-#define I_HASHMAX	(2*1024*1024UL)	/* max number of entries */
 
 static unsigned int i_hash_mask;
 static unsigned int i_hash_shift;
@@ -1336,12 +1335,11 @@ void __init inode_init(unsigned long mem
 	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
-	if (!ihash_entries) {
+	if (!ihash_entries)
 		ihash_entries = PAGE_SHIFT < 14 ?
 				mempages >> (14 - PAGE_SHIFT) :
 				mempages << (PAGE_SHIFT - 14);
-		ihash_entries = min(I_HASHMAX, ihash_entries);
-	}
+
 	ihash_entries *= sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < ihash_entries; order++)
 		;


