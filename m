Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTEGPJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTEGPJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:09:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12276 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263879AbTEGPJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:09:15 -0400
Message-ID: <3EB92464.3050306@mvista.com>
Date: Wed, 07 May 2003 08:21:08 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       chandra.smurthy@wipro.com
Subject: Re: [BUG] problem with timer_create(2) for SIGEV_NONE ??
References: <E935C89216CC5D4AB77D89B253ADED2A92257F@blr-m2-msg.wipro.com>
In-Reply-To: <E935C89216CC5D4AB77D89B253ADED2A92257F@blr-m2-msg.wipro.com>
Content-Type: multipart/mixed;
 boundary="------------080100050306030000020906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080100050306030000020906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a fix.

Change log:

Fix the sig_notify filtering code for the timer_create system call to 
properly check for the signal number being small enought, but only if 
SIG_NONE is not specified.

Eliminate useless test of sig_notify.

george


Aniruddha M Marathe wrote:
> George,
> 
>  timer_create(2) fails in the case where sigev_notify parameter of
> sigevent structure is SIGEV_NONE. I believe this should not happen.
> 
    ~snip~

>  
> Line 377:
> SIGEV_NONE & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID)
> = 001 & ~(000 | 100)
> = 001 & ~(100)
> = 001 & 011
> = 001
> therefore the if condition is true
> therefore the function returns NULL from line 378.
>  
> Now in sys_timer_create() at line number 462
> Process = NULL
>  
> Now at line 489
> if (!process) becomes TRUE
> and function returns with EINVAL
> 
> Is my analysis right? If so can you comment on this behaviour?
> 
Looks like a bug :(  I feel a patch coming on...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml



--------------080100050306030000020906
Content-Type: text/plain;
 name="hrtimers-fix-signone-2.5.69-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-fix-signone-2.5.69-1.0.patch"

--- linux-2.5.69-org/kernel/posix-timers.c	2003-05-05 15:34:09.000000000 -0700
+++ linux/kernel/posix-timers.c	2003-05-06 00:24:21.000000000 -0700
@@ -357,13 +357,10 @@
 			rtn->tgid != current->tgid))
 		return NULL;
 
-	if ((event->sigev_notify & SIGEV_SIGNAL & MIPS_SIGEV) &&
+	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
 			((unsigned) (event->sigev_signo > SIGRTMAX)))
 		return NULL;
 
-	if (event->sigev_notify & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID))
-		return NULL;
-
 	return rtn;
 }
 



--------------080100050306030000020906--

