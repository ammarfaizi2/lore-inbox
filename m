Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWGHSX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWGHSX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWGHSX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:23:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964938AbWGHSX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:23:28 -0400
Date: Sat, 8 Jul 2006 11:23:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: trajce nedev <trajcenedev@hotmail.com>
cc: acahalan@gmail.com, linux-kernel@vger.kernel.org, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <BAY110-F20F0B50886D0441B0B8989B8750@phx.gbl>
Message-ID: <Pine.LNX.4.64.0607081115420.3869@g5.osdl.org>
References: <BAY110-F20F0B50886D0441B0B8989B8750@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, trajce nedev wrote:
> 
> Incorrect.  I haven't been following this thread very closely [...]

Right. And maybe you should have followed it a bit more closely.

We're not talking about "asm volatile", which is a totally different use 
of the same word. 

We're not talking about pointers to volatile as arguments, which can be 
required for a generic function to not complain about it's argument types.

We're not even talking about code like

	#define writel(data, offset) \
		*(volatile int *)(offset) = (data)

which is perfectly fine on some architectures (but realize that on other 
archtiectures, you may need a _lot_ more than a single memory access to do 
an IO write, so if you don't abstract it like the above, you're broken by 
design.

In short, we're not talking about "volatile" in _code_. That's usually 
fine. We're talkign about "volatile" on data. IT'S WRONG.

Btw, your spinlock (that uses "volatile") is _totally_ and _utterly_ 
broken, exactly because it doesn't take things like memory ordering into 
account. In other words, your spinlock WON'T WORK. It won't actually 
protect the data accesses you have inside the spinlock.

Which proves my point: people who think that "volatile" is good are 
usually ignorant about the real needs of the code. To do a spinlock on 
_any_ modern CPU, you need inline assembly. End of story. You need it to 
make sure that you have told the CPU the right ordering constraints, 
something that "volatile" simply does not (and _can_not) do.

			Linus
