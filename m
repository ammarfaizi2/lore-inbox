Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbRHKODC>; Sat, 11 Aug 2001 10:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbRHKOCw>; Sat, 11 Aug 2001 10:02:52 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267844AbRHKOCd>; Sat, 11 Aug 2001 10:02:33 -0400
Date: Sat, 11 Aug 2001 16:02:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.8aa1
Message-ID: <20010811160231.C19169@athlon.random>
In-Reply-To: <20010811145813.B19169@athlon.random> <3B7533FE.4A8EC734@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B7533FE.4A8EC734@eyal.emu.id.au>; from eyal@eyal.emu.id.au on Sat, Aug 11, 2001 at 11:32:46PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 11:32:46PM +1000, Eyal Lebedinsky wrote:
> Andrea Arcangeli wrote:
> > 
> > Only in 2.4.8pre8aa1: 40_blkdev-pagecache-11
> > Only in 2.4.8aa1: 40_blkdev-pagecache-12
> 
> Everything possible selected as a module.
> 
> The relevant DRM part of .config:
> 
> CONFIG_DRM=y
> CONFIG_DRM_TDFX=m   
> CONFIG_DRM_GAMMA=m
> CONFIG_DRM_R128=m 
> CONFIG_DRM_RADEON=m  
> CONFIG_DRM_I810=m
> CONFIG_DRM_MGA=m
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4/include/linux/modversions.h   -c -o
> r128_drv.o r128_drv.c
> In file included from r128_drv.c:36:
> ati_pcigart.h: In function `r128_ati_pcigart_init':
> ati_pcigart.h:114: structure has no member named `virtual'
> make[3]: *** [r128_drv.o] Error 1
> make[3]: Leaving directory
> `/data2/usr/local/src/linux-2.4/drivers/char/drm'

This is the same problem I mentioned yesterday to the list. Nobody
should ever use page->virtual directly, it's not there in -aa when
highmem is disabled to save memory and increase performance, if it would
be in C or python it would be a private field of the class to make it
explicit (nitpicking, in python __ just rename and it's techincally
still visible from the outside of the class).

page_address(page) must be used instead of page->virtual.

Anyways here an incremental patch that will fix your compile problem
(Linus please include):

--- 2.4.8aa1/drivers/char/drm/ati_pcigart.h.~1~	Sat Aug 11 15:54:25 2001
+++ 2.4.8aa1/drivers/char/drm/ati_pcigart.h	Sat Aug 11 15:54:55 2001
@@ -111,7 +111,7 @@
 	memset( pci_gart, 0, ATI_MAX_PCIGART_PAGES * sizeof(u32) );
 
 	for ( i = 0 ; i < pages ; i++ ) {
-		page_base = virt_to_bus( entry->pagelist[i]->virtual );
+		page_base = virt_to_bus( page_address(entry->pagelist[i]) );
 		for (j = 0; j < (PAGE_SIZE / ATI_PCIGART_PAGE_SIZE); j++) {
 			*pci_gart++ = cpu_to_le32( page_base );
 			page_base += ATI_PCIGART_PAGE_SIZE;
--- 2.4.8aa1/drivers/char/drm/r128_cce.c.~1~	Sat Aug 11 08:04:05 2001
+++ 2.4.8aa1/drivers/char/drm/r128_cce.c	Sat Aug 11 15:55:51 2001
@@ -351,10 +351,10 @@
 		page_ofs = tmp_ofs >> PAGE_SHIFT;
 
 		R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR,
-			    virt_to_bus(entry->pagelist[page_ofs]->virtual));
+			    virt_to_bus(page_address(entry->pagelist[page_ofs])));
 
 		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
-			   virt_to_bus(entry->pagelist[page_ofs]->virtual),
+			   virt_to_bus(page_address(entry->pagelist[page_ofs])),
 			   entry->handle + tmp_ofs );
 	}
 
--- 2.4.8aa1/drivers/char/drm/radeon_cp.c.~1~	Sat Aug 11 08:04:05 2001
+++ 2.4.8aa1/drivers/char/drm/radeon_cp.c	Sat Aug 11 15:56:33 2001
@@ -624,10 +624,10 @@
 		page_ofs = tmp_ofs >> PAGE_SHIFT;
 
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
-			      virt_to_bus(entry->pagelist[page_ofs]->virtual));
+			      virt_to_bus(page_address(entry->pagelist[page_ofs])));
 
 		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
-			   virt_to_bus(entry->pagelist[page_ofs]->virtual),
+			   virt_to_bus(page_address(entry->pagelist[page_ofs])),
 			   entry->handle + tmp_ofs );
 	}
 

Also please include this below one too that I just addressed previously
for my own compilations.  (Eyal, you don't need to apply the below one
of course)

--- 2.4.8pre7aa1/drivers/char/drm/drm_vm.h.~1~	Thu Aug  9 01:37:46 2001
+++ 2.4.8pre7aa1/drivers/char/drm/drm_vm.h	Thu Aug  9 01:42:22 2001
@@ -107,7 +107,7 @@
 	if( !pmd_present( *pmd ) ) return NOPAGE_OOM;
 	pte = pte_offset( pmd, i );
 	if( !pte_present( *pte ) ) return NOPAGE_OOM;
-	physical = (unsigned long)pte_page( *pte )->virtual;
+	physical = (unsigned long)page_address(pte_page( *pte ));
 	atomic_inc(&virt_to_page(physical)->count); /* Dec. by kernel */
 
 	DRM_DEBUG("0x%08lx => 0x%08lx\n", address, physical);

Andrea
