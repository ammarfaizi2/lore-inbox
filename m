Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVKWXaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVKWXaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVKWXaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:30:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751307AbVKWXaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:30:05 -0500
Date: Wed, 23 Nov 2005 15:29:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       ak@muc.de
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
In-Reply-To: <20051123.152031.02282381.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0511231526340.13959@g5.osdl.org>
References: <20051123002134.287ff226.akpm@osdl.org> <20051123.005530.17893365.davem@davemloft.net>
 <Pine.LNX.4.64.0511230849380.13959@g5.osdl.org> <20051123.152031.02282381.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, David S. Miller wrote:
> 
> 1) Mark all IPI functions with ifdef CONFIG_SMP, or
> 2) Mark them with __attribute__((__unused__))) which is what
>    the net/core/flow.c case does

We could certainly do some of both.

Add a new "__smp_only__" thing, and do something like

	#ifdef CONFIG_SMP
	  #define __smp_only__
	#else
	  #define __smp_only \
		__attribute__((__unused__, section("discard")))
	#endif

(Yeah, I didn't look up the section syntax, because I'm lazy, but you get 
the point - put it explicitly in some section that will be thrown away, 
and that we can make the build-checking tools verify isn't linked to).

How does that feel? It would waste a bit of compiler time to even look at 
the function, but at least it wouldn't warn, and they'd get thrown away 
_without_ having to rely on a smart compiler.

Quite frankly, every time we rely on some really smart gcc feature, we're 
burnt.

		Linus
