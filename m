Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUCZBEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUCZAbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:31:41 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:33540 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263861AbUCZALf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:11:35 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: [PATCH] [0/6] HUGETLB memory commitment 
In-reply-to: Your message of "Thu, 25 Mar 2004 23:59:21 -0000."
             <1739144.1080259161@[192.168.0.89]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Mar 2004 11:10:44 +1100
Message-ID: <2668.1080259844@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 23:59:21 +0000, 
Andy Whitcroft <apw@shadowen.org> wrote:
>--On 25 March 2004 15:51 -0800 Andrew Morton <akpm@osdl.org> wrote:
>
>> I think it's simply:
>>
>> - Make normal overcommit logic skip hugepages completely
>>
>> - Teach the overcommit_memory=2 logic that hugepages are basically
>>   "pinned", so subtract them from the arithmetic.
>>
>> And that's it.  The hugepages are semantically quite different from normal
>> memory (prefaulted, preallocated, unswappable) and we've deliberately
>> avoided pretending otherwise.
>
>True currently.  Though the thread that prompted this was in response to 
>the time taken for this prefault and for the wish to fault them.
>
>I'll have a poke about at it and see how small I can make it.

FWIW, lkcd (crash dump) treats hugetlb pages as normal kernel pages and
dumps them, which is pointless and wastes a lot of time.  To avoid
dumping these pages in lkcd, I had to add a PG_hugetlb flag.  lkcd runs
at the page level, not mm or vma, so VM_hugetlb was not available.  In
set_hugetlb_mem_size()

	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
		SetPageReserved(map);
		SetPageHugetlb(map);
		map++;
	}

In dump_base.c, I changed kernel_page(), referenced_page() and
unreferenced_page() to test for PageHugetlb() before PageReserved().

Since you are looking at identifying hugetlb pages, could any other
code benefit from a PG_hugetlb flag?

