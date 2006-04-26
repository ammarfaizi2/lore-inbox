Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWDZVVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWDZVVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWDZVVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:21:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51474 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932480AbWDZVVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:21:13 -0400
Date: Wed, 26 Apr 2006 23:20:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: kyle@pbx.org
Cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: accept()ing socket connections with level triggered epoll
Message-ID: <20060426212056.GE13027@w.ods.org>
References: <20060426205557.GA5483@www.t3inc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426205557.GA5483@www.t3inc.us>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 26, 2006 at 02:55:57PM -0600, kyle@pbx.org wrote:
> Hello,
> 
> I think I may have found a bug in Linux's implementation of epoll.  My
> program creates a server socket that listens for incoming SOCK_STREAM
> connections.  It uses epoll to wait for notification of a new connection
> (and also to handle the client sockets).  While the client sockets use edge
> triggered epoll, for performance reasons, the server socket uses level
> triggered epoll.
> 
> I have found that when I open connections to my program very quickly, it is
> sometimes possible to call accept more than once before reaching the point
> where no more connections are available and EAGAIN is returned.  If I return
> to epoll_wait without accepting all of the available connections, I should
> immediately be notified that a read is still available on the server socket,
> since I am using level triggered epoll for that descriptor (at least that is
> my understanding of how all of this is supposed to work ;).  However, epoll
> does not make this notification.  Even if the program accepts further
> incoming connections, the missed connection is never accepted, and
> eventually times out on the client side.

I find this very strange because if your program accepts other connections,
I don't see how it could "select" some connections and ignore others. The
accept() call returns the next connection(s) in the listen queue. Stupid
question : are you sure that you don't miss anything in the loop around
accept() ? eg: reinitialise one error code or anything which could prevent
accept() from being further called after you have successfully done several
accept() at once ? I'm personnally using epoll in level triggered mode
in haproxy, which often does multiple accept() per call on very high loads
(>10k sessions/s), and although I've encountered difficult beginnings with
epoll, it's rock solid now.

> Kernel version is 2.6.9.  I can provide test code if needed.

I would suggest trying 2.6.16 first to see if it may be related to a bug
which has been fixed since then, and otherwise, some test code would help.

> Thanks,
> Kyle Cronan
> <kyle@pbx.org>

Cheers,
Willy

