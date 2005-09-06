Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVIFXmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVIFXmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVIFXmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:42:19 -0400
Received: from ozlabs.org ([203.10.76.45]:18370 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751132AbVIFXmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:42:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17182.10581.159598.839256@cargo.ozlabs.ibm.com>
Date: Wed, 7 Sep 2005 09:42:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mark Bellon <mbellon@mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org, akpm@osdl.org
Subject: Re: [PATCH]  PPC64: large INITRD causes kernel not to boot [UPDATE]
In-Reply-To: <431E1D1A.2090601@mvista.com>
References: <431E1D1A.2090601@mvista.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Bellon writes:

> Simply put the existing code has a fixed reservation (claim) address and 
> once the kernel plus initrd image are large enough to pass this address 
> all sorts of bad things occur. The fix is the dynamically establish the 
> first claim address above the loaded kernel plus initrd (plus some 
> "padding" and rounding). If PROG_START is defined this will be used as 
> the minimum safe address - currently known to be 0x01400000 for the 
> firmwares tested so far.

The idea is fine, but I have some questions about the actual patch:

> -void *claim(unsigned int, unsigned int, unsigned int);
> +void *claim(unsigned long, unsigned long, unsigned long);

What was the motivation for this change?  Since the zImage wrapper is
a 32-bit executable, int and long are both 32 bits.  I would prefer to
leave the parameters as unsigned int to force people to realize that
the parameters are 32 bits (even if said people have been working on
64-bit programs recently).

> +	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
> +
> +#if defined(PROG_START)
> +	/*
> +	 * Maintain a "magic" minimum address. This keeps some older
> +	 * firmware platforms running.
> +	 */
> +
> +	if (claim_base < PROG_START)
> +		claim_base = PROG_START;
> +#endif

This appears to be the meat of the patch, the rest is "cleanup",
right?

Paul.
