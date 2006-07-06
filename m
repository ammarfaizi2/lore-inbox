Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWGFWSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWGFWSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWGFWSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:18:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750912AbWGFWS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:18:29 -0400
Date: Thu, 6 Jul 2006 15:22:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix PCI error token awkward value
Message-Id: <20060706152203.5721d54e.akpm@osdl.org>
In-Reply-To: <20060706220119.GB29526@austin.ibm.com>
References: <20060706220119.GB29526@austin.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas@austin.ibm.com (Linas Vepstas) wrote:
>
> 
> 
> The pci channel state token currently has a poor choice of values;
> there  are two ways of indicating that "everything's OK": 0 and 1.
> This is a bit of a burden.
> 
> If a devce driver wants to check if the pci channel is in a working
> or a disconnected state, the driver writer must perform checks similar
> to
> 
>    if((pdev->error_state != 0) &&
>       (pdev->error_state != pci_channel_io_normal)) {
>          whatever();
>    }
> 
> which is rather akward. The first check is needed because 
> stuct pci_dev is inited to all-zeros. The scond is needed 
> because the error recovery will set the state to 
> pci_channel_io_normal (which is not zero).
> 
> This patch fixes this awkwardness.
> 

eww.

> 
> Index: linux-2.6.17-mm3/include/linux/pci.h
> ===================================================================
> --- linux-2.6.17-mm3.orig/include/linux/pci.h	2006-06-27 11:39:16.000000000 -0500
> +++ linux-2.6.17-mm3/include/linux/pci.h	2006-07-06 15:15:09.000000000 -0500
> @@ -85,7 +85,7 @@ typedef unsigned int __bitwise pci_chann
>  
>  enum pci_channel_state {
>  	/* I/O channel is in normal state */
> -	pci_channel_io_normal = (__force pci_channel_state_t) 1,
> +	pci_channel_io_normal = (__force pci_channel_state_t) 0,
>  
>  	/* I/O to channel is blocked */
>  	pci_channel_io_frozen = (__force pci_channel_state_t) 2,

It needs a comment to prevent people from breaking it in the future, and
to help people who are trying to work out why the heck the kernel is
looking for a particular state in something which hasn't been set to that
state.

Also, it's a bit odd that we've gone and left a hole in the enum space.


Wouldn't it be better to sort out our initialisation so we don't actually
need this memset-equals-pci_channel_io_normal trick?  pci_scan_device()
looks like a good place..
