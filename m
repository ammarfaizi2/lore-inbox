Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbUKENWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUKENWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUKENTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:19:04 -0500
Received: from cantor.suse.de ([195.135.220.2]:62095 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262684AbUKENQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:16:31 -0500
Date: Fri, 5 Nov 2004 14:12:32 +0100
From: Andi Kleen <ak@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Fix for vmalloc problem was Re: 2.6.10-rc1-mm3
Message-ID: <20041105131232.GA1030@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org.suse.lists.linux.kernel> <418B5C70.7090206@kolivas.org.suse.lists.linux.kernel> <p73sm7o7br3.fsf@verdi.suse.de> <418B6F18.9090404@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418B6F18.9090404@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:16:24PM +1100, Con Kolivas wrote:
> Andi Kleen wrote:
> >Con Kolivas <kernel@kolivas.org> writes:
> >
> >
> >>It's life Jim but not as we know it...
> >>
> >>
> >>This happened during modprobe of alsa modules. Keyboard still alive,
> >>everything else dead; not even sysrq would do anything, netconsole had
> >>no output, luckily this made it to syslog:
> >
> >
> >I just tested modprobing of alsa (snd_intel8x0) and it works for me.
> >Also vmalloc must work at least to some point.
> >
> >Can you confirm it's really caused by 4level by reverting all the 
> >4level-* patches from broken out? 
> 
> I dont recall blaming 4level. When I get a chance I'll try.

This patch should fix it. Can you please test? Thanks.

-Andi

Fix silly typo in mm/vmalloc.c and some minor cleanups.

Signed-off-by: Andi Kleen <ak@suse.de>


diff -up linux-2.6.10rc1-mm3/mm/vmalloc.c-o linux-2.6.10rc1-mm3/mm/vmalloc.c
--- linux-2.6.10rc1-mm3/mm/vmalloc.c-o	2004-11-05 11:42:00.000000000 +0100
+++ linux-2.6.10rc1-mm3/mm/vmalloc.c	2004-11-05 14:10:04.000000000 +0100
@@ -98,7 +98,6 @@ static void unmap_area_pgd(pml4_t *pml4,
 	}
 
 	pgd = pml4_pgd_offset_k(pml4, address);
-	address &= ~PML4_MASK;
 	end = address + size;
 
 	do {
@@ -114,8 +113,8 @@ static int map_area_pte(pte_t *pte, unsi
 {
 	unsigned long end;
 
-	address &= ~PMD_MASK;
 	end = address + size;
+	address &= ~PMD_MASK;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 
@@ -187,7 +186,7 @@ void unmap_vm_area(struct vm_struct *are
 	flush_cache_vunmap(address, end);
 	for (i = pml4_index(address); i <= pml4_index(end-1); i++) {
 		next = (address + PML4_SIZE) & PML4_MASK;
-		if (next <= address || next > end)
+		if (next < address || next > end)
 			next = end;
 		unmap_area_pgd(pml4, address, next - address);
 		address = next;
@@ -213,7 +212,7 @@ int map_vm_area(struct vm_struct *area, 
 			err = -ENOMEM;
 			break;
 		}
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
+		next = (address + PML4_SIZE) & PML4_MASK;
 		if (next < address || next > end)
 			next = end;
 		if (map_area_pgd(pgd, address, next, prot, pages)) {
