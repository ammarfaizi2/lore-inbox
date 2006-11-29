Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758364AbWK2WFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758364AbWK2WFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbWK2WFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:05:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:12245 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758295AbWK2WEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:04:54 -0500
Message-Id: <20061129220639.359593000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:32 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Eric Anholt <eric@anholt.net>, Keith Packard <keithp@keithp.com>
Subject: [patch 21/23] AGP: Allocate AGP pages with GFP_DMA32 by default
Content-Disposition: inline; filename=agp-allocate-agp-pages-with-gfp_dma32-by-default.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Linus Torvalds <torvalds@osdl.org>

Not all graphic page remappers support physical addresses over the 4GB
mark for remapping, so while some do (the AMD64 GART always did, and I
just fixed the i965 to do so properly), we're safest off just forcing
GFP_DMA32 allocations to make sure graphics pages get allocated in the
low 32-bit address space by default.

AGP sub-drivers that really care, and can do better, could just choose
to implement their own allocator (or we could add another "64-bit safe"
default allocator for their use), but quite frankly, you're not likely
to care in practice.

So for now, this trivial change means that we won't be allocating pages
that we can't map correctly by mistake on x86-64.

[ On traditional 32-bit x86, this could never happen, because GFP_KERNEL
  would never allocate any highmem memory anyway ]

Acked-by: Andi Kleen <ak@suse.de>
Acked-by: Dave Jones <davej@redhat.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Keith Packard <keithp@keithp.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/char/agp/generic.c   |    2 +-
 drivers/char/agp/intel-agp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.4.orig/drivers/char/agp/generic.c
+++ linux-2.6.18.4/drivers/char/agp/generic.c
@@ -1042,7 +1042,7 @@ void *agp_generic_alloc_page(struct agp_
 {
 	struct page * page;
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL | GFP_DMA32);
 	if (page == NULL)
 		return NULL;
 
--- linux-2.6.18.4.orig/drivers/char/agp/intel-agp.c
+++ linux-2.6.18.4/drivers/char/agp/intel-agp.c
@@ -160,7 +160,7 @@ static void *i8xx_alloc_pages(void)
 {
 	struct page * page;
 
-	page = alloc_pages(GFP_KERNEL, 2);
+	page = alloc_pages(GFP_KERNEL | GFP_DMA32, 2);
 	if (page == NULL)
 		return NULL;
 

--
