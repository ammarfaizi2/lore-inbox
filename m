Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWEIQwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWEIQwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWEIQwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:10145 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750733AbWEIQwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:52:46 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 11/35] Add support for Xen to entry.S.
Date: Tue, 9 May 2006 18:51:37 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085152.524462000@sous-sol.org>
In-Reply-To: <20060509085152.524462000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091851.37903.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 09:00, Chris Wright wrote:

> +#define sizeof_vcpu_shift		6

This should be generated in asm-offsets.c

> +
> +#ifdef CONFIG_SMP
> +#define GET_VCPU_INFO		movl TI_cpu(%ebp),%esi			; \
> +				shl  $sizeof_vcpu_shift,%esi		; \
> +				addl HYPERVISOR_shared_info,%esi

I think you need some comments on the register usage in the macros.
Otherwise people hacking on it later will go crazy.

>  restore_all:
> +#ifndef CONFIG_XEN
>  	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
>  	# Warning: OLDSS(%esp) contains the wrong/random values if we
>  	# are returning to the kernel.
> @@ -258,12 +289,32 @@ restore_all:
>  	cmpl $((4 << 8) | 3), %eax
>  	je ldt_ss			# returning to user-space with LDT SS
>  restore_nocheck:
> +#else

Needs comment

> +restore_nocheck:
> +	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
> +	movb CS(%esp), %al
> +	andl $(VM_MASK | 3), %eax
> +	cmpl $3, %eax
> +	jne hypervisor_iret
> +	ENABLE_INTERRUPTS
>

-Andi
