Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVAUO3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVAUO3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVAUO3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:29:16 -0500
Received: from news.suse.de ([195.135.220.2]:25019 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262373AbVAUO3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:29:09 -0500
Date: Fri, 21 Jan 2005 15:29:08 +0100
From: Andi Kleen <ak@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix put_user under mmap_sem in sys_get_mempolicy()
Message-ID: <20050121142908.GA3487@wotan.suse.de>
References: <41F116DB.3BA37CEB@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F116DB.3BA37CEB@tv-sign.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 05:51:07PM +0300, Oleg Nesterov wrote:
> Hello.
> 
> sys_get_mempolicy() accesses user memory with mmap_sem held.
> If I understand correctly, this can cause deadlock:
> 
> sys_get_mempolicy:		Another thread, same mm:
> 
> down_read(mmap_sem);
> 				down_write(mmap_sem);
> put_user();
> do_page_fault:
> down_read(mmap_sem);

Hrm. Normal Linux policy seems to ignore this potential
and rare deadlock and using nesting safely (e.g. it's been 
known for a long time for the tasklist rw spinlock, but
nobody really cares and it doesn't seem to be hit by users). 
Do you really think it is likely to happen?
> 
> Compile tested only, I have no NUMA machine.

It's hard to figure out what your patch actually does because
of all the gratious white space changes.

I suppose this simpler patch has the same effect (also untested).


diff -u linux-2.6.11-rc1-bk4/mm/mempolicy.c-o linux-2.6.11-rc1-bk4/mm/mempolicy.c
--- linux-2.6.11-rc1-bk4/mm/mempolicy.c-o	2005-01-14 10:12:27.000000000 +0100
+++ linux-2.6.11-rc1-bk4/mm/mempolicy.c	2005-01-21 15:26:12.000000000 +0100
@@ -485,7 +485,7 @@
 	int err, pval;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct mempolicy *pol = current->mempolicy;
+	struct mempolicy *pol = current->mempolicy, *pol2 = NULL;
 
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
@@ -502,6 +502,10 @@
 			pol = vma->vm_ops->get_policy(vma, addr);
 		else
 			pol = vma->vm_policy;
+		pol2 = mpol_copy(pol);
+		up_read(&mm->mmap_sem);
+		if (IS_ERR(pol2)) 
+			return PTR_ERR(pol2);
 	} else if (addr)
 		return -EINVAL;
 
@@ -536,8 +540,7 @@
 	}
 
  out:
-	if (vma)
-		up_read(&current->mm->mmap_sem);
+	mpol_free(pol2);
 	return err;
 }
 

