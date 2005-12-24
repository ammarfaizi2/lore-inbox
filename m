Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbVLXIcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbVLXIcd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 03:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbVLXIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 03:32:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422635AbVLXIcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 03:32:32 -0500
Date: Sat, 24 Dec 2005 00:32:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: michael.bishop@APPIQ.com, linux-kernel@vger.kernel.org, hugh@veritas.com,
       nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
In-Reply-To: <20051223.154509.86780332.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512240029581.14098@g5.osdl.org>
References: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
 <20051223.111940.17674086.davem@davemloft.net> <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
 <20051223.154509.86780332.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Dec 2005, David S. Miller wrote:
>
> Something like this patch below.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
> index 646c43f..ac937da 100644
> --- a/drivers/video/sbuslib.c
> +++ b/drivers/video/sbuslib.c
> @@ -46,6 +46,9 @@ int sbusfb_mmap_helper(struct sbus_mmap_
>  	unsigned long off;
>  	int i;
>                                          
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +

Side note - as I explained to Nick the other week, VM_SHARED really means 
"shared _writable_" mapping, so you're now disallowing a shared read-only 
open too.

Which may be fine, of course. Especially if sbusfb always ends up giving a 
writable pfn-mapping. But I wanted to check that that was what you meant 
to do.

To test for MAP_SHARED, either do the is_cow_mapping() thing, or check 
the VM_MAYSHARE bit.

		Linus
