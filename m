Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267063AbTGGPdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267066AbTGGPdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:33:54 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:47236 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S267063AbTGGPdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:33:49 -0400
Date: Mon, 7 Jul 2003 10:48:23 -0500
From: Eric Varsanyi <e0216@foo21.com>
To: linux-kernel@vger.kernel.org
Cc: davidel@xmailserver.org
Subject: epoll vs stdin/stdout
Message-ID: <20030707154823.GA8696@srv.foo21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems reasonable to register for read events on stdin and write events
on stdout.  In an earlier posting on the epoll API it was asserted that 
anyone registering for events on 2 fd's that shared the same file * was 
asking for trouble.

I can imagine many apps that might want to proxy async traffic thru
stdin/stdout, what is the intended general solution for this with epoll?

FWIW in my app I'm just assuming that fd0 is a dup of fd1 if EPOLL_CTL_ADD 
on fd1 fails with EEXISTS, then I EPOLL_CTL_MOD on fd0 to add the write event.
This seems like a bit of a hack tho.

Example, 2nd ADD fails with EEXIST:

int
main(int ac, char **av)
{
        int pfd;
        struct epoll_event ev;

        pfd = epoll_create(10);
        ev.events = EPOLLIN | EPOLLET;
        ev.data.u32 = 0xdeadbee0;
        if (epoll_ctl(pfd, EPOLL_CTL_ADD, 0, &ev) < 0) {
                perror("EPOLL_CTL_ADD stdin");
                exit(1);
        }
        ev.events = EPOLLOUT | EPOLLET;
        ev.data.u32 = 0xdeadbee1;
        if (epoll_ctl(pfd, EPOLL_CTL_ADD, 1, &ev) < 0) {
                perror("EPOLL_CTL_ADD stdout");
                exit(1);
        }
}

-Eric Varsanyi
