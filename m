Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753224AbWKFWEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbWKFWEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbWKFWEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:04:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753224AbWKFWEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:04:53 -0500
Date: Mon, 6 Nov 2006 14:04:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Greg KH" <gregkh@suse.de>, "Andi Kleen" <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Message-Id: <20061106140432.44d3c19f.akpm@osdl.org>
In-Reply-To: <86802c440611032127u33442a33ufc4cf3b11e9b8c7a@mail.gmail.com>
References: <86802c440611032127u33442a33ufc4cf3b11e9b8c7a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 21:27:35 -0800
"Yinghai Lu" <yinghai.lu@amd.com> wrote:

> 	For co-prcessor with mem installed, the ram will be treated to pref mem.	

What is "pref mem"?

> 	Under 64bit kernel, when 64bit pref mem size is above 4G, sz from pci_size in low bits, will get 0, 
> 	at this point, we need to check szhi too. Otherwise the pre-set value by firmware can not be read 
> 	to resrource struct, it will skip that resource, and try to hi 32 bit as another 32bit resource.
> 
> 	Cc: Myles Watson <myles@mouselemur.cs.byu.edu>
> 	Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>	
> 
> 
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -165,8 +165,13 @@ static void pci_read_bases(struct pci_de
>  			l = 0;
>  		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
>  			sz = pci_size(l, sz, (u32)PCI_BASE_ADDRESS_MEM_MASK);
> -			if (!sz)
> -				continue;
> +			/* for 64bit pref, sz could be 0, if the real size is bigger than 4G,
> +				so need to check szhi for it
> +			 */
> +			if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
> +			    != (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) 
> +				if (!sz)
> +					continue;
>  			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
>  			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
>  		} else {
> @@ -188,6 +193,12 @@ static void pci_read_bases(struct pci_de
>  			szhi = pci_size(lhi, szhi, 0xffffffff);
>  			next++;
>  #if BITS_PER_LONG == 64
> +			if( !sz && !szhi) {
> +				res->start = 0;
> +				res->end = 0;
> +				res->flags = 0;
> +				continue;
> +			}
>  			res->start |= ((unsigned long) lhi) << 32;
>  			res->end = res->start + sz;
>  			if (szhi) {

I don't really understand what this patch does.

We have a PCI device with a 64-bit BAR and the size is also 64-bit and is
larger than 4G, yes?

But the code appears to already be attempting to handle such devices. 
Confused.

