Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVDGRVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVDGRVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVDGRVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:21:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:65493 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262502AbVDGRVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:21:23 -0400
Date: Thu, 7 Apr 2005 10:23:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, stsp@aknet.ru,
       linux-kernel@vger.kernel.org, VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <20050407164734.GB19016@redhat.com>
Message-ID: <Pine.LNX.4.58.0504071000450.28951@ppc970.osdl.org>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
 <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru>
 <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru>
 <20050407080004.GA27252@elte.hu> <20050407041006.4c9db8b2.akpm@osdl.org>
 <Pine.LNX.4.58.0504070737190.28951@ppc970.osdl.org> <20050407164734.GB19016@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Dave Jones wrote:
>
> On Thu, Apr 07, 2005 at 07:47:41AM -0700, Linus Torvalds wrote:
> 
>  > So the sysenter sequence might as well look like
>  > 
>  > 	pushl $(__USER_DS)	
>  > 	pushl %ebp
>  > 	sti
>  > 	pushfl
>  > 	..
>  > 
>  > which actually does three protected pushes thanks to the one-instruction 
>  > "interrupt shadow" after an sti.
> 
> Is this guaranteed on every x86 variant (or rather, every one
> that has SEP). ?

Well, since we only need two in this case, we don't care, but yes, it's 
supposed to be guaranteed by anything that calls itself an x86.

In fact, we _do_ depend on it in a few other sequences. Notably

	sti ; hlt

depends on the fact that an interrupt will always finish _after_ the hlt, 
and we'll never halt before the hlt (and then re-execute the hlt after the 
interrupt), and in

	sti ; iret

where we depend on the fact that we don't get recursive interrupt stacks 
(since we at that point have re-enabled the interrupt that happened).

Of course, if some future x86 decides that the interrupt shadow only
matters for special instructions (ie it's not so much a general interrupt
shadow as a "instruction combination"), I don't think Linux would care. I
really think there are only a very few valid sti-combinations, and I
suspect the above two are pretty much it.

(The other "magic" x86 behaviour is loading into the SS register, which
creates a one-cycle black hole after it. Linux shouldn't care, and in fact
nothing should care about it outside of old 16-bit non-protected-mode
programs, so I think that's another one that could be retired eventually)

		Linus
