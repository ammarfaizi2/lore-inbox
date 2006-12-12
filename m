Return-Path: <linux-kernel-owner+w=401wt.eu-S932553AbWLLWyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWLLWyy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWLLWyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:54:54 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2491 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553AbWLLWyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:54:53 -0500
Date: Tue, 12 Dec 2006 22:54:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, davem@davemloft.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops safe assignment
Message-ID: <20061212225443.GA25902@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davem@davemloft.com, matthew@wil.cx,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 08:11:12PM +0000, David Howells wrote:
> diff --git a/include/asm-arm/bitops.h b/include/asm-arm/bitops.h
> index b41831b..5932134 100644
> --- a/include/asm-arm/bitops.h
> +++ b/include/asm-arm/bitops.h
> @@ -117,6 +117,32 @@ ____atomic_test_and_change_bit(unsigned 
>  	return res & mask;
>  }
>  
> +#if __LINUX_ARM_ARCH__ >= 6 && defined(CONFIG_CPU_32v6K)
> +static inline void assign_bits(unsigned long v, unsigned long *addr)
> +{
> +	unsigned long tmp;
> +
> +	__asm__ __volatile__("@ atomic_set\n"
> +"1:	ldrex	%0, [%1]\n"
> +"	strex	%0, %2, [%1]\n"
> +"	teq	%0, #0\n"
> +"	bne	1b"
> +	: "=&r" (tmp)
> +	: "r" (addr), "r" (v)
> +	: "cc");
> +}

This seems to be a very silly question (and I'm bound to be utterly
wrong as proven in my last round) but why are we implementing a new
set of atomic primitives which effectively do the same thing as our
existing set?

Why can't we just use atomic_t for this?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
