Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUGNHa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUGNHa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 03:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUGNHa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 03:30:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:37798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265770AbUGNHaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 03:30:23 -0400
Date: Wed, 14 Jul 2004 00:29:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.8-rc1-mm1
Message-Id: <20040714002912.26ed0e66.akpm@osdl.org>
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org>
References: <20040713182559.7534e46d.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6.8-rc1-mm1/
>

This kernel runs like a dessicated slug if you have more than 2G of memory
due to a 32-bit overflow.

Dentry cache hash table entries: 1 (order: -10, 4 bytes)
Inode-cache hash table entries: 1 (order: -10, 4 bytes)

The dcache is a singly-linked list.  Here's a (lame) fix:


--- 25/mm/page_alloc.c~making-i-dhash_entries-cmdline-work-as-it-use-to-fix	2004-07-14 00:11:26.437028752 -0700
+++ 25-akpm/mm/page_alloc.c	2004-07-14 00:24:56.461886256 -0700
@@ -2004,7 +2004,8 @@ void *__init alloc_large_system_hash(con
 				     unsigned int *_hash_shift,
 				     unsigned int *_hash_mask)
 {
-	unsigned long max, log2qty, size;
+	unsigned long long max;
+	unsigned long log2qty, size;
 	void *table;
 
 	/* allow the kernel cmdline to have a say */
@@ -2025,18 +2026,19 @@ void *__init alloc_large_system_hash(con
 	numentries = 1UL << (long_log2(numentries) + 1);
 
 	/* limit allocation size to 1/16 total memory */
-	max = ((nr_all_pages << PAGE_SHIFT)/16) / bucketsize;
+	max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
+	do_div(max, bucketsize);
 
 	if (numentries > max)
 		numentries = max;
 
 	log2qty = long_log2(numentries);
 
+	size = bucketsize << log2qty;
 	do {
-		size = bucketsize << log2qty;
-
-		table = (void *) alloc_bootmem(size);
-
+		table = alloc_bootmem(size);
+		if (!table)
+			size /= 2;
 	} while (!table && size > PAGE_SIZE);
 
 	if (!table)
_



btw, David, I'm wondering about this loop:

	do {
		size = bucketsize << log2qty;

		table = (void *) alloc_bootmem(size);

	} while (!table && size > PAGE_SIZE);

Is this a busy-wait-until-someone-plugs-in-more-ram-chips thing? ;)

I assume you meant something like the above?

btw, that (void *) cast was superfluous...
