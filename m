Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUG3RSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUG3RSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUG3RSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:18:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267749AbUG3RQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:16:44 -0400
Message-ID: <410A826C.4000508@pobox.com>
Date: Fri, 30 Jul 2004 13:16:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive kernels
References: <20040730190227.29913e23.ak@suse.de>
In-Reply-To: <20040730190227.29913e23.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> This is a minor optimization for the pci_alloc_consistent wrapper for
> the generic dma API. When the kernel is compiled preemptive the caller
> can decide if the allocation needs to be GFP_KERNEL or GFP_ATOMIC.
[...]
> +/* Would be better to move this out of line. It's already quite big. */
>  static inline void *
>  pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
>  		     dma_addr_t *dma_handle)
>  {
> -	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
> +	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, preempt_atomic() ? GFP_ATOMIC : GFP_KERNEL);
>  }


I do agree with the patch, but I have two worries:

1) Changing from GFP_ATOMIC to <something else> may break code
2) Conversely from #1, I also worry why GFP_ATOMIC would be needed at 
all.  I code all my drivers to require that pci_alloc_consistent() be 
called from somewhere that is allowed to sleep.

	Jeff


