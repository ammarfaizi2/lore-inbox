Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbTCIH5m>; Sun, 9 Mar 2003 02:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbTCIH5m>; Sun, 9 Mar 2003 02:57:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:30649 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262460AbTCIH5l>;
	Sun, 9 Mar 2003 02:57:41 -0500
Date: Sun, 9 Mar 2003 00:08:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: Kevin Brosius <cobra@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-Id: <20030309000839.31041e3e.akpm@digeo.com>
In-Reply-To: <3E6AEDA5.D4C0FC83@compuserve.com>
References: <3E6AEDA5.D4C0FC83@compuserve.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2003 08:08:13.0202 (UTC) FILETIME=[07F46720:01C2E613]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Brosius <cobra@compuserve.com> wrote:
>
> Second attempt to send this after not seeing it post after about a day. 
> Anyone else have kernel posting problems?
> 
> I started seeing the cron task runaway, using 100% CPU continuously on a
> single CPU with
> 2.5.63+bk and now with 2.5.64 (about two weeks now.)  No other
> apps/tasks seem to be affected, that I've noticed.  It seems to take
> upwards of 8 hours running the kernel for this to occur.
> 
> top shows:
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>   594 root      25   0  1428  620  1364 R    49.9  0.1 195:23 cron
> 

Yes I've seen this four times over maybe three weeks.  Three times on dual
CPU, once on a different UP machine.

In all cases, crond is stuck in a loop calling nanosleep with a tv_sec value
of a bit over 4,000,000 and a tv_nsec value of zero.  nanosleep keeps
returning EINVAL immediately.

I'm not sure why crond is trying to sleep for so long.  Maybe it has set an
alarm.

errr, OK.  This returns -EINVAL:

#include <time.h>

main()
{
	struct timespec req;
	struct timespec rem;
	int ret;

	req.tv_sec = 5000000;
	req.tv_nsec = 0;

	ret = nanosleep(&req, &rem);
	if (ret)
		perror("nanosleep");
}

I shall take a look....

