Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVCJGJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVCJGJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVCJGHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 01:07:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:13513 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262451AbVCJGE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 01:04:58 -0500
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Omkhar Arasaratnam <iamroot@ca.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
References: <422FA817.4060400@ca.ibm.com>
	 <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com>
	 <422FC042.40303@ca.ibm.com>
	 <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 16:59:43 +1100
Message-Id: <1110434383.32525.184.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 19:47 -0800, Linus Torvalds wrote:
> 
> On Wed, 9 Mar 2005, Omkhar Arasaratnam wrote:
> > 
> > I confirmed that this occurs with the 2.6.11 code straight from 
> > kernel.org Here is an error from the bringup:
> 
> So if 2.6.9 works, and 2.6.11 does not, can you check 2.6.10? And perhaps 
> hunt it down even more, to a -rc release?
> 
> > sym0: No NVRAM, ID 7, Fast-80 LVD, parity checking
> > CACHE TEST FAILED: DMA error (dstat=0xa0) .sym0: CACHE INCORRECTLY CONFIGURED
> > sym0: giving up ...
> 
> There are certainly sym changes in there too since 2.6.9, let's see if 
> James or Willy have any suggestions. It might not be ppc64-specific.

Ok, we have it working here on a similar machine with 2.6.11 and failing
in a similar way with bk which is why I asked ;)

The bk problem is found & fixed here tho. I'll send a patch later, it's
a bug with ppc64 iounmap() not properly flushing the hash table after
the set_pte_at() patch due to some crap in our custom implementation of
that guy.

Here's the patch, but I want to get rid of that stuff anyway (at least
make unmap_vm_area take the "mm", or rather make an unmap_vm_area_mm()
and make unmap_vm_area() just call it and then use that instead of our
own implementation, but I'm waiting for Hugh cleanup to get in before
touching any of this).

--

This patch fixes a bug in ppc64 local implementation of iounmap() that
would cause it to incorrectly flush the hash table since the changes to
set_pte have been applied.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: working-2.6/arch/ppc64/mm/init.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/init.c	2005-03-07 13:06:23.000000000 +1100
+++ working-2.6/arch/ppc64/mm/init.c	2005-03-10 12:59:50.000000000 +1100
@@ -288,7 +288,7 @@
 static void unmap_im_area_pte(pmd_t *pmd, unsigned long address,
 				  unsigned long size)
 {
-	unsigned long end;
+	unsigned long base, end;
 	pte_t *pte;
 
 	if (pmd_none(*pmd))
@@ -300,6 +300,7 @@
 	}
 
 	pte = pte_offset_kernel(pmd, address);
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -307,7 +308,7 @@
 
 	do {
 		pte_t page;
-		page = ptep_get_and_clear(&ioremap_mm, address, pte);
+		page = ptep_get_and_clear(&ioremap_mm, base + address, pte);
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
@@ -321,7 +322,7 @@
 static void unmap_im_area_pmd(pgd_t *dir, unsigned long address,
 				  unsigned long size)
 {
-	unsigned long end;
+	unsigned long base, end;
 	pmd_t *pmd;
 
 	if (pgd_none(*dir))
@@ -333,13 +334,14 @@
 	}
 
 	pmd = pmd_offset(dir, address);
+	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 
 	do {
-		unmap_im_area_pte(pmd, address, end - address);
+		unmap_im_area_pte(pmd, base + address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);


 

Ben.

