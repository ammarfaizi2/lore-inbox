Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314545AbSDZX4I>; Fri, 26 Apr 2002 19:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSDZX4H>; Fri, 26 Apr 2002 19:56:07 -0400
Received: from [195.223.140.120] ([195.223.140.120]:42364 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314545AbSDZX4F>; Fri, 26 Apr 2002 19:56:05 -0400
Date: Sat, 27 Apr 2002 01:56:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: hgchewml@optusnet.com.au,
        "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        riel@conectiva.com.br
Subject: Re: File corruption when running VMware.
Message-ID: <20020427015623.P19278@dualathlon.random>
In-Reply-To: <37A7BD60863@vcnet.vc.cvut.cz> <20020427010134.M19278@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 01:01:34AM +0200, Andrea Arcangeli wrote:
> On Fri, Apr 26, 2002 at 05:30:37PM +0200, Petr Vandrovec wrote:
> > On 24 Apr 02 at 2:01, Rik van Riel wrote:
> > > On Wed, 24 Apr 2002, Hong-Gunn Chew wrote:
> > > 
> > > > I have a repeatable problem when running VMware workstation 3.00 and
> > > > 3.01.  The cause is still unknown, and could be VMware itself, the
> > > > hardware or the kernel.
> > > 
> > > If you can reproduce it without VMware or with only the
> > > open source part of VMware (ie without any of the binary
> > > only parts) we might have a chance of debugging it.
> > 
> > Hi again,
> >   one of 2.4.x kernel images available in SuSE's 8.0 has patched&enabled 
> > support for page tables in high memory, and this quickly revealed
> > incompatibility between VMware's vmmon page table handling and
> > ptes above directly mapped range.
> > 
> >   So if you have >890MB of RAM and your kernel is compiled with support
> > for pte in high memory, please stop using VMware, or reconfigure your 
> > kernel to not use pte in high memory (4GB config without pte-in-highmem
> > is OK). Using pte-in-highmem with vmmon will cause kernel oopses and/or 
> 
> passing to the kernel mem=850M in lilo at boot will be enough.

I downloaded your latest driver from your site (vmware-ws-any-update16
package) and I adjusted it this way:

--- vmware-ws-any-update16/vmmon-only/linux/hostif.c.~1~	Sun Mar 31 20:44:35 2002
+++ vmware-ws-any-update16/vmmon-only/linux/hostif.c	Sat Apr 27 01:12:50 2002
@@ -176,7 +176,7 @@
 	unsigned long pagenr;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *ptep, pte;
 	
 	pgd = pgd_offset(current->mm, addr);
 	if (pgd_none(*pgd))
@@ -184,10 +184,12 @@
 	pmd = pmd_offset(pgd, addr);
 	if (pmd_none(*pmd))
 		return 0;
-	pte = pte_offset(pmd, addr);
-	if (!pte_present(*pte))
+	ptep = pte_offset_atomic(pmd, addr);
+	pte = *ptep;
+	pte_kunmap(ptep);
+	if (!pte_present(pte))
 		return 0;
-	pagenr = pte_pagenr(*pte);
+	pagenr = pte_pagenr(pte);
 	return pagenr;
 #else
    int pdoffset = PFN_2_PDOFF(ppn);
--- vmware-ws-any-update16/vmnet-only/vmnetInt.h.~1~	Sat Mar 23 04:27:54 2002
+++ vmware-ws-any-update16/vmnet-only/vmnetInt.h	Sat Apr 27 01:16:43 2002
@@ -96,10 +96,8 @@
 #endif
 
 
-#ifndef KERNEL_2_5_5
-#   define pte_offset_map(_dir, _address) pte_offset(_dir, _address)
-#   define pte_unmap(_pte)
-#endif
+#   define pte_offset_map(_dir, _address) pte_offset_atomic(_dir, _address)
+#   define pte_unmap(_pte) pte_kunmap(_pte);
 
 
 #ifndef KERNEL_2_4_8


I'm running the patched driver right now with vmware 3.0 workstataion
on my main desktop with 1G using 2.4.19-pre7 as kernel (pte-highmem
enabled of course). If I'll find any instability of the host OS I'll let
you know, so far it looks solid.

Hope this helps,

Andrea
