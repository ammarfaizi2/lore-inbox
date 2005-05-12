Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVELIAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVELIAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVELIAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:00:45 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:44108 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261300AbVELIAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:00:24 -0400
Message-ID: <42830D0A.3090109@sw.ru>
Date: Thu, 12 May 2005 12:00:10 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm acct accounting fix
References: <428223E0.2070200@sw.ru> <Pine.LNX.4.61.0505111701110.7331@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0505111701110.7331@goblin.wat.veritas.com>
Content-Type: multipart/mixed;
 boundary="------------050302030301090706040908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050302030301090706040908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>>Sorry, forgot to write that all these patches are against 2.6.12-rc4...
>>
>>This patch fixes mm->total_vm and mm->locked_vm acctounting in case
>>when move_page_tables() fails inside move_vma().
>>
>>Signed-Off-By: Kirill Korotaev <dev@sw.ru>
>>
>>--- ./mm/mremap.c.mmacct	2005-05-10 16:10:40.000000000 +0400
>>+++ ./mm/mremap.c	2005-05-10 18:12:13.000000000 +0400
>>@@ -213,6 +213,7 @@ static unsigned long move_vma(struct vm_
>> 		old_len = new_len;
>> 		old_addr = new_addr;
>> 		new_addr = -ENOMEM;
>>+		new_len = 0;
>> 	}
>> 
>> 	/* Conceal VM_ACCOUNT so old reservation is not undone */
> 
> 
> Are you sure?
> 
> The way it's supposed to work is that the do_munmap(,,old_len) which
> follows, which normally unmaps the area moved from, when unsuccessful
> unmaps the area moved to: which will "mistakenly" decrement total_vm etc.
> by old_len, which needs to be bumped back up by that amount before leaving.

Yup, I was wrong. Sorry for taking your time.
It would be nice to accept this small patch with a comment.

Kirill


--------------050302030301090706040908
Content-Type: text/plain;
 name="diff-mainstream-mmacct-20050512"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-mainstream-mmacct-20050512"

--- ./mm/mremap.c.mmacct	2005-05-10 16:10:40.000000000 +0400
+++ ./mm/mremap.c	2005-05-12 11:56:17.000000000 +0400
@@ -224,6 +224,12 @@ static unsigned long move_vma(struct vm_
 			split = 1;
 	}
 
+	/*
+	 * if we failed to move page tables we still do total_vm increment
+	 * since do_munmap() will decrement it by old_len == new_len
+	 */
+	mm->total_vm += new_len >> PAGE_SHIFT;
+
 	if (do_munmap(mm, old_addr, old_len) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_unacct_memory(excess >> PAGE_SHIFT);
@@ -237,7 +243,6 @@ static unsigned long move_vma(struct vm_
 			vma->vm_next->vm_flags |= VM_ACCOUNT;
 	}
 
-	mm->total_vm += new_len >> PAGE_SHIFT;
 	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;

--------------050302030301090706040908--

