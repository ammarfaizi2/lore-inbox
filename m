Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVKQTc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVKQTc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKQTc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:32:58 -0500
Received: from silver.veritas.com ([143.127.12.111]:33568 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964804AbVKQTc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:32:57 -0500
Date: Thu, 17 Nov 2005 19:31:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] unpaged: sound nopage get_page
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171930090.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:32:54.0346 (UTC) FILETIME=[B4B382A0:01C5EBAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something noticed when studying use of VM_RESERVED in different drivers:
snd_usX2Y_hwdep_pcm_vm_nopage omitted to get_page: fixed.

And how did this work before?  Aargh!  That nopage is returning a page
from within a buffer allocated by snd_malloc_pages, which allocates a
high-order page, then does SetPageReserved on each 0-order page within.

That would have worked in 2.6.14, because when the area was unmapped,
PageReserved inhibited put_page.  2.6.15-rc1 removed that inhibition
(while leaving ineffective PageReserveds around for now), but it hasn't
caused trouble because.. we've not been freeing from VM_RESERVED at all.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 sound/usb/usx2y/usx2yhwdeppcm.c |    1 +
 1 files changed, 1 insertion(+)

--- unpaged02/sound/usb/usx2y/usx2yhwdeppcm.c	2005-11-12 09:01:30.000000000 +0000
+++ unpaged03/sound/usb/usx2y/usx2yhwdeppcm.c	2005-11-17 15:10:34.000000000 +0000
@@ -691,6 +691,7 @@ static struct page * snd_usX2Y_hwdep_pcm
 	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_OOM);
 	vaddr = (char*)((usX2Ydev_t*)area->vm_private_data)->hwdep_pcm_shm + offset;
 	page = virt_to_page(vaddr);
+	get_page(page);
 
 	if (type)
 		*type = VM_FAULT_MINOR;
