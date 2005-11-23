Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVKWUdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVKWUdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVKWUdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:33:35 -0500
Received: from silver.veritas.com ([143.127.12.111]:57733 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932437AbVKWUdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:33:31 -0500
Date: Wed, 23 Nov 2005 20:33:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave Airlie <airlied@gmail.com>
cc: Michael Frank <mhf@berlios.de>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Michael Krufky <mkrufky@m1k.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
In-Reply-To: <21d7e9970511230307l1fcfc182w7ec82a76243a9a0c@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0511231926500.12654@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com> 
 <20051122211625.165F114CB@hornet.berlios.de> 
 <Pine.LNX.4.61.0511222124040.29784@goblin.wat.veritas.com> 
 <20051122231603.2209814DA@hornet.berlios.de>
 <21d7e9970511230307l1fcfc182w7ec82a76243a9a0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Nov 2005 20:33:30.0839 (UTC) FILETIME=[2AB2CE70:01C5F06D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Dave Airlie wrote:
> On 11/23/05, Michael Frank <mhf@berlios.de> wrote:
> >
> > Your patch fixed the DRM issue.

Thanks a lot for the testing and feedback, Michael.

> I'm at a bit of a loss how this can fix the i810 driver, but maybe I'm
> missing something,

I presume it's going the drm_do_vm_dma_nopage route, and the pages
in the pagelist (though each PAGE_SIZEd itself) have been allocated
from >0-order pages.

> I'm having a look at the drm_pci_alloc code that
> calls pci_alloc_consistent, it may have an issue also (Hugh??)

Just when I thought I could get away from DRM!  I've spent a while
groping around there again, and I believe you're right that there
is an issue with drm_pci_alloc too, but that it's not a new issue.

Not a new issue because we've only been changing the behaviour of
PageReserved, and there was no PageReservation around drm_pci_alloc.

But an issue, yes, because pci_alloc_consistent is likely to supply
a >0-order page, with latter constituent 0-order pages having count 0.

Hmm, could this have caused some of my mm/rmap.c BUG_ONs in the past?
Not very likely, I think; but it's not immediately obvious quite how
it would have behaved; certainly "Bad page states" a possibility
(even before the recent changes).

Below is a cowardly patch which I believe will correct this: since
nopage will be a problem here, just go the remap_pfn_range way instead.

I'm not proud of coming up with different adhoc solutions to different
manifestations of the same underlying problem, but pci_alloc_consistent
depends on the architecture, I don't want to go there.  Uncompiled,
untested, see what you think.

Though two worries noticed on the way.  One, there's drm_addbufs_pci:
that's a bit confusingly named, isn't it, since it's working on the
DMA pagelist, and unrelated to drm_pci_alloc?  Two, is it right that
only _DRM_SHM and _DRM_CONSISTENT end up using drm_vm_shm_close,
which does cleanup which the others miss by using drm_vm_close?
No need to explain why I'm wrong! just mentioned in case it's wrong.

> I've queued up the patch for Linus, along with a couple of other bugfixes...

Thanks for looking after that, Dave.  Please take care of this one too,
if you agree it's the right thing to do...

_DRM_CONSISTENT memory is allocated in one range by pci_alloc_consistent,
and is therefore likely to be a >0-order page, whose constituent 0-order
pages should not be exposed to nopage and freeing: use remap_pfn_range.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.15-rc2-git3/drivers/char/drm/drm_vm.c	2005-11-20 19:43:39.000000000 +0000
+++ linux/drivers/char/drm/drm_vm.c	2005-11-23 19:15:58.000000000 +0000
@@ -154,8 +154,7 @@ static __inline__ struct page *drm_do_vm
 
 	offset = address - vma->vm_start;
 	i = (unsigned long)map->handle + offset;
-	page = (map->type == _DRM_CONSISTENT) ?
-		virt_to_page((void *)i) : vmalloc_to_page((void *)i);
+	page = vmalloc_to_page((void *)i);
 	if (!page)
 		return NOPAGE_OOM;
 	get_page(page);
@@ -636,10 +635,16 @@ int drm_mmap(struct file *filp, struct v
 			  vma->vm_start, vma->vm_end, map->offset + offset);
 		vma->vm_ops = &drm_vm_ops;
 		break;
-	case _DRM_SHM:
 	case _DRM_CONSISTENT:
-		/* Consistent memory is really like shared memory. It's only
-		 * allocate in a different way */
+		/* Consistent memory is really like shared memory.  But
+		 * it's allocated in a different way, so avoid nopage */
+		if (remap_pfn_range(vma, vma->vm_start,
+					page_to_pfn(virt_to_page(map->handle)),
+					vma->vm_end - vma->vm_start,
+					vma->vm_page_prot))
+			return -EAGAIN;
+		/* fall through to _DRM_SHM... */
+	case _DRM_SHM:
 		vma->vm_ops = &drm_vm_shm_ops;
 		vma->vm_private_data = (void *)map;
 		/* Don't let this area swap.  Change when
