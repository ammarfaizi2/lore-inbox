Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWIUGDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWIUGDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWIUGDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:03:41 -0400
Received: from xenotime.net ([66.160.160.81]:35524 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751253AbWIUGDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:03:40 -0400
Date: Wed, 20 Sep 2006 23:04:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 4/4] Blackfin: binfmt patch to enhance stacking checking
Message-Id: <20060920230446.f6b825c6.rdunlap@xenotime.net>
In-Reply-To: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
References: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 11:33:20 +0800 Luke Yang wrote:

> Hi all,

Patch is malformed due to format=flowed.

>  fs/binfmt_elf_fdpic.c       |    7 +-
>  fs/binfmt_flat.c            |  150 ++++++++++++++++++++++++++------------------
>  include/asm-arm/mmu.h       |    1
>  include/asm-frv/mmu.h       |    1
>  include/asm-h8300/mmu.h     |    1
>  include/asm-m32r/mmu.h      |    1
>  include/asm-m68knommu/mmu.h |    1
>  include/asm-sh/mmu.h        |    1
>  include/asm-v850/mmu.h      |    1
>  include/linux/flat.h        |   13 ++-
>  10 files changed, 112 insertions(+), 65 deletions(-)

> diff -urN linux-2.6.18.patch2/fs/binfmt_flat.c
> linux-2.6.18.patch3/fs/binfmt_flat.c
> --- linux-2.6.18.patch2/fs/binfmt_flat.c	2006-09-21 09:37:18.000000000 +0800
> +++ linux-2.6.18.patch3/fs/binfmt_flat.c	2006-09-21 09:52:02.000000000 +0800
> @@ -16,6 +16,7 @@
>   */
> 
>  #include <linux/module.h>
> +#include <linux/config.h>

Don't add config.h at all.

>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>

> @@ -413,7 +416,9 @@
>  /****************************************************************************/
> 
>  static int load_flat_file(struct linux_binprm * bprm,
> -		struct lib_info *libinfo, int id, unsigned long *extra_stack)
> +			  struct lib_info *libinfo, int id,
> +			  unsigned long *extra_stack,
> +			  unsigned long *stack_base)
>  {
>  	struct flat_hdr * hdr;
>  	unsigned long textpos = 0, datapos = 0, result;
> @@ -426,7 +431,6 @@
>  	int i, rev, relocs = 0;
>  	loff_t fpos;
>  	unsigned long start_code, end_code;
> -	int ret;
> 
>  	hdr = ((struct flat_hdr *) bprm->buf);		/* exec-header */
>  	inode = bprm->file->f_dentry->d_inode;
> @@ -451,25 +455,24 @@
>  		 */
>  		if (strncmp(hdr->magic, "#!", 2))
>  			printk("BINFMT_FLAT: bad header magic\n");
> -		ret = -ENOEXEC;
> -		goto err;
> +		return -ENOEXEC;

Some of us actually prefer to have one exit path per function,
not multiple ones.  It can help with debugging...

and it would be Good to describe such a change in the
patch description too, but I'd prefer not to see that
particular change.


>  	}
> -
> +#ifdef DEBUG
> +	flags |= FLAT_FLAG_KTRACE;
> +#endif
>  	if (flags & FLAT_FLAG_KTRACE)
>  		printk("BINFMT_FLAT: Loading file: %s\n", bprm->filename);
> 
>  	if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
>  		printk("BINFMT_FLAT: bad flat file version 0x%x (supported 0x%x and
> 0x%x)\n", rev, FLAT_VERSION, OLD_FLAT_VERSION);
> -		ret = -ENOEXEC;
> -		goto err;
> +		return -ENOEXEC;
>  	}
> -	
> +
>  	/* Don't allow old format executables to use shared libraries */
>  	if (rev == OLD_FLAT_VERSION && id != 0) {
>  		printk("BINFMT_FLAT: shared libraries are not available before rev 0x%x\n",
>  				(int) FLAT_VERSION);
> -		ret = -ENOEXEC;
> -		goto err;
> +		return -ENOEXEC;
>  	}
> 
>  	/*
> @@ -482,8 +485,7 @@
>  #ifndef CONFIG_BINFMT_ZFLAT
>  	if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
>  		printk("Support for ZFLAT executables is not enabled.\n");
> -		ret = -ENOEXEC;
> -		goto err;
> +		return -ENOEXEC;
>  	}
>  #endif
> 
> @@ -495,18 +497,27 @@
>  	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
>  	if (rlim >= RLIM_INFINITY)
>  		rlim = ~0;
> -	if (data_len + bss_len > rlim) {
> -		ret = -ENOMEM;
> -		goto err;
> +	if (data_len + bss_len > rlim)
> +		return -ENOMEM;
> +
> +	if (flags & FLAT_FLAG_L1STK) {
> +		if (stack_base == 0) {
> +			printk ("BINFMT_FLAT: requesting L1 stack for shared library\n");

No space between printk and '('.
Use a printk level, like KERN_DEBUG (or drop this printk call
completely :).

> +			return -ENOEXEC;
> +		}

---
~Randy
