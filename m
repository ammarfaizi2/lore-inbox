Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUBCHyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 02:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbUBCHyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 02:54:23 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:7555 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265922AbUBCHyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 02:54:19 -0500
Date: Tue, 03 Feb 2004 16:53:59 +0900 (JST)
Message-Id: <20040203.165359.149824126.nomura@linux.bs1.fc.nec.co.jp>
To: hugh@veritas.com, linux-kernel@vger.kernel.org
Cc: j-nomura@ce.jp.nec.com
Subject: Re: [2.4] heavy-load under swap space shortage
From: j-nomura@ce.jp.nec.com
In-Reply-To: <Pine.LNX.4.44.0402021326170.16097-100000@localhost.localdomain>
References: <20040202.191242.278747628.nomura@linux.bs1.fc.nec.co.jp>
	<Pine.LNX.4.44.0402021326170.16097-100000@localhost.localdomain>
X-Mailer: Mew version 3.3 on XEmacs 21.4.14 (Reasonable Discussion)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for for your comment.

> Your patch just disables freeing mapped pages under memory pressure.

Right.

> You could try the untested patch below to swap_out_vma(), but I don't
> really recommend it: it still skips freeing up a less common category
> of clean pages, just when you'd most like to free them.

Hmm, your patch to swap_out_vma didn't solve the problem.

The main cause of the heavy load seems hard contention on page_table_lock.
The CPUs are virtually seriarized for swap_out_mm with each unfruitful
scannings.

The contention could be avoided by changing the spinlock to trylock.
How about the patch below?
With this change, the scannings become more efficient because they can be
done in parallel.

I'm not sure in this case whether the test for nr_swap_pages is necessary.

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com>

--- linux-2.4.24/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -292,7 +292,11 @@ static inline int swap_out_mm(struct mm_
 	 * Find the proper vm-area after freezing the vma chain 
 	 * and ptes.
 	 */
-	spin_lock(&mm->page_table_lock);
+	if (nr_swap_pages <= 0) {
+		if (!spin_trylock(&mm->page_table_lock))
+			return count; /* avoid contention */
+	} else
+		spin_lock(&mm->page_table_lock);
 	address = mm->swap_address;
 	if (address == TASK_SIZE || swap_mm != mm) {
 		/* We raced: don't count this mm but try again */
