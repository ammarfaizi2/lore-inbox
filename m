Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVKBSG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVKBSG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVKBSG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:06:57 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:42448 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S965152AbVKBSG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:06:56 -0500
Message-ID: <4369003F.8020205@vc.cvut.cz>
Date: Wed, 02 Nov 2005 19:06:55 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au> <4368139A.30701@vc.cvut.cz> <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 2 Nov 2005, Petr Vandrovec wrote:
> 
>>So we just marked vma VM_RESERVED, as it
>>did not hurt, and all pages in this vma have refcount > 1 anyway so there is
>>no point in trying to cleanup these page tables.  Now rmap catches this by
>>page_count() != page_mapcount(), so VM_RESERVED is not needed anymore, but
>>there did not seem to be any reason to remove it.
> 
> 
> Well, beware.  That "page_count() != page_mapcount() + 2" check in rmap.c
> went away in 2.6.13: the problem it was there to solve being solved
> instead by a can_share_swap_page based on page_mapcount instead of
> page_count (partly to fix a page migration progress problem).
> 
> So, you may still be in trouble?  But how do the pages you're concerned
> with come to be on the LRU in the first place?  If they're not on the
> LRU, vmscanning will never try to take them away.  Most drivers with
> special pages, and ->mapping unset, don't put the pages on the LRU.

No, we do not put pages on LRU.  Older kernels were removing once
instantiated page entries from pagetables.  It did not cause any
problems, but as VM cannot gain anything from this removal, we were
happy to find that VM did not clear page tables for VM_RESERVED vmas.
But primary motivation for VM_RESERVED was to get rid warning on SuSE
2.6.4.  As one VMware instance uses 4 to 6 pages allocated this way,
it is really not big problem even if VM will try to remove them from
pagetables...

>>--- vmmon-only/linux/driver.c.orig	2005-11-02 02:00:46.000000000 +0100
>>+++ vmmon-only/linux/driver.c	2005-11-01 20:12:13.000000000 +0100
>>@@ -1283,9 +1283,13 @@
>>/*
>>* It seems that SuSE's 2.6.4-52 needs this.  Hopefully
>>* it will not break anything else.
>>+    *
>>+    * It breaks on post 2.6.14 kernels, so get rid of it on them.
>>   */
>> #ifdef VM_RESERVED
>>+#  if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 14)
>>    vma->vm_flags |= VM_RESERVED;
>>+#  endif
>>#endif
>>  return 0;
>>}
> 
> 
> Nick's PageReserved/VM_RESERVED changes are not in 2.6.14 so I'd expect
> 2.6.15 there.  Ah, you're trying to handle this awkward interval before
> 2.6.15-rc1 brings the numbering up to 2.6.15, okay.

For our purpose anything between 2.6.6 and 2.6.14 is fine as for us.
Allocated pages are normal memory pages, they just were allocated to
meet specific criteria - being allocated either from low 4GB (accessible in
32bit mode without paging), or being physically contiguous, so they all
have 'struct page' and can be happily refcounted.

Only really obscure thing we do is that we allocate order 1 or 2 (8/16KB)
regions, bump refcount by 1 on all pages except first one (if CONFIG_MMU
is set), and then pass independent pages from this region through nopage
handler to the VM to map them to the user level.  It means that region
is allocated by alloc_pages(GFP_USER, 2), while it is released by 4 calls
to put_page(), for page+0...page+3.

It works on all Linux kernels with MMU I've tested, and it would be nice
if this could continue to work.  Current kernels seems to provide PageCompound,
which would fit our needs as well after some changes, but as long as
PageCompound is build time option it is not possible to rely on it.

						Best regards,
							Petr Vandrovec

