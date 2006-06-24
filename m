Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933176AbWFXCLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176AbWFXCLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbWFXCLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:11:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933176AbWFXCLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:11:45 -0400
Date: Fri, 23 Jun 2006 19:11:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com, ak@muc.de, akpm@osdl.org
Subject: Re: i386 ABI and the stack
In-Reply-To: <449C9C6D.7050905@zytor.com>
Message-ID: <Pine.LNX.4.64.0606231907290.6483@g5.osdl.org>
References: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
 <Pine.LNX.4.64.0606231844460.6483@g5.osdl.org> <449C9C6D.7050905@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2006, H. Peter Anvin wrote:
> > 
> > The x86-64 ABI has a 128-byte(*) zone that is safe from signals etc, so you
> > can use a small amount of stack below the stackpointer safely. Not so on
> > x86.
> 
> Adding a small redzone like this to i386 would be easy, though -- just drop
> the stack pointer by that much when creating a signal frame.  128 bytes isn't
> enough to interfere with libraries.

However, any binaries created with that in mind would be 
buggy-by-definition on older kernels, so I don't think it's worth it. 

> Unlike other enhancements that have been proposed to the i386 ABI (like
> regparm), this has the advantage of being fully backwards-compatible with old
> binaries and libraries.

Right, but it's not backwards-compatible with old kernels ;(

So any user space app that does it would have to be pretty crazy.

I don't think it's a huge advantage anyway. x86 CPU's are really good at 
tracking %esp - there are papers out there that talk about how %esp is the 
limiter for effective IPC, but modern x86 CPU's will generally have ways 
around it, so in _practice_ I think you can do

	subl $16,%esp
	movl %eax,4(%esp)

without having any address stall on the subtract on most modern CPU cores 
(because the core will break the dependency and track %esp specially).

That's the Yonah "stack engine", afaik. And I could obviously name other 
CPU's that does it too, but I probably shouldn't ;)

		Linus
