Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVKUTqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVKUTqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVKUTqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:46:51 -0500
Received: from silver.veritas.com ([143.127.12.111]:21620 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932079AbVKUTqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:46:49 -0500
Date: Mon, 21 Nov 2005 18:12:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Takashi Iwai <tiwai@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       William Irwin <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Dave Airlie <airlied@gmail.com>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: [PATCH 12/11] unpaged: fix sound Bad page states
Message-ID: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 18:12:29.0032 (UTC) FILETIME=[223E0680:01C5EEC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I unifdefed PageCompound, so that snd_pcm_mmap_control_nopage
and others can give out a 0-order component of a higher-order page,
which won't be mistakenly freed when zap_pte_range unmaps it.  But
many Bad page states reported a PG_reserved was freed after all: I had
missed that we need to say __GFP_COMP to get compound page behaviour.

Some of these higher-order pages are allocated by snd_malloc_pages, some
by snd_malloc_dev_pages; or if SBUS, by sbus_alloc_consistent - but that
has no gfp arg, so add __GFP_COMP into its sparc32/64 implementations.

I'm still rather puzzled that DRM seems not to need a similar change.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/sparc/kernel/ioport.c |    2 +-
 arch/sparc64/kernel/sbus.c |    2 +-
 sound/core/memalloc.c      |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

--- 2.6.15-rc1-mm2/arch/sparc/kernel/ioport.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/arch/sparc/kernel/ioport.c	2005-11-19 19:11:04.000000000 +0000
@@ -252,7 +252,7 @@ void *sbus_alloc_consistent(struct sbus_
 	}
 
 	order = get_order(len_total);
-	if ((va = __get_free_pages(GFP_KERNEL, order)) == 0)
+	if ((va = __get_free_pages(GFP_KERNEL|__GFP_COMP, order)) == 0)
 		goto err_nopages;
 
 	if ((res = kmalloc(sizeof(struct resource), GFP_KERNEL)) == NULL)
--- 2.6.15-rc1-mm2/arch/sparc64/kernel/sbus.c	2005-11-12 09:00:36.000000000 +0000
+++ linux/arch/sparc64/kernel/sbus.c	2005-11-19 19:12:53.000000000 +0000
@@ -327,7 +327,7 @@ void *sbus_alloc_consistent(struct sbus_
 	order = get_order(size);
 	if (order >= 10)
 		return NULL;
-	first_page = __get_free_pages(GFP_KERNEL, order);
+	first_page = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
 	if (first_page == 0UL)
 		return NULL;
 	memset((char *)first_page, 0, PAGE_SIZE << order);
--- 2.6.15-rc1-mm2/sound/core/memalloc.c	2005-11-12 09:01:28.000000000 +0000
+++ linux/sound/core/memalloc.c	2005-11-19 19:03:32.000000000 +0000
@@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
 
 	snd_assert(size > 0, return NULL);
 	snd_assert(gfp_flags != 0, return NULL);
+	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
 	pg = get_order(size);
 	if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
 		mark_pages(virt_to_page(res), pg);
@@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
 	snd_assert(dma != NULL, return NULL);
 	pg = get_order(size);
 	gfp_flags = GFP_KERNEL
+		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
 	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
