Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTKUTOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTKUTOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:14:20 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26801 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262805AbTKUTOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:14:14 -0500
Message-ID: <3FBE603C.3020903@colorfullife.com>
Date: Fri, 21 Nov 2003 19:58:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pinotj@club-internet.fr
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
References: <mnet1.1069438363.27768.pinotj@club-internet.fr>
In-Reply-To: <mnet1.1069438363.27768.pinotj@club-internet.fr>
Content-Type: multipart/mixed;
 boundary="------------060800040507040306040304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060800040507040306040304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

pinotj@club-internet.fr wrote:

>0. Increase verbosity of the printk (thanks to Manfred):
>(compilation of kernel)
>slab: double free detected in cache 'buffer_head', objp c4c8e3d8, objnr 10,
>slabp c4c8e000, s_mem c4c8e180, bufctl ffffffff.
>(compilation of firebird)
>slab: double free detected in cache 'pte_chain', objp c18a6600, objnr 10,
>slabp c18a6000, s_mem c18a6100, bufctl ffffffff.
>  
>
The correct value for the bufctl would be 0xfffffffe - a single bit is 
wrong, but OTHO 0xffffffff is also a valid value.
Two different caches are affected.
The addresses of the corrupted variable differ, the offset into the page 
is identical. I think that rules out bad memory. That leaves a bug in 
slab.c, a bad bit in the L1/L2 cache, or random pointer scribbling.
Jerome, could you try the attached patch? It changes the magic constants 
that are used by slab.c. And please pay attention to the objnr: Is it 
always objnr 10, slabp xxxxx000, or do you see other values as well?

--
    Manfred

--
    Manfred

--------------060800040507040306040304
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

--- 2.6/mm/slab.c	2003-11-18 18:18:20.000000000 +0100
+++ build-2.6/mm/slab.c	2003-11-21 19:50:02.000000000 +0100
@@ -153,9 +153,9 @@
  * is less than 512 (PAGE_SIZE<<3), but greater than 256.
  */
 
-#define BUFCTL_END	0xffffFFFF
-#define BUFCTL_FREE	0xffffFFFE
-#define	SLAB_LIMIT	0xffffFFFD
+#define BUFCTL_END	0xfeffFFFF
+#define BUFCTL_FREE	0xf7ffFFFE
+#define	SLAB_LIMIT	0xf0ffFFFD
 typedef unsigned int kmem_bufctl_t;
 
 /* Max number of objs-per-slab for caches which use off-slab slabs.

--------------060800040507040306040304--

