Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUHYDEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUHYDEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268256AbUHYDEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:04:45 -0400
Received: from holomorphy.com ([207.189.100.168]:43144 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268158AbUHYDEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:04:42 -0400
Date: Tue, 24 Aug 2004 20:04:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: fix text reporting in O(1) proc_pid_statm()
Message-ID: <20040825030437.GO2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1093388816.434.355.camel@cube> <20040824231236.GG2793@holomorphy.com> <1093402351.434.631.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093402351.434.631.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 19:12, William Lee Irwin III wrote:
>> The current 2.6 semantics are purely virtual, so this merely
>> reimplements those semantics more efficiently. The scheme you
>> describe would require accounting at the time of pte modification
>> to implement in a like fashion, which has been rejected.

On Tue, Aug 24, 2004 at 10:52:31PM -0400, Albert Cahalan wrote:
> Hmmm, why not reject RSS too then? It's the same thing.
> If trs and drs and so on were kept, then rss would
> just be the sum of them. Per-permission tracking
> seems about right:
> rss[perms] += change;
> (where "perms" is rwx plus shared/private and dirty/clean)
> At some point, it would be good to have per-vma rss.
> This would be displayed by the pmap command's -x option.
> (added to /proc/*/maps right before the filename)

Generally the way these patches have operated is accounting
only the interesting combinations of those with respect to
reporting in the interest of conserving space in the mm. These
have also been combined with various checks on e.g. address
ranges and some special casing of hugetlb. So it's not been
quite as simple as all that.

The code from my 2.6.0-test7-bk1 forward port of the Red Hat patches
for this was as follows:

static inline void vm_account(struct vm_area_struct *vma, pte_t pte,
					unsigned long addr, long adjustment)
{
	struct mm_struct *mm = vma->vm_mm;
	unsigned long pfn;
	struct page *page;

	if (!pte_present(pte))
		return;

	pfn = pte_pfn(pte);
	if (!pfn_valid(pfn))
		goto out;

	page = pfn_to_page(pfn);
	if (PageReserved(page))
		goto out;

	if (vma->vm_flags & VM_EXECUTABLE)
		mm->text += adjustment;
	else if (vma->vm_flags & (VM_STACK_FLAGS & (VM_GROWSUP | VM_GROWSDOWN))) {
		mm->data += adjustment;
		mm->stack += adjustment;
	} else if (addr >= TASK_UNMAPPED_BASE)
		mm->lib += adjustment;
	else
		mm->data += adjustment;

	if (page_mapping(page))
		mm->shared += adjustment;

out:
	if (pte_write(pte))
		mm->dirty += adjustment;
}


-- wli
