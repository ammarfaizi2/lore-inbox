Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbTHOQv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270626AbTHOQup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:50:45 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:27110 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270620AbTHOQtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:49:09 -0400
Message-ID: <3F3D2B96.6060903@wanadoo.fr>
Date: Fri, 15 Aug 2003 18:51:02 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] slab debug vs. L1 alignement
References: <1060956004.581.13.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------050707090408050907020108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050707090408050907020108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> Currently, when enabling slab debugging, we lose the property of
> having the objects aligned on a cache line size.
> 
> This is, imho, an error, especially if GFP_DMA is passed. Such an
> object _must_ be cache alined (and it's size rounded to a multiple
> of the cache line size).
> 
> There is a simple performance reason on cache coherent archs, but
> there's also the fact that it will just _not_ work properly on
> non cache-coherent archs. Actually, I also have to deal with some
> old machines who have a SCSI controller who has a problem accessing
> buffers that aren't aligned on a cache line size boundary.
> 
> This is typically causing me trouble in various parts of SCSI which
> abuses kmalloc(512, GFP_KERNEL | GFP_DMA) for buffers passed to some
> SCSI commands, typically "utility" commands used to read a disk
> capacity, read read/write protect flags, some sense buffers, etc...
> 
> While I know SCSI shall use the consistent alloc things, it has not
> been fully fixed yet and kmalloc with GFP_DMA is still valid despite
> not beeing efficient, so we should make sure in this case, the returned
> buffer is really suitable for DMA, that is cache aligned.

Attached untested patch should fix it (vs 2.6.0-test1), I've no
idea if it's acceptable.

regards
Philippe Elie

--------------050707090408050907020108
Content-Type: text/plain;
 name="slab1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab1.diff"

--- mm/slab.c~	2003-07-14 03:36:48.000000000 +0000
+++ mm/slab.c	2003-08-15 18:40:14.000000000 +0000
@@ -682,7 +682,7 @@
 
 		sizes->cs_dmacachep = kmem_cache_create(
 			names->name_dma, sizes->cs_size,
-			0, SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
+			0, SLAB_CACHE_DMA|SLAB_MUST_HWCACHE_ALIGN, NULL, NULL);
 		if (!sizes->cs_dmacachep)
 			BUG();
 

--------------050707090408050907020108--

