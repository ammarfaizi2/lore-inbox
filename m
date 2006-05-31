Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWEaUPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWEaUPo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWEaUPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:15:44 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:20943 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751156AbWEaUPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:15:43 -0400
Message-ID: <447DF96E.4000602@vmware.com>
Date: Wed, 31 May 2006 13:15:42 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: 76306.1226@compuserve.com, ak@muc.de, rohitseth@google.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: + i386-fix-get_segment_eip-with-vm86.patch added to -mm tree
References: <200605300302.k4U321t6026244@shell0.pdx.osdl.net>
In-Reply-To: <200605300302.k4U321t6026244@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------020206040109000403080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206040109000403080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

akpm@osdl.org wrote:
> The patch titled
>
>      i386: fix get_segment_eip() with vm86 segments
>
> has been added to the -mm tree.  Its filename is
>
>      i386-fix-get_segment_eip-with-vm86.patch
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
>
> ------------------------------------------------------
> Subject: i386: fix get_segment_eip() with vm86 segments
> From: Chuck Ebbert <76306.1226@compuserve.com>
>
>
> We need to check for vm86 mode first before looking at selector privilege
> bits.
>
> Segment limit is always base + 64k and only the low 16 bits of EIP are
> significant in vm86 mode.
>
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> Cc: Andi Kleen <ak@muc.de>
> Cc: Zachary Amsden <zach@vmware.com>
> Cc: Rohit Seth <rohitseth@google.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/i386/mm/fault.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff -puN arch/i386/mm/fault.c~i386-fix-get_segment_eip-with-vm86 arch/i386/mm/fault.c
> --- devel/arch/i386/mm/fault.c~i386-fix-get_segment_eip-with-vm86	2006-05-29 20:06:19.000000000 -0700
> +++ devel-akpm/arch/i386/mm/fault.c	2006-05-29 20:06:19.000000000 -0700
> @@ -77,12 +77,15 @@ static inline unsigned long get_segment_
>  	unsigned seg = regs->xcs & 0xffff;
>  	u32 seg_ar, seg_limit, base, *desc;
>  
> +	/* Unlikely, but must come before segment checks. */
> +	if (unlikely(regs->eflags & VM_MASK)) {
> +		base = seg << 4;
> +		*eip_limit = base + 0xffff;
> +		return base + (eip & 0xffff);
> +	}
> +
>  	/* The standard kernel/user address space limit. */
>  	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
> -
> -	/* Unlikely, but must come before segment checks. */
> -	if (unlikely((regs->eflags & VM_MASK) != 0))
> -		return eip + (seg << 4);
>  	
>  	/* By far the most common cases. */
>  	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
> _
>
> Patches currently in -mm which might be from 76306.1226@compuserve.com are
>
> i386-let-usermode-execute-the-enter.patch
> i386-fix-get_segment_eip-with-vm86.patch
>
>   

This looks great.  While we're in the spirit let's fix kprobes v8086 
handling as well by filtering out int3s from v8086 mode.

--------------020206040109000403080807
Content-Type: text/plain;
 name="i386-dont-try-kprobes-for-v8086-mode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-dont-try-kprobes-for-v8086-mode"

Never allow int3 traps from V8086 mode to enter the kprobes handler.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.17-rc/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.17-rc.orig/arch/i386/kernel/kprobes.c	2006-05-18 13:31:50.000000000 -0700
+++ linux-2.6.17-rc/arch/i386/kernel/kprobes.c	2006-05-31 13:09:26.000000000 -0700
@@ -607,7 +607,7 @@ int __kprobes kprobe_exceptions_notify(s
 	struct die_args *args = (struct die_args *)data;
 	int ret = NOTIFY_DONE;
 
-	if (args->regs && user_mode(args->regs))
+	if (args->regs && user_mode_vm(args->regs))
 		return ret;
 
 	switch (val) {

--------------020206040109000403080807--
