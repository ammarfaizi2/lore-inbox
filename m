Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbTIER1X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbTIER1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:27:23 -0400
Received: from colin2.muc.de ([193.149.48.15]:15108 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265726AbTIER1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:27:22 -0400
Date: 5 Sep 2003 19:27:15 +0200
Date: Fri, 5 Sep 2003 19:27:15 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Jan Hubicka <jh@suse.cz>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org, rth@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905172715.GA80302@colin2.muc.de>
References: <20030905004710.GA31000@averell> <20030905053730.GB24509@kam.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905053730.GB24509@kam.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How much work would be to fix kernel in this regard?

The big problem is that -funit-at-a-time is not widely used yet,
so even if we fix the kernel at some point it would likely 
get broken again all the time by people who use older kernels
(= most kernel developers currently)

> Are there some cases where this is esential?  Kernel would be nice
> target to whole program optimization and GCC is not that far from it
> right now.

I'm not sure that is that good an idea. When I was still hacking 
TCP I especially moved some stuff out-of-line in the fast path to avoid 
register pressure. Otherwise gcc would inline rarely used sub functions 
and completely mess up the register allocation in the fast path.
Of course just a call alone messes up the registers somewhat because
of its clobbers, but a full inlining is usually worse.

That was a long time ago, of course the code has significantly changed by
then.

I suspect that is true for a lot of core kernel code - everything
that is worth inlining is already inlined and for the rest it doesn't matter.

On the other hand a lot of driver code seems to be written without
manual consideration for inline. For that it may be worth it. But then
I would consider core kernel code to be more important than driver
code.

Also I fear cross module inlining would expose a lot of latent bugs
(missing barriers etc.) when the optimizer becomes more aggressive. 
I'm not saying this would be a bad thing, just that it may be a lot 
of work to fix (both for compiler and kernel people)

-Andi

