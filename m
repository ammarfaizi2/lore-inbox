Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267899AbUHXPLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267899AbUHXPLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267947AbUHXPLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:11:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:50633 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267899AbUHXPLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:11:37 -0400
Date: Tue, 24 Aug 2004 17:11:36 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Andrei Voropaev <avorop@mail.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20040824144241.GE1527@avorop.local>
Subject: Re: with 2.6.7 setitimer called in sequence returns strange values on i686
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <21011.1093360296@www48.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrei,

> Sorry if I'm taking your time away but to me it looks like I have kernel
> problem, so I hoped to find some help in this list. I'm not subscribed
> so please CC me on replies.
> 
> I'm using setitimer(ITIMER_REAL...) to measure time intervals.
> Everything was working fine untill I've installed 2.6.7 kernel. 
> 
> bash$ uname -a
> Linux avorop 2.6.7 #5 Thu Aug 19 11:53:33 CEST 2004 i686 unknown
> 
> Here's little piece of code that reproduces problem on my machine.

There's a little problem with your code.  You're not
displaying microseconds correctly.  That "10.479" below should really 
be "10.000479".  I suspect that that sort of small rounding error 
(smaller than HZ) is probably acceptable, but someone else might 
have some input on this point.

Cheers,

Michael

PS The use of pthreads in this program has no relevance to the 
behaviour you are seeing -- I removed the pthread stuff and saw 
the same results.


> 
> ===========================================
> #include <pthread.h>
> #include <stdio.h>
> #include <sys/time.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <error.h>
> #include <time.h>
> 
> void
> set_timer(int arg)
> {
>     struct itimerval n, o;
>     struct timespec per;
> 
>     n.it_interval.tv_sec = 0;
>     n.it_interval.tv_usec = 0;
>     n.it_value.tv_sec = arg;
>     n.it_value.tv_usec = 0;
>     // init timer
>     if(setitimer(ITIMER_REAL, &n, &o) != 0) 
>        error(EXIT_FAILURE, errno, "Can't set timer");
>     printf("Previous value of %d timer is %ld.%ld\n", arg, 
>             o.it_value.tv_sec, o.it_value.tv_usec);
>     per.tv_sec = arg / 2;
>     per.tv_nsec = 0;
>     // sleep for half a timer time
>     nanosleep(&per, NULL);
>     n.it_value.tv_sec = arg;
>     n.it_value.tv_usec = 0;
>     // check how much time is left and restart it at the same time
>     if(setitimer(ITIMER_REAL, &n, &o) != 0) 
>        error(EXIT_FAILURE, errno, "Can't set timer");
>     printf("Previous value of %d timer is %ld.%ld\n", arg, 
>              o.it_value.tv_sec, o.it_value.tv_usec);
>     n.it_value.tv_sec = 0;
>     n.it_value.tv_usec = 0;
>     // check how much time is left. 
>     if(setitimer(ITIMER_REAL, &n, &o) != 0) 
>         error(EXIT_FAILURE, errno, "Can't set timer");
>     printf("Previous value of %d timer is %ld.%ld\n", arg, 
>         o.it_value.tv_sec, o.it_value.tv_usec);
> }
> 
> int
> main(void)
> {
>     pthread_t thr1, thr2;
> 
>     pthread_create(&thr1, NULL, (void*)set_timer, (void*)10);
> //    pthread_create(&thr2, NULL, (void*)set_timer, (void*)12);
> 
>     pthread_join(thr1, NULL);
>     pthread_join(thr2, NULL);
>     return 0;
> }
> ======================================================
> On my machine this program produces
> 
> Previous value of 10 timer is 0.0
> Previous value of 10 timer is 4.999240
> Previous value of 10 timer is 10.479
> 
> Note the last line. I've reset timer to 10 seconds and setitimer tells
> me that there are 10.479 seconds left.
> 
> As I said this code works fine with 2.4.21 kernel. It produces 
> Previous value of 10 timer is 0.0
> Previous value of 10 timer is 4.980000
> Previous value of 10 timer is 10.0
> 
> I have one more machine with 2.6.7 kernel. But that machine is Athlon64
> and runs 64-bit kernel. There the program also runs correctly.
> 
> Any hints on where to look for the problem?
> 
> TIA.
> 
> Andrei
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail

