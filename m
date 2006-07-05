Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWGEWJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWGEWJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWGEWJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:09:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965026AbWGEWJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:09:50 -0400
Date: Wed, 5 Jul 2006 15:09:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
In-Reply-To: <20060705214502.GA27597@elte.hu>
Message-ID: <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
References: <20060705025349.eb88b237.akpm@osdl.org> <20060705102633.GA17975@elte.hu>
 <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu>
 <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu>
 <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
 <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
 <20060705214502.GA27597@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, Ingo Molnar wrote:
> 
> yeah, i'd not want to skip over some interesting and still unexplained 
> effect either, but 35 bytes isnt all that outlandish and from everything 
> i've seen it's a real win. Here is an actual example:
> 
>  c0fb6137:       c7 44 24 08 00 00 00    movl   $0x0,0x8(%esp)
>  c0fb613e:       00
>  c0fb613f:       c7 44 24 08 01 00 00    movl   $0x1,0x8(%esp)
>  c0fb6146:       00
>  c0fb6147:       c7 43 60 00 00 00 00    movl   $0x0,0x60(%ebx)
>  c0fb614e:       8b 44 24 08             mov    0x8(%esp),%eax
>  c0fb6152:       89 43 5c                mov    %eax,0x5c(%ebx)
>  c0fb6155:       8d 43 64                lea    0x64(%ebx),%eax
>  c0fb6158:       89 40 04                mov    %eax,0x4(%eax)
>  c0fb615b:       89 43 64                mov    %eax,0x64(%ebx)

Ahh, it's _that_ old gcc problem. 

That's actually a different thing. 

Gcc is HORRIBLY BAD at doing the simple

	some_structure = (struct somestruct) { INITIAL };

assignments. It is so ludicrously bad that it's sad. It tends to do that 
as a local "struct somestruct" on the stack that gets initialized, 
followed by a memcpy().

In this case, the problem appears to be the spinlock initialization code.

In other words, I suspect 90% of your improvement was because you got that 
braindamage out of line.

It would be _much_  better to just fix "spin_lock_init()" instead. That 
would help a lot of _other_ users too, not just the waitqueue 
initializations.

Making that a real function (and inline only for the non-debug case, at 
which point it's just a simple and small store) would be much better.

		Linus
