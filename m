Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTLUVTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTLUVTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:19:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:12190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264113AbTLUVTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:19:41 -0500
Date: Sun, 21 Dec 2003 13:19:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <3FE60BCC.5090305@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0312211313070.13039@home.osdl.org>
References: <3FE492EF.2090202@colorfullife.com> <8765ga6moe.fsf@devron.myhome.or.jp>
 <3FE5F116.9020608@colorfullife.com> <Pine.LNX.4.58.0312211250370.13039@home.osdl.org>
 <3FE60BCC.5090305@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Manfred Spraul wrote:
> >
> >Just make the caller do the locking.
>
> It's not that simple:

It _is_ that simple.

The choices are:
 - let the caller do the locking
 - make the callee locking be statically determinable

Those are the choices. Your kind of code is not goign to be integrated.

> the function does
>     kmalloc();
>     spin_lock();
>     use_allocation.

This is trivially handled by splitting out the allocation as a separate 
phase. 

Yes, it requires that the caller be changed, but if the choice is between 
insane locking and making a caller change, then the choice is very very 
clear.

> But: as far as I can see, these lines usually run under lock_kernel(). 
> If this is true, then the spin_lock(&fasync_lock) won't cause any 
> scalability regression, and I'll use that lock instead of lock_sock, 
> even for network sockets.

Don't.

Here's a big clue: if you make code worse than it is today, it won't be 
accepted. I don't even see why you'd bother in the first place.

So go back to the drawing board, and just do it _right_. Or don't do it at 
all. There's no point to making the code look and behave worse than it 
does today.

		Linus
