Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUALQuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUALQuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:50:55 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:55184 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266186AbUALQur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:50:47 -0500
Message-ID: <4002D059.3030505@colorfullife.com>
Date: Mon, 12 Jan 2004 17:50:33 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Limit hash table size
Content-Type: multipart/mixed;
 boundary="------------020906090105020408060807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020906090105020408060807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>Why cant we do something like Andrews recent min_free_kbytes patch and
>make the rate of change non linear. Just slow the increase down as we
>get bigger. I agree a 2GB hashtable is pretty ludicrous, but a 4MB one
>on a 512GB machine (which we sell at the moment) could be too :)
>  
>
What about making the limit configurable with a boot time parameter? If 
someone uses a 512 GB ppc64 as an nfs server, he might want a 2 GB inode 
hash.

--
    Manfred

--------------020906090105020408060807
Content-Type: text/plain;
 name="patch-hash-alloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-hash-alloc"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 0
//  EXTRAVERSION = -test11
--- 2.6/fs/inode.c	2003-11-29 09:46:34.000000000 +0100
+++ build-2.6/fs/inode.c	2003-11-29 10:19:21.000000000 +0100
@@ -1327,6 +1327,20 @@
 		wake_up_all(wq);
 }
 
+static __initdata int ihash_entries;
+
+static int __init set_ihash_entries(char *str)
+{
+	get_option(&str, &ihash_entries);
+	if (ihash_entries <= 0) {
+		ihash_entries = 0;
+		return 0;
+	}
+	return 1;
+}
+
+__setup("ihash_entries=", set_ihash_entries);
+
 /*
  * Initialize the waitqueues and inode hash table.
  */
@@ -1340,8 +1354,16 @@
 	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
-	mempages >>= (14 - PAGE_SHIFT);
-	mempages *= sizeof(struct hlist_head);
+	if (!ihash_entries) {
+		ihash_entries = mempages >> (14 - PAGE_SHIFT);
+		/* Limit inode hash size. Override for nfs servers
+		 * that handle lots of files.
+		 */
+		if (ihash_entries > 1024*1024)
+			ihash_entries = 1024*1024;
+	}
+
+	mempages = ihash_entries*sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
 
--- 2.6/fs/dcache.c	2003-11-29 09:46:34.000000000 +0100
+++ build-2.6/fs/dcache.c	2003-11-29 10:53:15.000000000 +0100
@@ -1546,6 +1546,20 @@
 	return ino;
 }
 
+static __initdata int dhash_entries;
+
+static int __init set_dhash_entries(char *str)
+{
+	get_option(&str, &dhash_entries);
+	if (dhash_entries <= 0) {
+		dhash_entries = 0;
+		return 0;
+	}
+	return 1;
+}
+
+__setup("dhash_entries=", set_dhash_entries);
+
 static void __init dcache_init(unsigned long mempages)
 {
 	struct hlist_head *d;
@@ -1571,10 +1585,18 @@
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
+	if (!dhash_entries) {
 #if PAGE_SHIFT < 13
-	mempages >>= (13 - PAGE_SHIFT);
+		mempages >>= (13 - PAGE_SHIFT);
 #endif
-	mempages *= sizeof(struct hlist_head);
+		dhash_entries = mempages;
+		/* 8 mio is enough for general purpose systems.
+		 * For file servers, override with "dhash_entries="
+		 */
+		if (dhash_entries > 8*1024*1024)
+			dhash_entries = 8*1024*1024;
+	}
+	mempages = dhash_entries*sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
 

--------------020906090105020408060807--

