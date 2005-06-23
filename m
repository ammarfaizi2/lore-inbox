Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbVFWI3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVFWI3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbVFWIYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:24:35 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:48038 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262631AbVFWHdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:33:42 -0400
Message-ID: <42BA65CD.6020006@yahoo.com.au>
Date: Thu, 23 Jun 2005 17:33:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 2/5: micro optimisation for mm/rmap.c
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <20050623072609.GA3334@holomorphy.com>
In-Reply-To: <20050623072609.GA3334@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------000306070506030701020106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000306070506030701020106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:
> On Thu, Jun 23, 2005 at 05:06:35PM +1000, Nick Piggin wrote:
> 
>>+		index = (address - vma->vm_start) >> PAGE_SHIFT;
>>+		index += vma->vm_pgoff;
>>+		index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
>>+		page->index = index;
> 
> 
> linear_page_index()
> 

Ah indeed it is, thanks. I'll queue this up as patch 2.5, then?


--------------000306070506030701020106
Content-Type: text/plain;
 name="mm-cleanup-rmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-cleanup-rmap.patch"

Use linear_page_index in mm/rmap.c, as noted by Bill Irwin.

Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -448,16 +448,11 @@ void page_add_anon_rmap(struct page *pag
 
 	if (atomic_inc_and_test(&page->_mapcount)) {
 		struct anon_vma *anon_vma = vma->anon_vma;
-		pgoff_t index;
-
 		BUG_ON(!anon_vma);
 		anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 		page->mapping = (struct address_space *) anon_vma;
 
-		index = (address - vma->vm_start) >> PAGE_SHIFT;
-		index += vma->vm_pgoff;
-		index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-		page->index = index;
+		page->index = linear_page_index(vma, address);
 
 		inc_page_state(nr_mapped);
 	}

--------------000306070506030701020106--
Send instant messages to your online friends http://au.messenger.yahoo.com 
