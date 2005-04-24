Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVDXWwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVDXWwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 18:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVDXWwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 18:52:14 -0400
Received: from mail.dif.dk ([193.138.115.101]:21708 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261704AbVDXWwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 18:52:06 -0400
Date: Mon, 25 Apr 2005 00:55:20 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent possible infinite loop in fs/select.c::do_pollfd()
In-Reply-To: <20050424015156.5773b399.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0504250049570.2071@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504240112340.2474@dragon.hyggekrogen.localhost>
 <20050424015156.5773b399.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > If a sufficiently large 'num' is passed to the function, the for loop 
> >  becomes an infinite loop - as far as I can see, that's a bug waiting to 
> >  happen. Sure, 'len' in struct poll_list is currently an int, so currently 
> >  this can't happen, but that might change in the future. In my oppinion, 
> >  a function should be able to function correctly with the complete range 
> >  of values that can potentially be passed via its parameters, and without 
> >  the patch below that's just not true for this function.
> > 
> >  Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > 
> >  --- linux-2.6.12-rc2-mm3-orig/fs/select.c	2005-04-05 21:21:47.000000000 +0200
> >  +++ linux-2.6.12-rc2-mm3/fs/select.c	2005-04-24 01:11:13.000000000 +0200
> >  @@ -397,7 +397,7 @@ struct poll_list {
> >   static void do_pollfd(unsigned int num, struct pollfd * fdpage,
> >   	poll_table ** pwait, int *count)
> >   {
> >  -	int i;
> >  +	unsigned int i;
> >   
> >   	for (i = 0; i < num; i++) {
> >   		int fd;
> 
> An expression such as the above which mixes signed and unsigned types will
> promote the signed types to unsigned.  So there is no bug in the above
> `for' statement.
> 
You are right of course, I need to remember the promotion rules :)
Still, unsigned int is the logical type to use for `i'.


> But there's a bug a bit further on:
> 
> > 		unsigned int mask;
> > 		struct pollfd *fdp;
> > 
> > 		mask = 0;
> > 		fdp = fdpage+i;
> 
> This will oops the kernel if there are more than 2^31 pollfd's at *fdpage.
> 
Hmm, if you mean that i will overflow and become negative so we'll actully 
be subtracting from fdpage, then I'm not so sure - won't gcc actually 
promote i to unsigned int here as well? I did a little test app, and it 
seems that's the case (well, `i' of course still ought to be unsigned). 
But I guess we'll probably cause fdpage to wrap with such a large i (but 
then we should never have managed to allocate so many fd's in the first 
place).


> Yes, like most signed variables in the kernel, `i' should really be
> unsigned, but I don't think it's worth raising a patch to change it.
> 
Why not? I thought we were trying to make the kernel as perfect as 
possible. I agree with you that there are many bigger issues that have 
priority, but even the little things (like this) ought to get fixed as 
well IMHO (and when the patch is already done, why not apply it?).


-- 
Jesper


