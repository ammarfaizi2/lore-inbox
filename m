Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTGGTdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTGGTdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:33:10 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:22406 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S264377AbTGGTdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:33:05 -0400
Date: Mon, 7 Jul 2003 14:47:36 -0500
From: Eric Varsanyi <e0216@foo21.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030707194736.GF9328@srv.foo21.com>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 11:57:02AM -0700, Davide Libenzi wrote:
> Events caught by epoll comes from a file* since that is the abstraction
> the kernel handles. Events really happen on the file* and there's no way
> if you dup()ing 1000 times a single fd, to say that events are for fd = 122.

It is useful/mildly common at the app level to want to get read events
for fd0 and write avail events for fd1. An app that might want to deal
with reads from stdin in one process and writes to stdout in another
(something like "team" perhaps) would have trouble here too.

Epoll's API/impl is great as it is IMO, not suggesting need for change, I was
hoping there was a good standard trick someone worked up to get around
this specifc end case of stdin/stdout usually being dups but sometimes
not. Porting my event system over to use epoll was easy/straightforward
except for this one minor hitch.

I considered:
	- using a second epoll object just for one of the fd's (to inspire
	  delivery of the event to 2 wait queues in the kernel); a little
	  ugly because of need to stack another epfd under the main one
	  just for stdout write events

	- select() on (0, 1, epfd) and just use epoll with a timeout of 0
	  when select fires to gather bulk of events; morally similar to 
	  previous but using select (which I want to just get away from)

	- make the app use stdin as its output (this is what I ended up doing);
	  breaks redirection of stdout but that doesn't matter to this app

Thanks,
-Eric Varsanyi
