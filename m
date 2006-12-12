Return-Path: <linux-kernel-owner+w=401wt.eu-S932467AbWLLWFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWLLWFi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWLLWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:05:38 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:28095 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbWLLWFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:05:37 -0500
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com
Subject: mapping PCI registers with write combining (and PAT on x86)...
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 12 Dec 2006 14:05:32 -0800
Message-ID: <adalklcu5w3.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Dec 2006 22:05:32.0779 (UTC) FILETIME=[A4A7FBB0:01C71E39]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose that I would like to map some PIO registers (in a PCI BAR) to
userspace, and I would like to enable write combining if possible.

I have two problems.  First, there's no generic interface for
requesting write combining if possible when doing
io_remap_pfn_range().  Would it make sense to define
pageprot_writecombine for all architectures (and make it fall back to
doing non-cached access if write combining is not possible)?  And it
seems that making pgprot_noncached() universal wouldn't hurt either.

Second, given the extreme shortage of MTRRs, it seems that write
combining is not really possible in general on x86 without some
interface to use PATs instead.  What is holding up something like Eric
Biederman's patches from going in?

Right now we end up with stuff like the absolutely hair-raising code
in drivers/video/fbmem.c shown below.  I really would like to make
progress towards having a better interface for doing this stuff, and
I'm more than willing to work on getting something mergable.

	#if defined(__mc68000__)
	#if defined(CONFIG_SUN3)
		pgprot_val(vma->vm_page_prot) |= SUN3_PAGE_NOCACHE;
	#elif defined(CONFIG_MMU)
		if (CPU_IS_020_OR_030)
			pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE030;
		if (CPU_IS_040_OR_060) {
			pgprot_val(vma->vm_page_prot) &= _CACHEMASK040;
			/* Use no-cache mode, serialized */
			pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
		}
	#endif
	#elif defined(__powerpc__)
		vma->vm_page_prot = phys_mem_access_prot(file, off >> PAGE_SHIFT,
							 vma->vm_end - vma->vm_start,
							 vma->vm_page_prot);
	#elif defined(__alpha__)
		/* Caching is off in the I/O space quadrant by design.  */
	#elif defined(__i386__) || defined(__x86_64__)
		if (boot_cpu_data.x86 > 3)
			pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
	#elif defined(__mips__) || defined(__sparc_v9__)
		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
	#elif defined(__hppa__)
		pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
	#elif defined(__arm__) || defined(__sh__) || defined(__m32r__)
		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
	#elif defined(__ia64__)
		if (efi_range_is_wc(vma->vm_start, vma->vm_end - vma->vm_start))
			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
		else
			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
	#else
	#warning What do we have to do here??
	#endif
		if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
				     vma->vm_end - vma->vm_start, vma->vm_page_prot))
			return -EAGAIN;
		return 0;

Thanks!
  Roland
