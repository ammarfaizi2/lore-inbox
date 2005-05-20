Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVETTYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVETTYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVETTYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:24:14 -0400
Received: from graphe.net ([209.204.138.32]:57862 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261547AbVETTYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:24:07 -0400
Date: Fri, 20 May 2005 12:23:52 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <428E3497.3080406@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505201210460.390@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
 <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
 <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net>
 <Pine.LNX.4.62.0505182105310.17811@graphe.net> <428E3497.3080406@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Matthew Dobson wrote:

> Christoph, I'm getting the following errors building rc4-mm2 w/ GCC 2.95.4:

Works fine here with gcc 2.95.4.ds15-22 but that is a debian gcc 
2.95.4 patched up to work correctly. If you need to address the pathology in pristine 
gcc 2.95.4 by changing the source then declare the entry field with 0 
members.

Index: linux-2.6.12-rc4/mm/slab.c
===================================================================
--- linux-2.6.12-rc4.orig/mm/slab.c	2005-05-19 21:29:45.000000000 +0000
+++ linux-2.6.12-rc4/mm/slab.c	2005-05-20 19:18:22.000000000 +0000
@@ -267,7 +267,7 @@
 #ifdef CONFIG_NUMA
 	spinlock_t lock;
 #endif
-	void *entry[];
+	void *entry[0];
 };
 
 /* bootstrap: The caches do not work without cpuarrays anymore,



gcc 2.95 can produce proper code for ppc64?



> mm/slab.c:281: field `entry' has incomplete typemm/slab.c: In function
> 'cache_alloc_refill':

See patch above?

> mm/slab.c:2497: warning: control reaches end of non-void function

That is the end of cache_alloc_debug_check right? This is a void 
function in my source.

> mm/slab.c: In function `kmem_cache_alloc':
> mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
> mm/slab.c: In function `kmem_cache_alloc_node':
> mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
> mm/slab.c: In function `__kmalloc':
> mm/slab.c:2567: warning: `objp' might be used uninitialized in this function

There is a branch there and the object is initialized in either branch.
