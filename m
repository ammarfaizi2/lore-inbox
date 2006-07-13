Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWGMXhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWGMXhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWGMXhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:37:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161050AbWGMXhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:37:50 -0400
Date: Thu, 13 Jul 2006 16:37:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: nigel@suspend2.net
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tglx@timesys.com,
       linux-pm@lists.osdl.org
Subject: Re: [PATCH] Rt-tester makes freezing processes fail.
Message-Id: <20060713163743.e71975b0.akpm@osdl.org>
In-Reply-To: <200607140918.49040.nigel@suspend2.net>
References: <200607140918.49040.nigel@suspend2.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 09:18:43 +1000
Nigel Cunningham <nigel@suspend2.net> wrote:

> Compiling in the rt-tester currently makes freezing processes fail.
> I don't think there's anything wrong with it running during
> suspending, so adding PF_NOFREEZE to the flags set seems to be the
> right solution.
> 
> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> 
>  rtmutex-tester.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff -ruNp 9971-rt-tester.patch-old/kernel/rtmutex-tester.c 9971-rt-tester.patch-new/kernel/rtmutex-tester.c
> --- 9971-rt-tester.patch-old/kernel/rtmutex-tester.c	2006-07-07 10:27:46.000000000 +1000
> +++ 9971-rt-tester.patch-new/kernel/rtmutex-tester.c	2006-07-14 07:48:01.000000000 +1000
> @@ -259,7 +259,7 @@ static int test_func(void *data)
>  	struct test_thread_data *td = data;
>  	int ret;
>  
> -	current->flags |= PF_MUTEX_TESTER;
> +	current->flags |= PF_MUTEX_TESTER | PF_NOFREEZE;
>  	allow_signal(SIGHUP);
>  
>  	for(;;) {


I yesterday queued up the below patch.  Which approach is most appropriate?



From: Luca Tettamanti <kronos.it@gmail.com>

When CONFIG_RT_MUTEX_TESTER is enabled kernel refuses to suspend the
machine because it's unable to freeze the rt-test-* threads.

Add try_to_freeze() after schedule() so that the threads will be freezed
correctly; I've tested the patch and it lets the notebook suspends and
resumes nicely.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/rtmutex-tester.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN kernel/rtmutex-tester.c~add-try_to_freeze-to-rt-test-kthreads kernel/rtmutex-tester.c
--- a/kernel/rtmutex-tester.c~add-try_to_freeze-to-rt-test-kthreads
+++ a/kernel/rtmutex-tester.c
@@ -275,6 +275,7 @@ static int test_func(void *data)
 
 		/* Wait for the next command to be executed */
 		schedule();
+		try_to_freeze();
 
 		if (signal_pending(current))
 			flush_signals(current);
_

