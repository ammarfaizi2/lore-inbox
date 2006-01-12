Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWALTGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWALTGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWALTGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:06:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64132 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964775AbWALTGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:06:39 -0500
Date: Thu, 12 Jan 2006 11:04:22 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: hawkes@sgi.com, tony.luck@gmail.com, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       steiner@sgi.com, djh@sgi.com, jh@sgi.com, edwardsg@sgi.com
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
In-Reply-To: <20060111160937.921a719d.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0601121057550.30182@schroedinger.engr.sgi.com>
References: <20060105213948.11412.45463.sendpatchset@tomahawk.engr.sgi.com>
 <20060111160937.921a719d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Paul Jackson wrote:

>       LD      .tmp_vmlinux1
>     arch/ia64/kernel/built-in.o(.init.text+0x68b2): In function `topology_init':
>     arch/ia64/kernel/ivt.S:1465: undefined reference to `__you_cannot_kmalloc_that_much'
>     make: *** [.tmp_vmlinux1] Error 1
> 
> Backing off to 512 CPUs built ok.
> 
> There are a couple of kmalloc() calls in topology_init().  I didn't try
> to figure out which one blew up, nor did I try to investigate further.

Here are two patches that might to cure it (used to be in 
2.6.15-rc5-mm1 but the cure accepted for the workqueues was to use
alloc_percpu):

From: Christoph Lameter <clameter@engr.sgi.com>

The workqueue structure can grow larger than 128k under 2.6.14-rc2 (with
all debugging features enabled on 64 bit platforms) which will make kzalloc
for workqueue structure entries fail.  This patch increases the maximum
slab entry size to 256K.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/kmalloc_sizes.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/kmalloc_sizes.h~increase-maximum-kmalloc-size-to-256k include/linux/kmalloc_sizes.h
--- 25/include/linux/kmalloc_sizes.h~increase-maximum-kmalloc-size-to-256k	Thu Sep 22 15:09:57 2005
+++ 25-akpm/include/linux/kmalloc_sizes.h	Thu Sep 22 15:09:57 2005
@@ -19,8 +19,8 @@
 	CACHE(32768)
 	CACHE(65536)
 	CACHE(131072)
-#ifndef CONFIG_MMU
 	CACHE(262144)
+#ifndef CONFIG_MMU
 	CACHE(524288)
 	CACHE(1048576)
 #ifdef CONFIG_LARGE_ALLOCS
_

From: Andrew Morton <akpm@osdl.org>

Fix instaoops.

Cc: Christoph Lameter <clameter@sgi.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/slab.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN mm/slab.c~increase-maximum-kmalloc-size-to-256k-fix mm/slab.c
--- devel/mm/slab.c~increase-maximum-kmalloc-size-to-256k-fix	2005-09-22 21:19:27.000000000 -0700
+++ devel-akpm/mm/slab.c	2005-09-22 21:19:27.000000000 -0700
@@ -551,8 +551,8 @@ static void **dbg_userword(kmem_cache_t 
 #define	MAX_OBJ_ORDER	13	/* up to 32Mb */
 #define	MAX_GFP_ORDER	13	/* up to 32Mb */
 #elif defined(CONFIG_MMU)
-#define	MAX_OBJ_ORDER	5	/* 32 pages */
-#define	MAX_GFP_ORDER	5	/* 32 pages */
+#define	MAX_OBJ_ORDER	6	/* 64 pages */
+#define	MAX_GFP_ORDER	6	/* 64 pages */
 #else
 #define	MAX_OBJ_ORDER	8	/* up to 1Mb */
 #define	MAX_GFP_ORDER	8	/* up to 1Mb */
_
