Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVAUO61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVAUO61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVAUO61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:58:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:12006 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262381AbVAUO6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:58:20 -0500
Message-ID: <41F12773.AAC62D5C@tv-sign.ru>
Date: Fri, 21 Jan 2005 19:01:55 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix put_user under mmap_sem in sys_get_mempolicy()
References: <41F116DB.3BA37CEB@tv-sign.ru> <20050121142908.GA3487@wotan.suse.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>
> I suppose this simpler patch has the same effect (also untested).
>
> 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
> 		return -EINVAL;
>@@ -502,6 +502,10 @@
> 			pol = vma->vm_ops->get_policy(vma, addr);
> 		else
> 			pol = vma->vm_policy;
>+		pol2 = mpol_copy(pol);
>+		up_read(&mm->mmap_sem);
>+		if (IS_ERR(pol2)) 
>+			return PTR_ERR(pol2);
>

I don't think so. With MPOL_F_ADDR|MPOL_F_NODE sys_get_mempolicy
calls lookup_node()->get_user_pages() few lines below, so we can't
up_read(&mm->mmap_sem) here.

> It's hard to figure out what your patch actually does because
> of all the gratious white space changes.

For your convenience here is the code with the patch applied.

	if (flags & MPOL_F_ADDR) {
		struct mm_struct *mm = current->mm;
		struct vm_area_struct *vma;

		err = 0;
		down_read(&mm->mmap_sem);
		vma = find_vma_intersection(mm, addr, addr+1);
		if (!vma)
			err = -EFAULT;
		else {
			if (vma->vm_ops && vma->vm_ops->get_policy)
				pol = vma->vm_ops->get_policy(vma, addr);
			else
				pol = vma->vm_policy;

			if (flags & MPOL_F_NODE) {
				pval = lookup_node(mm, addr);
				if (pval < 0)
					err = pval;
			}
		}
		up_read(&mm->mmap_sem);
		if (err)
			goto out;
	} else if (addr)
		return -EINVAL;

	if (!pol)
		pol = &default_policy;

	if (flags & MPOL_F_NODE) {
		if (!(flags & MPOL_F_ADDR)) {
			if (pol == current->mempolicy &&
					pol->policy == MPOL_INTERLEAVE) {
				pval = current->il_next;
			} else {
				err = -EINVAL;
				goto out;
			}
		}
	} else
		pval = pol->policy;
