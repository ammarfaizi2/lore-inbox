Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUIGRtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUIGRtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIGRtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:49:00 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:54754 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266149AbUIGRri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 13:47:38 -0400
Message-ID: <413DD825.9000405@nortelnetworks.com>
Date: Tue, 07 Sep 2004 11:47:49 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: looking for help with details of mapping pages to kernel and userspace
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box with 1.5GB of memory and HIGHMEM enabled.

I would like to have a page of memory accessable from userspace, regular kernel 
space, and late asm code on return from exceptions with no valid C context.  As 
far as I can see, this implies that the page tables need to be in lowmem since 
having to do a kmap_atomic in asm would be painful.

It has been suggested that we could do something like the following, where this 
is running on behalf of userspace which passed in a desired mapping address:

mypage =  __get_free_page(GFP_KERNEL);
SetPageReserved(virt_to_page(mypage));
remap_page_range(vma->vm_start, virt_to_phys((void *) mypage), PAGE_SIZE, 
vma->vm_page_prot);

This seems to work, but I'm concerned about cleanup.  When the task dies, how 
much cleanup will be done on the page?  Does the memory subsystem handle 
everything, or do I need to explicitly do something like:

reservedClearPageReserved(virt_to_page(mypage));
free_page(mypage);

Is there a better way of doing this?  I had considered mmap(), but I think that 
could give me pages with their page tables up in high memory.


Thanks,

Chris
