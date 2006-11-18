Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755776AbWKRBOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbWKRBOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 20:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756117AbWKRBOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 20:14:32 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:6282 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1755776AbWKRBOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 20:14:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YG0hwCN8ohVy6Laa/NoEgkS5wpIcXGaUjPpSgef4ZzDVZ1M/FNUgdOQ3vTzWOi0Yu64HioD4xgiOj5iW7Dpp1ItzYfnmSKCLdlFJwrTF7fAP7Q9I0358psdbzs4l6u/LjO9/g73yx2Gujf07emYgj6bkDRpc/NjWrY+n0wJ2Vx8=
Message-ID: <aec7e5c30611171714p23c00fdbgea4a1097cfdf4ec0@mail.gmail.com>
Date: Sat, 18 Nov 2006 10:14:31 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH 17/20] x86_64: Remove CONFIG_PHYSICAL_START
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Reloc Kernel List" <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
In-Reply-To: <20061117225628.GR15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061117223432.GA15449@in.ibm.com>
	 <20061117225628.GR15449@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

Sorry for not commenting on an earlier version.

On 11/18/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> I am about to add relocatable kernel support which has essentially
> no cost so there is no point in retaining CONFIG_PHYSICAL_START
> and retaining CONFIG_PHYSICAL_START makes implementation of and
> testing of a relocatable kernel more difficult.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
>
>  arch/x86_64/Kconfig                |   19 -------------------
>  arch/x86_64/boot/compressed/head.S |    6 +++---
>  arch/x86_64/boot/compressed/misc.c |    6 +++---
>  arch/x86_64/defconfig              |    1 -
>  arch/x86_64/kernel/vmlinux.lds.S   |    2 +-
>  arch/x86_64/mm/fault.c             |    4 ++--
>  include/asm-x86_64/page.h          |    2 --
>  7 files changed, 9 insertions(+), 31 deletions(-)

[snip]

> diff -puN arch/x86_64/mm/fault.c~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/mm/fault.c
> --- linux-2.6.19-rc6-reloc/arch/x86_64/mm/fault.c~x86_64-Remove-CONFIG_PHYSICAL_START   2006-11-17 00:12:50.000000000 -0500
> +++ linux-2.6.19-rc6-reloc-root/arch/x86_64/mm/fault.c  2006-11-17 00:12:50.000000000 -0500
> @@ -644,9 +644,9 @@ void vmalloc_sync_all(void)
>                         start = address + PGDIR_SIZE;
>         }
>         /* Check that there is no need to do the same for the modules area. */
> -       BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
> +       BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL_map));
>         BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
> -                               (__START_KERNEL & PGDIR_MASK)));
> +                               (__START_KERNEL_map & PGDIR_MASK)));
>  }

This code looks either like a bugfix or a bug. If it's a fix then
maybe it should be broken out and submitted separately for the
rc-kernels?

> diff -puN include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START include/asm-x86_64/page.h
> --- linux-2.6.19-rc6-reloc/include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START        2006-11-17 00:12:50.000000000 -0500
> +++ linux-2.6.19-rc6-reloc-root/include/asm-x86_64/page.h       2006-11-17 00:12:50.000000000 -0500
> @@ -75,8 +75,6 @@ typedef struct { unsigned long pgprot; }
>
>  #endif /* !__ASSEMBLY__ */
>
> -#define __PHYSICAL_START       _AC(CONFIG_PHYSICAL_START,UL)
> -#define __START_KERNEL         (__START_KERNEL_map + __PHYSICAL_START)
>  #define __START_KERNEL_map     _AC(0xffffffff80000000,UL)
>  #define __PAGE_OFFSET           _AC(0xffff810000000000,UL)

I understand that you want to remove the Kconfig option
CONFIG_PHYSICAL_START and that is fine with me. I don't however like
the idea of replacing __PHYSICAL_START and __START_KERNEL with
hardcoded values. Is there any special reason behind this?

The code in page.h already has constants for __START_KERNEL_map and
__PAGE_OFFSET (thank god) and none of them are adjustable via Kconfig.
Why not change as little as possible and keep __PHYSICAL_START and
__START_KERNEL in page.h and the places that use them but remove
references to CONFIG_PHYSICAL_START in Kconfig, defconfig, and page.h?

/ magnus
