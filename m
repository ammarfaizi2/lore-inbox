Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUBJR0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265975AbUBJRWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:22:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:14014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266068AbUBJRTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:19:24 -0500
Date: Tue, 10 Feb 2004 09:18:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Andrew Morton <akpm@osdl.org>, Jeff Chua <jchua@fedex.com>,
       jeffchua@silk.corp.fedex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
In-Reply-To: <20040210171055.GA32612@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0402100914500.2128@home.osdl.org>
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
 <20040209225336.1f9bc8a8.akpm@osdl.org> <Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com>
 <20040210082514.04afde4a.akpm@osdl.org> <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
 <20040210171055.GA32612@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Feb 2004, Daniel Jacobowitz wrote:
> 
> This is what Debian has been using.  I believe the other folks with a
> glibc-kernel-headers package based on 2.6 do something similar.  I
> don't know how you'll feel about adding this sort of crap to the
> kernel, though.  Someone else needs to find time to start linuxabi
> moving again...

I don't mind adding a few __KERNEL__ checks, but no I don't want code like 
this:

> +#if !defined(__KERNEL__)
> +/* Debian: Most of these are inappropriate for userspace.  */
> +/* We don't define likely, unlikely, or barrier; they're namespace-intrusive
> +   and should not be needed outside of __KERNEL__.  For __attribute_pure__
> +   and __attribute_used__ we use glibc's definitions.  */
> +# include <sys/cdefs.h>
> +# define __deprecated
> +#else

that is completely glibc-dependent and has no meaning in a kernel header 
file.

In general, anything that uses most of the kernel special magic defines
(__deprecated, __inline__, etc) probably should be inside #ifdef
__KERNEL__ anyway, so the kernel <linux/compiler.h> file should not need 
to define them. 

There are a few cases that look special, just because they touch data
structures that are actually visible to user space. That would be things
like "__packed__" and "__user" etc, which are used to tell something about 
the data structure.

So right now I just added a "#ifdef __KERNEL__" around the special parts, 
and did _not_ do the part about. We can add a few more #ifdef's around 
something else that breaks, but in general I feel that this is up to 
whoever merges the headers into user space.

		Linus
