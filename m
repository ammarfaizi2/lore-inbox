Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWEVV4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWEVV4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWEVV4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:56:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751221AbWEVV4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:56:52 -0400
Date: Mon, 22 May 2006 14:56:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid
 context'
Message-Id: <20060522145635.252c71d4.akpm@osdl.org>
In-Reply-To: <20060522065649.5C3E7EE9EE@wolfe.lmc.cs.sunysb.edu>
References: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
	<447119B3.7000506@yahoo.com.au>
	<20060522055852.63940EE9EE@wolfe.lmc.cs.sunysb.edu>
	<4471551B.1070701@yahoo.com.au>
	<447155E5.8060406@yahoo.com.au>
	<20060522065649.5C3E7EE9EE@wolfe.lmc.cs.sunysb.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giridhar Pemmasani <giri@lmc.cs.sunysb.edu> wrote:
>
> diff -Naur linux.orig/include/linux/vmalloc.h linux/include/linux/vmalloc.h
>  --- linux.orig/include/linux/vmalloc.h	2006-05-22 02:45:23.000000000 -0400
>  +++ linux/include/linux/vmalloc.h	2006-05-22 02:45:38.000000000 -0400
>  @@ -3,6 +3,7 @@
>   
>   #include <linux/spinlock.h>
>   #include <asm/page.h>		/* pgprot_t */
>  +#include <linux/gfp.h>
>   
>   /* bits in vm_struct->flags */
>   #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
>  @@ -52,8 +53,15 @@
>   extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
>   extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
>   					unsigned long start, unsigned long end);
>  -extern struct vm_struct *get_vm_area_node(unsigned long size,
>  -					unsigned long flags, int node);
>  +extern struct vm_struct *get_vm_area_node_mask(unsigned long size,
>  +					       unsigned long flags, int node,
>  +					       gfp_t gfp_mask);
>  +static inline struct vm_struct *get_vm_area_node(unsigned long size,
>  +						 unsigned long flags, int node)
>  +{
>  +	return get_vm_area_node_mask(size, flags, node, GFP_KERNEL);
>  +}
>  +
>   extern struct vm_struct *remove_vm_area(void *addr);
>   extern struct vm_struct *__remove_vm_area(void *addr);
>   extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
>  diff -Naur linux.orig/mm/vmalloc.c linux/mm/vmalloc.c
>  --- linux.orig/mm/vmalloc.c	2006-05-19 01:22:00.000000000 -0400
>  +++ linux/mm/vmalloc.c	2006-05-22 02:45:49.000000000 -0400
>  @@ -157,8 +157,9 @@
>   	return err;
>   }
>   
>  -struct vm_struct *__get_vm_area_node(unsigned long size, unsigned long flags,
>  -				unsigned long start, unsigned long end, int node)
>  +static struct vm_struct *__get_vm_area_node(unsigned long size, unsigned long flags,
>  +					    unsigned long start, unsigned long end,
>  +					    int node, gfp_t gfp_mask)
>   {
>   	struct vm_struct **p, *tmp, *area;
>   	unsigned long align = 1;
>  @@ -177,7 +178,7 @@
>   	addr = ALIGN(start, align);
>   	size = PAGE_ALIGN(size);
>   
>  -	area = kmalloc_node(sizeof(*area), GFP_KERNEL, node);
>  +	area = kmalloc_node(sizeof(*area), gfp_mask, node);
>   	if (unlikely(!area))
>   		return NULL;
>   
>  @@ -233,7 +234,7 @@
>   struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
>   				unsigned long start, unsigned long end)
>   {
>  -	return __get_vm_area_node(size, flags, start, end, -1);
>  +	return __get_vm_area_node(size, flags, start, end, -1, GFP_KERNEL);
>   }
>   
>   /**
>  @@ -251,9 +252,11 @@
>   	return __get_vm_area(size, flags, VMALLOC_START, VMALLOC_END);
>   }
>   
>  -struct vm_struct *get_vm_area_node(unsigned long size, unsigned long flags, int node)
>  +struct vm_struct *get_vm_area_node_mask(unsigned long size, unsigned long flags,
>  +					int node, gfp_t gfp_mask)
>   {
>  -	return __get_vm_area_node(size, flags, VMALLOC_START, VMALLOC_END, node);
>  +	return __get_vm_area_node(size, flags, VMALLOC_START, VMALLOC_END, node,
>  +				  gfp_mask);
>   }
>   
>   /* Caller must hold vmlist_lock */
>  @@ -471,7 +474,7 @@
>   	if (!size || (size >> PAGE_SHIFT) > num_physpages)
>   		return NULL;
>   
>  -	area = get_vm_area_node(size, VM_ALLOC, node);
>  +	area = get_vm_area_node_mask(size, VM_ALLOC, node, gfp_mask);
>   	if (!area)
>   		return NULL;
>   

It was wrong for get_vm_area_node() to have assumed that it could use
GFP_KERNEL.

Please just change the top-level API of get_vm_area_node() to take a gfp_t
and don't worry about the get_vm_area_node_mask() thing.

The only callers of get_vm_area_node() are in vmalloc.c anyway.  We could
in fact make it static, but I guess exposing it as an API call makes sense.


