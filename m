Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbTAVGqO>; Wed, 22 Jan 2003 01:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267356AbTAVGqO>; Wed, 22 Jan 2003 01:46:14 -0500
Received: from 84e5e703.math.leidenuniv.nl ([132.229.231.3]:59566 "EHLO
	zada.math.leidenuniv.nl") by vger.kernel.org with ESMTP
	id <S267355AbTAVGqN>; Wed, 22 Jan 2003 01:46:13 -0500
Date: Wed, 22 Jan 2003 07:55:02 +0100
From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030122065502.GA23790@math.leidenuniv.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Both /dev/epoll EP_POLL and sys_epoll_wait, when converting the passed
timeout value in msec to jiffies, round down instead of up.  This
occasionally causes these functions to return without any active fd's
before the given timeout period has passed.

This can cause fun situations like these:
	epoll_wait(epfd, events, maxevents, timeout_until_next_timer_expiry)
		[ returns too early ]

	gettimeofday(&now, NULL)
		[ notice that the first timer has not yet expired, do nothing ]

	epoll_wait(epfd, events, maxevents, random_small_value_less_than_jiffy)
		[ returns immediately ]

	gettimeofday(&now, NULL)
		[ notice that first timer still didn't expire yet, do nothing ]

	etc.

Effectively causing busy-wait loops of on average half a jiffy.


nanosleep(2) always rounds timeout values up (I think it is required to do
so by some specification which says that this call should sleep _at_least_
the given amount of time), and this approach to me makes sense for
{sys_,/dev/}epoll also.  See <linux/time.h>:timespec_to_jiffies and
kernel/time.c:sys_nanosleep.

Will you accept a patch to do this?


cheers,
Lennert
