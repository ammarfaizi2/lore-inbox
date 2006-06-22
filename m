Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWFVF5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWFVF5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 01:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWFVF5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 01:57:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750806AbWFVF5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 01:57:04 -0400
Date: Wed, 21 Jun 2006 22:56:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       dhowells@redhat.com, a.p.zijlstra@chello.nl, christoph@lameter.com,
       mbligh@google.com, npiggin@suse.de, torvalds@osdl.org
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
Message-Id: <20060621225639.4c8bad93.akpm@osdl.org>
In-Reply-To: <20060619175253.24655.96323.sendpatchset@lappy>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	<20060619175253.24655.96323.sendpatchset@lappy>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 19:52:53 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

Could we have a changelog for this patch?  A list of
what-i-changed-since-last-time bullet points is uninteresting and unuseful
for the permanent record.  Think in terms of some random person in
Barcelona who is trying to work upon your code two years hence.

The patch should be accompanied by a standalone description of what it
does, why it does it and how it does it, thanks.


> Index: 2.6-mm/include/linux/mm.h
> ===================================================================
> --- 2.6-mm.orig/include/linux/mm.h	2006-06-14 10:29:04.000000000 +0200
> +++ 2.6-mm/include/linux/mm.h	2006-06-19 14:45:18.000000000 +0200
> @@ -182,6 +182,12 @@ extern unsigned int kobjsize(const void 
>  #define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
>  #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
>  
> +static inline int is_shared_writable(unsigned int flags)
> +{
> +	return (flags & (VM_SHARED|VM_WRITE|VM_PFNMAP)) ==
> +		(VM_SHARED|VM_WRITE);
> +}

Need a comment: what's VM_PFNMAP doing in there.

>  
> -	if (unlikely(vma->vm_flags & VM_SHARED)) {
> +	if (unlikely(is_shared_writable(vma->vm_flags))) {

See, this is an incompatible change.  We used to have

	if (unlikely((vma->vm_flags & (VM_SHARED|VM_WRITE)) ==
			(VM_SHARED|VM_WRITE))) {

in there, only now it has secretly started looking at VM_PFNMAP.


> +		vma->vm_page_prot =
> +			__pgprot(pte_val
> +				(pte_wrprotect
> +				 (__pte(pgprot_val(vma->vm_page_prot)))));
> +

Is there really no simpler way?

> ===================================================================
> --- 2.6-mm.orig/fs/buffer.c	2006-06-14 10:28:52.000000000 +0200
> +++ 2.6-mm/fs/buffer.c	2006-06-19 14:45:18.000000000 +0200
> @@ -2985,6 +2985,7 @@ int try_to_free_buffers(struct page *pag
>  
>  	spin_lock(&mapping->private_lock);
>  	ret = drop_buffers(page, &buffers_to_free);
> +	spin_unlock(&mapping->private_lock);
>  	if (ret) {
>  		/*
>  		 * If the filesystem writes its buffers by hand (eg ext3)
> @@ -2996,7 +2997,6 @@ int try_to_free_buffers(struct page *pag
>  		 */
>  		clear_page_dirty(page);
>  	}
> -	spin_unlock(&mapping->private_lock);
>  out:
>  	if (buffers_to_free) {
>  		struct buffer_head *bh = buffers_to_free;

Needs changelogging, please.


Performance testing is critical here.  I think some was done, but I don't
reall what tests were performed, nor do I remember the results.  Without such
info it's not possible to make a go/no-go decision.


