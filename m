Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbUL0UIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUL0UIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUL0UI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:08:28 -0500
Received: from stingr.net ([212.193.32.15]:21175 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S261961AbUL0UFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:05:14 -0500
Date: Mon, 27 Dec 2004 23:05:09 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidel@xmailserver.org
Subject: How to implement multithreaded event loop ?
Message-ID: <20041227200509.GD1035@stingr.sgu.ru>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davidel@xmailserver.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am trying to implement a multithreaded event loop using epoll. So, I
have 2 kind of events. First, there are conditions on fds I have
(listener sockets, client connections, my connections to other
clients). Second, I need to have some kind of priority queue into
which I can push forthcoming timed events.

In case of single-threaded server, this is fairly trivial. I just need
to make heap queue and add its 1st (i.e. minimal) element as timeout
to each next epoll_wait call. When some condition breaks the wait, I
can always do find_min and wait again with new timeout.

Things become complicated when I need to scale. So, without this
timeout cruft, I can just add proper locking around my data structures
but main epoll_wait loop is multithread-aware, e.g. it will retrieve
different events for different waiting threads (to be absolutely fair
with you, I did not implemented this part yet, but I assume that some
combination of edge triggered + one shot epoll will do the trick).
But, if using heap priority queue to manage timed events, I need to
wake up each waiting thread when any event was added to the heap
before one that was minimal.

>From all I've read about it, waking up all waiting thread isn't
trivial.

Another solution proposed by my poor brain is - to have alive thread
which will handle this priority queue, and have one fifo fd in my
epoll set dedicated to this purpose. Priority queue management thread
will write single char to that fd when some timed event needs to be
processed.

Doing some google search, I've found this message:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.3/2416.html
Things can be much easier if there was timer kernel object (or its
equivalent). Can anyone give me some advice - how I should solve this
problem?

Thanks in advance.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
