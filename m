Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVBVTzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVBVTzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVBVTzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:55:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:32406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261183AbVBVTz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:55:29 -0500
Date: Tue, 22 Feb 2005 11:55:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: olof@austin.ibm.com (Olof Johansson)
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, jamie@shareable.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-Id: <20050222115503.729cd17b.akpm@osdl.org>
In-Reply-To: <20050222190646.GA7079@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

olof@austin.ibm.com (Olof Johansson) wrote:
>
> Hi,
> 
> Consider a small testcase that spawns off two threads, either thread
> doing a loop of:
> 
> 	buf = mmap /dev/zero MAP_SHARED for 0x100000 bytes
> 	call sys_futex (buf+page, FUTEX_WAIT, 1, NULL, NULL) for each page in said mmap
> 	munmap(buf)
> 	repeat
> 
> This will quickly lock up, since the futex_wait code dows a
> down_read(mmap_sem), then a get_user().
> 
> The do_page_fault code on ppc64 (as well as other architectures) needs
> to take the same semaphore for reading. This is all good until the
> second thread comes into play: Its mmap call tries to take the same
> semaphore for writing which causes in the do_page_fault down_read()
> to get stuck. Classic deadlock.

Yup.  Jamie says that the futex code _has_ to hold mmap_sem across the
get_user().  I forget (but could probably locate) the details.

>
> One attempt to fix this is included below. It works, but I'm not entirely
> happy with the fact that it's a bit messy solution. If anyone has a
> better idea for how to solve it I'd be all ears.

It's fairly sane.  Style-wise I'd be inclined to turn this:

	down_read(&current->mm->mmap_sem);
	while (!check_user_page_readable(current->mm, uaddr1)) {
		up_read(&current->mm->mmap_sem);
		/* Fault in the page through get_user() but discard result */
		if (get_user(curval, (int __user *)uaddr1) != 0)
			return -EFAULT;
		down_read(&current->mm->mmap_sem);
	}

into a standalone helper function.

> --- linux-2.5.orig/mm/mempolicy.c	2005-02-04 00:27:40.000000000 -0600
> +++ linux-2.5/mm/mempolicy.c	2005-02-21 16:43:08.000000000 -0600
> @@ -486,6 +486,7 @@
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	struct mempolicy *pol = current->mempolicy;
> +	DECLARE_BITMAP(nodes, MAX_NUMNODES);
>  
>  	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
>  		return -EINVAL;
> @@ -524,16 +525,21 @@
>  	} else
>  		pval = pol->policy;
>  
> +	if (nmask)
> +		get_zonemask(pol, nodes);
> +
> +	if (vma) {
> +		up_read(&current->mm->mmap_sem);
> +		vma = NULL;
> +	}
> +

OK.

>  	err = -EFAULT;
>  	if (policy && put_user(pval, policy))
>  		goto out;
>  
>  	err = 0;
> -	if (nmask) {
> -		DECLARE_BITMAP(nodes, MAX_NUMNODES);
> -		get_zonemask(pol, nodes);
> +	if (nmask)
>  		err = copy_nodes_to_user(nmask, maxnode, nodes, sizeof(nodes));
> -	}
>  
>   out:
>  	if (vma)

I don't think we need to hold mmap_sem while running get_zonemask().  `pol'
is a copy of current->mempolicy, and it won't be going away.


