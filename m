Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWGRKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWGRKfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWGRKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:35:34 -0400
Received: from [216.208.38.107] ([216.208.38.107]:385 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S932139AbWGRKfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:35:33 -0400
Subject: Re: [RFC PATCH 33/33] Add Xen virtual block device driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091958.657332000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091958.657332000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:34:06 +0200
Message-Id: <1153218847.3038.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (blkfront)
> The block device frontend driver allows the kernel to access block
> devices exported exported by a virtual machine containing a physical
> block device driver.

Hi,

as first general comment, I think that some of the memory allocation
GFP_ flags are possibly incorrect; I would expect several places to use
GFP_NOIO rather than GFP_KERNEL, to avoid recursion/deadlocks

> +static void blkif_recover(struct blkfront_info *info)
> +{
> +	int i;
> +	struct blkif_request *req;
> +	struct blk_shadow *copy;
> +	int j;
> +
> +	/* Stage 1: Make a safe copy of the shadow state. */
> +	copy = kmalloc(sizeof(info->shadow), GFP_KERNEL | __GFP_NOFAIL);

like here..

> +	memcpy(copy, info->shadow, sizeof(info->shadow));

and __GFP_NOFAIL is usually horrid; is this because error recovery was
an afterthought, or because it's physically impossible? In addition
__GFP_NOFAIL in a block device driver is... an interesting way to add
OOM deadlocks... have the VM guys looked into this yet?

> +#if 1
> +#define IPRINTK(fmt, args...) \
> +    printk(KERN_INFO "xen_blk: " fmt, ##args)
> +#else
> +#define IPRINTK(fmt, args...) ((void)0)
> +#endif

hmm isn't this a duplication of the pr_debug() and dev_dbg()
infrastructure? Please don't reinvent new ones..




