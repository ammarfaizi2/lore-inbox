Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVGRSVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVGRSVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVGRSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 14:21:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34697 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261447AbVGRSVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 14:21:49 -0400
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [RFC/PATCH 1/17][kexec-tools-1.101] vmlinux
 parameter segment stomping fix
References: <1112016353.4001.72.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 18 Jul 2005 12:21:12 -0600
In-Reply-To: <1112016353.4001.72.camel@localhost.localdomain> (Vivek Goyal's
 message of "Mon, 28 Mar 2005 18:55:53 +0530")
Message-ID: <m13bqcht5z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My apologies for taking so long to look at these patches.

I agree there is an issue here, but large parts of this
we need to address kernel side.  If the parameter buffer is allocated
after the kernel there is no guarantee that it will be addressable
from the kernels early page table so this fix will not work.
As for the practical problem it addresses it looks like we simply
need to increase the size of the kernel's bss segment so we don't
stop things.

Problem agreed upon patch rejected.

Eric

Vivek Goyal <vgoyal@in.ibm.com> writes:

> During loading of panic kernel(vmlinux), it was found that on some systems,
> parameter segment was being stomped over by kernel. This was resulting in 
> corruption of e820 memory map and leading to boot memory allocator
> initialization failures while booting into new kernel. This patch fixes the
> problem by loading the parameter segment beyond alrady loaded kernel image
> and setup code. A 64K buffer has been provided to avoid any stomping by
> kernel.

>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
>
>  kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
>
> diff -puN kexec/arch/i386/kexec-elf-x86.c~kexec-tools-vmlinux-parameter-segment-stomping-fix kexec/arch/i386/kexec-elf-x86.c
> --- kexec-tools-1.101/kexec/arch/i386/kexec-elf-x86.c~kexec-tools-vmlinux-parameter-segment-stomping-fix	2005-03-21 16:43:50.000000000 +0530
> +++ kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c	2005-03-21 16:43:50.000000000 +0530
> @@ -199,15 +199,27 @@ int elf_x86_load(int argc, char **argv, 
>  	}
>  	else if (arg_style == ARG_STYLE_LINUX) {
>  		struct x86_linux_faked_param_header *hdr;
> -		unsigned long param_base;
> +		unsigned long param_base, min_param_base = 0;
>  		const unsigned char *ramdisk_buf;
>  		off_t ramdisk_length;
>  		struct entry32_regs regs;
> +		int i;
>  
>  		/* Get the linux parameter header */
>  		hdr = xmalloc(sizeof(*hdr));
> +		/* Add parameter segment beyond already loaded segments, so that
> +		 * it does not get stomped by kernel. */
> +		for (i = 0; i < info->nr_segments; i++) {
> +			unsigned long temp;
> +			temp = (unsigned long) info->segment[i].mem +
> +				info->segment[i].memsz;
> +			if (temp > min_param_base)
> +				min_param_base =  temp;
> +		}
> +		/* 64K of buffer to keep enough distance from kernel. */
> +		min_param_base += 64*1024;
>  		param_base = add_buffer(info, hdr, sizeof(*hdr), sizeof(*hdr),
> -			16, 0, max_addr, 1);
> +			16, min_param_base, max_addr, 1);
>  
>  		/* Initialize the parameter header */
>  		memset(hdr, 0, sizeof(*hdr));
> _
> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/fastboot
