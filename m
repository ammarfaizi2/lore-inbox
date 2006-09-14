Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWINOsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWINOsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWINOsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:48:22 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:51675 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1750720AbWINOsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:48:21 -0400
X-AuditID: 7f000001-a3ea0bb000006360-a6-45096bc00e0c 
Date: Thu, 14 Sep 2006 15:48:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Yingchao Zhou <yc_zhou@ncic.ac.cn>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       alan <alan@redhat.com>, zxc <zxc@ncic.ac.cn>
Subject: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
In-Reply-To: <20060913140241.60C5FFB046@ncic.ac.cn>
Message-ID: <Pine.LNX.4.64.0609141517470.32008@blonde.wat.veritas.com>
References: <20060913140241.60C5FFB046@ncic.ac.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Sep 2006 14:48:01.0121 (UTC) FILETIME=[C6AF1D10:01C6D80C]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Yingchao Zhou wrote:
> 
>      The current kernel set PAGE_COPY without write bit. This will cause intermittent non-cosistent data for user-level network drivers such as Infiniband, Quadrics and Myrinet. Which has also be mentioned by Costin Iancu in the paper "HUNTing the Overlap " (PACT'05).
>     An example of such phenomena is the following sequences: 
> 	register a memory space BUFF for receive message, 
> 	receive message,
> 	call mprotect(...PROT_NONE...) and mprotect(...PROT_READ|PROT_WRITE) one by one, 	
> 	write into BUFF, 
> 	then receive again.      
>     The second time received data will perhaps not be the data sent by the peer machine but the data written by itself in the 4th step.

PAGE_COPY (without the write bit) is used when the area was mmap'ed
MAP_PRIVATE: which indeed is asking for private copies of pages to
be made - which will be left containing the data written there by the
application, rather than shared data received later by the driver.

You want to mmap MAP_SHARED, which will use PAGE_SHARED instead,
including the write bit, both before and after the mprotects.
There should be no problem then: do you actually see a problem
when MAP_SHARED is used?

(You don't mention which release you're describing, and some of
the details may vary: the not-yet-started 2.6.19 is likely to use
PAGE_COPY even when MAP_SHARED, to help it keep track of the number
of dirty pages; but in that case, do_wp_page() won't make a copy.)

> 
>      The reson is that :
>      1) User-level network driver locks phy pages when memory space is registered;
>      2) 2 calls to mprotect change ptes in the space to PAGE_COPY, so write any page in the space will cause a page fault;

Not if PROT_WRITE, MAP_SHARED I think.

>      3) In the page fault handler, it goes to do_wp_page, and in it if Page Is Locked, a new page is generated and filled into the pte. So the physical page seen by the host is not the same one by the NIC.

When MAP_PRIVATE, it's not the page being locked that causes the copy
(it's not normally locked there, is it?), it's that it's not PageAnon;
or if you're looking at 2.6.12 or older, that page_count is raised.

> 
>      Adding PAGE_RW to PAGE_COPY will resolve this problem.  

No!  That would give every user write access to shared files they
should have no write access to.

>      In my option, the reason for absense of RW is to save memory by mapping all those only read pages into ZERO_PAGE. But is there really programs which make many read-ops in memory space without even initialize them?

Not just the ZERO_PAGE: initial program data is another common example.

Hugh
