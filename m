Return-Path: <linux-kernel-owner+w=401wt.eu-S1161324AbWLPSP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbWLPSP1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbWLPSP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:15:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56755 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161324AbWLPSP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:15:26 -0500
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Kyle McMartin <kyle@ubuntu.com>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061214195842.GA14041@athena.road.mcmartin.ca>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	 <1166053317.909.19.camel@praia>
	 <20061214195842.GA14041@athena.road.mcmartin.ca>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 16:15:12 -0200
Message-Id: <1166292912.20055.72.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I posted a patch to Paul this week to fix this, as saw we saw it on
> Ubuntu's powerpc kernel builds.
> 
> Since ppc32 can't do a 64bit comparison on its own it seems, gcc
> will generate a call to a helper function from libgcc. What other
> arches do is link libgcc.a into libs-y, and export the symbol
> they want from it. The build process will discard the rest of the
> .a that is unused. parisc uses this method, for example.
> 
> Gcc targets can provide optimized versions of these helpers in
> assembly, but at least in this case, the generic C version seems
> to be used everywhere. It might be useful to provide kernel local
> copies of these C versions linked __weak or something if the
> arch happens to need them.
> 
> (Not going to sign off or anything, since I've already sent it to
> paulus@ and I don't want it to get merged without his approval...)

Seems to be a good way to solve it.


> ---
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index a00fe72..5b60c05 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -139,6 +139,8 @@ core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
>  
>  drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
>  
> +libs-y				+= `$(CC) -print-libgcc-file-name`
> +
>  # Default to zImage, override when needed
>  defaultimage-y			:= zImage
>  defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
> index 9179f07..dea8384 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -164,6 +164,9 @@ long long __lshrdi3(long long, int);
>  EXPORT_SYMBOL(__ashrdi3);
>  EXPORT_SYMBOL(__ashldi3);
>  EXPORT_SYMBOL(__lshrdi3);
> +
> +extern void __ucmpdi2(void);
> +EXPORT_SYMBOL(__ucmpdi2);
>  #endif
>  
>  EXPORT_SYMBOL(memcpy);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Cheers, 
Mauro.

