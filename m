Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136548AbRASXUv>; Fri, 19 Jan 2001 18:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136559AbRASXUl>; Fri, 19 Jan 2001 18:20:41 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:14550 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S136548AbRASXUb>; Fri, 19 Jan 2001 18:20:31 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Michael Lindner" <mikel@att.net>, <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: select() on TCP socket sleeps for 1 tick even if data available
Date: Fri, 19 Jan 2001 15:20:29 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKAEHINCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3A68A7D0.FF534B97@att.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If select() is waiting for data to become available on a
> TCP socket FD, and
> data becomes available, it doesn't return until the next clock tick.

	If your application has scheduling requirements, you need to communicate
them to the scheduler.

> 	#include <sys/time.h>
> 	#include <sys/types.h>
> 	#include <unistd.h>
>
> 	/* this program should take 1 second to complete, but takes 10 */
> 	/* yes i know, it doesn't do any I/O, but the behavior is the
> 		same as if it did */
> 	main()
> 	{
> 	        for (int i = 0; i < 1000; i++) {
> 			struct timeval to;
> 			to.tv_sec = 0;
> 			to.tv_usec = 1000;
> 			select(0, 0, 0, 0, &to);
> 		}
> 		return 0;
> 	}

	This program doesn't demonstrate anything except that Linux's sleep time is
granular. This shouldn't be news to anyone. If you don't force a reschedule,
everything works the way it's supposed to:

main()
{
 int i, j, pipes[2];
 struct timeval tv;
 fd_set rd;
 pipe(pipes);
 write(pipes[1], "foo", 4);
 for(i=0; i<1000; i++)
 {
  FD_ZERO(&rd);
  FD_SET(pipes[0], &rd);
  tv.tv_sec=0;
  tv.tv_usec=1000;
  j=select(10, &rd, NULL, NULL, &tv);
  if(j!=1) printf("oops\n");
 }
}

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
