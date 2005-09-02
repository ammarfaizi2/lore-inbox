Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030673AbVIBE1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030673AbVIBE1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030674AbVIBE1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:27:18 -0400
Received: from fmr23.intel.com ([143.183.121.15]:14555 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030673AbVIBE1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:27:17 -0400
Message-Id: <200509020427.j824R0g01601@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Dave McCracken'" <dmccr@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
Subject: RE: [PATCH 1/1] Implement shared page tables
Date: Thu, 1 Sep 2005 21:26:27 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWtsDj7hT33i8q8RK6wi49tnEe7OABxRgLw
In-Reply-To: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote on Tuesday, August 30, 2005 3:13 PM
> This patch implements page table sharing for all shared memory regions that
> span an entire page table page.  It supports sharing at multiple page
> levels, depending on the architecture.

In function pt_share_pte():

> +		while ((svma = next_shareable_vma(vma, svma, &iter))) {
> +			spgd = pgd_offset(svma->vm_mm, address);
> +			if (pgd_none(*spgd))
> +				continue;
> +
> +			spud = pud_offset(spgd, address);
> +			if (pud_none(*spud))
> +				continue;
> +
> +			spmd = pmd_offset(spud, address);
> +			if (pmd_none(*spmd))
> +				continue;
....
> +			page = pmd_page(*spmd);
> +			pt_increment_share(page);
> +			pmd_populate(vma->vm_mm, pmd, page);
> +		}


Do you really have to iterate through all the vma?  Can't you just break
out of the while loop on first successful match and populating the pmd?
I would think you will find them to be the same pte page. Or did I miss
some thing?


--- ./mm/ptshare.c.orig	2005-09-01 21:16:35.311915518 -0700
+++ ./mm/ptshare.c	2005-09-01 21:18:24.629296992 -0700
@@ -200,6 +200,7 @@ pt_share_pte(struct vm_area_struct *vma,
 			page = pmd_page(*spmd);
 			pt_increment_share(page);
 			pmd_populate(vma->vm_mm, pmd, page);
+			break;
 		}
 	}
 	pte = pte_alloc_map(vma->vm_mm, pmd, address);

