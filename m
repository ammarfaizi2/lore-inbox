Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281620AbRKUGUW>; Wed, 21 Nov 2001 01:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281621AbRKUGUM>; Wed, 21 Nov 2001 01:20:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57963 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281620AbRKUGUD>; Wed, 21 Nov 2001 01:20:03 -0500
To: Linus Torvalds <torvalds@transmeta.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: 2.4.14 + Bug in swap_out.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Nov 2001 23:01:06 -0700
Message-ID: <m1vgg41x3x.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In swap_out we have the following code:

	spin_lock(&mmlist_lock);
	mm = swap_mm;
	while (mm->swap_address == TASK_SIZE || mm == &init_mm) {
		mm->swap_address = 0;
		mm = list_entry(mm->mmlist.next, struct mm_struct, mmlist);
		if (mm == swap_mm)
			goto empty;
		swap_mm = mm;
	}

	/* Make sure the mm doesn't disappear when we drop the lock.. */
	atomic_inc(&mm->mm_users);
	spin_unlock(&mmlist_lock);

	nr_pages = swap_out_mm(mm, nr_pages, &counter, classzone);

	mmput(mm);


And looking in fork.c mmput under with right circumstances becomes.
kmem_cache_free(mm_cachep, (mm)))

So it appears that there is nothing that keeps the mm_struct that
swap_mm points to as being valid. 

I guess the easy fix would be to increment the count on swap_mm,
and then do an mmput we assign something else to the value of swap_mm.  But
I don't know if that is what we want.

Thoughts?

Eric








