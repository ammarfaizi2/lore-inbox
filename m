Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTLDTUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLDTUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:20:31 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:44713 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263491AbTLDTU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:20:28 -0500
Message-ID: <3FCF88D9.7080002@colorfullife.com>
Date: Thu, 04 Dec 2003 20:19:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: pinotj@club-internet.fr, nathans@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
References: <mnet1.1070562461.26292.pinotj@club-internet.fr> <Pine.LNX.4.58.0312041035530.6638@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312041035530.6638@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070408020402040006090000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070408020402040006090000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

>Manfred, any ideas? What's different between 2.6.x and 2.4.x in slab?
>
>But it may also be that the bug is in some slab user - since my slab-
>translates-to-page-alloc hack always calls the slab constructor function
>on every allocation, and the destructor gets called immediately after the
>free, my debug version might hide some usage bugs.
>  
>
The changes between 2.4 and 2.6 are huge, for both debug and non-debug. 
Slab with debugging enabled now calls the destructors/constructor on 
every alloc. If page debugging is enabled, then all objects larger than 
128 bytes get their own page and are unmapped after kmem_cache_free(). 
The bio structure is smaller than 128 bytes - that probably explains why 
slab didn't catch the oopses that were mentioned in the other thread.
Perhaps something like the attached patch could help to trigger the 
oops: It increase the size of the bio structures, then they are handled 
by slab debugging.
If it oopses, then call ptrinfo() from the trap handler - it prints the 
name of the cache and the caller of the last slab operation. And hexdump 
the object (after ptrinfo mapped it), it contains a backtrace from the 
kmem_cache_free call.

--
    Manfred

--------------070408020402040006090000
Content-Type: text/plain;
 name="patch-bio"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-bio"

--- 2.6/fs/bio.c	2003-10-25 20:43:54.000000000 +0200
+++ build-2.6/fs/bio.c	2003-12-04 20:13:52.000000000 +0100
@@ -798,7 +798,7 @@
 
 		size = bp->nr_vecs * sizeof(struct bio_vec);
 
-		bp->slab = kmem_cache_create(bp->name, size, 0,
+		bp->slab = kmem_cache_create(bp->name, max(128,size), 0,
 						SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!bp->slab)
 			panic("biovec: can't init slab cache\n");
@@ -815,7 +815,7 @@
 
 static int __init init_bio(void)
 {
-	bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
+	bio_slab = kmem_cache_create("bio", max(128U,sizeof(struct bio)), 0,
 					SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!bio_slab)
 		panic("bio: can't create slab cache\n");

--------------070408020402040006090000--

