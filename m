Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWHaUJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWHaUJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWHaUJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:09:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750775AbWHaUJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:09:36 -0400
Date: Thu, 31 Aug 2006 13:08:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Erik Habbinga" <erikhabbinga@inphase-tech.com>
Cc: <eric.moore@lsil.com>, <james.bottomley@steeleye.com>,
       <trivial@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] SCSI: improve endian handling in LSI fusion
 firmware mpt_downloadboot
Message-Id: <20060831130849.0d0f9e18.akpm@osdl.org>
In-Reply-To: <000b01c6cc5a$52cedf10$2018010a@inphasetech.com>
References: <000b01c6cc5a$52cedf10$2018010a@inphasetech.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 11:32:47 -0600
"Erik Habbinga" <erikhabbinga@inphase-tech.com> wrote:

> The mpt_downloadboot function in drivers/message/fusion/mptbase.c doesn't work correctly on big endian systems (powerpc in my case).
> I've added appropriate le32_to_cpu calls to correctly translate little endian firmware file data into cpu endian format before
> getting written to little endian PCI registers.  This patch has been tested successfully on a powerpc target and an Intel target.
> 
> Signed-off-by: Erik Habbinga <erikhabbinga@inphase-tech.com>
> 
> --- a/drivers/message/fusion/mptbase.c.orig	2006-08-23 15:16:33.000000000 -0600
> +++ b/drivers/message/fusion/mptbase.c	2006-08-30 10:28:39.000000000 -0600
> @@ -2915,7 +2915,7 @@
>  	u32 			 ioc_state=0;
>  
>  	ddlprintk((MYIOC_s_INFO_FMT "downloadboot: fw size 0x%x (%d), FW Ptr %p\n",
> -				ioc->name, pFwHeader->ImageSize, pFwHeader->ImageSize, pFwHeader));
> +				ioc->name, le32_to_cpu(pFwHeader->ImageSize), le32_to_cpu(pFwHeader->ImageSize), pFwHeader));
>  
>  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
>  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
> @@ -2968,7 +2968,7 @@
>  	/* Set the DiagRwEn and Disable ARM bits */
>  	CHIPREG_WRITE32(&ioc->chip->Diagnostic, (MPI_DIAG_RW_ENABLE | MPI_DIAG_DISABLE_ARM));
>  
> -	fwSize = (pFwHeader->ImageSize + 3)/4;
> +	fwSize = (le32_to_cpu(pFwHeader->ImageSize) + 3)/4;
>  	ptrFw = (u32 *) pFwHeader;
>  
>  	/* Write the LoadStartAddress to the DiagRw Address Register
> @@ -2977,23 +2977,23 @@
>  	if (ioc->errata_flag_1064)
>  		pci_enable_io_access(ioc->pcidev);
>  
> -	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, pFwHeader->LoadStartAddress);
> +	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, le32_to_cpu(pFwHeader->LoadStartAddress));
>  	ddlprintk((MYIOC_s_INFO_FMT "LoadStart addr written 0x%x \n",
> -		ioc->name, pFwHeader->LoadStartAddress));
> +		ioc->name, le32_to_cpu(pFwHeader->LoadStartAddress)));
>  
>  	ddlprintk((MYIOC_s_INFO_FMT "Write FW Image: 0x%x bytes @ %p\n",
>  				ioc->name, fwSize*4, ptrFw));
>  	while (fwSize--) {
> -		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, *ptrFw++);
> +		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, le32_to_cpu(*ptrFw++));

hm, I'd be a bit more comfortable if this didn't require that le32_to_cpu()
was sanely implemented.   include/linux/byteorder/swab.h has

#  define __swab32(x) \
(__builtin_constant_p((__u32)(x)) ? \
 ___swab32((x)) : \
 __fswab32((x)))

so if `x' is foo++, what value does `foo' end up with?  I guess it would be
pretty dumb if __builtin_constant_p(foo++) were to increment foo, but is
that guaranteed?

Anyway.  This is a moderately important fix, isn't it?  Eric (Moore), do
you want to proceed with this patch?

Thanks.

