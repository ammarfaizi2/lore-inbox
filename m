Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVHPSoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVHPSoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVHPSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:44:21 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:14353 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030294AbVHPSoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:44:20 -0400
Message-ID: <430233FF.7090106@vmware.com>
Date: Tue, 16 Aug 2005 11:44:15 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 3/6] i386 virtualization - Make ldt a desc struct
References: <200508161306_MC3-1-A75D-6646@compuserve.com>
In-Reply-To: <200508161306_MC3-1-A75D-6646@compuserve.com>
Content-Type: multipart/mixed;
 boundary="------------070406090605020605060208"
X-OriginalArrivalTime: 16 Aug 2005 18:44:15.0093 (UTC) FILETIME=[80461A50:01C5A292]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406090605020605060208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chuck Ebbert wrote:

>
>>@@ -97,14 +96,16 @@
>> 
>> void destroy_ldt(struct mm_struct *mm)
>> {
>>+     int pages = mm->context.ldt_pages;
>>+
>>      if (mm == current->active_mm)
>>              clear_LDT();
>>-     ClearPagesLDT(mm->context.ldt, (mm->context.size * LDT_ENTRY_SIZE) / PAGE_SIZE);
>>-     if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
>>+     ClearPagesLDT(mm->context.ldt, pages);
>>+     if (pages > 1)
>>              vfree(mm->context.ldt);
>>      else
>>              kfree(mm->context.ldt);
>>-     mm->context.size = 0;
>>+     mm->context.ldt_pages = 0;   <====================
>> }
>> 
>> static int read_ldt(void __user * ptr, unsigned long bytecount)
>>    
>>
>
>  destroy_ldt does not zero "ldt", just the size.  Potential bug?
>  
>

Not a bug, truly unnecessary at all.


--------------070406090605020605060208
Content-Type: text/plain;
 name="remove-useless-zeroing"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-useless-zeroing"

Several reviewers noticed that initialization and destruction of the
mm->context is unnecessary, since the entire MM struct is zeroed on
allocation anyways.

Verified with BUG_ON(mm->context.ldt || mm->context.ldt_pages);

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/mmu_context.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mmu_context.h	2005-08-15 11:23:32.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mmu_context.h	2005-08-16 11:35:11.000000000 -0700
@@ -16,7 +16,6 @@
 	struct mm_struct * old_mm;
 	int retval = 0;
 
-	memset(&mm->context, 0, sizeof(mm->context));
 	init_MUTEX(&mm->context.sem);
 	old_mm = current->mm;
 	if (old_mm && unlikely(old_mm->context.ldt)) {
Index: linux-2.6.13/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ldt.c	2005-08-15 11:23:32.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ldt.c	2005-08-16 11:12:59.000000000 -0700
@@ -105,7 +105,6 @@
 		vfree(mm->context.ldt);
 	else
 		kfree(mm->context.ldt);
-	mm->context.ldt_pages = 0;
 }
 
 static int read_ldt(void __user * ptr, unsigned long bytecount)

--------------070406090605020605060208--
