Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTGGTsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTGGTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:48:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42892 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262177AbTGGTsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:48:50 -0400
Date: Mon, 7 Jul 2003 21:03:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Varsanyi <e0216@foo21.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030707200315.GA10939@mail.jlokier.co.uk>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030707194736.GF9328@srv.foo21.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Varsanyi wrote:
> Epoll's API/impl is great as it is IMO, not suggesting need for change, I was
> hoping there was a good standard trick someone worked up to get around
> this specifc end case of stdin/stdout usually being dups but sometimes
> not. Porting my event system over to use epoll was easy/straightforward
> except for this one minor hitch.

Easy: if it's a read event, it's stdin; if it's a write event, it's stdout :)

You've raised an interesting problem.  It is easy to fix this in the
specific case of stdin/stdout, however what happens when your process
is passed a pair of fds from some other process (or more than one
process, using AF_UNIX), and told to read one and write the other?
What happens when you have 10 fds from different sources, some for
reading and some for writing (quite typical in a complex server)?

With the epoll API, your process has to know whether any paids or fds
correspond to the same file *, in order to decide whether to register
one interested in READ+WRITE or two interests separately.

Unfortunately I cannot think of a way for a process to know, in
general, whether two fds that it is passed correspond to the same file
*.  Well, apart from trying epoll on it and seeing what happens :/

Perhaps this indicates the epoll API _is_ flawed.  Epoll maintains
this state mapping:

	file * -> (event mask, event states)

when it ought to maintain this:

	(file *, event type) -> event state

In other words, perhaps epoll should be keeping registered interest in
read events and registered interest in write events completely
separate.

I suspect changing the API to do that wouldn't even break any of the
existing apps.

Davide, what do you think?

-- Jamie
