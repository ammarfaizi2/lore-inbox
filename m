Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUFBP7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUFBP7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUFBP6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:58:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:52677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263457AbUFBPxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:53:23 -0400
Date: Wed, 2 Jun 2004 08:52:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
In-Reply-To: <20040602152741.GC26474@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0406020839230.3403@ppc970.osdl.org>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
 <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
 <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
 <20040602142748.GA25939@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org>
 <20040602150440.GA26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020807270.3403@ppc970.osdl.org>
 <20040602152741.GC26474@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jun 2004, Jörn Engel wrote:
> > 
> > If we have a good detector that is reliable and easy to run, why not?
> 
> Great!  So the official format to document recursions is plain english
> for human readers?

Actually, I'd suggest making it a preprocessor directive at the very top
of the function itself. That way I can make sparse parse it too if I ever
want to.

So something like

	/*
	 * This function is part of recursion, but we limit
	 * the depth with the "depth" parameter to 5
	 */
	int my_recursive_function(int depth, struct datastruct *arg)
	{
		declare_recursion_depth(5);
		...

where we could either just #define it to some no-op like

	#define declare_recursion_depth(x) \
		extern void __dummy_function_never_used()

or even do something fancier:

	#define declare_recursion_depth(x) \
		static __init char recursion[] = __FILE__ ":" __FUNCTION__ "=" #x;

which will generate a nice clean variable that shows up in "objdump" in 
all its glory, so that pretty much any tool can trivially parse it.

And for something like sparse or other automated tools, we can trivially 
make it be something more appropriate, ie

	#define recursion_depth(x) \
		__builtin_recursion_depth(x)

or whatever checker-specific thing we want it to be.

And other tools should be equally able to easily pick it up, either by 
just looking at the object file or re-defining the macro to suit 
themselves.

I think the above syntax is both human-readable and "obviously parseable" 
in many trivial ways. Whaddaya think? Works for you?

		Linus
