Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTKZUpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTKZUpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:45:00 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:20865 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264340AbTKZUnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:43:13 -0500
Date: Wed, 26 Nov 2003 20:42:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG (non-kernel), can hurt developers.
Message-ID: <20031126204256.GJ14383@mail.shareable.org>
References: <Pine.LNX.4.53.0311261153050.10929@chaos> <Pine.LNX.4.58.0311261021400.1524@home.osdl.org> <Pine.LNX.4.53.0311261344280.11326@chaos> <20031126193310.GE14383@mail.shareable.org> <Pine.LNX.4.53.0311261459340.11574@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311261459340.11574@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > What is the "bad interaction" that you observed at monthly intervals?
> > Also a SIGSEGV?
> 
> Yes. When the call to rand() was replaced with a static-linked
> clone it went away.

> The calling rand() from a handler in a newer libc doesn't seg-fault.

On both cases, although it doesn't seg-fault, you can no longer trust
the results to be the same quality of random numbers.

It's an implementation detail that the other versions of rand() happen
not to segfault even though you are calling them incorrectly.  Just
like you can call free() twice on a memory block and it will segfault
with Glibc, but is fine in some versions of BSD.  It's still an error
to do it.

> Not with the emulation. The problem is that rand() uses a thread-
> specific pointer to find the seed (history variable), just like
> 'errno' which isn't really a static variable, but a function
> that returns a pointer to a thread-specific integer. If this
> is interrupted in a critical section, and that same pointer
> is used, that pointer is left pointing to a variable in somebody
> else's address space.

Yes that sounds reasonable.  A newer libc would fix it because newer
libc uses a different method for looking up thread-specific pointers.

> That same problem is observed to happen when the same shared runtime
> library was used by entirely different tasks.

When you say "entirely different tasks", do you mean "different
threads in the same process" or "different processes"?

That same problem _can_ happen between different threads in a single
process, but it _cannot_ happen between different processes.

-- Jamie

