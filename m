Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbUCRRa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbUCRRa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:30:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:12687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262772AbUCRRaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:30:24 -0500
Date: Thu, 18 Mar 2004 09:30:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: fcntl error
In-Reply-To: <7051.1079628297@redhat.com>
Message-ID: <Pine.LNX.4.58.0403180923190.880@ppc970.osdl.org>
References: <7051.1079628297@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Mar 2004, David Howells wrote:
> 
> The attached patch fixes a minor problem with fcntl.

I agree that it is a cleanup, but I disagree on the "problem" part.

> get_close_on_exec() uses FD_ISSET() to determine the fd state. However,
> FD_ISSET() does not return 0 or 1 on all archs. On some it returns 0 or non-0,
> which is fine by POSIX.

FD_ISSET() is broken if it returns anything but 0/1, in my not-so-humble 
opinion.

Looking at the implementations, you are right that some architectures 
don't do this right, but that is a bug, and it's a bug in FD_ISSET(), not 
in fcntl.

The fact is, FD_ISSET() isn't always used in just as a conditional, and
you're supposed to be able to do

	int was_set = FD_ISSET(..);
	...

and in fact I'd suggest very _strongly_ that it also should work with

	bool is_set = FD_ISSET(..);

where some people use "char" for booleans for space reasons.

That implies that while non-zero for "set" is ok, that non-zero had better
have the _low_ bits set. Which is not true on architectures that use just
a logical and with the bits in the word.

Which implies that FD_ISSET() really must NOT be of that "logical and" 
approach, which in turn implies that it should be either a inequality 
expression, or it should be a "shift down and then and with 1".

And in both of those cases, the result ends up being 0/1. So we might as 
well just make it so.

In short, the real bug is elsewhere.

> Also, the argument of set_close_on_exec() is being AND'ed with literal 1. This
> is incorrect - there's no requirement for FD_CLOEXEC to be 1.

Not in theory, no. In practice, it always is.

I'd suggest architecture maintainers fix their __FD_ISSET() 
implementations to conform to the proper return value.

		Linus
