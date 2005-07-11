Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVGKOhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVGKOhy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVGKOff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:35:35 -0400
Received: from thunk.org ([69.25.196.29]:3735 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261877AbVGKOea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:34:30 -0400
Date: Mon, 11 Jul 2005 10:34:27 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050711143427.GC14529@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Paolo Ornati <ornati@fastwebnet.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050711123237.787dfcde@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711123237.787dfcde@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 12:32:37PM +0200, Paolo Ornati wrote:
> But what I'm looking for is a list of syscalls that are automatically
> restarted when SA_RESTART is set, and especially in what conditions.
> 
> For example: read(), write(), open() are obviously restarted, but even
> on non-blocking fd?
> And what about connect() and select() for example?
> 
> There are a lot of syscalls that can fail with "EINTR"! What's the
> advantage of using SA_RESTART if one doesn't know what syscalls are
> restarted?

According to the Single Unix Specification V3, all functions that
return EINTR are supposed to restart if a process receives a signal
where signal handler has been installed with the SA_RESTART flag.  

There may be a few places in the kernel where this isn't happenning,
that's what the specification states. 

My preference is to always check for EINTR out of sheer paranoia and
for portability, since SA_RESTART is an optional part (XSI) of the
specification which is not necessarily implemented by all Unix
systems, and contrary to popular belief, there _are_ Linux-like
systems beyond just Linux that an application writer might want their
programs to be portable to.  You know, quaint legacy systems like
Solaris, HP-UX, AIX, etc.  :-)

> Example of behavior: according to source code it seems that "connect()"
> (the "net/ipv4/af_inet.c : inet_stream_connect()" implementation)
> returns -ERESTARTSYS if interrupted, but if the socket is in
> non-blocking mode it returns -EINTR.

If the socket is non-blocking mode, and there isn't a connection ready
to be received, then the socket is going to return with some kind of
errno set; either EINPROGRESS (Operation now in progress) or EALREADY
(Operation already in progress), or if a signal came in during the
system call (which would happen pretty rarely, the window for the race
condition is pretty small) it will return EINTR.  I _think_ that a
close reading of the specification would state that the system call
should be restarted, and since a connection isn't ready, then at that
point EINPROGRESS or EALREADY would be returned.  

But this is a pretty small corner case, and in practice happens quite
rarely.  There might be some existing code that expects EINTR in this
case, which might explain this, or perhaps it was thought that it was
useful for the application to know that a system call was handled in
the middle of a non-blocking system call (but what's the point, since
no notification would be given if the signal was processed right
before or right after the system call).  

Still, I'd suggest that the old internet dictum of being conservative
in what you send and liberal in what you accept applies here.  If you
want your program to be robust and portable, check for EINTR.  

						- Ted
