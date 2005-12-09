Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVLIVSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVLIVSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVLIVSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:18:43 -0500
Received: from smtpout.mac.com ([17.250.248.83]:48350 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932435AbVLIVSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:18:42 -0500
In-Reply-To: <Pine.LNX.4.61.0512092034510.28318@goblin.wat.veritas.com>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]> <1134148609.30856.22.camel@localhost> <E4ECF4F0-9442-4FFE-BE55-3EF7A1CC40F4@mac.com> <1134151696.3278.2.camel@localhost> <DB1A6A43-DA12-4C5B-B195-5C01DED4CF3E@mac.com> <Pine.LNX.4.61.0512092034510.28318@goblin.wat.veritas.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A699737E-EE3B-4521-B68C-F7D90C018CFB@mac.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix coding style
Date: Fri, 9 Dec 2005 15:18:38 -0600
To: Hugh Dickins <hugh@veritas.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 9, 2005, at 2:37 PM, Hugh Dickins wrote:

> On Fri, 9 Dec 2005, Mark Rustad wrote:
>>
>> If hugetlbfs could be guaranteed to provide contiguous memory for  
>> a file, that
>> could be used in this application. We used to use remap_pfn_range  
>> in our
>> driver, but recent changes there made that not work for this  
>> application, so I
>
> You're not the only one to have trouble with recent remap_pfn_range  
> changes.
> Would you let us know what you were doing, that you can no longer do?
> Some of the change may need to be reverted.

Well, our driver had been allocating two 320MB and one 128MB range of  
memory, each of the three being contiguous. These were allocated by  
allocating lots of 1MB groups of pages until we got a contiguous  
range, then the unneeded pages were freed.

These areas were then mapped into the application with  
remap_pfn_range. We have been running on a SuSE kernel derived from  
2.6.5 for a long time where this worked fine, even for gdb to access  
during debugging. Now that we are moving to a more current kernel,  
changes were needed mainly to allow gdb to access these shared memory  
areas.

I had messed with simply taking the large memory by restricting the  
kernel's memory range with mem=, but gdb still can't get to the pages  
because it believes that they are for I/O (there would be no struct  
page in that case).

Given the situation, using hugepages seemed more attractive anyway,  
so I just decided to go that way and specify hugepages=192 on the  
kernel command line.

We also have a single page shared between our processes and the  
driver, but we now use the new insert_single_page call for that,  
which works nicely. It seemed to me that calling that for the each of  
the single pages in our 768M of shared memory was silly, so I went  
the hugepage route, and that proved to be less trouble than I had  
expected. I feel like things now are really where they should have  
been all along.

-- 
Mark Rustad, MRustad@mac.com

