Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUD0FSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUD0FSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUD0FSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:18:37 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:38366 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263761AbUD0FSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:18:34 -0400
Message-ID: <408DED00.6070402@BitWagon.com>
Date: Mon, 26 Apr 2004 22:17:52 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, mike@navi.cx, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: arch/ia64/ia32/binfmt_elf32.c: elf32_map() broken ia64 build
References: <20040426185633.7969ca0d.pj@sgi.com>
In-Reply-To: <20040426185633.7969ca0d.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Not sure how (no lkml thread that I can see), but it seems from Andrew's
> broken out patch "bssprot.patch" in 2.6.6-rc2-mm2 that John Reiser
> and/or others on the To list above conspired to break the build of
> arch/ia64/ia32/binfmt_elf32.c: elf32_map().

There was no conspiracy.  The patch was compiled and linked on three archs,
and ia64 was not one of them.  The #define of elf32_map contributed to
the obfuscation.

> Would someone care to recommend a proper fix?

A proper fix might require help from an ia64 maintainer to define macros
IA32_ELF_PAGESTART, IA32_ELF_PAGEALIGN, IA32_ELF_PAGEOFFSET
and will require ia32_do_munmap().  Below is partial progress,
"completing the parallelogram" from fs/binfmt_elf.c via
arch/x86_64/ia32/ia32_binfmt.c and arch/s390/kernel/binfmt_elf32.c.
This patch requires an ia32_do_munmap().  Until then, Paul's change
is sufficient, and loses no functionality except when PT_LOADs from the
same file designate non-adjacent regions, which was part of the reason
for the bssprot* patch(es) anyway.

When applied after 2.6.6-rc2-mm2, this compiles with warning (no prototype
for ia32_do_munmap), does not link (ia32_do_munmap is undefined), and
has not been executed.

--- ./arch/ia64/ia32/binfmt_elf32.c.orig	2004-04-26 19:17:14.000000000 -0700
+++ ./arch/ia64/ia32/binfmt_elf32.c	2004-04-26 19:57:19.000000000 -0700
@@ -220,10 +220,33 @@
  }

  static unsigned long
-elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf32_map (struct file *filep, unsigned long addr, struct elf_phdr const *eppnt,
+	 int prot, int type, unsigned long total_size)
  {
-	unsigned long pgoff = (eppnt->p_vaddr) & ~IA32_PAGE_MASK;
+		/* IA32_ELF_PAGEOFFSET ? */
+	unsigned long const pgoff = eppnt->p_vaddr & ~IA32_PAGE_MASK;

-	return ia32_do_mmap(filep, (addr & IA32_PAGE_MASK), eppnt->p_filesz + pgoff, prot, type,
-			    eppnt->p_offset - pgoff);
+	unsigned long size = eppnt->p_filesz + pgoff;
+	unsigned long off  = eppnt->p_offset - pgoff;
+
+	addr = addr & IA32_PAGE_MASK;  /* IA32_ELF_PAGESTART ? */
+	size = IA32_PAGE_ALIGN(size);  /* IA32_ELF_PAGEALIGN ? */
+
+	/*
+	 * total_size is the size of the ELF (interpreter) image.
+	 * The _first_ mmap needs to know the full size, otherwise
+	 * randomization might put this image into an overlapping
+	 * position with the ELF binary image. (since size < total_size)
+	 * So we first map the 'big' image - and unmap the remainder at
+	 * the end. (which unmap is needed for ELF images with holes.)
+	 */
+	if (total_size) {
+		unsigned long map_addr;
+		total_size = IA32_PAGE_ALIGN(total_size);  /* IA32_ELF_PAGEALIGN ? */
+		map_addr = ia32_do_mmap(filep, addr, total_size, prot, type, off);
+		if (!BAD_ADDR(map_addr))
+			ia32_do_munmap(current->mm, map_addr+size, total_size-size);
+		return map_addr;
+	} else
+		return ia32_do_mmap(filep, addr, size, prot, type, off);
  }

-- 



