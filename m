Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164224AbWLHAbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164224AbWLHAbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164227AbWLHAbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:31:33 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:61928 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164224AbWLHAbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:31:32 -0500
In-Reply-To: <20061207143611.7a2925e2.akpm@osdl.org>
References: <45789124.1070207@mvista.com> <20061207143611.7a2925e2.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <33ee3d4b6b9cbe26cca3cb78c3189f3e@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: new procfs memory analysis feature
Date: Thu, 7 Dec 2006 16:30:01 -0800
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7, 2006, at 2:36 PM, Andrew Morton wrote:

> On Thu, 07 Dec 2006 14:09:40 -0800
> David Singleton <dsingleton@mvista.com> wrote:
>
>>
>> Andrew,
>>
>>     this implements a feature for memory analysis tools to go along 
>> with
>> smaps.
>> It shows reference counts for individual pages instead of aggregate
>> totals for a given VMA.
>> It helps memory analysis tools determine how well pages are being
>> shared, or not,
>> in a shared libraries, etc.
>>
>>    The per page information is presented in /proc/<pid>/pagemaps.
>>
>
> I think the concept is not a bad one, frankly - this requirement arises
> frequently.  What bugs me is that it only displays the mapcount and
> dirtiness.  Perhaps there are other things which people want to know.  
> I'm
> not sure what they would be though.
>
> I wonder if it would be insane to display the info via a filesystem:
>
> 	cat /mnt/pagemaps/$(pidof crond)/pgd0/pmd1/pte45
>
> Probably it would.
>
>> Index: linux-2.6.18/Documentation/filesystems/proc.txt
>
> Against 2.6.18?  I didn't know you could still buy copies of that ;)

whoops, I have an old copy.  let me make a patch against 2.6.19.

>
> This patch's changelog should include sample output.

okay.

>
> Your email client wordwraps patches, and it replaces tabs with spaces.

Is an attachment okay?  gziped tarfile?  a new mailer?

David
>
>> ...
>>
>> +static void pagemaps_pte_range(struct vm_area_struct *vma, pmd_t 
>> *pmd,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pte_t *pte, ptent;
>> +       spinlock_t *ptl;
>> +       struct page *page;
>> +       int mapcount = 0;
>> +
>> +       pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>> +       do {
>> +               ptent = *pte;
>> +               if (pte_present(ptent)) {
>> +                       page = vm_normal_page(vma, addr, ptent);
>> +                       if (page) {
>> +                               if (pte_dirty(ptent))
>> +                                       mapcount = 
>> -page_mapcount(page);
>> +                               else
>> +                                       mapcount = 
>> page_mapcount(page);
>> +                       } else {
>> +                               mapcount = 1;
>> +                       }
>> +               }
>> +               seq_printf(m, " %d", mapcount);
>> +
>> +       } while (pte++, addr += PAGE_SIZE, addr != end);
>
> Well that's cute.  As long as both seq_file and pte-pages are of size
> PAGE_SIZE, and as long as pte's are more than three bytes, this will 
> not
> overflow the seq_file output buffer.
>
> hm.  Unless the pages are all dirty and the mapcounts are all 10000.  I
> think it will overflow then?
>
>> +
>> +static inline void pagemaps_pmd_range(struct vm_area_struct *vma, 
>> pud_t
>> *pud,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pmd_t *pmd;
>> +       unsigned long next;
>> +
>> +       pmd = pmd_offset(pud, addr);
>> +       do {
>> +               next = pmd_addr_end(addr, end);
>> +               if (pmd_none_or_clear_bad(pmd))
>> +                       continue;
>> +               pagemaps_pte_range(vma, pmd, addr, next, m);
>> +       } while (pmd++, addr = next, addr != end);
>> +}
>> +
>> +static inline void pagemaps_pud_range(struct vm_area_struct *vma, 
>> pgd_t
>> *pgd,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pud_t *pud;
>> +       unsigned long next;
>> +
>> +       pud = pud_offset(pgd, addr);
>> +       do {
>> +               next = pud_addr_end(addr, end);
>> +               if (pud_none_or_clear_bad(pud))
>> +                       continue;
>> +               pagemaps_pmd_range(vma, pud, addr, next, m);
>> +       } while (pud++, addr = next, addr != end);
>> +}
>> +
>> +static inline void pagemaps_pgd_range(struct vm_area_struct *vma,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pgd_t *pgd;
>> +       unsigned long next;
>> +
>> +       pgd = pgd_offset(vma->vm_mm, addr);
>> +       do {
>> +               next = pgd_addr_end(addr, end);
>> +               if (pgd_none_or_clear_bad(pgd))
>> +                       continue;
>> +               pagemaps_pud_range(vma, pgd, addr, next, m);
>> +       } while (pgd++, addr = next, addr != end);
>> +}
>
> I think that's our eighth open-coded pagetable walker.  Apparently 
> they are
> all slightly different.  Perhaps we shouild do something about that one
> day.
>
>

