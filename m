Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbULWMjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbULWMjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 07:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbULWMjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 07:39:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12930 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261168AbULWMjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 07:39:39 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       dipankar sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] Secondary cpus boot-up for non defalut location built kernels
References: <1103802944.8123.114.camel@2fwv946.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Dec 2004 05:38:42 -0700
In-Reply-To: <1103802944.8123.114.camel@2fwv946.in.ibm.com>
Message-ID: <m1k6r9ur3h.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Hi,
> 
> This patch fixes the problem of secondary cpus boot up. This situation
> is faced when kernel is built for non default locations like 16MB and
> onwards. In this configuration, only primary cpu (BP) comes and
> secondary cpus don't boot.
> 
> Problem occurs because in trampoline code, lgdt is not able to load the
> GDT as it happens to be situated beyond 16MB. This is due to the fact
> that cpu is still in real mode and default operand size is 16bit.

Which means that the cpu will load a 24bit linear address (3 bytes)
because it is acting like a 286.
 
> This patch uses lgdtl instead of lgdt to force operand size to 32
> instead of 16.

Sounds sane looking at the trampoline I suspect that people thought
it was using a 32bit address all along.  And the code only worked
because the data was stored little endian.  We probably want to apply
the same fix to the ldt instruction just about it.  Just in case
we ever decide to populate an idt at that point.

But the fix certainly looks good from here.

Eric


> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
> 
>  linux-2.6.10-rc3-mm1-changes-root/arch/i386/kernel/trampoline.S | 8 +++++++-
> 
>  1 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff -puN arch/i386/kernel/trampoline.S~boot_ap_for_nondefault_kernel
> arch/i386/kernel/trampoline.S
> 
> ---
> linux-2.6.10-rc3-mm1-changes/arch/i386/kernel/trampoline.S~boot_ap_for_nondefault_kernel
> 2004-12-22 16:36:50.000000000 +0530
> 
> +++ linux-2.6.10-rc3-mm1-changes-root/arch/i386/kernel/trampoline.S 2004-12-22
> 16:47:54.000000000 +0530
> 
> @@ -51,8 +51,14 @@ r_base = .
>  	movl	$0xA5A5A5A5, trampoline_data - r_base
>  				# write marker for master knows we're running
>  
> +	/* GDT tables in non default location kernel can be beyond 16MB and
> +	 * lgdt will not be able to load the address as in real mode default
> +	 * operand size is 16bit. Use lgdtl instead to force operand size
> +	 * to 32 bit.
> +	 */
> +
>  	lidt	boot_idt - r_base	# load idt with 0, 0
> -	lgdt	boot_gdt - r_base	# load gdt with whatever is appropriate
> +	lgdtl	boot_gdt - r_base	# load gdt with whatever is appropriate
>  
>  	xor	%ax, %ax
>  	inc	%ax		# protected mode (PE) bit
> _
