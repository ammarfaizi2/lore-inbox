Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUAXWbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUAXWbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:31:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:17024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261877AbUAXWbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:31:12 -0500
Date: Sat, 24 Jan 2004 14:30:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: eric.piel@tremplin-utc.net
Cc: minyard@acm.org, george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Incorrect value for SIGRTMAX
Message-Id: <20040124143037.5116ccc9.akpm@osdl.org>
In-Reply-To: <1074979873.4012e421714b1@mailetu.utc.fr>
References: <1074979873.4012e421714b1@mailetu.utc.fr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eric.piel@tremplin-utc.net wrote:
>
> Hello,
> 
> Few months ago, Corey Minyard corrected handling of incorrect values of signals.
> cf
> http://linux.bkbits.net:8080/linux-2.5/cset@1.1267.56.40?nav=index.html%7Csrc/%7Csrc/kernel%7Crelated/kernel/posix-timers.c
> 
> Working on the High-Resolution Timers project, I noticed there is an error in
> good_sigevent() to catch the case when sigev_signo is 0. In this function, we
> want to return NULL when sigev_signo is 0. The one liner attached (used for a
> long time in the HRT patch) should do the trick, it's against vanilla 2.6.1 .
> 

OK, the current code is obviously junk:

	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
			event->sigev_signo &&
			((unsigned) (event->sigev_signo > SIGRTMAX)))
		return NULL;

a) it's doing

	if (foo && foo > N)

   which is redundant.

b) it's casting the result of (foo > N) to unsigned which is nonsensical.

Your patch doesn't address b).

I don't thik there's a case in which sigev_signo can be negative anyway. 
But if there is, the cast should be done like the below, yes?



 kernel/posix-timers.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN kernel/posix-timers.c~SIGRTMAX-fix kernel/posix-timers.c
--- 25/kernel/posix-timers.c~SIGRTMAX-fix	2004-01-24 14:27:13.000000000 -0800
+++ 25-akpm/kernel/posix-timers.c	2004-01-24 14:28:21.000000000 -0800
@@ -344,8 +344,7 @@ static inline struct task_struct * good_
 		return NULL;
 
 	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
-			event->sigev_signo &&
-			((unsigned) (event->sigev_signo > SIGRTMAX)))
+	    (((unsigned)event->sigev_signo > SIGRTMAX) || !event->sigev_signo))
 		return NULL;
 
 	return rtn;

_

