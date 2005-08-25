Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVHYOWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVHYOWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHYOWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:22:15 -0400
Received: from ns.suse.de ([195.135.220.2]:43919 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965017AbVHYOWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:22:14 -0400
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: process creation time increases linearly with shmem
Date: Thu, 25 Aug 2005 16:22:08 +0200
User-Agent: KMail/1.8
Cc: Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
References: <082520051405.5272.430DD0420003F49F00001498220076139400009A9B9CD3040A029D0A05@comcast.net>
In-Reply-To: <082520051405.5272.430DD0420003F49F00001498220076139400009A9B9CD3040A029D0A05@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508251622.08456.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Would it be worth trying to do something like this?

Maybe. Shouldn't be very hard though - you just need to check if the VMA is 
backed by an object and if yes don't call copy_page_range for it.

I think it just needs (untested) 

Index: linux-2.6.13-rc5-misc/kernel/fork.c
===================================================================
--- linux-2.6.13-rc5-misc.orig/kernel/fork.c
+++ linux-2.6.13-rc5-misc/kernel/fork.c
@@ -265,7 +265,8 @@ static inline int dup_mmap(struct mm_str
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		retval = copy_page_range(mm, current->mm, tmp);
+		if (!file && !is_vm_hugetlb_page(vma))
+			retval = copy_page_range(mm, current->mm, tmp);
 		spin_unlock(&mm->page_table_lock);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)

But I'm not sure it's a good idea in all cases. Would need a lot of 
benchmarking  at least.

-Andi
