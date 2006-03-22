Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWCVR2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWCVR2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWCVR2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:28:15 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15312 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751043AbWCVR2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:28:15 -0500
Message-ID: <44218916.3030607@us.ibm.com>
Date: Wed, 22 Mar 2006 11:27:50 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 09/35] Change __FIXADDR_TOP to leave room for the
 hypervisor.
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063747.636585000@sorel.sous-sol.org>
In-Reply-To: <20060322063747.636585000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> Move the definition of __FIXADDR_TOP into a subarch include file so
> that it can be overridden for subarch xen -- the hypervisor needs
> about 64MB at the top of the address space.
>   

I think this is more generally useful if it's actually a CONFIG option 
(as it was in the VMI patches) instead of subarch specific.  Qemu has 
had a "fast" patch for a while that pretty much just increases the size 
of the memory hole and changes ___PAGE_OFFSET to be lower in memory.   
There are a number of interesting things one can do once there's an 
adequately sized hole too (assuming you're doing full-virtualization).

Regards,

Anthony Liguori

> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  include/asm-i386/fixmap.h                   |    8 +-------
>  include/asm-i386/mach-default/mach_fixmap.h |   11 +++++++++++
>  include/asm-i386/mach-xen/mach_fixmap.h     |   11 +++++++++++
>  3 files changed, 23 insertions(+), 7 deletions(-)
>
> --- xen-subarch-2.6.orig/include/asm-i386/fixmap.h
> +++ xen-subarch-2.6/include/asm-i386/fixmap.h
> @@ -14,13 +14,7 @@
>  #define _ASM_FIXMAP_H
>  
>  #include <linux/config.h>
> -
> -/* used by vmalloc.c, vsyscall.lds.S.
> - *
> - * Leave one empty page between vmalloc'ed areas and
> - * the start of the fixmap.
> - */
> -#define __FIXADDR_TOP	0xfffff000
> +#include <mach_fixmap.h>
>  
>  #ifndef __ASSEMBLY__
>  #include <linux/kernel.h>
> --- /dev/null
> +++ xen-subarch-2.6/include/asm-i386/mach-default/mach_fixmap.h
> @@ -0,0 +1,11 @@
> +#ifndef __ASM_MACH_FIXMAP_H
> +#define __ASM_MACH_FIXMAP_H
> +
> +/* used by vmalloc.c, vsyscall.lds.S.
> + *
> + * Leave one empty page between vmalloc'ed areas and
> + * the start of the fixmap.
> + */
> +#define __FIXADDR_TOP	0xfffff000
> +
> +#endif /* __ASM_MACH_FIXMAP_H */
> --- /dev/null
> +++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_fixmap.h
> @@ -0,0 +1,11 @@
> +#ifndef __ASM_MACH_FIXMAP_H
> +#define __ASM_MACH_FIXMAP_H
> +
> +/* used by vmalloc.c, vsyscall.lds.S.
> + *
> + * Leave one empty page between vmalloc'ed areas and
> + * the start of the fixmap.
> + */
> +#define __FIXADDR_TOP	(HYPERVISOR_VIRT_START - 2 * PAGE_SIZE)
> +
> +#endif /* __ASM_MACH_FIXMAP_H */
>
> --
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/virtualization
>   

