Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUI1Wkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUI1Wkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUI1Wkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:40:52 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:47796 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S268082AbUI1Wku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:40:50 -0400
Message-ID: <4159E85A.6080806@ammasso.com>
Date: Tue, 28 Sep 2004 17:40:26 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: get_user_pages() still broken in 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was hoping that this bug would be fixed in the 2.6 kernels, but 
apparently it hasn't been.

Function get_user_pages() is supposed to lock user memory.  However, 
under extreme memory constraints, the kernel will swap out the "locked" 
memory.

I have a test app which does this:

1) Calls our driver, which issues a get_user_pages() call for one page.
2) Calls our driver again to get the physical address of that page (the 
driver uses pgd/pmd/pte_offset).
3) Tries allocate 1GB of memory (this system has 1GB of physical RAM).
4) Tries to get the physical address again.

In step 4, the physical address is usually zero, which means either 
pgd_offset or pmd_offset failed.  This indicates the page was swapped out.

I don't understand how this bug can continue to exist after all this 
time.  get_user_pages() is supposed to lock the memory, because drivers 
use it for DMA'ing directly into user memory.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
