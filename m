Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWIVDQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWIVDQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 23:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWIVDQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 23:16:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932247AbWIVDQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 23:16:16 -0400
Date: Thu, 21 Sep 2006 20:16:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: kmannth@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek goyal <vgoyal@in.ibm.com>,
       dave hansen <haveblue@us.ibm.com>
Subject: Re: [Patch] i386 bootioremap / kexec fix
Message-Id: <20060921201604.2cea5abb.akpm@osdl.org>
In-Reply-To: <1158893685.5657.72.camel@keithlap>
References: <1158893685.5657.72.camel@keithlap>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 19:54:45 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> 
>   With CONFIG_PHYSICAL_START set to a non default values the i386
> boot_ioremap code calculated its pte index wrong and users of
> boot_ioremap have their areas incorrectly mapped  (for me SRAT table not
> mapped during early boot). This patch removes the addr < BOOT_PTE_PTRS
> constraint. 
> 
> Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
> ---
>  boot_ioremap.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff -urN linux-2.6.18-rc6-mm2-orig/arch/i386/mm/boot_ioremap.c
> linux-2.6.17/arch/i386/mm/boot_ioremap.c
> --- linux-2.6.18-rc6-mm2-orig/arch/i386/mm/boot_ioremap.c	2006-09-18
> 01:19:22.000000000 -0700
> +++ linux-2.6.17/arch/i386/mm/boot_ioremap.c	2006-09-18
> 01:23:33.000000000 -0700
> @@ -29,8 +29,11 @@
>   */
>  
>  #define BOOT_PTE_PTRS (PTRS_PER_PTE*2)
> -#define boot_pte_index(address) \
> -	     (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
> +
> +static unsigned long boot_pte_index(unsigned long vaddr) 
> +{
> +	return __pa(vaddr) >> PAGE_SHIFT;
> +}
>  
>  static inline boot_pte_t* boot_vaddr_to_pte(void *address)
>  {

Thanks.  This patch is against 2.6.18-rc6-mm2, yes?  Does it fix a bug which
is only in -mm?  If so, do you know which patch introduced it?  Seems to me
that this is a 2.6.18 fix?

Is this the thing which was causing your NUMA machine to fail?  If so, does
2.6.18 boot OK now?

You have a bit of wordwrapping happening there btw.
