Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTD0C5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 22:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbTD0C5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 22:57:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263288AbTD0C5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 22:57:44 -0400
Date: Sat, 26 Apr 2003 20:09:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternative patching for prefetches & cleanup
In-Reply-To: <20030427021958.GA27897@averell>
Message-ID: <Pine.LNX.4.44.0304262005460.25292-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Apr 2003, Andi Kleen wrote:
> 
> It also adds nop types for various CPUs straight from their optimization 
> manuals. Now you can always get the fastest nops for K7,K8 and Intel.
> I moved them into the include files to make it easy to use them
> for padding alternative()s. Some cleanups in the patch function to use this.

Please, this part I definitely want cleaned up.

> +++ linux-gencpu/arch/i386/kernel/setup.c	2003-04-27 04:12:32.000000000 +0200
> @@ -795,41 +795,42 @@
>  		pci_mem_start = low_mem_size;
>  }
>  
> +asm("nops: " 
> +    ASM_NOP1 ASM_NOP2 ASM_NOP3 ASM_NOP4 ASM_NOP5 ASM_NOP6
> +    ASM_NOP7 ASM_NOP8); 
> +

This in particular is just too ugly for words. Why can't you just have a

	static const char *intel_nops[] = {
		NULL,
		INOP1, INOP2, INOP3, INOP4, INOP5, INOP6, INOP7, INOP8
	};

	static const char *k7_nops[] = {
		NULL,
		K7NOP1, K7NOP2, ...
	}

	....

	/*
	 * This will be overridden at boot once we find out what kind of 
	 * CPU we actually have
	 */
	static char **nops = intel_nops;

and then just use

	.. nops[size] ..

when you want a nop of size "size".

		Linus

