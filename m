Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVKWQzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVKWQzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVKWQzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:55:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932086AbVKWQzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:55:11 -0500
Date: Wed, 23 Nov 2005 08:54:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       ak@muc.de
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
In-Reply-To: <20051123.005530.17893365.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0511230849380.13959@g5.osdl.org>
References: <200511230159.jAN1xeMl003154@hera.kernel.org>
 <20051123002134.287ff226.akpm@osdl.org> <20051123.005530.17893365.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, David S. Miller wrote:
>
> From: Andrew Morton <akpm@osdl.org>
> Date: Wed, 23 Nov 2005 00:21:34 -0800
> 
> > Nope, this will break !CONFIG_SMP builds.  Quite a few places in the
> > kernel do not implement the ipi handler if !CONFIG_SMP.
> 
> Ho hum, nothing is ever easy eh? :-) I think your patch is fine for
> now, but in the long term the !CONFIG_SMP ifdefs for those ipi
> handlers should probably just get removed.  If GCC can't optimize
> those things away, I'd be really surprised.

I just reverted the whole commit.

We've had this exact thing before, and it's easy enough to handle, but you 
have to do it right.

The way to handle it is to do

	static inline int maybe_ignored(int arg, ...)
	{
		return arg;
	}

	#define smp_call_function(func,info,retry,wait) \
		maybe_ignored(0, info, retry, wait)

which is a very useful way to say: we don't care about "func", but we want 
to avoid unused warnings for "info", "retry" and "wait", and we want to 
return 0 regardless and compile it all away.

If somebody tests this, puts the "maybe_ignored()" function in some nice 
generic header file, I'll apply it.

I _refuse_ to apply the patch from Andrew that adds "(void)" to shut up 
the compiler. That's a piece of crap, and we should never do things like 
that. Bad C style.

		Linus
