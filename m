Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTDDNgG (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTDDNeQ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:34:16 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:58380 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263530AbTDDN2f (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:28:35 -0500
Date: Fri, 4 Apr 2003 14:40:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>, Paolo Zeppegno <zeppegno.paolo@seat.it>,
       Andi Kleen <ak@muc.de>, lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [rfc][patch] Memory Binding Take 2 (1/1)
Message-ID: <20030404144003.D25147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	Paolo Zeppegno <zeppegno.paolo@seat.it>, Andi Kleen <ak@muc.de>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <3E8BCB96.6090908@us.ibm.com> <3E8BCD21.2050307@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E8BCD21.2050307@us.ibm.com>; from colpatch@us.ibm.com on Wed, Apr 02, 2003 at 09:56:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifndef _LINUX_MBIND_H
> +#define _LINUX_MBIND_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#include <linux/mmzone.h>
> +
> +/* Structure to keep track of memory segment (VMA) bindings */
> +struct binding {
> +	struct zonelist	zonelist;
> +};
> +
> +#endif /* CONFIG_NUMA */
> +#endif /* _LINUX_MBIND_H */

Using CONFIG_ without explicitly including config.h is a bad idea.
But the ifdef is unessecary anyway, no one is hurt by having this
struct defintion in the non-numa case.  Also I wonder how you can have
a copyright on a single trivial struct defintion :)  What about just
moving it to mmzone.h, btw?

> +#include <linux/errno.h>
> +#include <linux/mm.h>
> +#include <linux/mbind.h>
> +#include <asm/string.h>

Use <linux/string.h> instead.

> +	binding = (struct binding *)kmalloc(sizeof(struct binding), GFP_KERNEL);

The cast is superflous.

> +	if (!(vma && vma->vm_file && vma->vm_ops && 
> +		vma->vm_ops->nopage == shmem_nopage)) {
> +		/* This isn't a shm segment.  For now, we bail. */
> +		error = -EINVAL;
> +		goto out;
> +	}

This check is just horrible.  Please describe what kind of mappings
this doesn't work for and why and add a VM_ flag for those that
support memory binding.

>  	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
> +#ifdef CONFIG_NUMA
> +	.binding	= NULL,
> +#endif

You don't need to initialize this at all.

