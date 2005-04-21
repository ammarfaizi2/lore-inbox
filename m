Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVDUAhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVDUAhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 20:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVDUAhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 20:37:24 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:11681 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261852AbVDUAhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 20:37:15 -0400
Subject: [PATCH][MTHCA] fix sparc build WAS: Re: [openib-general]
	[PATCH][RFC][3/4] IB: userspace verbs mthca changes
From: Tom Duffy <tduffy@sun.com>
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <200544159.AzH1nqpM3uTQZaKG@topspin.com>
References: <200544159.AzH1nqpM3uTQZaKG@topspin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Apr 2005 17:37:11 -0700
Message-Id: <1114043831.18198.17.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 15:09 -0700, Roland Dreier wrote:
> @@ -574,6 +836,22 @@
>         return 0;
>  }
>  
> +static int mthca_mmap_uar(struct ib_ucontext *context,
> +                         struct vm_area_struct *vma)
> +{
> +       if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +               return -EINVAL;
> +
> +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +       if (remap_pfn_range(vma, vma->vm_start,
> +                           to_mucontext(context)->uar.pfn,
> +                           PAGE_SIZE, vma->vm_page_prot))
> +               return -EAGAIN;
> +
> +       return 0;
> +}
> +

This breaks building on sparc64:

  CC [M]  drivers/infiniband/hw/mthca/mthca_provider.o
/build1/tduffy/openib-work/linux-2.6.11-openib/drivers/infiniband/hw/mthca/mthca_provider.c: In function `mthca_mmap_uar':
/build1/tduffy/openib-work/linux-2.6.11-openib/drivers/infiniband/hw/mthca/mthca_provider.c:352: warning: implicit declaration of function `pgprot_noncached'
/build1/tduffy/openib-work/linux-2.6.11-openib/drivers/infiniband/hw/mthca/mthca_provider.c:352: error: incompatible types in assignment
make[3]: *** [drivers/infiniband/hw/mthca/mthca_provider.o] Error 1
make[2]: *** [drivers/infiniband/hw/mthca] Error 2
make[1]: *** [_module_drivers/infiniband] Error 2
make: *** [_all] Error 2

This is ugly, but fixes the build.  Perhaps sparc needs
pgprot_noncached() to be a noop?

Signed-off-by: Tom Duffy <tduffy@sun.com>

Index: linux-2.6.11-openib/drivers/infiniband/hw/mthca/mthca_provider.c
===================================================================
--- linux-2.6.11-openib/drivers/infiniband/hw/mthca/mthca_provider.c	(revision 2202)
+++ linux-2.6.11-openib/drivers/infiniband/hw/mthca/mthca_provider.c	(working copy)
@@ -349,7 +349,9 @@ static int mthca_mmap_uar(struct ib_ucon
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+#ifdef pgprot_noncached
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+#endif
 
 	if (remap_pfn_range(vma, vma->vm_start,
 			    to_mucontext(context)->uar.pfn,

