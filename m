Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVGVXW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVGVXW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVGVXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:19:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbVGVXTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:19:42 -0400
Date: Fri, 22 Jul 2005 16:19:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
In-Reply-To: <200507212309_MC3-1-A534-95EF@compuserve.com>
Message-ID: <Pine.LNX.4.58.0507221607190.6074@g5.osdl.org>
References: <200507212309_MC3-1-A534-95EF@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jul 2005, Chuck Ebbert wrote:
> 
>   This patch makes restore_fpu() an inline.  When L1/L2 cache are saturated
> it makes a measurable difference.

I've now pushed out an alternative fix for this, which imho is much 
cleaner.

We've long had infrastructure for "alternative asm instructions" that are 
conditional on CPU features, and I just made restore_fpu() use that 
instead:

	/*
	 * The "nop" is needed to make the instructions the same
	 * length.
	 */
	#define restore_fpu(tsk)                        \
	        alternative_input(                      \
	                "nop ; frstor %1",              \
	                "fxrstor %1",                   \
	                X86_FEATURE_FXSR,               \
	                "m" ((tsk)->thread.i387.fsave))

which not only makes it inline, but makes it a single instruction instead 
of the mess it was before.

Now, we should do the same for "fnsave ; fwait" vs "fxsave ; fnclex" too,
but I was lazy. If somebody wants to try that, it would need an 
"alternative_output()" define but should otherwise be trivial too.

		Linus
