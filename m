Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWIRP3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWIRP3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWIRP3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:29:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:24485 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750940AbWIRP3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:29:31 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Sysenter crash with Nested Task Bit set
Date: Mon, 18 Sep 2006 17:29:23 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, bcrl@kvack.org
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com> <20060917222537.55241d19.akpm@osdl.org> <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181729.23934.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If we fix it in the task-switch code, we shouldn't need any other changes 
> (ie Chuck's change is unnecessary too), because then the process that sets 
> NT will happily die (with NT set), but switch away to something else and 
> nobody else will be affected.

Won't it die in the kernel with an oops on the next interrupt?
 
> So if I'm right, then this patch _should_ fix it. UNTESTED (and the 
> "ref_from_fork" special case doesn't clear NT, so it's strictly incompete, 
> but maybe somebody can test this?)

Are you sure this handles interrupts or nested syscalls 
before the context switch correctly?

I think it really needs to be handled in the sysenter path.

> 
> Hmm? Ingo? Comments?
> 
> Andi? I don't know if x86-64 honors NT in 64-bit mode, but if it does, it 
> needs something similar (assuming this works).

It doesn't task switch, but you would get a #GP in IRET at least.
Leaking that to another process is definitely not good.


>  #define switch_to(prev,next,last) do {					\
>  	unsigned long esi,edi;						\
> -	asm volatile("pushl %%ebp\n\t"					\
> +	asm volatile("pushfl\n\t"		/* Save flags */	\
> +		     "pushl %%ebp\n\t"					\

We used to do that pushfl/popfl some time ago, but Ben removed it because
it was slow on P4.  Ok, nobody thought of that case back then.

-Andi
