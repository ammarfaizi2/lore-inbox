Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbRGPP5c>; Mon, 16 Jul 2001 11:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbRGPP5W>; Mon, 16 Jul 2001 11:57:22 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:59696 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S267440AbRGPP5L>;
	Mon, 16 Jul 2001 11:57:11 -0400
Message-ID: <3B530E9A.2080500@valinux.com>
Date: Mon, 16 Jul 2001 09:56:10 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 52 probable security holes in 2.4.6 and 2.4.6-ac2
In-Reply-To: <Pine.GSO.4.31.0107131616290.8768-100000@myth9.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Michael Ashcraft wrote:

> 
> [BUG] but mainly can make the kernel allocate unbounded amount of
>       memory and crash.
> /home/kash/linux/2.4.6/drivers/char/drm/ioctl.c:90:drm_setunique: ERROR:RANGE:82:90: Using user length "unique_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] [linkages -> 88:unique_len=unique_len -> 88:u->unique_len -> 82:u:start] [distance=25]
> 	drm_unique_t	 u;
> 
> 	if (dev->unique_len || dev->unique)
> 		return -EBUSY;
> 
> Start --->
> 	if (copy_from_user(&u, (drm_unique_t *)arg, sizeof(u)))
> 		return -EFAULT;
> 
> 	if (!u.unique_len)
> 		return -EINVAL;
> 
> 	dev->unique_len = u.unique_len;
> 	dev->unique	= drm_alloc(u.unique_len + 1, DRM_MEM_DRIVER);
> Error --->
> 	if (copy_from_user(dev->unique, u.unique, dev->unique_len))
> 		return -EFAULT;
> 	dev->unique[dev->unique_len] = '\0';


This is not a bug.  This is a root only ioctl called only during Xserver 
initialization/recycle.  It can't be called anywhere else.

> 
> 
> 
> [BUG]  unchecked int [should print this out in the message]
> /home/kash/linux/2.4.6/drivers/char/drm/i810_dma.c:1419:i810_copybuf: ERROR:RANGE:1411:1419: Using user length "used" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':1419 [linkages -> 1419:d->used -> 1411:d:start] [distance=46]
> 	if(!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
> 		DRM_ERROR("i810_dma called without lock held\n");
> 		return -EINVAL;
> 	}
> 
> Start --->
>    	if (copy_from_user(&d, (drm_i810_copy_t *)arg, sizeof(d)))
> 		return -EFAULT;
> 
> 	if(d.idx < 0 || d.idx > dma->buf_count) return -EINVAL;
> 	buf = dma->buflist[ d.idx ];
>    	buf_priv = buf->dev_private;
> 	if (buf_priv->currently_mapped != I810_BUF_MAPPED) return -EPERM;
> 
> Error --->
>    	if (copy_from_user(buf_priv->virtual, d.address, d.used))
> 		return -EFAULT;
> 
>    	sarea_priv->last_dispatch = (int) hw_status[5];

I'll send in a patch for this one.  Its really a bug.

