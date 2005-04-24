Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVDXIwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVDXIwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 04:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVDXIwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 04:52:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:17110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262289AbVDXIwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 04:52:18 -0400
Date: Sun, 24 Apr 2005 01:51:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent possible infinite loop in
 fs/select.c::do_pollfd()
Message-Id: <20050424015156.5773b399.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0504240112340.2474@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504240112340.2474@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> If a sufficiently large 'num' is passed to the function, the for loop 
>  becomes an infinite loop - as far as I can see, that's a bug waiting to 
>  happen. Sure, 'len' in struct poll_list is currently an int, so currently 
>  this can't happen, but that might change in the future. In my oppinion, 
>  a function should be able to function correctly with the complete range 
>  of values that can potentially be passed via its parameters, and without 
>  the patch below that's just not true for this function.
> 
>  Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
>  --- linux-2.6.12-rc2-mm3-orig/fs/select.c	2005-04-05 21:21:47.000000000 +0200
>  +++ linux-2.6.12-rc2-mm3/fs/select.c	2005-04-24 01:11:13.000000000 +0200
>  @@ -397,7 +397,7 @@ struct poll_list {
>   static void do_pollfd(unsigned int num, struct pollfd * fdpage,
>   	poll_table ** pwait, int *count)
>   {
>  -	int i;
>  +	unsigned int i;
>   
>   	for (i = 0; i < num; i++) {
>   		int fd;

An expression such as the above which mixes signed and unsigned types will
promote the signed types to unsigned.  So there is no bug in the above
`for' statement.

But there's a bug a bit further on:

> 		unsigned int mask;
> 		struct pollfd *fdp;
> 
> 		mask = 0;
> 		fdp = fdpage+i;

This will oops the kernel if there are more than 2^31 pollfd's at *fdpage.

Yes, like most signed variables in the kernel, `i' should really be
unsigned, but I don't think it's worth raising a patch to change it.
