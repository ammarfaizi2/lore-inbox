Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVAHAW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVAHAW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVAHATx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:19:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:48537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbVAHAPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:15:42 -0500
Date: Fri, 7 Jan 2005 16:15:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
In-Reply-To: <1105136446.7628.11.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> 
 <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Alan Cox wrote:
>
> Please don't use that for mainline - do_brk_locked doesn't follow kernel
> convention

I agree, I also find the "do_brk_locked()" naming confusing. To me it 
implies that we already _are_ locked, not that we're going to lock.

On the other hand, I think Alan's patch is equally confusing: the calling 
rules for "do_brk()" and "do_mmap()" are the same, and they are "caller 
takes mmap_sem". 

So I think you _both_ broke kernel conventions.

So I'd personally much prefer to just first fix the bug minimally (by just
taking the lock in the two places that need it), and then _separately_ say
"we should warn if anybody ever calls 'do_brk()' without the lock". That's 
how we tend to verify locking in other cases, ie we have things like

	if (!spin_is_locked(&t->sighand->siglock))
		BUG();

to verify the calling conventions. Same would go for mmap_sem (although we
don't seem to have any "sem_is_writelocked()" test - although you can fake
it with

	if (down_read_trylock(&mm->mmap_sem))
		BUG();

instead.

Now _that_ is a non-silent failure mode. The machine doesn't just silently 
deadlock: it tells you exactly what's wrong.

		Linus
