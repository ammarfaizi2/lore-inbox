Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUH1JnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUH1JnO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUH1JnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:43:13 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35013 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267391AbUH1Jlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:41:40 -0400
Date: Sat, 28 Aug 2004 18:43:03 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 0/4][diskdump] x86-64 support
To: linux-kernel@vger.kernel.org
Message-id: <89C48CE36A27FFindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is the latest diskdump patch for kernel 2.6.8.1.

- Supports x86_64
- Fix bug of Fusion-MPT scsi driver patch
- Add new functions for finding ram area

Source code can be downloaded from
 http://sourceforge.net/projects/lkdump


When I tested diskdump on x86-64 machine, I found that memory dump of
the following two areas failed.

1) 04000000 - 07ffffff
2) around last two page

Memory dump of the area 2) failed because page->flag was broken.
So I compare PFN to page_to_pfn(pfn_to_page(PFN)) and skip this PFN
if these value is different.

		page = pfn_to_page(nr);
		if (nr != page_to_pfn(page)) {
			/* page_to_pfn() is called from kmap_atomic().
			 * If page->flag is broken, it specified a wrong
			 * zone and it causes kmap_atomic() fail.
			 */
			Err("Bad page. PFN %lu flags %lx\n",
			    nr, (unsigned long)page->flags);
			memset(scratch + blk_in_chunk * PAGE_SIZE, 0,
			       PAGE_SIZE);
			sprintf(scratch + blk_in_chunk * PAGE_SIZE,
				"Bad page. PFN %lu flags %lx\n",
			 	 nr, (unsigned long)page->flags);
			goto write;
		}


Memory dump of the area 1) failed because this area was not mapped to
vaddr. Diskdump checks page using page_is_ram() and maps it using 
kmap_atomic(). In the area 1), both page_is_ram() and kmap_atomic()
return true, but page is not attached to the page table.

I think this area is AGP Aperture. I found this message in the dmesg.

    PCI-DMA: Disabling AGP.
    PCI-DMA: aperture base @ 4000000 size 65536 KB
    PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture

To resolve this problem, I check page using kern_addr_valid() before
kmap_atomic().

		if (!kern_addr_valid((unsigned long)pfn_to_kaddr(nr))) {
			memset(scratch + blk_in_chunk * PAGE_SIZE, 0,
			       PAGE_SIZE);
			sprintf(scratch + blk_in_chunk * PAGE_SIZE,
				"Unmapped page. PFN %lu\n", nr);
			goto write;
		}

		kaddr = kmap_atomic(page, KM_CRASHDUMP);
		memcpy(scratch + blk_in_chunk * PAGE_SIZE, kaddr, PAGE_SIZE);
		kunmap_atomic(kaddr, KM_CRASHDUMP);

	write:


Now diskdump seems to work correctly.  But I am not sure these method is
right. Please let me know if there are better methods.

Best Regards,
Takao Indoh
