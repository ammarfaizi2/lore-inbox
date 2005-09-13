Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbVIMMI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVIMMI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVIMMI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:08:56 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48014 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932622AbVIMMIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:08:55 -0400
Message-ID: <4326C285.7040901@sw.ru>
Date: Tue, 13 Sep 2005 16:13:57 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: Re: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org> <Pine.LNX.4.61.0509131217200.7040@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509131217200.7040@goblin.wat.veritas.com>
Content-Type: multipart/mixed;
 boundary="------------040303060500070400040204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040303060500070400040204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>>Kirill Korotaev <dev@sw.ru> wrote:
>>
>>> This patch fixes error path in setup_arg_pages() functions, since it 
>>> misses vm_unacct_memory() after successful call of 
>>> security_vm_enough_memory(). Also it cleans up error path.
>>
>>Ugh.  The identifier `security_vm_enough_memory()' sounds like some
>>predicate which has no side-effects.  Except it performs accounting.  Hence
>>bugs like this.
>>
>>It's a shame that you mixed a largeish cleanup along with a bugfix - please
>>don't do that in future.
>>
>>Patch looks OK to me.  Hugh, could you please double-check sometime?
> 
> 
> It's a good find, and the patch looks correct to me, so far as it goes.
> But I think it's the wrong patch, and incomplete: it can be done more
> appropriately, more simply and more completely in insert_vm_struct itself.
> I'll post a replacement patch (or admit I'm wrong) in a little while.

this looks like the weirdest solution to me...
also it looks like not all the callers of insert_vm_struct do call 
security_vm_enough_memory(), e.g. ./arch/sparc/mm/sun4c.c

------------------------------------------------------------------

Also, Pavel missed ppc64 version of setup_arg_pages due to different 
name. I attached 2 new additional patches:



1. diff-ms-ppsleak-20050913:

[PATCH] error path in ppc64::arch_setup_additional_pages() misses 
vm_unacct_memory() and kmem_cache_free()

This patch fixes error path in arch_setup_additional_pages() function, 
since it misses vm_unacct_memory() and kmmem_cache_free() after 
successful call of security_vm_enough_memory().

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>



2. diff-ms-ppscleanup-20050913:
[PATCH] This patch cleanups error path in 
ppc64::arch_setup_additional_pages() function.

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>



Kirill

--------------040303060500070400040204
Content-Type: text/plain;
 name="diff-ms-ppsleak-20050913"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-ppsleak-20050913"

--- linux-2.6.13.1/arch/ppc64/kernel/vdso.c.ppcfix	2005-09-13 15:44:17.000000000 +0400
+++ linux-2.6.13.1/arch/ppc64/kernel/vdso.c	2005-09-13 15:47:26.000000000 +0400
@@ -237,8 +237,11 @@ int arch_setup_additional_pages(struct l
 	 */
 	vdso_base = get_unmapped_area(NULL, vdso_base,
 				      vdso_pages << PAGE_SHIFT, 0, 0);
-	if (vdso_base & ~PAGE_MASK)
+	if (vdso_base & ~PAGE_MASK) {
+		vm_unacct_memory(vdso_pages);
+		kmem_cache_free(vm_area_cachep, vma);
 		return (int)vdso_base;
+	}
 
 	current->thread.vdso_base = vdso_base;
 

--------------040303060500070400040204
Content-Type: text/plain;
 name="diff-ms-ppscleanup-20050913"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-ppscleanup-20050913"

--- linux-2.6.13.1/arch/ppc64/kernel/vdso.c.ppccln	2005-09-13 15:47:26.000000000 +0400
+++ linux-2.6.13.1/arch/ppc64/kernel/vdso.c	2005-09-13 15:55:08.000000000 +0400
@@ -221,13 +221,13 @@ int arch_setup_additional_pages(struct l
 	if (vdso_pages == 0)
 		return 0;
 
+	vdso_base = -ENOMEM;
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (vma == NULL)
-		return -ENOMEM;
-	if (security_vm_enough_memory(vdso_pages)) {
-		kmem_cache_free(vm_area_cachep, vma);
-		return -ENOMEM;
-	}
+		goto out;
+	if (security_vm_enough_memory(vdso_pages))
+		goto out_free;
+
 	memset(vma, 0, sizeof(*vma));
 
 	/*
@@ -237,11 +237,8 @@ int arch_setup_additional_pages(struct l
 	 */
 	vdso_base = get_unmapped_area(NULL, vdso_base,
 				      vdso_pages << PAGE_SHIFT, 0, 0);
-	if (vdso_base & ~PAGE_MASK) {
-		vm_unacct_memory(vdso_pages);
-		kmem_cache_free(vm_area_cachep, vma);
-		return (int)vdso_base;
-	}
+	if (vdso_base & ~PAGE_MASK)
+		goto out_unacct;
 
 	current->thread.vdso_base = vdso_base;
 
@@ -274,6 +271,13 @@ int arch_setup_additional_pages(struct l
 	up_write(&mm->mmap_sem);
 
 	return 0;
+
+out_unacct:
+	vm_unacct_memory(vdso_pages);
+out_free:
+	kmem_cache_free(vm_area_cachep, vma);
+out:
+	return (int)vdso_base;
 }
 
 static void * __init find_section32(Elf32_Ehdr *ehdr, const char *secname,

--------------040303060500070400040204--

