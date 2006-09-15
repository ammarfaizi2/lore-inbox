Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWIOA6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWIOA6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWIOA6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:58:50 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:52432 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S1751390AbWIOA6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:58:49 -0400
Date: Fri, 15 Sep 2006 08:58:45 +0800
From: "Yingchao Zhou" <yc_zhou@ncic.ac.cn>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "alan" <alan@redhat.com>, "zxc" <zxc@ncic.ac.cn>
Subject: Re: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20060915005846.07C31FB045@ncic.ac.cn>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>PAGE_COPY (without the write bit) is used when the area was mmap'ed
>MAP_PRIVATE: which indeed is asking for private copies of pages to
>be made - which will be left containing the data written there by the
>application, rather than shared data received later by the driver.
>
>You want to mmap MAP_SHARED, which will use PAGE_SHARED instead,
>including the write bit, both before and after the mprotects.
>There should be no problem then: do you actually see a problem
>when MAP_SHARED is used?
It's ok to mmap MAP_SHARED. But is it not a normal way to malloc() a space and
then registered to NIC ?
>
>(You don't mention which release you're describing, and some of
>the details may vary: the not-yet-started 2.6.19 is likely to use
>PAGE_COPY even when MAP_SHARED, to help it keep track of the number
>of dirty pages; but in that case, do_wp_page() won't make a copy.)
>
>> 
>>      The reson is that :
>>      1) User-level network driver locks phy pages when memory space is registered;
>>      2) 2 calls to mprotect change ptes in the space to PAGE_COPY, so write any page in the space will cause a page fault;
>
>Not if PROT_WRITE, MAP_SHARED I think.
Yeah, of course.
>
>>      3) In the page fault handler, it goes to do_wp_page, and in it if Page Is Locked, a new page is generated and filled into the pte. So the physical page seen by the host is not the same one by the NIC.
>
>When MAP_PRIVATE, it's not the page being locked that causes the copy
>(it's not normally locked there, is it?), it's that it's not PageAnon;
>or if you're looking at 2.6.12 or older, that page_count is raised.
>
>> 
>>      Adding PAGE_RW to PAGE_COPY will resolve this problem.  
>
>No!  That would give every user write access to shared files they
>should have no write access to.
I guess you refer to mmap a file MAP_READ|MAP_WRITE in MAP_PRIVATE way.
I think it is probably more logical to read the file data into an anoymous page and filled the pte with _PAGE_RW in the first time page-fault. It will probably reduce numbers of page fault interrupt.
>
>>      In my option, the reason for absense of RW is to save memory by mapping all those only read pages into ZERO_PAGE. But is there really programs which make many read-ops in memory space without even initialize them?
>
>Not just the ZERO_PAGE: initial program data is another common example.
Ok, we can deal with initial program data using the above flow.
>
>Hugh
>
Best regards
Yingchao Zhou


