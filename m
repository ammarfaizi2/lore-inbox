Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUKDT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUKDT6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUKDTyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:54:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:13512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262388AbUKDTw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:52:28 -0500
Date: Thu, 4 Nov 2004 11:52:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
In-Reply-To: <4187E920.1070302@nortelnetworks.com>
Message-ID: <Pine.LNX.4.58.0411041140410.2187@ppc970.osdl.org>
References: <4187E920.1070302@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Nov 2004, Chris Friesen wrote:
> 
> While nice to read, it would seem that it might be more efficient to do the 
> following:
> 
> if (error condition) {
> 	err = -ERRORCODE;
> 	goto out;
> }
> 
> 
> Is there any particular reason why the former is preferred?  Is the compiler 
> smart enough to optimize away the additional write in the non-error path?

Quite often, the additional write is _faster_ in the non-error path.

If it's a plain register, the obvious code generation for the above is

		..
		testl error-condition
		je no_error
		movl $-XXX,%eax
		jmp out;
	no_error:
		...

which is a lot slower (for the common non-error case) than

	
		movl $-XXX,%eax
		testl error-condition
		jne out

because forward branches are usually predicted not-taken when no other 
prediction exists.

You can do the same thing with

	if (unlikely(error condition)) {
		err = -ERRORCODE;
		goto out;
	}

which is hopefully even better, but the fact is, the regular

	err = -ERRORCODE;
	if (error condition)
		goto out;

is just _smaller_ and simpler and quite often more readable anyway.

It has the added advantage that it tends to stylistically match what I 
consider the proper error return behaviour, ie

	err = function_returns_errno(...)
	if (err)
		goto out;

ie it looks syntactically identical when "error condition" and the error 
value happen to be one and the same. Which is, after all, _the_ most 
common case.

So I personally tend to prefer the simple format for several reasons. 
It's small, it's consistent, and it maps well to good code generation.

The code generation part ends up being nice when something goes wrong.  
When somebody sends in an oops, I often end up having to look at the
disassembly (and no, a fancy debugger wouldn't help - I'm talking about
the disassembly of the "code" portion of the oops itself, and matching it
up with the source tree - the oops doesn't come with the whole binary),
and then having code generation match the source makes things a _lot_
easier.

Does it make sense for other projects? Dunno. But it is, as you noted, a 
common idiom in the kernel. Getting used to it just makes it even more 
readable.

			Linus
