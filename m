Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268364AbTGLT36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268380AbTGLT36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:29:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:4756 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S268364AbTGLT35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:29:57 -0400
Date: Sat, 12 Jul 2003 20:44:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Varsanyi <e0206@foo21.com>
Cc: linux-kernel@vger.kernel.org, davidel@xmailserver.org
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030712194432.GE10450@mail.jlokier.co.uk>
References: <20030712181654.GB15643@srv.foo21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712181654.GB15643@srv.foo21.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Varsanyi wrote:
> 	- epoll_wait() returns a single EPOLLIN event on the FD representing
> 	  both the 1/2 shutdown state and data available

Correct.

> At this point there is no way the app can tell if there is a half closed
> connection so it may issue a close() back to the client after writing
> results. Normally the server would distinguish these events by assuming
> EOF if it got a read ready indication and the first read returned 0 bytes,
> or would issue read calls until less data was returned than was asked for.
> 
> In a level triggered world this all just works because the read ready
> indication is driven back to the app as long as the socket state is half
> closed. The event driven epoll mechanism folds these two indications
> together and thus loses one 'edge'.

Well then, use epoll's level-triggered mode.  It's quite easy - it's
the default now. :)

If there's an EOF condition pending after you called read(), and then
you call epoll_wait(), you _should_ see another EPOLLIN condition
immediately.

If you aren't seeing epoll_wait() return with EPOLLIN when there's an
EOF pending, *and* you haven't set EPOLLET in the event flags, that's
a bug in epoll.  Is that what you're seeing?

-- Jamie
