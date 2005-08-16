Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVHPFq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVHPFq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVHPFq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:46:28 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:6917 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965118AbVHPFq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:46:27 -0400
Message-ID: <43017DB1.6010506@vmware.com>
Date: Mon, 15 Aug 2005 22:46:25 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, chrisl@vmware.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwane@arm.linux.org.uk
Subject: Re: [PATCH 3/6] i386 virtualization - Make ldt a desc struct
References: <200508152259.j7FMxdh2005320@zach-dev.vmware.com> <20050816052352.GV7762@shell0.pdx.osdl.net>
In-Reply-To: <20050816052352.GV7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 05:46:26.0312 (UTC) FILETIME=[D7834080:01C5A225]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

Thanks for the feedback.  Comments inline.

>>@@ -30,7 +33,7 @@
>> static inline unsigned long get_desc_base(struct desc_struct *desc)
>> {
>> 	unsigned long base;
>>-	base = ((desc->a >> 16)  & 0x0000ffff) |
>>+	base = (desc->a >> 16) |
>>    
>>
>
>Seemingly unrelated.
>  
>

Yes, alas my bucket has leaks.  I was hoping for better assembly, but 
never got around to verifying.  So I matched this to shorter C code 
which I had obsoleted.

>>@@ -28,28 +28,27 @@
>> }
>> #endif
>> 
>>-static inline int alloc_ldt(mm_context_t *pc, const int oldsize, int mincount, const int reload)
>>+static inline int alloc_ldt(mm_context_t *pc, const int old_pages, int new_pages, const int reload)
>> {
>>-	void *oldldt;
>>-	void *newldt;
>>+	struct desc_struct *oldldt;
>>+	struct desc_struct *newldt;
>> 
>>    
>>
>
>Not quite related here (since change was introduced in earlier patch),
>but old alloc_ldt special cased when room was available.  This is gone,
>so am I reading this correctly, each time through it will allocate a
>new one, and free the old one (if it existed)?  Just double checking
>that change doesn't introduce possible mem leak.
>  
>

Since LDT is now in pages, it is only called when page reservation 
increases.   I chose a slightly bad name here for new_pages.  See 
further down:

        if (page_number >= mm->context.ldt_pages) {
                error = alloc_ldt(&current->mm->context, 
mm->context.ldt_pages,
                                        page_number+1, 1);
                if (error < 0)
                        goto out_unlock;
        }

I actually had to check the code here to verify there is no leak, and I 
don't believe I changed any semantics, but was very happy when I found this:

        if (old_pages) {
                ClearPagesLDT(oldldt, old_pages);
                if (old_pages > 1)
                        vfree(oldldt);
                else
                        kfree(oldldt);
        }


>>-	mincount = (mincount+511)&(~511);
>>-	if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
>>-		newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
>>+	if (new_pages > 1)
>>+		newldt = vmalloc(new_pages*PAGE_SIZE);
>> 	else
>>-		newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
>>+		newldt = kmalloc(PAGE_SIZE, GFP_KERNEL);
>>    
>>
>
>If so, then full page is likely to be reusable in common case, no? (If
>there's such a thing as LDT common case ;-)
>  
>

Yeah, there is no LDT common case.  This code could be made 100% optimal 
with a lot of likely/unlikely wrappers and additional cleanup, but 
seeing as it is already uncommon, the only worthwhile optimizations for 
this code are ones that reduce code size or make it more readable and 
less error prone.  I had to write a test that emits inline assembler 
onto a crossing page boundary, clones the VM, and tests strict 
conformance to byte/page limits to actually test this.  :)


>> 	if (!newldt)
>> 		return -ENOMEM;
>> 
>>-	if (oldsize)
>>-		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
>>+	if (old_pages)
>>+		memcpy(newldt, pc->ldt, old_pages*PAGE_SIZE);
>> 	oldldt = pc->ldt;
>> 	if (reload)
>>-		memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
>>+		memset(newldt+old_pages*LDT_ENTRIES_PER_PAGE, 0, (new_pages-old_pages)*PAGE_SIZE);
>>    
>>
>
>In fact, I _think_ this causes a problem.  Who says newldt is bigger
>than old one?  This looks like user-triggerable oops to me.
>  
>

Safe -- two call sites.  One has no LDT (cloning), and the other is here:

        if (page_number >= mm->context.ldt_pages) {
                error = alloc_ldt(&current->mm->context, 
mm->context.ldt_pages,

Note page_number is zero-based, ldt_pages is not.

>>@@ -113,13 +114,13 @@
>> 	unsigned long size;
>> 	struct mm_struct * mm = current->mm;
>> 
>>-	if (!mm->context.size)
>>+	if (!mm->context.ldt_pages)
>> 		return 0;
>> 	if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
>> 		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
>> 
>> 	down(&mm->context.sem);
>>-	size = mm->context.size*LDT_ENTRY_SIZE;
>>+	size = mm->context.ldt_pages*PAGE_SIZE;
>> 	if (size > bytecount)
>> 		size = bytecount;
>>    
>>
>
>This now looks like you can leak data?  Since full page is unlikely
>used, but accounting is done in page sizes.  Asking to read_ldt with
>bytcount of PAGE_SIZE could give some uninitialzed data back to user.
>Did I miss the spot where this is always zero-filled?
>  
>

You could leak data, but the code already takes care to zero the page.  
This is especially important, since random present segments could allow 
a violation of kernel security ;)

        if (reload)
                memset(newldt+old_pages*LDT_ENTRIES_PER_PAGE, 0, 
(new_pages-old_pages)*PAGE_SIZE);



Wow.  Thanks for a completely thorough review.  I have tested this code 
quite intensely, but I very much appreciate having more eyes on it, 
since it is quite a tricky biscuit.

Zach
