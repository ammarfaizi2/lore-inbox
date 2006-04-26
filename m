Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWDZUz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWDZUz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWDZUz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:55:58 -0400
Received: from t3inc.us ([66.250.45.69]:21427 "EHLO www.t3inc.us")
	by vger.kernel.org with ESMTP id S932461AbWDZUz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:55:58 -0400
Date: Wed, 26 Apr 2006 14:55:57 -0600
From: kyle@pbx.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: accept()ing socket connections with level triggered epoll
Message-ID: <20060426205557.GA5483@www.t3inc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think I may have found a bug in Linux's implementation of epoll.  My
program creates a server socket that listens for incoming SOCK_STREAM
connections.  It uses epoll to wait for notification of a new connection
(and also to handle the client sockets).  While the client sockets use edge
triggered epoll, for performance reasons, the server socket uses level
triggered epoll.

I have found that when I open connections to my program very quickly, it is
sometimes possible to call accept more than once before reaching the point
where no more connections are available and EAGAIN is returned.  If I return
to epoll_wait without accepting all of the available connections, I should
immediately be notified that a read is still available on the server socket,
since I am using level triggered epoll for that descriptor (at least that is
my understanding of how all of this is supposed to work ;).  However, epoll
does not make this notification.  Even if the program accepts further
incoming connections, the missed connection is never accepted, and
eventually times out on the client side.

Kernel version is 2.6.9.  I can provide test code if needed.

Thanks,
Kyle Cronan
<kyle@pbx.org>
