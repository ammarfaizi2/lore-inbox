Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268332AbUHQQDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268332AbUHQQDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268319AbUHQQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:03:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61407 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268326AbUHQQBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:01:33 -0400
Subject: Re: [PATCH][2/6]Memory preserving reboot using kexec
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org, Andrew Morton <akpm@osdl.org>,
       "Suparna Bhattacharya [imap]" <suparna@in.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, litke@us.ibm.com,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20040817120717.GC3916@in.ibm.com>
References: <20040817120239.GA3916@in.ibm.com>
	 <20040817120531.GB3916@in.ibm.com>  <20040817120717.GC3916@in.ibm.com>
Content-Type: text/plain
Message-Id: <1092758492.5415.49.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 09:01:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 05:07, Hariprasad Nellitheertha wrote:
> Regards, Hari


> +void __relocate_base_mem(unsigned long backup_addr, unsigned long backup_size)
> +{
> +       unsigned long pfn, pfn_max;
> +       void *src_addr, *dest_addr;
> +       struct page *page;
> +
> +       pfn_max = backup_size >> PAGE_SHIFT;
> +       for (pfn = 0; pfn < pfn_max; pfn++) {
> +               src_addr = phys_to_virt(pfn << PAGE_SHIFT);
> +               dest_addr = backup_addr + src_addr;
> +               if (!pfn_valid(pfn))
> +                       continue;
> +               page = pfn_to_page(pfn);
> +               if (PageReserved(page))
> +                       copy_page(dest_addr, src_addr);
> +       }
> +}

You're getting a little sloppy with your types in there.  I know you
probably aren't getting warnings for passing unsigned longs to
copy_page(), but you should probably still be passing pointers to it.  

I think the general convention is to keep physical addresses in unsigned
longs and virtual addresses in pointers.  Just keep that in mind.  

> +#define CRASH_BACKUP_BASE 0x08000000
> +#define CRASH_BACKUP_SIZE 0x01000000

What are these numbers?  Why do you need to define them when your config
option is off?

> +/*
> + * If we have booted due to a crash, max_pfn will be a very low value. We need
> + * to know the amount of memory that the previous kernel used.
> + */
> +unsigned long saved_max_pfn;

I'd probably put that comment next to the place where saved_max_pfn is
used instead of where it is declared.  


-- Dave

