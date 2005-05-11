Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVEKPaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVEKPaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEKP3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:29:33 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:5180 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261180AbVEKP2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:28:19 -0400
Message-ID: <4282248F.3070206@sw.ru>
Date: Wed, 11 May 2005 19:28:15 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] do_swap_page() can map random data if swap read fails
Content-Type: multipart/mixed;
 boundary="------------010308080100070909090009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010308080100070909090009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

against 2.6.12-rc4

There is a bug in do_swap_page(): when swap page happens to be 
unreadable, page filled with random data is mapped into user
address space.
The fix is to check for PageUptodate and send SIGBUS in case of error.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>
Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

--------------010308080100070909090009
Content-Type: text/plain;
 name="diff-mainstream-swaperrs-20050429"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-mainstream-swaperrs-20050429"

--- ./mm/memory.c.swaperr	2005-05-10 16:10:40.000000000 +0400
+++ ./mm/memory.c	2005-05-10 18:09:12.000000000 +0400
@@ -1701,12 +1701,13 @@ static int do_swap_page(struct mm_struct
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (unlikely(!pte_same(*page_table, orig_pte))) {
-		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
-		unlock_page(page);
-		page_cache_release(page);
 		ret = VM_FAULT_MINOR;
-		goto out;
+		goto out_nomap;
+	}
+
+	if (unlikely(!PageUptodate(page))) {
+		ret = VM_FAULT_SIGBUS;
+		goto out_nomap;
 	}
 
 	/* The page isn't present yet, go ahead with the fault. */
@@ -1741,6 +1742,12 @@ static int do_swap_page(struct mm_struct
 	spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
+out_nomap:
+	pte_unmap(page_table);
+	spin_unlock(&mm->page_table_lock);
+	unlock_page(page);
+	page_cache_release(page);
+	goto out;
 }
 
 /*

--------------010308080100070909090009--