> 
> ---------------------------------------------------------
> [BUG] you could loop for a long time.
> /home/kash/linux/2.4.6/drivers/char/drm/mga_bufs.c:485:mga_freebufs: ERROR:RANGE:482:485: [LOOP] Looping on user length "count" set by 'copy_from_user':485 [linkages -> 485:request->count -> 482:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_free_t *)arg,
> Start --->
> 			   sizeof(request)))
> 		return -EFAULT;
> 
> Error --->
> 	for (i = 0; i < request.count; i++) {
> 		if (copy_from_user(&idx,
> 				   &request.list[i],
> 				   sizeof(idx)))
> ---------------------------------------------------------
> [BUG]  you could loop for a long time.
> /home/kash/linux/2.4.6/drivers/char/drm/bufs.c:435:drm_freebufs: ERROR:RANGE:431:435: [LOOP] Looping on user length "count" set by 'copy_from_user':434 [linkages -> 434:request->count -> 431:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_free_t *)arg,
> Start --->
> 			   sizeof(request)))
> 		return -EFAULT;
> 
> 	DRM_DEBUG("%d\n", request.count);
> Error --->
> 	for (i = 0; i < request.count; i++) {
> 		if (copy_from_user(&idx,
> 				   &request.list[i],
> 				   sizeof(idx)))
> ---------------------------------------------------------
> [BUG] you could loop for a long time.
> /home/kash/linux/2.4.6/drivers/char/drm/i810_bufs.c:311:i810_freebufs: ERROR:RANGE:307:311: [LOOP] Looping on user length "count" set by 'copy_from_user':310 [linkages -> 310:request->count -> 307:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_free_t *)arg,
> Start --->
> 			   sizeof(request)))
> 		return -EFAULT;
> 
> 	DRM_DEBUG("%d\n", request.count);
> Error --->
> 	for (i = 0; i < request.count; i++) {
> 		if (copy_from_user(&idx,
> 				   &request.list[i],
> 				   sizeof(idx)))
> ---------------------------------------------------------


These are not bugs.  The maximum this loop can ever be is dma->buf_count.
drm_free_buffer will set the owner pid to zero, and if (buf->pid != 
current->pid) we exit the loop.

> 
> [BUG] no direct check on count
> /home/kash/linux/2.4.6/drivers/char/drm/i810_bufs.c:104:i810_addbufs_agp: ERROR:RANGE:61:104: [LOOP] Looping on user length "count" [linkages -> 64:count=count -> 64:request->count -> 61:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_desc_t *)arg,
> Start --->
> 			   sizeof(request)))
> 
> 	... DELETED 37 lines ...
> 
> 
> 	entry->buf_size   = size;
> 	entry->page_order = page_order;
> 	offset = 0;
> 
> Error --->
> 	while(entry->buf_count < count) {
> 		buf = &entry->buflist[entry->buf_count];
> 		buf->idx = dma->buf_count + entry->buf_count;
> 		buf->total = alignment;
> ---------------------------------------------------------
> [BUG] no direct check on count
> /home/kash/linux/2.4.6/drivers/char/drm/mga_bufs.c:115:mga_addbufs_agp: ERROR:RANGE:62:115: [LOOP] Looping on user length "count" [linkages -> 65:count=count -> 65:request->count -> 62:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_desc_t *)arg,
> Start --->
> 			   sizeof(request)))
> 
> 	... DELETED 47 lines ...
> 
> 	entry->buf_size   = size;
> 	entry->page_order = page_order;
> 	offset = 0;
> 
> 
> Error --->
> 	while(entry->buf_count < count) {
> 		buf = &entry->buflist[entry->buf_count];
> 		buf->idx = dma->buf_count + entry->buf_count;
> 		buf->total = alignment;
> ---------------------------------------------------------
> [BUG] no direct check on count
> /home/kash/linux/2.4.6/drivers/char/drm/radeon_bufs.c:116:radeon_addbufs_agp: ERROR:RANGE:62:116: [LOOP] Looping on user length "count" [linkages -> 65:count=count -> 65:request->count -> 62:request:start]
> 	int               byte_count;
> 	int               i;
> 
> 	if (!dma) return -EINVAL;
> 
> Start --->
> 	if (copy_from_user(&request, (drm_buf_desc_t *)arg, sizeof(request)))
> 
> 	... DELETED 48 lines ...
> 
> 
> 	entry->buf_size   = size;
> 	entry->page_order = page_order;
> 	offset            = 0;
> 
> Error --->
> 	for (offset = 0;
> 	     entry->buf_count < count;
> 	     offset += alignment, ++entry->buf_count) {
> 		buf          = &entry->buflist[entry->buf_count];
> ---------------------------------------------------------
> [BUG] no direct check on count
> /home/kash/linux/2.4.6/drivers/char/drm/r128_bufs.c:119:r128_addbufs_agp: ERROR:RANGE:65:119: [LOOP] Looping on user length "count" [linkages -> 68:count=count -> 68:request->count -> 65:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_desc_t *)arg,
> Start --->
> 			   sizeof(request)))
> 
> 	... DELETED 48 lines ...
> 
> 
> 	entry->buf_size   = size;
> 	entry->page_order = page_order;
> 	offset            = 0;
> 
> Error --->
> 	for (offset = 0;
> 	     entry->buf_count < count;
> 	     offset += alignment, ++entry->buf_count) {
> 		buf          = &entry->buflist[entry->buf_count];
> ---------------------------------------------------------
> [BUG] no direct check on count
> /home/kash/linux/2.4.6/drivers/char/drm/mga_bufs.c:287:mga_addbufs_pci: ERROR:RANGE:220:287: [LOOP] Looping on user length "count" [linkages -> 223:count=count -> 223:request->count -> 220:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_desc_t *)arg,
> Start --->
> 			   sizeof(request)))
> 
> 	... DELETED 61 lines ...
> 
> 
> 	entry->buf_size	  = size;
> 	entry->page_order = page_order;
> 	byte_count	  = 0;
> 	page_count	  = 0;
> Error --->
> 	while (entry->buf_count < count) {
> 		if (!(page = drm_alloc_pages(page_order, DRM_MEM_DMA))) break;
> 		entry->seglist[entry->seg_count++] = page;
> 		for (i = 0; i < (1 << page_order); i++) {
> ---------------------------------------------------------
> [BUG] no direct check on count
> /home/kash/linux/2.4.6/drivers/char/drm/bufs.c:239:drm_addbufs: ERROR:RANGE:172:239: [LOOP] Looping on user length "count" [linkages -> 175:count=count -> 175:request->count -> 172:request:start]
> 
> 	if (!dma) return -EINVAL;
> 
> 	if (copy_from_user(&request,
> 			   (drm_buf_desc_t *)arg,
> Start --->
> 			   sizeof(request)))
> 
> 	... DELETED 61 lines ...
> 
> 
> 	entry->buf_size	  = size;
> 	entry->page_order = page_order;
> 	byte_count	  = 0;
> 	page_count	  = 0;
> Error --->
> 	while (entry->buf_count < count) {
> 		if (!(page = drm_alloc_pages(page_order, DRM_MEM_DMA))) break;
> 		entry->seglist[entry->seg_count++] = page;
> 		for (i = 0; i < (1 << page_order); i++) {
> ---------------------------------------------------------
> 

These are not bugs, they are root only ioctl's.

-Jeff

