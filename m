Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWCVPD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWCVPD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWCVPDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:35 -0500
Received: from cantor2.suse.de ([195.135.220.15]:12673 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751269AbWCVPDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:30 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 11/35] Add support for Xen to entry.S.
Date: Wed, 22 Mar 2006 14:55:48 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063749.275209000@sorel.sous-sol.org>
In-Reply-To: <20060322063749.275209000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221455.48365.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:30, Chris Wright wrote:

> +
> +/* Offsets into shared_info_t. */
> +#define evtchn_upcall_pending		/* 0 */
> +#define evtchn_upcall_mask		1
> +
> +#define sizeof_vcpu_shift		6

This should be all generated in asm-offsets.c

> +#else

This needs a comment explaining why it is different

> +restore_nocheck:
> +	testl $(VM_MASK|NMI_MASK), EFLAGS(%esp)
> +	jnz hypervisor_iret
> +	movb EVENT_MASK(%esp), %al
> +	notb %al			# %al == ~saved_mask
> +	GET_VCPU_INFO
> +	andb evtchn_upcall_mask(%esi),%al
> +	andb $1,%al			# %al == mask & ~saved_mask

This would be faster if you used 32bit because it wouldn't cause
partial register stalls.

> +	jnz restore_all_enable_events	#     != 0 => reenable event delivery
> +#endif
>  	RESTORE_REGS
>  	addl $4, %esp
>  1:	iret
>  .section .fixup,"ax"
>  iret_exc:
> -	sti
> +#ifndef CONFIG_XEN
> +	ENABLE_INTERRUPTS
> +#endif
>  	pushl $0			# no error code
>  	pushl $do_iret_error
>  	jmp error_code
> @@ -269,6 +317,7 @@ iret_exc:
>  	.long 1b,iret_exc
>  .previous
>  
> +#ifndef CONFIG_XEN
>  ldt_ss:

So are you sure that problem this ugly piece of code tries to work around
isn't in Xen kernels too? Or do you just not care? If yes add a comment.

>  	larl OLDSS(%esp), %eax
>  	jnz restore_nocheck
> @@ -281,7 +330,7 @@ ldt_ss:
>  	 * CPUs, which we can try to work around to make
>  	 * dosemu and wine happy. */
>  	subl $8, %esp		# reserve space for switch16 pointer
> -	cli
> +	DISABLE_INTERRUPTS
>  	movl %esp, %eax
>  	/* Set up the 16bit stack frame with switch32 pointer on top,
>  	 * and a switch16 pointer on top of the current frame. */
> @@ -293,6 +342,13 @@ ldt_ss:
>  	.align 4
>  	.long 1b,iret_exc
>  .previous
> +#else

Needs comment.

> +hypervisor_iret:
> +	andl $~NMI_MASK, EFLAGS(%esp)
> +	RESTORE_REGS
> +	addl $4, %esp
> +	jmp  hypercall_page + (__HYPERVISOR_iret * 32)
> +#endif
>  

>  
>  ENTRY(divide_error)
>  	pushl $0			# no error code
> @@ -462,6 +522,126 @@ error_code:
>  	call *%edi
>  	jmp ret_from_exception
>  
> +#ifdef CONFIG_XEN

It would be nicer to put that one into a separate file

> +# A note on the "critical region" in our callback handler.




>  	pushl $do_coprocessor_error
> @@ -475,17 +655,19 @@ ENTRY(simd_coprocessor_error)
>  ENTRY(device_not_available)
>  	pushl $-1			# mark this as an int
>  	SAVE_ALL
> +#ifndef CONFIG_XEN
>  	movl %cr0, %eax
>  	testl $0x4, %eax		# EM (math emulation bit)
> -	jne device_not_available_emulate
> -	preempt_stop
> -	call math_state_restore
> -	jmp ret_from_exception
> -device_not_available_emulate:
> +	je device_available_emulate
>  	pushl $0			# temporary storage for ORIG_EIP
>  	call math_emulate
>  	addl $4, %esp
>  	jmp ret_from_exception
> +device_available_emulate:
> +#endif
> +	preempt_stop
> +	call math_state_restore
> +	jmp ret_from_exception

It's not quite clear why the Xen special case is needed here. Just because
of the CR0 access? If yes better put that one into a macro that just writes
0 to the register for the Xen case.

-Andi
