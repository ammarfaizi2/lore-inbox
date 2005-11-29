Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVK2HnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVK2HnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVK2HnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:43:20 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:56695 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750801AbVK2HnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:43:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=WoaavT9XrTmflubtNiuOrmeZC2l3lu4bh50sN5BGheas0z9jI6oMUJucZ1mSEa0+Ej5cXwG4iPTZo8tejp3Obb2IpVSSZiksfcM+I7QA5++jMIuB0rURsX9iMFfPzH7anKUjZSbP3ujUg2vW7aEN0pE6PRSnU44MFUkF0ru93Iw=  ;
Message-ID: <438C0695.2050808@yahoo.com.au>
Date: Tue, 29 Nov 2005 18:43:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Krufky <mkrufky@m1k.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net>
In-Reply-To: <438C0124.3030700@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------040609060006030504040808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040609060006030504040808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Michael Krufky wrote:

> Unable to handle kernel NULL pointer dereference at virtual address 

> EFLAGS: 00010202   (2.6.15-rc3) EIP is at vm_normal_page+0x17/0x60

> Process gdb (pid: 5628, threadinfo=f488e000 task=f7239a30)

> [<c014a8f5>] get_user_pages+0x29f/0x309

The clues point to the following patch. Can you give it a test
please?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------040609060006030504040808
Content-Type: text/plain;
 name="mm-fix-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-fix-oops.patch"

vm_normal_page can be called with a NULL vma. This can be replaced with
gate_vma, and no problem because none of the gate vmas use VM_PFNMAP
(if they did they would need to set vm_pgoff).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -988,7 +988,8 @@ int get_user_pages(struct task_struct *t
 				return i ? : -EFAULT;
 			}
 			if (pages) {
-				struct page *page = vm_normal_page(vma, start, *pte);
+				struct page *page;
+				page = vm_normal_page(gate_vma, start, *pte);
 				pages[i] = page;
 				if (page)
 					get_page(page);

--------------040609060006030504040808--
Send instant messages to your online friends http://au.messenger.yahoo.com 
