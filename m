Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbTCIIGJ>; Sun, 9 Mar 2003 03:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262473AbTCIIGJ>; Sun, 9 Mar 2003 03:06:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:36537 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262472AbTCIIGH>;
	Sun, 9 Mar 2003 03:06:07 -0500
Date: Sun, 9 Mar 2003 00:17:06 -0800
From: Andrew Morton <akpm@digeo.com>
To: cobra@compuserve.com, linux-kernel@vger.kernel.org,
       george anzinger <george@mvista.com>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-Id: <20030309001706.75467db1.akpm@digeo.com>
In-Reply-To: <20030309000839.31041e3e.akpm@digeo.com>
References: <3E6AEDA5.D4C0FC83@compuserve.com>
	<20030309000839.31041e3e.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2003 08:16:39.0823 (UTC) FILETIME=[35ECA1F0:01C2E614]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> errr, OK.  This returns -EINVAL:
> 
> #include <time.h>
> 
> main()
> {
> 	struct timespec req;
> 	struct timespec rem;
> 	int ret;
> 
> 	req.tv_sec = 5000000;
> 	req.tv_nsec = 0;
> 
> 	ret = nanosleep(&req, &rem);
> 	if (ret)
> 		perror("nanosleep");
> }
> 

OK, I give up.

			/*
			 * This is a considered response, not exactly in
			 * line with the standard (in fact it is silent on
			 * possible overflows).  We assume such a large 
			 * value is ALMOST always a programming error and
			 * try not to compound it by setting a really dumb
			 * value.
			 */
			return -EINVAL;

George, RH7.3 and RH8.0 cron daemons are triggering this (trying to sleep
for 4,500,000 seconds) and it causes them to go into a busy loop.

I think we need to just sleep for as long as we can and return an
appropriate partial result.

