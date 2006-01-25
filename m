Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWAYP7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWAYP7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWAYP7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:59:14 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:52316 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750745AbWAYP7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:59:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=ZZ6sD+q/leyu0yITDL1iAJXV24uTtV3o9FOqebaWruxKpUC4hsYqyhzrd5dOeR34k1yaewYM2aVlR9l0DjPjlg1p1W7Ps4G70kuMqMCFwxu9BMYT8SHuI51H3uMlMhvJhpOl+SNLz1hjzXqf/dmiKLiCQNe0lvNXWRFuNxNb6OA=  ;
Message-ID: <43D7A047.3070004@yahoo.com.au>
Date: Thu, 26 Jan 2006 02:59:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org> <6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
In-Reply-To: <6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070305060406010003010105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070305060406010003010105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Michal Piotrowski wrote:
> ------------[ cut here ]------------
> kernel BUG at /usr/src/linux-mm/include/linux/mm.h:302!
> invalid opcode: 0000 [#1]
> PREEMPT SMP DEBUG_PAGEALLOC
> last sysfs file: /class/vc/vcsa7/dev
> Modules linked in: binfmt_misc thermal fan processor ipv6 w83627hf
> hwmon_vid hwmon i2c_isa snd_intel8x0 snd_ac97_codec snd_ac97_bus
> sk98lin snd_pcm_oss snd_mixer_oss skge intel_agp snd_pcm snd_timer snd
> soundcore i2c_i801 parport_pc parport snd_page_alloc 8250_pnp 8250
> serial_core agpgart rtc ide_cd cdrom hw_random unix
> CPU:    0
> EIP:    0060:[<b013fe81>]    Not tainted VLI
> EFLAGS: 00210246   (2.6.16-rc1-mm3 #1)
> EIP is at release_pages+0x33/0x15e

Is it repeatable?

If so, I'd imagine it must be a specific driver page which is not properly
refcounted somewhere. A bug in generic code would have shown up elsewhere
by now.

Can you try something like the attached patch and see what it gives you?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------070305060406010003010105
Content-Type: text/plain;
 name="mm-debug-refcount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-debug-refcount.patch"

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -15,6 +15,7 @@
 #include <linux/prio_tree.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
+#include <linux/kallsyms.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -264,6 +265,8 @@ struct page {
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
+
+	void *debug;
 };
 
 #define page_private(page)		((page)->private)
@@ -294,8 +297,14 @@ struct page {
  */
 static inline int put_page_testzero(struct page *page)
 {
-	BUG_ON(atomic_read(&page->_count) == 0);
-	return atomic_dec_and_test(&page->_count);
+	if (unlikely(atomic_read(&page->_count) == 0)) {
+		printk(KERN_WARNING "put_page_testzero found free page (flags = %lx)\n", page->flags);
+		if (page->debug)
+			print_symbol(KERN_WARNING "nopage is %s\n", (unsigned long)page->debug);
+		WARN_ON(1);
+		return 0;
+	} else
+		return atomic_dec_and_test(&page->_count);
 }
 
 /*
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -2056,6 +2056,8 @@ retry:
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
 
+	new_page->debug = (struct address_space *)vma->vm_ops->nopage;
+
 	/*
 	 * Should we do an early C-O-W break?
 	 */
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -521,6 +521,8 @@ static int prep_new_page(struct page *pa
 	if (PageReserved(page))
 		return 1;
 
+	page->debug = NULL;
+
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);

--------------070305060406010003010105--
Send instant messages to your online friends http://au.messenger.yahoo.com 
