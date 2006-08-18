Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWHRUwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWHRUwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWHRUwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:52:46 -0400
Received: from xenotime.net ([66.160.160.81]:42674 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932337AbWHRUwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:52:44 -0400
Date: Fri, 18 Aug 2006 13:55:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 1/8] mprotect patch for use by SLIM
Message-Id: <20060818135539.8670fd26.rdunlap@xenotime.net>
In-Reply-To: <1155844385.6788.55.camel@localhost.localdomain>
References: <1155844385.6788.55.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 12:53:05 -0700 Kylene Jo Hall wrote:

> This small patch makes mprotect available for use by SLIM for
> write revocation.

A symbol doesn't need to be exported for use by built-in code
(as opposed to loadable modules).  Since 'slim' cannot be built
as a loadable module, "do_protect" just needs not to be
static.  The EXPORT isn't needed.


> Updated to allow the usage locking to work properly.
> 
> Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> ---
>  include/linux/mm.h |    2 ++
>  mm/mprotect.c      |   23 +++++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.18-rc3/mm/mprotect.c	2006-07-30
> 01:15:36.000000000 -0500 +++
> linux-2.6.18-rc3-working/mm/mprotect.c	2006-08-07
> 13:11:07.000000000 -0500 @@ -19,6 +19,7 @@
>  #include <linux/mempolicy.h>
>  #include <linux/personality.h>
>  #include <linux/syscalls.h>
> +#include <linux/module.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <asm/uaccess.h>
> @@ -202,9 +203,10 @@ fail:
>  	vm_unacct_memory(charged);
>  	return error;
>  }
> -
> -asmlinkage long
> -sys_mprotect(unsigned long start, size_t len, unsigned long prot)
> +/* 
> + * Call holding the current->mm->mmap_sem for writing
> + */
> +int do_mprotect(unsigned long start, size_t len, unsigned long
> prot) {
>  	unsigned long vm_flags, nstart, end, tmp, reqprot;
>  	struct vm_area_struct *vma, *prev;
> @@ -234,8 +236,6 @@ sys_mprotect(unsigned long start, size_t
>  
>  	vm_flags = calc_vm_prot_bits(prot);
>  
> -	down_write(&current->mm->mmap_sem);
> -
>  	vma = find_vma_prev(current->mm, start, &prev);
>  	error = -ENOMEM;
>  	if (!vma)
> @@ -298,6 +298,17 @@ sys_mprotect(unsigned long start, size_t
>  		}
>  	}
>  out:
> -	up_write(&current->mm->mmap_sem);
>  	return error;
>  }
> +EXPORT_SYMBOL_GPL(do_mprotect);
> +
> +asmlinkage long
> +sys_mprotect(unsigned long start, size_t len, unsigned long prot)
> +{
> +	int ret;
> +
> +	down_write(&current->mm->mmap_sem);
> +	ret = do_mprotect(start, len, prot);
> +	up_write(&current->mm->mmap_sem);
> +	return ret;
> +}
> --- linux-2.6.18-rc3/include/linux/mm.h	2006-07-30
> 01:15:36.000000000 -0500 +++
> linux-2.6.18-rc3-working/include/linux/mm.h	2006-08-01
> 12:18:13.000000000 -0500 @@ -137,6 +137,8 @@ extern unsigned int
> kobjsize(const void 
>  #define VM_EXEC		0x00000004
>  #define VM_SHARED	0x00000008
>  
> +extern int do_mprotect(unsigned long start, size_t len, unsigned
> long prot); +
>  /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for
> r/w/x bits. */
>  #define VM_MAYREAD	0x00000010	/* limits for mprotect
>  #() etc */ define VM_MAYWRITE	0x00000020
> 
> 
> -

---
~Randy
