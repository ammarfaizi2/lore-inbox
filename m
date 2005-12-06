Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVLFSb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVLFSb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVLFSb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:31:28 -0500
Received: from gold.veritas.com ([143.127.12.110]:31384 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932529AbVLFSb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:31:27 -0500
Date: Tue, 6 Dec 2005 18:31:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Holloway <Nick.Holloway@pyrites.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc4 1/1] cpia: use vm_insert_page() instead of
 remap_pfn_range()
In-Reply-To: <20051205152758.GA29108@pyrites.org.uk>
Message-ID: <Pine.LNX.4.61.0512061801220.26899@goblin.wat.veritas.com>
References: <20051205152758.GA29108@pyrites.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Dec 2005 18:31:22.0470 (UTC) FILETIME=[42053060:01C5FA93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Nick Holloway wrote:

> Use vm_insert_page() instead of remap_pfn_range(), and remove
> the PageReserved fiddling.
> 
> Signed-off-by: Nick Holloway <Nick.Holloway@pyrites.org.uk>
> 
> ---
> 
> Although the cpia driver functioned correctly after printing out the
> "incomplete pfn remapping" message, I thought I would have a go at the
> trivial conversion'' as I have access to the hardware.
> 
> Driver has been tested with a parport CPIA camera (using "motion").

That patch looks good, thanks for making and testing it.

A couple of minor points which you may reasonably feel go beyond
what you were attempting:

rvfree becomes totally pointless (since vfree checks for NULL itself),
so it would be better to delete rvfree and replace the rvfree calls
by vfree calls (removing the size argument).

pos would be better off as a u8* matching frame_buf, than an unsigned
long that has to be cast this way and that.

And a third point which makes me hesitate.  It used to set PAGE_SHARED
(read-write access) on all the page table entries, whether the mmap
was MAP_PRIVATE or MAP_SHARED, PROT_WRITE or not.  That was wrong, and
Linus intentionally does not permit that mistake with vm_insert_page.

And the change _probably_ causes no trouble for anyone; but it _might_
cause trouble somewhere: it could be that userspace needs correcting
(to ask for shared write access where it wasn't asking before).
I've no idea whether write access makes sense with this driver.

So personally I'm rather reluctant to recommend a change of this kind
late in a release cycle (and I'd prefer that you didn't have to endure
the noisy warnings at this stage too, but Linus put them in,
so I think he wants them to stay).

Mauro, is this drivers/media/video/cpia.c under your maintainership?
If the maintainer wants such a patch to go in now, then I'd agree
with him; but I wouldn't be pushing it myself.

Later on, perhaps 2.6.16-rc-mm and early 2.6.17, I'd like to go over
lots of SetPageReserved drivers, to remove that and convert them over.
I'm sure various other little fixups will suggest themselves in that
exercise (things like adding VM_DONTEXPAND, removing VM_RESERVED and
VM_SHM, adding helpers for vmalloc and high-order loops).

Hugh

>  cpia.c |   22 ++++------------------
>  1 files changed, 4 insertions(+), 18 deletions(-)
> 
> --- linux-2.6.15-rc4/drivers/media/video/cpia.c~	2005-12-03 10:04:33.000000000 +0000
> +++ linux-2.6.15-rc4/drivers/media/video/cpia.c	2005-12-05 11:20:57.000000000 +0000
> @@ -219,7 +219,6 @@ static void set_flicker(struct cam_param
>  static void *rvmalloc(unsigned long size)
>  {
>  	void *mem;
> -	unsigned long adr;
>  
>  	size = PAGE_ALIGN(size);
>  	mem = vmalloc_32(size);
> @@ -227,29 +226,15 @@ static void *rvmalloc(unsigned long size
>  		return NULL;
>  
>  	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
> -	adr = (unsigned long) mem;
> -	while (size > 0) {
> -		SetPageReserved(vmalloc_to_page((void *)adr));
> -		adr += PAGE_SIZE;
> -		size -= PAGE_SIZE;
> -	}
>  
>  	return mem;
>  }
>  
>  static void rvfree(void *mem, unsigned long size)
>  {
> -	unsigned long adr;
> -
>  	if (!mem)
>  		return;
>  
> -	adr = (unsigned long) mem;
> -	while ((long) size > 0) {
> -		ClearPageReserved(vmalloc_to_page((void *)adr));
> -		adr += PAGE_SIZE;
> -		size -= PAGE_SIZE;
> -	}
>  	vfree(mem);
>  }
>  
> @@ -3753,7 +3738,8 @@ static int cpia_mmap(struct file *file, 
>  	struct video_device *dev = file->private_data;
>  	unsigned long start = vma->vm_start;
>  	unsigned long size  = vma->vm_end - vma->vm_start;
> -	unsigned long page, pos;
> +	unsigned long pos;
> +	struct page* page;
>  	struct cam_data *cam = dev->priv;
>  	int retval;
>  
> @@ -3781,8 +3767,8 @@ static int cpia_mmap(struct file *file, 
>  
>  	pos = (unsigned long)(cam->frame_buf);
>  	while (size > 0) {
> -		page = vmalloc_to_pfn((void *)pos);
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> +		page = vmalloc_to_page((void *)pos);
> +		if (vm_insert_page(vma, start, page)) {
>  			up(&cam->busy_lock);
>  			return -EAGAIN;
>  		}
> 
> -- 
>  `O O'  | Nick.Holloway@pyrites.org.uk
> // ^ \\ | http://www.pyrites.org.uk/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
