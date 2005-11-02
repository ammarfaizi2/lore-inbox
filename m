Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVKBBRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVKBBRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVKBBRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:17:16 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:5521 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932132AbVKBBRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:17:16 -0500
Message-ID: <4368139A.30701@vc.cvut.cz>
Date: Wed, 02 Nov 2005 02:17:14 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>
In-Reply-To: <4368097A.1080601@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Petr Vandrovec wrote:
> 
>> Hello Nick,
>>   what's the reason behind disallowing get_user_pages() on VM_RESERVED 
>> regions?  vmmon uses VM_RESERVED on its 'vma' as otherwise some 
>> kernels used by SUSE complained loudly about mismatch between 
>> PageReserved() and VM_RESERVED flags.
>>
> 
> The reason is that VM_RESERVED indicates that the core vm is not allowed
> to touch any 'struct page' through this mapping, which get_user_pages
> would do.

But get_user_pages() was not invoked by 'the core vm'.  I invoked it, from my
module...  same one which populated this VMA before.

>>   I'll remove it from vmmon for >= 2.6.14 kernels as that bogus test 
>> never made to Linux kernel, but I cannot find any reason why 
>> get_user_pages() should not work on VM_RESERVED (or VM_IO for that 
>> matter) user pages.  Can you show me reasoning behind that decision ?
> 
> The reasoning behind the decision was so VM_RESERVED is usable for a
> complete replacement to PageReserved. For example mappings through
> /dev/mem should not touch the page count.
> 
> You may be able to go a step further and clear PageReserved from your
> pages as well, and thus have a working driver without special casing
> for both kernels.

Nope.  We are not having PageReserved() set on our pages since we want them
refcounted.  But old SuSE kernels contained this code which was rather unhappy
if page did not have ->mapping set.  So we just marked vma VM_RESERVED, as it
did not hurt, and all pages in this vma have refcount > 1 anyway so there is no
point in trying to cleanup these page tables.  Now rmap catches this by
page_count() != page_mapcount(), so VM_RESERVED is not needed anymore, but there
did not seem to be any reason to remove it.

         pageable = !PageReserved(new_page);    << pageable = 1
         as = !!new_page->mapping;              << as = 0

         BUG_ON(!pageable && as);

         pageable &= as;                        << pageable = 0

         ...

         /*
          * This is the entry point for memory under VM_RESERVED vmas.
          * That memory will not be tracked by the vm. These aren't
          * real anonymous pages, they're "device" reserved pages instead.
          */
         reserved = !!(vma->vm_flags & VM_RESERVED);  << reserved = 0
         if (unlikely(reserved == pageable))          << fires...
                 printk("Badness in %s at %s:%d\n",
                        __FUNCTION__, __FILE__, __LINE__);

So I've made this change...  Test probably could be for 2.6.4 <= x <= 2.6.5 to 
rule out all buggy kernels, but I'll probably leave it this way unless there is 
some good reason to not set VM_RESERVED on these older kernels.

Thanks for explanation.
								Petr

--- vmmon-only/linux/driver.c.orig	2005-11-02 02:00:46.000000000 +0100
+++ vmmon-only/linux/driver.c	2005-11-01 20:12:13.000000000 +0100
@@ -1283,9 +1283,13 @@
     /*
      * It seems that SuSE's 2.6.4-52 needs this.  Hopefully
      * it will not break anything else.
+    *
+    * It breaks on post 2.6.14 kernels, so get rid of it on them.
      */
  #ifdef VM_RESERVED
+#  if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 14)
     vma->vm_flags |= VM_RESERVED;
+#  endif
  #endif
     return 0;
  }

