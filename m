Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVLNXOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVLNXOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVLNXOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:14:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965060AbVLNXOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:14:50 -0500
Date: Wed, 14 Dec 2005 15:16:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: hawkes@sgi.com
Cc: tony.luck@gmail.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com, kaos@sgi.com,
       hawkes@sgi.com
Subject: Re: [PATCH] ia64: eliminate softlockup warning
Message-Id: <20051214151613.2afc35b2.akpm@osdl.org>
In-Reply-To: <20051214230713.7528.68477.sendpatchset@tomahawk.engr.sgi.com>
References: <20051214230713.7528.68477.sendpatchset@tomahawk.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hawkes@sgi.com wrote:
>
> Fix an unnecessary softlockup watchdog warning in the ia64
> uncached_build_memmap() that occurs occasionally at 256p and always at
> 512p.  The problem occurs at boot time.
> 
> It would be good if we had a cleaner mechanism to temporarily silence
> the watchdog thread, e.g.,
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=111552476401175&w=2
> but until that patch gets merged, this fix will have to suffice.
> 

That patch is for the hangcheck timer driver which is unrelated to the
softlockup detector.

> 
> Index: linux/arch/ia64/kernel/uncached.c
> ===================================================================
> --- linux.orig/arch/ia64/kernel/uncached.c	2005-12-06 15:12:14.000000000 -0800
> +++ linux/arch/ia64/kernel/uncached.c	2005-12-14 14:50:55.000000000 -0800
> @@ -210,6 +210,7 @@
>  
>  	dprintk(KERN_ERR "uncached_build_memmap(%lx %lx)\n", start, end);
>  
> +	touch_softlockup_watchdog();
>  	memset((char *)start, 0, length);
>  
>  	node = paddr_to_nid(start - __IA64_UNCACHED_OFFSET);

Yes, additions like this are a bit awkward, but they're not _that_ bad.  It
says "this code is doing something unusual".  It's an explicit marker which
we can grep for and which conveys useful information about an exceptional
kernel state.
