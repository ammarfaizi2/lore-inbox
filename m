Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbUKKLer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbUKKLer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbUKKLcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:32:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262217AbUKKLaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:30:00 -0500
Date: Thu, 11 Nov 2004 06:01:02 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4.28-rc1] process stuck in release_task() call
Message-ID: <20041111080102.GB15278@logos.cnet>
References: <20041109162445.GM24130@kmv.ru> <20041110185813.GD12867@logos.cnet> <20041111083312.GE783@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111083312.GE783@alpha.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 09:33:12AM +0100, Willy Tarreau wrote:
> Hi Marcelo,
> 
> > > >>EIP; c012073d <release_task+1fd/230>   <=====
> (...)
> > > c0120540 <release_task>:
> > > c0120540:       55                      push   %ebp
> > > ....
> > > c0120736:       89 d8                   mov    %ebx,%eax
> > > c0120738:       e8 73 dd 01 00          call   c013e4b0 <free_pages> <= here
> > 
> > is this release_task+1fd?  Can you send me the full disassemble of release_task?
> 
> Yes it is because the next instruction after call will be at c0120738+5 =
> c012073d = release_task+1fd. (the return address on the stack is the
> address of the next instruction after the call).

OK.

> > It can't be blocked here, its a "call" instruction. 
> 
> Seems rather strange indeed ! Perhaps this is not the disassembled function
> of the *running* kernel ? it would be good to disassemble vmlinux and ensure
> that it is exactly the one currently running. I too have already lost lots
> of time searching a wrong bug because I disassembled the wrong kernel, so
> I'm certain it can happen even when we're very careful :-(
> 
> > free_pages can't block either. Odd.  
> 
> Marcelo, I have two questions for my own understanding :
>   - free_pages does spin_lock(&zone->lock) around the while() loop.
>     Considering that someone else could hold the lock (bug, etc...), it
>     could block here. But my feeling is that if such a lock were kept held,
>     the system would be totally frozen because everything which would want
>     to free memory would get stuck (even a process exit). Am I right ?

Right, the system will be totally frozen spinning on the lock.

>   - would it enhance performance a bit to put a bunch of 'unlikely()' in all
>     the ifs which end in BUG(), especially inside the loop ?

Yes, it should generate better code. 

Try it and see how the generated code differs from the original without unlikely.

I'm not aware of the internals of unlikely however, so I can't 
explain how it works in details... the GCC documentation 
should do it.  :)
