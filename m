Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVIHUkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVIHUkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVIHUkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:40:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62376 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751174AbVIHUkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:40:03 -0400
Date: Thu, 8 Sep 2005 13:39:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
In-Reply-To: <20050908.132634.88719733.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0509081333450.3039@g5.osdl.org>
References: <Pine.LNX.4.58.0509080922230.3208@g5.osdl.org>
 <20050908.131358.93602687.davem@davemloft.net> <20050908212236.A19542@flint.arm.linux.org.uk>
 <20050908.132634.88719733.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Sep 2005, David S. Miller wrote:
> 
> > the "regs" argument may not exist in the parent context in the
> > !SUPPORT_SYSRQ case.
> 
> Then pass in a NULL in the ARM serial drivers instead of this ugly
> dependency upon the macro not using the argument.

No, the ARM driver -does- want to pass in "regs" for the SYSRQ case, it's 
just that "regs" doesn't even exist when SYSRQ is not enabled. Look into 
drivers/serial/amba-pl010.c as an example.

Yes, it's a bit ugly, but we've had similar cases in other places. And
it's likely a valid optimization, and the old code worked beautifully by
just not even caring when "regs" wasn't used due to SYSRQ not being
enabled.

We've had somewhat similar cases where optimizations depended on macros 
not even expanding their arguments when they aren't used (ie the arguments 
might be expensive to expand: function calls or inline asm that the 
compiler can't remove even if the result isn't used).

So it's certainly a valid optimization to know that the arguments aren't
even evaluated, and thus it's sometimes really wrong to change a macro
into an inline function.

		Linus
