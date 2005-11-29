Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVK2XxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVK2XxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVK2XxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:53:08 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:52132 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1751406AbVK2XxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:53:06 -0500
Date: Wed, 30 Nov 2005 01:53:04 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andi Kleen <ak@suse.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 2.6.15-rc2-git5 fails to boot with 4GB memory
Message-ID: <20051129235304.GB5706@mea-ext.zmailer.org>
References: <20051129033102.GA5706@mea-ext.zmailer.org> <p73veybh7tj.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73veybh7tj.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 07:01:12AM -0700, Andi Kleen wrote:
> Matti Aarnio <matti.aarnio@zmailer.org> writes:
> 
> > With 2 GB in place, the kernel boots just fine, but with
> > 4 GB, it reports:
> 
> Works for me on several machines.
> 
> I even have a fix for the Asus wrong MCFG problem now that
> broke the IOMMU on these boards (workaround is pci=nommconf) 
> 
> > 
> >  kernel direct mapping tables upto ffff 8101 5000 000 @ 8000-f000
> >  PANIC: early exception rip  ffff ffff 8016 f002 error 0 cr2 4230
> >  PANIC: early exception rip  ffff ffff 8011 d1fe error 0 cr2 ffff ffff f5ff d023
> > 
> > and some other lines, which I didn't jot down on paper...
> 
> Can you please look up the RIP values in your System.map? 
> 
> > These were copied from some Fedora Core development kernel version
> > after 2.6.15-rc1 (last working one) in a box with 4 GB memory.
> 
> Please try vanilla 2.6.15rc2 as a reference at least.

Tried.  Crashes with 4 GB memory present in the box.
Boots and runs nicely with 2 GB memory populated in.

After adding  -g  to  *CFLAGS of top-level  Makefile, and
trying to determine WHERE those PANICs happened in rc2:

(gdb) list *0xffffffff80163a43
0xffffffff80163a43 is in memmap_init_zone (mm/page_alloc.c:1687).
1682            for (pfn = start_pfn; pfn < end_pfn; pfn++, page++) {
1683                    if (!early_pfn_valid(pfn))
1684                            continue;
1685                    if (!early_pfn_in_nid(pfn, nid))
1686                            continue;
1687                    page = pfn_to_page(pfn);
1688                    set_page_links(page, zone, nid, pfn);
1689                    set_page_count(page, 1);
1690                    reset_page_mapcount(page);
1691                    SetPageReserved(page);

(gdb) list *0xffffffff801196fa
0xffffffff801196fa is in safe_smp_processor_id (include/asm/smp.h:77).
72      #define raw_smp_processor_id() read_pda(cpunumber)
73
74      static inline int hard_smp_processor_id(void)
75      {
76              /* we don't want to mark this access volatile - bad code generation */
77              return GET_APIC_ID(*(unsigned int *)(APIC_BASE+APIC_ID));
78      }
79
80      extern int safe_smp_processor_id(void);
81      extern int __cpu_disable(void);


Not that those explain all that much...


> -Andi

/Matti Aarnio
