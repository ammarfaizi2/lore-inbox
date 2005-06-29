Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVF2AJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVF2AJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVF2AJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:09:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262250AbVF2AE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:04:58 -0400
Date: Tue, 28 Jun 2005 17:05:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 11/16] IB uverbs: add mthca mmap support
Message-Id: <20050628170553.00a14a29.akpm@osdl.org>
In-Reply-To: <2005628163.gtJFW6uLUrGQteys@cisco.com>
References: <2005628163.o84QGfsM7oMSy0oU@cisco.com>
	<2005628163.gtJFW6uLUrGQteys@cisco.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> Add support for mmap() method to mthca, so that userspace can get
> access to doorbell registers.  This allows userspace to get direct
> access to the HCA for data path operations.
> 
> Each userspace context gets its own copy of the doorbell registers and
> is only allowed to use resources that the kernel has given it access
> to.  In other words, this is safe.
> 
> ...
>  
> +static int mthca_mmap_uar(struct ib_ucontext *context,
> +			  struct vm_area_struct *vma)
> +{
> +	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +		return -EINVAL;
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vma->vm_flags    |= VM_DONTCOPY;
> +
> +	if (remap_pfn_range(vma, vma->vm_start,
> +			    to_mucontext(context)->uar.pfn,
> +			    PAGE_SIZE, vma->vm_page_prot))
> +		return -EAGAIN;
> +
> +	return 0;
> +}

What's the thinking behind the VM_DONTCOPY there?

What's actually being mapped here?  Hardware?  If so, is VM_IO not needed?
