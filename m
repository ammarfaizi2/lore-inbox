Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVLAAVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVLAAVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLAAVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:21:12 -0500
Received: from ozlabs.org ([203.10.76.45]:40149 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751386AbVLAAVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:21:11 -0500
Date: Thu, 1 Dec 2005 11:20:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Litke <agl@us.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Fix handling of ELF segments with zero filesize
Message-ID: <20051201002049.GB14247@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Adam Litke <agl@us.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply

mmap() returns -EINVAL if given a zero length, and thus elf_map() in
binfmt_elf.c does likewise if it attempts to map a (page-aligned) ELF
segment with zero filesize.  Such a situation never arises with the
default linker scripts, but there's nothing inherently wrong with
zero-filesize (but non-zero memsize) ELF segments.  Custom linker
scripts can generate them, and the kernel should be able to map them;
this patch makes it so.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/fs/binfmt_elf.c
===================================================================
--- working-2.6.orig/fs/binfmt_elf.c	2005-11-23 15:56:30.000000000 +1100
+++ working-2.6/fs/binfmt_elf.c	2005-12-01 11:11:01.000000000 +1100
@@ -288,11 +288,17 @@ static unsigned long elf_map(struct file
 			struct elf_phdr *eppnt, int prot, int type)
 {
 	unsigned long map_addr;
+	unsigned long pageoffset = ELF_PAGEOFFSET(eppnt->p_vaddr);
 
 	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+	/* mmap() will return -EINVAL if given a zero size, but a
+	 * segment with zero filesize is perfectly valid */
+	if (eppnt->p_filesz + pageoffset)
+		map_addr = do_mmap(filep, ELF_PAGESTART(addr),
+				   eppnt->p_filesz + pageoffset, prot, type,
+				   eppnt->p_offset - pageoffset);
+	else
+		map_addr = ELF_PAGESTART(addr);
 	up_write(&current->mm->mmap_sem);
 	return(map_addr);
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
